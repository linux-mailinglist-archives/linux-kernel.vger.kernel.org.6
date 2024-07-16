Return-Path: <linux-kernel+bounces-254054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E964932C79
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D2B1F245D3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3262B19F477;
	Tue, 16 Jul 2024 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dPJR+L0c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GAfHWvWH"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F3A19E838
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145315; cv=fail; b=U6AviafkGaUpXcL/9FGmhba/YQFd1n1OeZBMJS1BSVxs9HOuzI9iBGDrG3Ck4X4z4tMxmkwlMnSORSDrk7VKnnXDxC1vACTCBTvcVM6TR5EqFqaWArChUvEcWh3MnmL6sQzR7VxiYHJeN8dCtvsGIR/XyTkA8CRonMio780QRig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145315; c=relaxed/simple;
	bh=nImR2qJsF+D5LmCwS3YpNoeyl+ZaKFN6TwpE7Bg7P6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gFF3/r/p8o/bHZv0S91+QDyq6KByvHKVMbAZngoZgceLrV8Lz2M6w4hkReNplQnCuMwAya6PXnQP/BC4RrYxiwSp3VNT1Ncl9jQ2z13uN5CcpAUeqP1w7rsnYuAddjzp9Klfy6ouEzh7wdTyAq4DMNzOjJQRow+xtMIh3ROiMPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dPJR+L0c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GAfHWvWH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GFMZ0Z001871;
	Tue, 16 Jul 2024 15:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=L7gigIgrA+a0JJ4
	YQMyaNGQ4cMvz53//me21+svHbQw=; b=dPJR+L0cJUIZ1tJPDYk7DFWxWxXOFzw
	DLQ54oiVqZb32yJQLndt7PKi/UEJBu0lxA7IAuow/kuakD1P+xDUWeUrXF3qTQMG
	MhvuBueK/CQqVgrWD50OvYF76ZlKZ3n773tAnwmQ6/mHNwRzCFSv5X809OpUmG3e
	rAbJmjf6jV1GaP34vowdL5M7JVba2MtKSNcD+BB3AgQsbgB3hkRrGl+ZazQ52yRV
	SW7s9cdOaQOQA/udG4THHRO5Q0vVHOI+yTOKd/kGFZCkkN6Va2Na9RIbuYjfBIiv
	E/99Pvuuoq8pD8Nsf/5R+D5Fkcq0S+tRalkdTjlOcILgvk5apsk8acQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bggb6a0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jul 2024 15:54:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46GF2huN005946;
	Tue, 16 Jul 2024 15:54:53 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40bg19gex2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jul 2024 15:54:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n01iAAbAcsXGfZPL+XDamEgrhg6LjAf9Dvibl7eTlogic7xcG02G2KYvlX1CvQHLFK8bcHI+P6gK7G7V5AmfBKr/lpq4opp/QYRNC7oMKILoOiO77ylVT9olfDDRH4oWN2OkTpolJBPXMLBEJz5cuIedx7IFutgpMvp3lICq6TVSRYADZhL0C1Ncsuw2WHrxmf8BKmpzXLAbrz2COwpzyo7GV9tFWmBHePbR5YTwm9hqoP0rnjLQJTCmmR+w/aCzkq03Ch21Yf7/jTbyDp0VS1UnOW5oRazzpmKyQmsg5lmlggI/FBZR6vg4yQdPKmflcm01FnQYVR6MZpGzmeibdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7gigIgrA+a0JJ4YQMyaNGQ4cMvz53//me21+svHbQw=;
 b=mNB7oHjvtxkxzk1o1oGj6fsZc9esj4roprC2ifLqSg1124VIw5OCTat3TBNFAy5L7spHeqHRutRYPOgsczqZQgnykDzEVOEHyfQYhUYBo8A3vX6B7GI3LotGTGCVUL672dct/pBRWH+c7mKY5qqXon6j/HbycJnXmhj4yamT/3qTCcMNOM3DZuQuDdCWEzagYShJ73mYhUrL3nhoX9l5IJqll6cOxY+vnjro0swaJB//MF10UwEVplUWC9dHcdYa27/Ig6jo4UqPZd9GO2BDbuDd8tTThuBTumfVbWkYaOw8scjdmkDATjqIFrbLUGdeipaDXdjPIyWSmhLtPOp/9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7gigIgrA+a0JJ4YQMyaNGQ4cMvz53//me21+svHbQw=;
 b=GAfHWvWHYyrmxK3WthuO8di3oJl/Oj22R7PjT1Azma51uJjvg+iCDXWfIIiAEGEJwiGXdDTCzJWQySba/oVUL15MDTQArV90G9xCFDk9hGzTpozMzc/FNiOZX3WO8bpYpx1e4x1PNDgkzouE3u5TLmqzA36+gDs2n6Xp5pDEDu0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ1PR10MB5932.namprd10.prod.outlook.com (2603:10b6:a03:489::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 16 Jul
 2024 15:54:50 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 15:54:50 +0000
Date: Tue, 16 Jul 2024 11:54:47 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] radix tree test suite: include kconfig.h with
 incomplete path
