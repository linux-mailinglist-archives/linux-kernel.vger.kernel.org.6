Return-Path: <linux-kernel+bounces-280096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFC594C598
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 22:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99BFCB26494
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A35156250;
	Thu,  8 Aug 2024 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h6inSS6R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wvg2Qmno"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A2315534E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 20:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148479; cv=fail; b=MuSjd5tmlZVLJhUxoKXbhloETPl4Wl0Ydx2MZ7E7TdjhhnHAkBgE9SWUG6FgVUHKOIqrJb8h0b1Q82LNaIv9NV5PGVeMUCu96TyCC4GYTh7f7fiPVPB4Td7RMaKzoz2DkAYHqeGIc/RQHBigAls4ujfRpiPHiCnJS1y5V98S5dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148479; c=relaxed/simple;
	bh=xIUw+wP00J5lDYN+eSPrFnSADs27k9PnYx34pIrgaY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z517IGfi3d+C5zb51RFGpOxBzkkeYIDD0mVx6R3gZVjaKgK1oyXAx2tvoLgEjTTCmVcNpw/r6V0v+Uv7H49nw7RL+YDLnvZervsaIAjYKPCveByR6u0gWpz3OhuGa09tZn9VJp8vOfItWQUr4pp8R6CUU2rpgtrC0wFRhEJS2Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h6inSS6R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wvg2Qmno; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478HfbRi031710;
	Thu, 8 Aug 2024 20:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Ny+k17WeAboY7b+
	Zs6YWn9bxrySCl62twDj4tKZJvLY=; b=h6inSS6R1RC/uclg7nhJHf5lfRzSEkh
	ybFL/HbOWIJg9LTJysN1lRARHmkX/V+dp8Rx5S7Zet3Db2gBqThdqFQFlb1G591M
	hgjlXIvTvPHNtO8xxI4dPGMxCVXBEfzVUv10GAU6LlkC5P7+/wdg4uk26QIzOO1l
	NI6RWsXUUVOhx2rrIEF2+HSTBrRHJLYvV+0/6fzexy60jUwtARC1YyisePKDtU44
	FTdvRLjAO2PaXTlF52jIpwzYBwRntya1FMEjTrqqXeARl+Akd7+EtW2nRi8t2un2
	qXku08PhlN90a0VkSymiMpdgVhCnMwCDtguuEVRQvrxiGtm75eb3hLQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sckcjq6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 20:21:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 478Jj0o0027928;
	Thu, 8 Aug 2024 20:21:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0bskqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 20:21:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEg/cZBbhxdu3Kae9QyeusXGyowBILHgeUFqicZe5Akxakm9eyQafqJEgDwtlJzY1jamNl+jSwP+9kQO4CGxFBxkUUyCY9LkRM09OBYj+x779DSu/IiywXMT9QkMNyGDMaNdAYaaePpcKYljhJ8LRuZEvol6u1mXghlaKkRi/PYbZQKA44PGejVfPl5PoEOvCYvaN9BHkY9oc9tdeU8ASF7OTrL5Ddm+OrAuVCx3IAzqXY9aKUKtBT1eE/NIoxHlBaYuKhSy3N5AFAF2NQb90KiuuuaDkSK4yroVgisnafCgnssLdUDwqDFu058GvqY71bVzsbxZS2axpdfCPA5CsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ny+k17WeAboY7b+Zs6YWn9bxrySCl62twDj4tKZJvLY=;
 b=FZEE6Kq+G4fCE9LTK9VbGp8l2+BEyKkQFG5i/ag+LJxCvSExVxa3V2Skf29+qIcS28i//fzSAJ34HPbT5LujUn1zTrJqcU+zw2rnBrodMRpxt628pN7st6+f4H76LjSLvnG179eKMqNEdfCKRCd4btR9AICOz3j6xUspvmW1JSXP9KMP0O+xWRbG8kGVyewaG1FoNt+zfoaaTdQvyMeYvZ/E+f2mndwhfcsKcsHQ79+jE5zUAjRVxtotCsX5C1IoqU9KvwGOtX8KJDVhi51XiTCG/7eeZSUQVq7iBCFnwu96hIpKnqQkQzRlT4pdWq1/l7IoWTIY+38T8mFZUqZkTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ny+k17WeAboY7b+Zs6YWn9bxrySCl62twDj4tKZJvLY=;
 b=wvg2QmnocmZSh8mwv7AwNKW56xX0iJYLLY/pAn0X5jqw/949IHQ0U9pJwP82DWOH6UjbxCqlCuoHmABZIpfWNqt+sQU3FmY52/qrQDrrpZ9tfmgWKe8H/62JDUSZV4XKFnFlgAxrmkWfD5Z5vWL46U1m1UaxmNQZ7rF3ghNBBUE=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CY5PR10MB5915.namprd10.prod.outlook.com (2603:10b6:930:2d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Thu, 8 Aug
 2024 20:21:00 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7849.008; Thu, 8 Aug 2024
 20:20:59 +0000
Date: Thu, 8 Aug 2024 16:20:57 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 04/10] mm: abstract parameters for vma_expand/shrink()
Message-ID: <s3m3vhyh6wpxksleq7f64xq45dcf4qpywtjfedhetjsl4o36zq@ayef5yglqdxt>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <95292b1d1215f49bd895f1aa38f54a8274c350af.1722849859.git.lorenzo.stoakes@oracle.com>
 <f12608ec-9c40-4977-a5a6-479f86b44e80@kernel.org>
 <2d85f8a8-6937-499c-91fd-7dc5deced71f@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d85f8a8-6937-499c-91fd-7dc5deced71f@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1P288CA0027.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::40)
 To DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CY5PR10MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: d1902c7e-f45a-4ad2-6744-08dcb7e79e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0sktzKgW1TzyivkAcM88TbLztwT8cnBGJn8BL2yLGiK0fQHDqp38spOFdNIf?=
 =?us-ascii?Q?b7g6/K9DS5D0wQXRFqqjkowXF2fn+YFuihRb6BWa6s6fmeJRDUi9UCv/dnIy?=
 =?us-ascii?Q?3RFZub2NyHuwXy3Un91CAYbLmQ6FqS7fVw/5vAJb8BgIxFVEzBa4B1CCxY+p?=
 =?us-ascii?Q?EFjTCiy1iEGP1MSLKC9RHX+1te6DTBNy/jd1+9+sT3iHSBrzdfolG0jKsklL?=
 =?us-ascii?Q?4vWm2/j4Po+WneN83FPnGI1aR2CUL+38teKZYjcXPaOf9JO54D0OkQ+BtR15?=
 =?us-ascii?Q?6HBpIBc0llcQtJK5d1yqseqzWIVdShM8mhhWvIeklUIi5OfQsyr/bBl10NFB?=
 =?us-ascii?Q?CjMFQm6ZD/U6lABeWQbc9ZszkVFemyAayPvUAOcav80d2HKjULaSKKON1UtL?=
 =?us-ascii?Q?nzudpjOgOjgVdpSwwynhW0WUYB83Ljaue+lfxmTCb27NRB+wgJW3qyaVWUcQ?=
 =?us-ascii?Q?P2/RncEd0TppA6oIixiAgRFqSrS4m11Bdrdt8YeH8cHmVZPeWrC26ma88O9P?=
 =?us-ascii?Q?BEl/5Olj/5masbx5O4jSniUoiGGJtMC4T9MwaRreJqjlSPAnKsgXGDqVbqsl?=
 =?us-ascii?Q?SPIS0imtP4jnDvKy3dLKobBCTwo4JniJl2At/Q4k8GynlEcV80hL875hH5Jq?=
 =?us-ascii?Q?2lAD3jKCs1mDFsnip2Vf4k3ERfV6/A5dec0DFlwCjCaySmuzS+vURsd0MnWZ?=
 =?us-ascii?Q?QejJIPC+PqTDghaPKAh0Bjdf59WghJQ4OQOcyA2wlq5ObCxxNuvb9p/vgtnZ?=
 =?us-ascii?Q?+rutzKLPlDhhS9DzQD5SPb8FnmQoJABlyt07rjao1CdZshG6OIbhGy34nUvR?=
 =?us-ascii?Q?3mwKKt+hP0MSKCsUQgmSX2GnuLwgYWcQ3pGb82x1ygtX3EcLZo2gdETKXqIW?=
 =?us-ascii?Q?dDkcyuMHZeJvn/rGMstlS50CC0NJvQvoxG1oBP0xiIvz3b2ar4w6GX68btpD?=
 =?us-ascii?Q?pqLrHeyIT98mI6NUDke6BFfzPJKAqTWdK95YJmnC1TjC58jRyz7VkDp6A7Dv?=
 =?us-ascii?Q?l/4UUdXFioIPE2j4bDtHz5Oj1MbR9DkYNeg5bv6Ko1miqQYO34/3nvx2hGF5?=
 =?us-ascii?Q?uolHfXyBBYLqTQtIqql8+cvygQJYW70/hsMTSJK3w0olWvmZq+Hc/Xj/f15/?=
 =?us-ascii?Q?rWA6TsRjhAPJXNTdXSNr5p4VPkFcjoGiOBZzh+E+CkhSlkjjcISd2aRntxnE?=
 =?us-ascii?Q?Fd8sshfLI5l9oBIIvT5NxEvSsP8RI5fwMa6W/4ZGUczxdqRcbAj7WGJFO06r?=
 =?us-ascii?Q?y3Gnem4lzPfZgbCtC3eiLNAR4woPNAc25A7/3faxrOnO0sYyFgzMgKTR5qlU?=
 =?us-ascii?Q?qSbJj4q+vFNf78raJbvjXRT4bpnHI0Y9LNilGt/tyyEZ/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vFCgRclrs6ki1DcxPkBWZYhMTZ3Vk+K7tfY+yk92/PHa9FU5zJEMDXUWz8vv?=
 =?us-ascii?Q?qqBFz4MfnYFbyX7lQ37t57lu30CCyC+F1td1OcTZJ44a/+YuJRxahqY89tdo?=
 =?us-ascii?Q?BIUrY5E8GhS78tsLwQ/kGUXVHvADTkRXU/dUncbLob6VfzkQFt15dNilUXq9?=
 =?us-ascii?Q?HQ8qCZQH30J0xsnRiBEZX3WxOxOmpaIA4pR+y8Rt8F/KSSSP9GWvRFKZDTwm?=
 =?us-ascii?Q?3z/ycCpfmwbMWcCUGkPeCfYdAf4DZnrPMpYykzgeB5Z03T03HdwmTE8ttRk+?=
 =?us-ascii?Q?a5c+HGUSgFaWS2xh+pT/TJu23kymiIajBMFELNBrScL+TSNdUchjdD1pai3P?=
 =?us-ascii?Q?QpmDRghb0xmYaZZdYoyZ7T2exbD/Pe8Vc8CiFjaSOO0Sm9dcXr2vrp9ZSkzl?=
 =?us-ascii?Q?ahl1/Q4g2DetgeGn+FM8E26yYwmzmXyh1IYdQUpUxxAttwpv6T8EkI+p1a63?=
 =?us-ascii?Q?TT9CshN/M7s57LQrL7AOvknfaNGtSWZeeiUrr0ftp6Sb2T3IcRJchcEFPyhi?=
 =?us-ascii?Q?gYqW/t8EPzNH2PX6W6ue7e+3rI6m0IHrcXfDFopXLesWEREFCZ6kEX3a09hy?=
 =?us-ascii?Q?CFEHnqQ+Perz86dTxFg5wqlz8yvkHWLaGtH5lNGuSwbgkSqyKvu2AMcWb/Q4?=
 =?us-ascii?Q?9em7sITplmVQh4YoOWjBKNmSGSDENz0uOOsdMoM66MLt59b+Dub3NctzbubO?=
 =?us-ascii?Q?IP0xIlWH0tuVzRTcmicy+Q8AvmliSj3JIAB8YUArKe/KIBv4IYH0FFMTel7f?=
 =?us-ascii?Q?QMrvAy+hoXZNU956Wgm3m1pfHHuu5lAwV0GGoDpRrCl4STsJ2TyGy84ZUY/s?=
 =?us-ascii?Q?YGLoKgebfhILwnHIBnSGYya+1J2Mlsb/PFeyDgODcUOyMK7pYOWWUhu3SoKZ?=
 =?us-ascii?Q?KBx0rUGb2SyXsE4SRzluD/bgArM5sT8XLhvN3fdpuIv056fhgiXw3sQ87QZ9?=
 =?us-ascii?Q?EngAnU4N4+0iqq3MyqLu5v5tAREFmCqGLmSVO1to/bNXBeXl4KXF3SJh/lDD?=
 =?us-ascii?Q?Wa7yBHRTT5wz5n0SrQ3SK7l6jBXzKmHRc9OCXeaT/MrTZ64osAFXMqYbCHdU?=
 =?us-ascii?Q?jhONzZ4B/GmT6yLWsizU1DJqPU3I+jOxr0NxZ/Ei1c4tR+c1mfDDivY+QFTW?=
 =?us-ascii?Q?2skp4YLN3g80QSVbVzAfZf3YQV0ZYqDifnJRmbmWVU53njw6zUUXwYk4s2aY?=
 =?us-ascii?Q?x7GAsTT/sc3t7KcdZ9BS9G0eZdKUi3pXT7nX0XJ9NaK31RJs6RA/uwoG6UoN?=
 =?us-ascii?Q?iROHSHN4QNudU5KiHVgFAjLG11nIrxtWnQoI6A2dtfXlfvuXT7jrrrqMrgox?=
 =?us-ascii?Q?z0WEVTv//lT0RB1SEM4SMjzdZ7enmJ6jNO9pkuulp/Vvg1DKxoVVlWoOSmQP?=
 =?us-ascii?Q?600wEQsO7xfwPxfnH9yeJ2/NbfSmeANUvEENinrpTfwimHCEWvhx3kBZyftb?=
 =?us-ascii?Q?7oT9GgCUjtTAqNeR/x0r/0AKxxvnBcAYQPpFWQu/wYBsvI2FVJ59yAuz4Tq4?=
 =?us-ascii?Q?Hl/pS91SOmZxoe/TfiE+3ofW2+g3ZYOZeEgTfGuwt5i2+dyGA9vtkonaC21T?=
 =?us-ascii?Q?vqXlWT1AzkqSBKQbv0WhuE3hfWCmLwwYjQGP5twDoNeJ6owNT7nYRzwdOEFh?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JMiSR5O/BRV96FpbUTyugL11MWp3Pr1voYS4hwWx1iygrmC63VsTo8aMBiFy1Kh18IUnTHXfPqWuYJZR5y2uTW31RdIY46RYT24xf0+xZtxG8p4QeNZ9nNgZdj7XaPEx3ZUBZejEanV3YYcKKNGNSynQpaLtbrIORJmKy5I38CJMVVAsMJ4yMhVutEjv7gwpNXElyr+dxwn1u0l9g0HyD3cpIeXmCpMW7jv6c/QsIKKlvFjuNWMyhtia8PjeeVO5wp7045hIQsH1Gh0KQXMQs8ZXgaiQ16oMYCyZm9u/V8VUUD4hT7jkv0hgHr47tC3gFqRmCDQYzGN/QJG28k0nz4zQO2jxwBevqlHsULknT0dtbGstSEpXQsNwG4yr0CSPZZAT5A4cM/m9XXY89vYNRINkT2jZpPwcP3qoi7ram09F7/+OjHaZ/g1BLgh8SOVPs9Oau4e1TDdH2BJGJr36P20DpHPqS7gTiIladreb8cJLXeykFSyJYjkLaBvwIipAvvzgtkzdU7U7QdRH2cjSjB2KhGj5gpE/Sw9hZXulML6Y36uTKYVQw0oz3mn9AU/ful9YSnVfUtdP8g8dcFCQClHkCFwIhF2+h2jHUken6fg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1902c7e-f45a-4ad2-6744-08dcb7e79e1c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 20:20:59.8933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sR6XaW3PsmwProAuSlPPhpC/sLR0RKsK/NFHnqS8gV/+xx+HQ/vdzt6deqfbBVCDFfysyDIyhg23sEIKKSKNOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5915
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_20,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408080144
X-Proofpoint-GUID: 8AEEOy6Dv7i303jOmGaKpReEuyFy6t25
X-Proofpoint-ORIG-GUID: 8AEEOy6Dv7i303jOmGaKpReEuyFy6t25

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240808 11:46]:
> On Thu, Aug 08, 2024 at 04:20:26PM GMT, Vlastimil Babka (SUSE) wrote:
> > On 8/5/24 14:13, Lorenzo Stoakes wrote:
> > > Equally use struct vma_merge_struct to abstract parameters for VMA
> > > expansion and shrinking.
> > >
> > > This leads the way to further refactoring and de-duplication by
> > > standardising the interface.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > ---
> > >  mm/mmap.c               | 30 +++++++++++--------
> > >  mm/vma.c                | 66 ++++++++++++++++++-----------------------
> > >  mm/vma.h                |  8 ++---
> > >  tools/testing/vma/vma.c | 18 +++++++++--
> > >  4 files changed, 65 insertions(+), 57 deletions(-)
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 721ced6e37b0..04145347c245 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -1367,7 +1367,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  	pgoff_t pglen = len >> PAGE_SHIFT;
> > >  	unsigned long charged = 0;
> > >  	unsigned long end = addr + len;
> > > -	unsigned long merge_start = addr, merge_end = end;
> > >  	bool writable_file_mapping = false;
> > >  	int error;
> > >  	VMA_ITERATOR(vmi, mm, addr);
> > > @@ -1423,28 +1422,26 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  	/* Attempt to expand an old mapping */
> > >  	/* Check next */
> > >  	if (next && next->vm_start == end && can_vma_merge_before(&vmg)) {
> > > -		merge_end = next->vm_end;
> > > -		vma = next;
> > > +		/* We can adjust this as can_vma_merge_after() doesn't touch */
> > > +		vmg.end = next->vm_end;
> >
> > Ugh, ok but wonder how fragile that is.
> 
> Yeah you're right this is a bit horrid, I'll find a way to make this less
> brittle.
> 
> >
> > > +		vma = vmg.vma = next;
> > >  		vmg.pgoff = next->vm_pgoff - pglen;
> > > -	}
> > >
> > > -	if (vma) {
> > > +		/* We may merge our NULL anon_vma with non-NULL in next. */
> >
> > Hm now I realize the if (vma) block probably didn't need to be added in
> > patch 2 only to removed here, it could have been part of the if (next &&
> > ...) block above already? Which is not that important, but...
> 
> You're right, will fix.
> 
> >
> > >  		vmg.anon_vma = vma->anon_vma;
> > > -		vmg.uffd_ctx = vma->vm_userfaultfd_ctx;
> >
> > I don't see why it's now ok to remove this line? Was it intended? In patch 2
> > it made sense to me to add it so the can_vma_merge_after() still has the
> > right ctx for comparing, and this didn't change?
> 
> Yeah, yikes, I think I was lost in the maelstrom of considering edge cases,
> and now this is broken for the whole prev vs. next uffd thing.
> 
> The fact the mmap stuff is not directly testable is a factor here.
> 
> TL;DR: I'll fix this, you're right.
> 
> >
> > >  	}
> > >
> > >  	/* Check prev */
> > >  	if (prev && prev->vm_end == addr && can_vma_merge_after(&vmg)) {
> > > -		merge_start = prev->vm_start;
> > > -		vma = prev;
> > > +		vmg.start = prev->vm_start;
> > > +		vma = vmg.vma = prev;
> > >  		vmg.pgoff = prev->vm_pgoff;
> > >  	} else if (prev) {
> > >  		vma_iter_next_range(&vmi);
> > >  	}
> > >
> > >  	/* Actually expand, if possible */
> > > -	if (vma &&
> > > -	    !vma_expand(&vmi, vma, merge_start, merge_end, vmg.pgoff, next)) {
> > > +	if (vma && !vma_expand(&vmg)) {
> > >  		khugepaged_enter_vma(vma, vm_flags);
> > >  		goto expanded;
> > >  	}
> > > @@ -2359,6 +2356,13 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
> > >  	VMA_ITERATOR(vmi, mm, new_start);
> > >  	struct vm_area_struct *next;
> > >  	struct mmu_gather tlb;
> > > +	struct vma_merge_struct vmg = {
> > > +		.vmi = &vmi,
> > > +		.vma = vma,
> > > +		.start = new_start,
> > > +		.end = old_end,
> > > +		.pgoff = vma->vm_pgoff,
> > > +	};
> > >
> > >  	BUG_ON(new_start > new_end);
> > >
> > > @@ -2373,7 +2377,7 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
> > >  	/*
> > >  	 * cover the whole range: [new_start, old_end)
> > >  	 */
> > > -	if (vma_expand(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
> > > +	if (vma_expand(&vmg))
> > >  		return -ENOMEM;
> > >
> > >  	/*
> > > @@ -2406,6 +2410,8 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
> > >  	tlb_finish_mmu(&tlb);
> > >
> > >  	vma_prev(&vmi);
> > > +	vmg.end = new_end;
> > > +
> > >  	/* Shrink the vma to just the new range */
> > > -	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
> > > +	return vma_shrink(&vmg);
> >
> > The vma_shrink() doesn't seem to benefit that much from vmg conversion but I
> > guess why not. Maybe this will further change anyway...
> >
> 
> No it doesn't, but it's more about being consistent with vma_expand(). We
> maybe want to find a way to unite them possibly.

No, we probably should not unite them - the shrink happens in a single
place on setup.


