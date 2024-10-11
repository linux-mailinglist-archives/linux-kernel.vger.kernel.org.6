Return-Path: <linux-kernel+bounces-361389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 343EC99A781
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5C31F24FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7EA194A64;
	Fri, 11 Oct 2024 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SLQcFFKc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YjBVL7mN"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2F81946CF
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660346; cv=fail; b=DubgWBw0A2G3C8RpzcqGDaiu1wxZonJsptE16dis3xEsMyfth7euxRTJRpqF4hpwLLtN/YRGFXTRAecjMmCAZJLiNnFh0SvwjmkrIpG0+E3ohIv9sGiijUzF91GbM2K4i/YpY/SpHgiqkUvY+05615mBvWxCmYrNmN/lm7JF5ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660346; c=relaxed/simple;
	bh=f68L4+PfS9/NTNbMXkP/9oRwXVzCu4XWSfDCNmfsp3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lVqswZTMe2MHeSz38VEDDUHN7IJ6s4/ZOE2WjFqrJ+T8ZYJEN/AcgxlWxmkfSVls/Y+natoKWiouw7WBVMdwuA17J/HFgGHwst4gwER7MnZjkN3BTYGBYOXszdEUJ1AtUmxEG/IK8eezmWLGQFGZDeABlf/RK9rFmRGb3geIRmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SLQcFFKc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YjBVL7mN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BCpUTk019455;
	Fri, 11 Oct 2024 15:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=5z6fwq/GCLcHWm+N9h
	RJfv1apXKEHDr07OLUfiMRgb0=; b=SLQcFFKcVUadPqD6uhSiyNeHi1p5B1ifgT
	/KYH+NxAOWJ6NPg2Ob0KhZvbRY18iGEm9TIEVC2+LRaJbCqQBXALS1ee6Yc+5YNQ
	CKAndVDMKcE+z7xVzPK9OpAljhgmmoIQvblg0frihjw4P+Q7loWsM7bsZ7GqM4Lg
	zoJtc7sDehJ7DZzZ1ZI0HlLDoIddgLjgl0Xp8WmvMnoUR18jEbPP66wTywtythJ6
	Tt0w3wrnKuPWpn1E/A2i5ftSTxNvLomtS8cGjLfvD1/NEGhliU7NVd2Rc/1wM/4h
	SOevc1ubajsFK9ZjR20e1ZpdRTAldLk/7ySFW3IgZWrBn8BgWKVg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422yyvd4vk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 15:25:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49BEBqMK033310;
	Fri, 11 Oct 2024 15:25:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwbdknc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 15:25:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flWK13DoTcfoDgQisz8kVuZIKV4cLX+1YC7sb7EQNRz+kp7v1I6DkRg6vn0qDMC08xabbQDURjFsPOK+hVcP5EAMBF6cvPniufseguz8QPU/2KCiRq5plUnETQcmxWARF32c5LpwxilDvyExIKpdRs7rtNLGGBSni/i2yGIRi7RwsefgS6MR9pDSWeUSKipd0ADLeooR2aoQuDOaQAZy0pQblMEyohRSB/v1HQuZP7atx+eKGfLJ60O/+VHes/s+UZVMCwXfVAVTZNBwDQYwPfys/zR/ADWFOFYHjrz7F1tw6AZS/lVkd+Jty8SSWv8xRj3F9VXh+WMN1cDOrGR8Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5z6fwq/GCLcHWm+N9hRJfv1apXKEHDr07OLUfiMRgb0=;
 b=qH0YEkA5IltSwvvezuqNbt0OQMfYznFJyzfZEpSkOgH+fxi1vu1D/Fx9pfNGFMV6+em5kNGxm8+xGU5iPc/R2BYSmYvfYL5gyY2juXuLuTpWj3BmSP38B4w7UCy5wrsqclv9MbQdU7S8mb60LczUxTnuF6G6/pAqGycgA3+cZUaj+VfIEvGFmp+Ns/pFFQpq5Umn3h8KtNfnQuhSxAgHBl0baIE88EdE0YMxEE1VDgZ3khp43Wy1JbDLpoH9vfC7/IwrXKI4CAJPFdr1ZzivPWhCBpJXgyRDTF1Gp4N444JlO6TnAYVxCkQr7Z/nu5d85X7s7w483iILHvoVaxrwGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5z6fwq/GCLcHWm+N9hRJfv1apXKEHDr07OLUfiMRgb0=;
 b=YjBVL7mNNy/2H4BU9YZ3o3vftcVJRLTFwPpqMY801WIN/2/noamCV/rcnmvuHPKSP64aENMgkpicSZjELIbfaPCjwoUScJEVZ1rnczqyKgNB/CWznJEZI924OdFVzAgQdO4A4mqHsX62BOmhIduf1TQGgdElTxAn3C92sf4pS5U=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB6221.namprd10.prod.outlook.com (2603:10b6:8:c1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.16; Fri, 11 Oct 2024 15:25:27 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 15:25:27 +0000
Date: Fri, 11 Oct 2024 16:25:24 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: syzbot <syzbot+38c3a8b50658644abaca@syzkaller.appspotmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] WARNING in vms_complete_munmap_vmas
Message-ID: <fd8e59ee-97f6-407b-9206-64ba8b783e64@lucifer.local>
References: <6705953b.050a0220.840ef.000b.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6705953b.050a0220.840ef.000b.GAE@google.com>
X-ClientProxiedBy: LO2P265CA0271.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB6221:EE_
X-MS-Office365-Filtering-Correlation-Id: 998ae957-2134-4140-292e-08dcea08ef69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mT5YafAZ4xlUJeeKUO/dHOhqWgEpR4Zf4wYX8n8mFPcQdAM5Fg+oCjPzS8hV?=
 =?us-ascii?Q?B1D4EAGfkBrtEo2z28Gk6Fa05fnq7vZ6QOCga5XXOZHRpe44PouW3nuRoGy1?=
 =?us-ascii?Q?IoJUiCOnDiU4VJhisY0fgC6jC38PMdk+NV5FKNtXItz1Ry658RwrE18+SpS/?=
 =?us-ascii?Q?DYoc9TOss35njU1hYbZ+yOdx4/68mQ77NR8/x4WEM/SMplt/DQZNQ3yNujFY?=
 =?us-ascii?Q?l2kZB/+QVs3Osm3V3HKRFYllO7H+uuDkZ4OsyeIV2XZuCm8MNxDbR1DUvAtX?=
 =?us-ascii?Q?+CjmXD3Jhfiw0S0giWDKkhtBskPWOQrB+v+7hrp1THsmlHtVjZUAQ/SR76L/?=
 =?us-ascii?Q?96Vt+9RSWL+n1V3wbquHNxqWHjz7S446LfO8Y/L3eemljXGUllikYmscyeal?=
 =?us-ascii?Q?mAKMkhd2Q5iBTVljiLCOoeX+WSupcFLaaCQ5f2SDUKmEKyQoeTXYFfW/nZSr?=
 =?us-ascii?Q?cP5K+BtuBWmw7LWNcTVhlkL5HJgB4GFIxn7Xl4h3HoQjLCvmMKJM4870PQQZ?=
 =?us-ascii?Q?CUFksX6AJ1ylV5j6F+e66PJjScDSBHif9S/2FMcY6/c9WFrMy4ujHnS7O7s3?=
 =?us-ascii?Q?OE8m20qZGuNTnBrq8A6jw8uXaFLNuARFj5xROkQUfkGz+tRRbM8A+TuKsHQl?=
 =?us-ascii?Q?WYTgJ6XdKUs+M9xC6dIpByzzQDMfRarF9kt4xq0qmxxHsHDW9RySvBm4W0jF?=
 =?us-ascii?Q?+GPAlndimY/p2Mj6bxfqZfnARkLhR+RfnfX+FMshHcC4QzfjDL6U2/PMBSYG?=
 =?us-ascii?Q?8/Byny7+Oq5vaYPx5NU4v543qf6epmEfCHUN0eNTdY8KXgx2E1cA+uJvxyCY?=
 =?us-ascii?Q?QuacXa2jyovaFwlcbf50A5RfgIPs1fzG8ncUAdZmmATp50xp9ifXuIujPmKT?=
 =?us-ascii?Q?cmgeZ9t6cjgsc47yvBBsVzLoUOXMJoyEplKo/1FvTNTuvUWFBmvVHYLm16nA?=
 =?us-ascii?Q?oUxJdChrJKWR5P3Hb87qrKXINeYIv5ohb827lAwLocM51wJiis3CRv1JH2fW?=
 =?us-ascii?Q?M39rnX6QbAKhtfX/zEUwV/LO1wSQWCAjJoZdTTzoPOTqmSBnTYD0mfd1SEf8?=
 =?us-ascii?Q?7Ecl0ADdsbZ20sga0Yemu01tKNDh5PXRUNpzuEFYlqby/MOQcY+HhrSX9mdw?=
 =?us-ascii?Q?CJZ1RMW9lpJbbRLKdGzEwsX9DeGAGbjepdF74LyjnarDS+oF+byW5TlcWChN?=
 =?us-ascii?Q?s/qC/BCixSTeSJS/IYm9CB9oKfDTVrg59EqSj41++8T013UCkzCGQKkDWvM?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6SVTkEsP9zHJwptXC3sSyiZ0NmEQJ/9vt1qEq//Rgvwa504aTHEszR+gSct6?=
 =?us-ascii?Q?E7Ez2gdqsk6zVVVOe2JbBJ2rROJiOKn/nDj9PQOdepl41wzmq72McKhv9ScM?=
 =?us-ascii?Q?vyXHn86sQ2AKY4u9y+K++Bi5/BPxBQYUIvfgATIrgTal4c4XBhUr5lKbufru?=
 =?us-ascii?Q?mk7lfVjGroJcVZYdswZW9bh8Vpm1BskWW8dav05YB/+QS9oZEmeKhfjM4iAt?=
 =?us-ascii?Q?QRW7m34pRISqK3X5HpDeN/24PphtTq9ie6IlpkItzpVE2gRTe5YNb/PYwlNg?=
 =?us-ascii?Q?oneABWdBG6B5VtHaWXqEzmZjgqKyme+BWFJxCt8kr5TFfG+rPXOkwlB2xtXg?=
 =?us-ascii?Q?SODUUIRoz+7FfTV84GGvkW4KYToxJZBXD8R2zL87iH6l768Nlxs1XVveas+4?=
 =?us-ascii?Q?/EsnU9axWp8t2qcEILSEri8bCMehwcxOEcMlPNoVqKvR2MwfJAwAHP6ntB+Z?=
 =?us-ascii?Q?KR5IgQUTRu12Ux7mFFXkFi1Q6pvklFzVcBCAdVbE2Y/DFFT8xmUcw78WXC9a?=
 =?us-ascii?Q?IVZhF1iuDSlcDB9lV7gWmvL7HXXM8fkOEQcgTxs4Rt5DmnZRnSLz9eYxd8wA?=
 =?us-ascii?Q?TmFBRMg3Ehbm20gXe3AQdFM569P2UGQZ5PFucMdWTkB21IT/BU5VeX6QWPz5?=
 =?us-ascii?Q?EcV0LulV9M7uT0xe8D3JJbeMPUKvxT/vARQJir1Q2LpEsigf43QbY4aBL1//?=
 =?us-ascii?Q?FfWjWXFPN7XomAmHWsOXzCvkWX4u4upMVjVHnSrcJtd1G8uK95hn7kAXyLqh?=
 =?us-ascii?Q?Gho/4MloV2IcP6lesjI4Vqs5V7uuvdOEdili6d2QjLZ0vkZuN1ggI9HxUWma?=
 =?us-ascii?Q?rngwyQDF2I9YYNnwIm58+t1sue2FfWbWF4sxfzT5VBRtP+v0pIJ0RNb+OljL?=
 =?us-ascii?Q?H9hrNIgTSLb0vKVFT6pIG4DHmNGKwcpP25o9ZyW4i6OKWRVzY38WvXmODgZu?=
 =?us-ascii?Q?5EjZ7HZoGz7kMOCh0wtelVKKZ4TFrS5lzhS763jmcGc7CEG6H8UTIlch9LaF?=
 =?us-ascii?Q?hFo+pmhmGxRf8I0wsRggRzfDnk30aweunieSg5vZ7SkNGiUxJ0Ab2jDnZqJD?=
 =?us-ascii?Q?6n43sFkeRPOba9LaxuQnOuWD+VagEtqQmDaQgN0eN28O4iT5udYrDIjOwuOB?=
 =?us-ascii?Q?4IsvaL4NvzS6kPxksQpVXrH/r5dLufHqb7r/dDJMGTEU+Q5N1el4/ZsVAxb4?=
 =?us-ascii?Q?QEkY8Td/7zL7/1AIP01cxvEN1pJdDn8Zkt9pOCTm/3G03WBvdrc04fdxMRhb?=
 =?us-ascii?Q?ds1ZZ81WZL9eqRiHwcL6HxQblp/EeW3XCRFLR7bbdYkvzNlxIxeeg+faEocb?=
 =?us-ascii?Q?fUi1m2XE0bBfHNzkSmgrUSrXv1JlzgQCCaw7SDv83EUxWzTUf9TjxfS8sVfx?=
 =?us-ascii?Q?Ma34oXNgBBio+evzn6HpcoCmJlIHn9JvMhEQ0YsJi64lrFqWEquFK5CS31Zt?=
 =?us-ascii?Q?XRJfqVrpFuTmyOmjVlp0MQr2WunA5KqxfMl+BChDu6XQq8coMa1epTadFK1j?=
 =?us-ascii?Q?/jdPylA2jmnBaf5IVzL2ucPqoHdhMEq7CDX+3D393fmw9ABbnxoGoaWoTcHt?=
 =?us-ascii?Q?SEJjPmiN4Lng/MqnuglvbFFTLgdDCIBiugfBvRSLxmjqzXUGErAI363WqkLR?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VVNYWWNSkf6HI2Cb+lW2+/ROb3csJnBZm25gabIaymoHSwwx5+2/X01mH5FFE6HDBPTXFZ+sM2PS0/MbMhocCXSOFrgjRBN4B0ooOF4z/JjBPIFQ9Scr0M0JZEr42qWURFu5856Dco8wpRkCOqcBjqtIDwY8UG5uyDqaTvQ8NbVQ8TyOvFXq9Ejmccn9+DdWMeUPu2sFNZdHhjRxzx12jhJo07Astae3snqg+3wETJeEbv3AOK5eDPiWW15FS88ucGP8HXChUAqZIJ2HiZ77h1pCdQwLEqBgZog4rLSj7vDE9kbryHT1KRIqBRDGIW1Rz0J31bgqpvLpUzCs+jH6VOkbJJxGd8RemjUSWE7I5zppRPlRwNbiSbg7gHHBQeTO6bQ4FXWOOU/vWxaY4PfhtlefNr3j4GBbCnrij5IaS6rwyrGE1XzXF0X7iwtz8hpt1dVIxbWhJvdCl+BSm/l5+vK5NNJ1yYKVx/6WcM6lCD/ma6IjZuOK+eXWe6KobC10JQf9bEwXTeso3v6XKnn4fAjaNbf5lszB/3ks+E73hBRUhxyL9ILbO4NGSbT5EMrAa2ji9bbjVQWvVCyPPjkZ2qqJMJvbhiHoaLACCGkCUAI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 998ae957-2134-4140-292e-08dcea08ef69
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 15:25:27.8230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pl43M/aoBit9FkGkr6210+SleNWEB82PR+f74QFK0tp3eRaphXBvBE6A7MH17/7TQoXfX8bSKsNv9rshT76aXa8j4qc8SsnNoO8XliVROI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6221
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_13,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110106
X-Proofpoint-GUID: _s_D76cQeU9ZZ8ksxI4o06IEsWRzkMXJ
X-Proofpoint-ORIG-GUID: _s_D76cQeU9ZZ8ksxI4o06IEsWRzkMXJ

