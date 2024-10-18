Return-Path: <linux-kernel+bounces-372158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A439A4528
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EDAA1F2464A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D6F204F67;
	Fri, 18 Oct 2024 17:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fJWWUylB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FLGXwEi0"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C83204099
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273308; cv=fail; b=i3XkCIA4plKtD4BobTRkQa5Lt+K8jz68YbrIrnA37oZiNO/nP0K4YvsDT6m1btQPEG08nXWvBTliP5cH2AtYsIRNyp9/miy784z+h3NlbP1Q+Tu3oRdvTSixF9Wv48h5lRj5k+3H5LYVLReVYMM9zDkRr//YbkcBMzm/z5eLhWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273308; c=relaxed/simple;
	bh=00YPS6FrocTm8SdHJPI8ZOHac2mdsZXVmgMH0kE+X4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BMJdrb576BDVrX8Cfkm0g3K6Tml8wRQe4GdcchAsYA721PdiRNzPXKFVUuaiRnJ2io8EKNY96YWi84pNekRpCavmpZsp4CkjFpVlf6ogc4FeHpgc6/uGMXtz7I9ZBkhIH2qaWVS3LUFilUciOSI0gmELB3BBKAFZa0ARfrfZSQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fJWWUylB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FLGXwEi0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEBbeH022666;
	Fri, 18 Oct 2024 17:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=fuP9pPWwyPYmmyu97WF6oo6nWtuzv6HRrSuHo04WtDk=; b=
	fJWWUylBQeoo7oAuv3deSlgK3Bafok2VHQVicBixCG1u6tRb1rBtIYZhzbNRRKP2
	+xv8v5oERXcTiWbmNy8O3K26yJd2UA5fbFSc7ne4SLaNVwXN2BPXpjYmdphNLwq1
	SFdtsBSgfhL0Rmy8Y94qKuJgU2HC3mwNCJokiAnh8TYquae8Gi1PceNTIp8r5lPg
	7aDoAFIgldv5O6ax13IPSS57urlo+MVFjiSR1L3WJGCr1nmDcM3FFIN3QSSwCBK8
	/2OA0O0vHlZLtk6nKF1/AZlc4WyyM3EX1wbv601S7+RA58GZ+vgJ3bCZcQFoj+hd
	Q9a8dfJ/NcyLEaZFFRn8Aw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5csueq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 17:41:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IGMPTR019304;
	Fri, 18 Oct 2024 17:41:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjbvx7g-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 17:41:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBDHhWU38SXojqKpwTNvhUmxqW3w1AFAUPfY/C7HajmoWtu/5XkkzAh6Y2lRFVRcp7S5yLsCsQDgM2AxtMOUucki8GwfobxeRS9RROIo6K2MfxvddnmwxVjzFq+5vFsGT42KPWGqpEPucFbAlfPcnxJ2FwAj4W5hZzfI8jHo4TRxCnIBi+oITSOwyNT+Tk6y8LMsuqjxO5Pnu7cn7UlfelI62nv5B09X+FXgL6CwV+jGZw573nnZUQNhCj9GTgeRni8CvOnmPdfqZWA2EPG2frETF57HvVpNKcRdHxjJoF9JILydjH53ygniDPC21c00DAQJ4KyPmUYMXuhp71iHOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuP9pPWwyPYmmyu97WF6oo6nWtuzv6HRrSuHo04WtDk=;
 b=NvP4GCWYd5WJTa2inEjefeSC77/zjj/DlnUFisAGfmJi9wkFWOJ6tjV31ujjJ1OMVoVcut/r5b0jcK4XuWj8NZzX7ilnjcKXXrsonk5TverNsqqX1qQUVPTWmA9MsINB2VnohFm+koHoSNbnjfsBnWQeblA/caB7jMT7/atGd24jNWy/y6dSLqFLJlEKJGdc12WZ+q5RYYhchR/9ytbeEYEMfPz4AXxN/WLZd85Li2t2L97seKk5nnhLsJt0ph+WeX0B27fzBFt++Gl4JZ6qIo/K4nU671wDteQ13yHNsJZDsWx83pmT0lkx6YHhd4YzXyMH+I75/ZEwX+TkXDwvpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuP9pPWwyPYmmyu97WF6oo6nWtuzv6HRrSuHo04WtDk=;
 b=FLGXwEi0uO8LNblmiWI4Nj+s8Y5fW5nJqpYiJJZd/aHO6tDkL8fKTM1Co448q2/l0H447DiODKpyb1ExvF9Jg/4oevZoAuqwr3wENHTQQPIxcXUD5FZiA76WH3dA0pKDjGcB2Ly53zDe528onGpqrdc7CVRGLWYQjyFmH+OA7gI=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB7078.namprd10.prod.outlook.com (2603:10b6:510:288::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 17:41:19 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 17:41:19 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jann Horn <jannh@google.com>, David Hildenbrand <david@redhat.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jeff Xu <jeffxu@chromium.org>, Pedro Falcato <pedro.falcato@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v2 1/2] mm/mremap: Clean up vma_to_resize()