Message-ID: <xhshclihkl6d6bbh2f67yuo6qalwekc3qgf4hzvcibri74rh2q@a5qnddnskdm3>
References: <20240712074151.27009-1-richard.weiyang@gmail.com>
 <20240716021543.ghzeiq5yqtov43lk@master>
 <ZpXbalVnI9FzHMHx@casper.infradead.org>
 <20240716075609.rlw523szys2jztpy@master>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716075609.rlw523szys2jztpy@master>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0094.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::22) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ1PR10MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d030f77-7beb-4ad5-57c9-08dca5afa01b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?CYYpcRPr+QEGwc1csGCh5WJMC6fAFi5mySnzB/sy6AQRHfVxT6JbFY+HH7nU?=
 =?us-ascii?Q?6OZ8HeLfLYXLTYomtj5ihr59EMKuGu2eLvXG6c/DykcZSxVZRBIiUZ9G3xQW?=
 =?us-ascii?Q?MAYiMaRD1p9KnM8e7cWIprlkSHTYo1Wp4oVV4Y6IKwdQ/+FJrqVI36pyMbs6?=
 =?us-ascii?Q?V6t9+HCJIw/znM4sywrS+9H7Vjd7JVkn5ySggWy8RaRSZj5Um4Ug1VMYnFON?=
 =?us-ascii?Q?04BGyINRD+0lGo7wt84aN0hjCQnFZYniyPBHYs2dJweqxLxwU35xMcH0LTyk?=
 =?us-ascii?Q?B3xpoI0gr1iXSuRPB0PEpjdr0VuH9GmIO9HSa/X4BhzJXXt3YJwgspJuWOhz?=
 =?us-ascii?Q?3mKUDztjTFaHZtSZ3aa49BDNfSaFow/X0gxRh522+cmrw6msYBDzzqH6w8F6?=
 =?us-ascii?Q?VN0dq32XuU1h7m/zOgsPWecNlKcqK79ML+qErwg2solAesYN1uhxpnNUZ5gd?=
 =?us-ascii?Q?9GYQDQquP0+PUS3pw9I8gdYzzilKT5lQUi+NRhkT4otNHBG08wI3pIp4JPYb?=
 =?us-ascii?Q?NnpnlNB+SBHTDlE0WlN3WihOvWcG+aor1UeUTfy9MDTBDVfchlXmbu5gG1Z3?=
 =?us-ascii?Q?+jtcYgny9aB3fAG6VsH68RzuaYiFyIeIDsWNdkYJwvHrLvPn4qCyAt/QE9h9?=
 =?us-ascii?Q?0egDW4KenHgaL++Gua3WKjp89s/iPRSlhx6HC30zcb4LMpsU6UlXZp8/Rx7Z?=
 =?us-ascii?Q?n/K9lhQ+ctcw+SOLZD6YBPKD01vO0PyQX2dS8XHNIGNKARxlmpHVGRFFZwEB?=
 =?us-ascii?Q?5ffBarwFVXWFVWQme7l5E/PUzuF3/gfj5Yt3DTUE2cEy/Xs0gtkpUUrJKCRA?=
 =?us-ascii?Q?3nriX4E0yS9mRsMs/46sZXnSVyQdKn67uxXrmPwTs3gnlLx05CdJrUTvdoqd?=
 =?us-ascii?Q?A1X38ntYGxJHZj7D1BKr+vX2BWSey/egmKkXi0k+jZKYFCGKSC821T00vmcy?=
 =?us-ascii?Q?Shp8uxthEPSCDZATD/sUA01UP6LCkyqN5XjCethttJ2CbiRQcnk4fI0QKFD8?=
 =?us-ascii?Q?8y9iq/4Zx7lxNVJeFeJAhEtdUAYZUd3f+EE1pGlCoDVrDRczljhuUd8/AR3u?=
 =?us-ascii?Q?zYPXWFerDtVjwd9vkwyu3N23zHczs1kio0stwSj9F619vooF3V1FNjT1o9T/?=
 =?us-ascii?Q?iSh12Q1pwedE+vAwOd1wX7NHXuk6Nd12ZJfKOLTZ7NMbIo3sMXr/OadxLaCs?=
 =?us-ascii?Q?x5APhzXGY33haLtb5+wb9UTuB5P/i8zQ/rS/05b4QSmW6AerIZArHmhImmEi?=
 =?us-ascii?Q?Rs5/Ju6dIJSgaMOrSu9gmNbOXS3WbR+xB/+aNHHyVsxMsPPUmBhD7RaO8Man?=
 =?us-ascii?Q?FL6W6W1y+qJBkhlulSBlTXqOJzRPHXWOAVzzKk+hsiGOxg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?z93X1p4vAV8mVATDQ/UjR9bX2UFwOsjAluCuJihY5kT+ISXfyNxO6s8273/s?=
 =?us-ascii?Q?g071kt9Ehl7CPhB/LCagSMAyOg3uLLWtZQ6+6s0XWheNid6E+wS+wwPrbsij?=
 =?us-ascii?Q?2SAqvzJPWNBpTL6+gV0Tvp+eubW1/8OodTszwZvOM5Szl/ROdeD+RcZ7rPfj?=
 =?us-ascii?Q?whobY28A0Kd66uInUSzPadaryrOYkX7QK5zC4aC//JK8I9ZsDO33tlWLCZPR?=
 =?us-ascii?Q?F9me4JZPjsTfox1F1WMzjVfft5cLK/jj+zpUiZ4PSeCV7+ggU+uydA9tM7Vh?=
 =?us-ascii?Q?Uqj//FP8bSucxEYW6RBqtF6vqZbdB5SAZ0UW5hnSJrINYNiQU9Mm1f9AHUQm?=
 =?us-ascii?Q?M+n+v0hcN1x17ehSRH0sZHBoa/fG8VWvstTG9Mp4N5fOFsDJaZvjMAMzfSWt?=
 =?us-ascii?Q?ZHX41LU3Usktf1QekE9Jn3xP059MUCZgZpDQNW/DydEgLAy4BaYaJ80Nqxau?=
 =?us-ascii?Q?pzsO9OxQLphNHwfzugZJJ3Tq+851NUirwnUdDbNpElu1wxqyQFA33BAsmDyN?=
 =?us-ascii?Q?et+lpjQ2zfvIAUO4islfmdtu30BFNwTg/NoG1bl9lDKmCJPgKiotjmDxjTjt?=
 =?us-ascii?Q?Ebt0L0vc7/bXUKghBsBICtYqJLy4Wiu4ThbYPCD2R0NJBJu4sZ7k2NESM7M4?=
 =?us-ascii?Q?UyEzzoXuA9fFdZAYp3pHNWRi5dFfB4GwM/JwIGPvRqq1MteGUR3zzAyG0dbi?=
 =?us-ascii?Q?L1xesWj4WklZhCl37KCe3SiY/9xKzAqYIZZ8hZHvebIzbLBHXqhow9KDGRrY?=
 =?us-ascii?Q?/0hg55xY9KrwCYtWX8ykjlO68nzL5AjFpPJ4aKSRJupjpC/wEcsWtzSdvJM8?=
 =?us-ascii?Q?Qkr+5MPZ59OuSvR6R5+uB1moKq48H3+jG/BVlVH+SFOMOqeYYkcK5tXmgaaB?=
 =?us-ascii?Q?SnqfryP2YazEx/Hv4dn+0fuLd3jDBFG8AFHa8syCOhaIFiR4a3+hBcMMwL5O?=
 =?us-ascii?Q?+O83e5LDYNOUrJmyVE16ieRBpbRZ0u0S/RCnsdaiXJanHdf3DW8iLY8mz2WQ?=
 =?us-ascii?Q?3JsPS8BEyfE80beEQkWm6RPdQwVTrheRGooZ7xW5YvC1qqGWaHifIRm/vQHM?=
 =?us-ascii?Q?CEikVvyDktv9AbMdJJ4W8oxhUAlXq2gcq3faDwutDfy7OUthaKkG2DDENEsE?=
 =?us-ascii?Q?nkmJ19/96EsFfoDVJe0tauKOoZhNalhJWEwJ/x4WMSKyFyh0wI4BX2QDp+RV?=
 =?us-ascii?Q?uQ6iczhndR8DAe8HD6eA3bKk9WFd2XfgjKR8GF2aKfpB0X3/Vpg87en+p6LB?=
 =?us-ascii?Q?NU2nfmZYnZ+r70JifyK+jPsl5m3mdmSxyr1WHfduyTcIsDE7gPrl0FMcK+Km?=
 =?us-ascii?Q?JLxOztyRyBVnjGsuQc4OYlsl1F2f11FcwK4Not552zB7yFgVz8y3NhE3ylW4?=
 =?us-ascii?Q?Vg8YA1oRnD/sf5s/D5+UHpuF2/I2gxr2nZywdF/1Nc01zsMIE/FfXa/4MyIc?=
 =?us-ascii?Q?6P292JPbQSaE8Pt06U4bHA1y7ONogsOm+BGI7LS063O6jtAORq8+p4lH/jiC?=
 =?us-ascii?Q?JIF4Bo1m82WhkrfSEtT2xwZJ+nW8jDCaFUsmR+4UlQHNKltY/UV/J/8UQMs1?=
 =?us-ascii?Q?ILDWmf5n6EvMtQATZqPKWB15jAd7uj8vBTh839CB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DuNypSincbocq6rTnonSioBkxpwmPcbE9Wx6oByxSrDZWaPf6omLY8z4kBNjZ/7fpoW1j3ew9hwmkrpSQGZ4mB2EvXxPhhqUsisHtyBKgrlaV2GRqssuANhD46LfkHKJTEdRNlO0pOaCnk1A+RsQF7tsT0uHz/bKAQELf3h3IJKh4XqGvSPV+zXYk2DSizp/+6zUWzPypaD3HF1Msqf/rqyi8fB0kEwqAnUdfc1q7QtTVT8YmVGQNHlYjYldbuKJw6VyWEajrQ/XAlvV4oQ4iaJQEmgDVfe7dcNNTtod9KpWm98rDKVGNgdTmEUe6Eyv7NMJ9ASDRbaiUXqqIyEjKojC4tUUqMiRGQGvwpYuCIvlHUXAPk9qIhdh0uUjsmB6mD60LK7+S9pagLRXh04eZx6LXLsf5ZLhufaEakxNA1ZlKhcBhWE3meeDIxLPX6eJ7BqCMGTcmpvdB3muQ9NwP2akVIdTsrl/VOrdJYjLbMh1L0h6nnl6TwnddeO+oIhIVMSxAC+7DmBQ2o2xAe02VnHwX7iBcO3GXMI1ZQmZlPiPpO9hzWhiP2aWiLNph67mZ+53AXdK1kmcn4VqDrMQTkvBPhBASBhAvmmGsXPHeas=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d030f77-7beb-4ad5-57c9-08dca5afa01b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 15:54:50.5138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKBrJCrgpW9nYqxAyojLplt1IslNEiiYJkNCX2vDEz4mBIY1JLZ3NW6L0wEzuafpz3ws6wcwfRsQNUtazkveug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5932
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=702 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407160117
X-Proofpoint-GUID: HjZBMQXTI91ztspvZkF82Ve7uRmFlK9k
X-Proofpoint-ORIG-GUID: HjZBMQXTI91ztspvZkF82Ve7uRmFlK9k

* Wei Yang <richard.weiyang@gmail.com> [240716 03:56]:
> On Tue, Jul 16, 2024 at 03:31:06AM +0100, Matthew Wilcox wrote:
> >On Tue, Jul 16, 2024 at 02:15:43AM +0000, Wei Yang wrote:
> >> If you think my understanding is correct, I would send a v2 with proper
> >> changelog to describe it.
> >
> >It seems like you're trying to change something that isn't broken.
> 
> Currently we don't find the problem because these two kconfig.h is similar.
> The only difference is the one in tools/ doesn't include "generated/autoconf.h".

We need that include.

> 
> And in related files, like include/linux/xarray.h, includes the correct
> kconfig.h.
> 
> It is not broken, but doesn't mean it is correct, IMO.

This is really annoying because it works today and your change was
correct enough to look right, but it doesn't include the
generated/autoconf.h  - so it's not right.  It took a lot of time to
figure out that it isn't right.

Instead of forward progress, I am spending time debugging make and
compile considerations in test code that works today.  So, maybe it's
not exactly what you want to see in test code, but it doesn't mean it is
worth my time.

Don't change this until there is a reason to make the change.

Thanks,
Liam