On Tue, Oct 08, 2024 at 01:25:31PM -0700, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    80cb3fb61135 Merge branch 'for-next/core', remote-tracking..

I can't find this commit hash any more :) presumably rebased.

Also obviously not a hugely useful bisect. I wonder if there was some other
problematic patch in this rebase...

> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci

Bit strange that the head commit references a different branch than
this... presumably they were at the same commit or?

> console output: https://syzkaller.appspot.com/x/log.txt?x=137aa7d0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b9f31443a725c681
> dashboard link: https://syzkaller.appspot.com/bug?extid=38c3a8b50658644abaca
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f94327980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177aa7d0580000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f883f65fbfeb/disk-80cb3fb6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d950aa1c78a2/vmlinux-80cb3fb6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/972c4d758a0b/Image-80cb3fb6.gz.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+38c3a8b50658644abaca@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6413 at mm/vma.c:1147 vms_complete_munmap_vmas+0x6f4/0x840 mm/vma.c:1147

This is

	VM_WARN_ON(vms->stack_vm > mm->stack_vm);

But I cannot see what possibly caused this, we've not changed how this is
done, only that we check that we don't underflow this counter now.

Very strange for this to fail only now and only here and for this to have
not reproduced except only on this now-deleted commit, and once (I see on
the dashboard it was tried several times before).