Date: Fri, 18 Oct 2024 13:41:13 -0400
Message-ID: <20241018174114.2871880-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241018174114.2871880-1-Liam.Howlett@oracle.com>
References: <20241018174114.2871880-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::34) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: bec948ca-7cee-4d3a-87c1-08dcef9c1323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ORMzi3L3tJUv25mbUJoI2PJ/IDGLOOYrpNkIkL9dPf69LdigOoYqibIfA5Di?=
 =?us-ascii?Q?vlEM08/UnSlvaqLcSkstgfIKDXfRNMUaGewyqZJ62Bq0NEiy30otEqucNcTZ?=
 =?us-ascii?Q?to1Qtl3QMPKMMZJLyaHxD2rctSTqv4QnY227w+PlgFaG31LfosyoE8IPEY89?=
 =?us-ascii?Q?t9Qg+zte8H5H38q2+l71VfOWP8r2A+dGsOXFy0vwFbcC4pTKPQ4sFjCY5Dil?=
 =?us-ascii?Q?vsMX8U5Ip4SKM262XY+tI4Nzpl2IrvkwrCgbrsL8UgYghFzsItOCsliIbPpC?=
 =?us-ascii?Q?Ec/VgDKVWPsjSTW2LVHjjSdbeNB4DU0qLloSvmxCP1VOSsQVRcUAF3hFsSAr?=
 =?us-ascii?Q?5r6rTEN+m8ylJjb7MC0DgM+x2tXFsTM6zsUORblQ5hs4DN3eqoNQeSEE1Ck3?=
 =?us-ascii?Q?JH5eBcWkZVUCl01PePdhrc41m70UqxjhQwaackFaMfYapmhyCMhiVLPnTCm5?=
 =?us-ascii?Q?T0KNqxD9Bq5lOKAWhE87Gs057yIc5qcKAxH4gTf1NVT6Al6nA5tlbjwAProY?=
 =?us-ascii?Q?h/Wk6t2cOOyufSBwX1pKnxfNcT6cmAEfEIi9/6Hq+84iu0aVr6ZDQ3TtYqWM?=
 =?us-ascii?Q?RCEXuIzmcPnFz3oDjvQEvRzN567XlMNx6P+SZ3NBJJZSKuxpb7VEuGDFxiAv?=
 =?us-ascii?Q?KFGt0mvGowfA8FSZt+r+9G1OtpDxPM2yBJwCHHDOiqkMR5jztZo+WWvcN8dz?=
 =?us-ascii?Q?yQUbqclCUd/M8YYOBdPSZYryTvUxc6WUovsNbVUIijxxwRD0K/rDQn2B2k6F?=
 =?us-ascii?Q?GtJUSVsXjqQZJn5dEaW4Vwh+E/Y71NSNrb1oUBekUhnP/2rzoezLdcpL+7HG?=
 =?us-ascii?Q?UIYmblw3shN6/zzYebNP04EM83mE0t5AyQwcfwYObqqkQ9dpV8ZauhZjm3qW?=
 =?us-ascii?Q?FDll7SakbAu4NB1rfcJ3p5WZOyUZ+xPx2gODyM0weMj/cA0Dds2NTfYOvw1s?=
 =?us-ascii?Q?xDdBFHr1cQ2qIQ9csabyJTDXWBZD0gCHabt1JkkaKVZVMlBKbD691a/M4R1A?=
 =?us-ascii?Q?M39FEGn9Kl/pN5cZA8VLuw09Yq1E6oMftQNOZGkupeDXYBeCa8IZdpSIpVVv?=
 =?us-ascii?Q?aQ10Vh0Df6MYOhwOXF4fcy8GtyLP/SrmrW4sFuyWFmTFiaQv+G3rGE1hpVq9?=
 =?us-ascii?Q?byVPLVONx+gCPTrNGqbdGoK6LbFDChsDkgiYbxfvP4m1eTM46Tq7Ni2hac1H?=
 =?us-ascii?Q?owwRHIowDzjohQ7+CxIAX4sLvrrNackZvwhxdZsvFabOZFkKpRO4Wu+LESp3?=
 =?us-ascii?Q?Uh1Y088kbs6ldGD6l28v7swkeiVOcvWYM1GuNT6gDWwR999RKHALmemGeOap?=
 =?us-ascii?Q?kk5i2ZFX/biPRTH58bGN3Awt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dG8K0YtIwfO8JWpPk+Ueb3UZEZA7E7MagJR8sILzX14ZCNAXRnq4rnzGt+aL?=
 =?us-ascii?Q?GxGrSwE9MDNgQYyn/x8yfpQG0+yjWzSh9roq514G4NkxdcRshDEaCQq+tnn+?=
 =?us-ascii?Q?OV795lTH6T0zirKAfcy9rzm8SwsT2h2FCFHnPDTTqB2h2H1OMRDGczIduCM6?=
 =?us-ascii?Q?vhPqDK9qJMHhPDnnS8kzj9mlhDniF2GPXE04Q9ABRfOfhxZOSrMhlkdAx5A+?=
 =?us-ascii?Q?ma3p4LiG5t15nlfXOuRf6qWb/CjhkLtkpg1x+GcnzBLYtsdlZF7AtnCq/AZl?=
 =?us-ascii?Q?HXRa215CaBQoA3E9neSgBxltdY46F+Vvtgke9bvl8ImgaNBmEBZXaIJEoe6D?=
 =?us-ascii?Q?abv3pmcTVz0WfNR3GwP8v8GDcxORwQ7aYgigDVarPhAh1aUZdKRtWF6TdhuG?=
 =?us-ascii?Q?Z991QkY0wR93weXKb0+zcGUGiSNMBk9YsBRGoKNXhhWMPyjxPFRAn3Ii7rFP?=
 =?us-ascii?Q?HAUBHJaj6HqhhTh0HreZZwxxMyis41fNAPKIZEo81qoUldg8WR/kTbkczajT?=
 =?us-ascii?Q?qWlbCvCC3LQdumTa73ycoZfXJCY09Dqr2U9+UwBU7gsT0s3uWZfuqnx0J2yB?=
 =?us-ascii?Q?7GuLtoQRv4dMkZKYdTBQ+VVSPEwIvUjbfmSeN8K1n3JRGKQMzzVoQlj/0kKe?=
 =?us-ascii?Q?C2UNNTMG6kPBIdjv5lsUq2LqLdeNcaMNw5r3pPMa9j+iSIlrLVawCvmDXlb0?=
 =?us-ascii?Q?boPnXZSwtpxWTV4S30aI3LtEE7ca277S2rEXXfwP2Fz79ckxbrLqFjxW4Tu7?=
 =?us-ascii?Q?R54QXUxEQchWqO4GAYqVkn9VE3j8mFB76nroR8czAk6S+gITeF4iMjbhGrpb?=
 =?us-ascii?Q?uvc22l4lrI34Loy5VPmkD0IlBSLndZCcarY8r+78SRks7ueCp+edPUAqjgnT?=
 =?us-ascii?Q?8UAP+m35LkOgHcPNCxnlaJ5R1AuVBF/wozekGtAfTnqH6Nd9Q5WclqjQGEMs?=
 =?us-ascii?Q?k0eWOHM03h66x03vj5ujU8aLdfg5CMZaTK1cykDql5olK5HGJgQBOOaFYMVw?=
 =?us-ascii?Q?hDa8pSlGvQ7WRgtr0hoxNRLEgeepmgXyPazQzebKYGCyKx80KnjgnA9Vv6Af?=
 =?us-ascii?Q?AlC5Bp9QC68JazBuVW5ZPvAaMpaYW0DsmSRVIJTpbaNcE6mhix/vha2e9fd2?=
 =?us-ascii?Q?esg/6y2n4dLkndXRHeiCLuVF1FaHtw/Str27W+YZqrhA30EwaPlrnm6PhSMq?=
 =?us-ascii?Q?xY59UDz5U+fCWZuWvnNcvmVjh3W68Kk+45FNx30kja0S/zoDWrpa/Tk4lJEL?=
 =?us-ascii?Q?6BTpxOWozze5g6NxKwP5vT/iW2lgvjfOLvFrTH5k99nYz1rgA3cj+3+s4DOE?=
 =?us-ascii?Q?v/Ruaq/jVqI3wDLyA7ii/xNkw/WV/X7x6b+/U3mUEUYRRuGDk9X0XtMSL12i?=
 =?us-ascii?Q?dB7Ob0okt38QdeOGM3RddXlXLIYolLIj1JSSQi5EcdsRZYhNLVBcY1DPxU/T?=
 =?us-ascii?Q?S3VvqSoMCRBbLMcbLHZ9KE5a+uyIu5BNZZNqd8eN2QNeIQHB76+EXKnYHp+U?=
 =?us-ascii?Q?5oXcUPnttES2JSIG1djIT3T0PN0iSJqaBaxsFLynYY5oO5jPD/k+Uo+SWzex?=
 =?us-ascii?Q?32pAmit0rDKwdQM04t8g8Lo+TLm2t9hbZ0otvKg6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hKgoFopJHFvHoW0zVxPSVIzLba/iMnA8KoCwQDAhxU2pehlBq8Mh9P8TZMrrqU27g0SNV6SvXicmr7XQyVio48NO+Tvhnr6q27aS22/i0jlAvMOzhxrxfqnLLhdTEiqADthJpNOHx8nAwhDzGbsfifp1vj8XL3pc4DJLOhbYwyGvMHgaZIO9KPVEnZggEkV60RIv+9WtaJ/124ixRrTuWzb2wmR3rfmus8p2UPwFGYn0qT45CChNS5/v4F4ICOwkp5CPDx10xRdZjI4wQH4tOxtb78eQSCYKyCNgghxDMeKRNNo0ubS/SOeKr9EpOIUcRmGJJnGWsALdhymb7SImbILCSDsHxAMaglh7vV6CaUScH/Kk+saZdw3FeH0JsXsQkvlFvKXWjEAiCG4GiHsUbZ9OTmvVlsVGQxEXD0KA80hZH311iyYCLpP9Q5XjMQHHwjhVBBJ7tA3Jt3FR85QCr4pauGVWXNNdb1eS0usg9aM+ykoQwcm4A9c6AGvg1Cld7WHEmYhJvbl63CIiHYCd6pCVAudFgVsdfdow4gz4ey1Wh41fP1iJnNO9ZmB3x6MP3WVfnnc3TeM027gGW7DFVccW21flCSGMgyzps4+1NCs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bec948ca-7cee-4d3a-87c1-08dcef9c1323
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 17:41:19.6399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WGSLyKC/irL4eaFVVMmXDhMZeMxzvFgldl0dtNSnvrmx0QreuXe5D/NwNjPBEyMGS+fai7eh7FrTltZPmuHoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_13,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410180113
X-Proofpoint-ORIG-GUID: SRiAttfrKKI7o4uE3wOo49uYw7k2MBwB
X-Proofpoint-GUID: SRiAttfrKKI7o4uE3wOo49uYw7k2MBwB

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