I wonder if another patch has impacted this somehow...

> Modules linked in:
> CPU: 0 UID: 0 PID: 6413 Comm: syz-executor308 Not tainted 6.12.0-rc1-syzkaller-g80cb3fb61135 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : vms_complete_munmap_vmas+0x6f4/0x840 mm/vma.c:1147
> lr : vms_complete_munmap_vmas+0x6f4/0x840 mm/vma.c:1147
> sp : ffff80009bc27550
> x29: ffff80009bc275a0 x28: ffff0000d695f800 x27: 0000000000000c00
> x26: ffff0000d695fa00 x25: ffff80009bc277d0 x24: ffff0000d695f9f8
> x23: ffff80009bc277c8 x22: 0000000000000021 x21: 00000000000010dd
> x20: 1ffff00013784ef6 x19: dfff800000000000 x18: ffff80009bc26b60
> x17: 000000000000d6db x16: ffff80008b3bde40 x15: 0000000000000010
> x14: 1ffff00013784e84 x13: 0000000000000000 x12: 0000000000000000
> x11: ffff700013784e94 x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000c2c88000 x7 : 0000000000000000 x6 : 000000000000003f
> x5 : 0000000000000040 x4 : ffffffffffffffe0 x3 : 0000000000000020
> x2 : 0000000000000000 x1 : 0000000000000021 x0 : 0000000000000c00
> Call trace:
>  vms_complete_munmap_vmas+0x6f4/0x840 mm/vma.c:1147
>  mmap_region+0xc68/0x1e28 mm/mmap.c:1533

There are two possible mmap() calls that trigger this, both hugetlb and
overwriting existing mappings.

They have some uffd logic between them however.

>  do_mmap+0x7e0/0xe00 mm/mmap.c:496
>  vm_mmap_pgoff+0x1a0/0x38c mm/util.c:588
>  ksys_mmap_pgoff+0x3f0/0x5c8 mm/mmap.c:542
>  __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
>  __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
>  __arm64_sys_mmap+0xf8/0x110 arch/arm64/kernel/sys.c:21
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:732
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:750
>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
> irq event stamp: 8790
> hardirqs last  enabled at (8789): [<ffff80008047a578>] se
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
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
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

Overall I wonder if this is a genuine issue or an interaction with some
other change. We're pretty stuck when the repro doesn't repro and the
referenced commit doesn't exist anywhere.

If this is real, I suspect it must be arm64-specific, but at the same time
given the fact things should be write-locked when these counters are
updated, I just cannot see how it can be that we are able to subtract more
on the stack counter than was previously there.

It's suspicious that in [0] we can see that arm64/mm: Implement
map_shadow_stack() is there, and we account shadow stack here.

I wonder if there is a bug in accounting pages in that code?

[0]:https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?id=80cb3fb6113554f316c79901354b2a3c81479bf5

Will see if I can get an arm64 setup going here.