vma_to_resize() is used in two locations to find and validate the vma
for the mremap location.  One of the two locations already has the vma,
which is then re-found to validate the same vma.

This code can be simplified by moving the vma_lookup() from
vma_to_resize() to mremap_to() and changing the return type to an int
error.

Since the function now just validates the vma, the function is renamed
to resize_is_valid() to better reflect what it is doing.

This commit also adds documentation about the function.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mremap.c | 53 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 5917feafe8cc..e781ec4573ca 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -826,17 +826,24 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	return new_addr;
 }
 
-static struct vm_area_struct *vma_to_resize(unsigned long addr,
+/*
+ * resize_is_valid() - Ensure the vma can be resized to the new length at the give
+ * address.
+ *
+ * @vma: The vma to resize
+ * @addr: The old address
+ * @old_len: The current size
+ * @new_len: The desired size
+ * @flags: The vma flags
+ *
+ * Return 0 on success, error otherwise.
+ */
+static int resize_is_valid(struct vm_area_struct *vma, unsigned long addr,
 	unsigned long old_len, unsigned long new_len, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
 	unsigned long pgoff;
 
-	vma = vma_lookup(mm, addr);
-	if (!vma)
-		return ERR_PTR(-EFAULT);
-
 	/*
 	 * !old_len is a special case where an attempt is made to 'duplicate'
 	 * a mapping.  This makes no sense for private mappings as it will
@@ -847,37 +854,37 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
 	 */
 	if (!old_len && !(vma->vm_flags & (VM_SHARED | VM_MAYSHARE))) {
 		pr_warn_once("%s (%d): attempted to duplicate a private mapping with mremap.  This is not supported.\n", current->comm, current->pid);
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
 	if ((flags & MREMAP_DONTUNMAP) &&
 			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	/* We can't remap across vm area boundaries */
 	if (old_len > vma->vm_end - addr)
-		return ERR_PTR(-EFAULT);
+		return -EFAULT;
 
 	if (new_len == old_len)
-		return vma;
+		return 0;
 
 	/* Need to be careful about a growing mapping */
 	pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
 	pgoff += vma->vm_pgoff;
 	if (pgoff + (new_len >> PAGE_SHIFT) < pgoff)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	if (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
-		return ERR_PTR(-EFAULT);
+		return -EFAULT;
 
 	if (!mlock_future_ok(mm, vma->vm_flags, new_len - old_len))
-		return ERR_PTR(-EAGAIN);
+		return -EAGAIN;
 
 	if (!may_expand_vm(mm, vma->vm_flags,
 				(new_len - old_len) >> PAGE_SHIFT))
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
-	return vma;
+	return 0;
 }
 
 static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
@@ -936,12 +943,16 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 		old_len = new_len;
 	}
 
-	vma = vma_to_resize(addr, old_len, new_len, flags);
-	if (IS_ERR(vma)) {
-		ret = PTR_ERR(vma);
+	vma = vma_lookup(mm, addr);
+	if (!vma) {
+		ret = -EFAULT;
 		goto out;
 	}
 
+	ret = resize_is_valid(vma, addr, old_len, new_len, flags);
+	if (ret)
+		goto out;
+
 	/* MREMAP_DONTUNMAP expands by old_len since old_len == new_len */
 	if (flags & MREMAP_DONTUNMAP &&
 		!may_expand_vm(mm, vma->vm_flags, old_len >> PAGE_SHIFT)) {
@@ -1114,11 +1125,9 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	/*
 	 * Ok, we need to grow..
 	 */
-	vma = vma_to_resize(addr, old_len, new_len, flags);
-	if (IS_ERR(vma)) {
-		ret = PTR_ERR(vma);
+	ret = resize_is_valid(vma, addr, old_len, new_len, flags);
+	if (ret)
 		goto out;
-	}
 
 	/* old_len exactly to the end of the area..
 	 */
-- 
2.43.0


