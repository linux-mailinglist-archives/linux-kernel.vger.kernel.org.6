Return-Path: <linux-kernel+bounces-365940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0215299EE32
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BFF31C21D42
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847301AF0BE;
	Tue, 15 Oct 2024 13:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MzHkfJcC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="si2aXKh0"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C862B14C588
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000395; cv=fail; b=sTjHpfVHL/jX/wGegijECiVXeHJlsVnMTir8sASnKj23o+uW5iidMavg6bD0fYaCN9o69Z9UgdM5tvR5wf/o1CSIAPqfjFRdlLJN2kBbLmA/QQPzwL6Icm2/4hoogHFB3YpUB1xdmKKvVerV1jtPqpN7XMWEt6cOMh0vlfAMCD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000395; c=relaxed/simple;
	bh=ayuTGbQoDSGpK7ydJ3eQI2sG2K9PwGUW4O3oVghsMx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OTuqYb2TNWk3k7dN4VTcdekFRGN2wEdNz7cGD1eACyqDZvqv/hIXpVceue05xI7oUNMr7niUiKUXJarc0B84h9Or1f0RgUfOq6KxzqO7iwtCnNRfOOowiRlksPHDyHiZwUJnu7JDttI8LdrxJ6UiJ1JLcMFKrjNjnXJW3B296hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MzHkfJcC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=si2aXKh0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FDMgGt012292;
	Tue, 15 Oct 2024 13:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=uWptQMHMx4JfLdyzJJ
	mRbbxYnkUIFHS5oGsF+EPd3OM=; b=MzHkfJcCpfKTCWDxOwpglxqgQiFYGEs43e
	P5BbiK4q7cm2XDFKeHI8++trxZK/fhLEuZECcwVVqje/13PSEIqgm32KQpaIe667
	8GfgpoJJlC2vosb2K+gioEBhZXbGqkwpmSs2lEVAXAH4bWf6jXWumv4E4Y8wc9jF
	mpcxikNEQQUr0I2QhfN4gW77ijUAaCtP0ObWLjZ3IDIqJMVcdfQvNXXaUjQPNBT3
	Gt6d1tzq5v0dw8N+O3XLW+Hm7TyChUocz8C4PCx3KFl2cs2TNlg+TlpUSkycp4lV
	h48B4EXiu5qj454RIYXMeb3EKzrzcB/xnCuWCveZiB17L6ummYjw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1ah0vy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 13:53:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FDftNE014020;
	Tue, 15 Oct 2024 13:53:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj7etya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 13:53:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQmv7Ns93Gil4Yb/ZUy20EHRNb5v80K6PRgmeH0MxbkJ2/pMAdaFrEeZUCOLBSs5j8Ym5Dj0Cwd8SNrYO9oXzdF81A2TPFnQdwsc1SHiHabBV6WvlRM8Io/zjYMKnjinFlnSHXV87hcawNyHffp1NMsg0HTuhPB+MmrB15DItJLQyQf1N4eWko3OfijUA+QzGVBSjbGSOnZ0npbg8HqMAY3F1+7j+ibwF+2Na774WXsDeEemvGf1qHrT0LNncVaDfo5nqtve28k58526QBKWYdQuzoilYIFh7hKy5okk+jWBuXzMnp5Bg8M5pjRT/tXtShzM4OEhDjiVBATSn+fNAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWptQMHMx4JfLdyzJJmRbbxYnkUIFHS5oGsF+EPd3OM=;
 b=lIqWt2BGQ/2NXNRixwGN/pCZc++/HshB3+JjWfKEOf3jYxQgL1oWdq/ir/TC+3wKZkItN2BfmUj29PWGbjrn8RrCM9YGutLCcHowQk1H65WaDfJr12xpnQxalnYXJH0ccT0uKrbpn1asiHoWC467T5IExKKCYyS74EFrePHy5i/N0pXEW4FvQCa29ZjZfANlQkXpUj0BlSP95MXHloSWpTxeYIbyfP8scQVqqjRTH+DIiqaN3YQfjVSVUn7I3JeDusryCtl+RN+kmroCy9A437xHvzLC089r9vuSWvmhyk14BOhYJm6N3sm3t9yimaxm8jAyz9s9GcSItZvFvFXglg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWptQMHMx4JfLdyzJJmRbbxYnkUIFHS5oGsF+EPd3OM=;
 b=si2aXKh0RCVQXpEOUJbivFZ2/kSKgH2Fb82wY3o/52kXRkAaktQud+lZEtogUmmBSsE1JLJr7y2e+z2vhBK3tew9tnJ6Xj7lsfMuGNxz/X/6Oqtci8NiNAp6rKOxtOZC97vaRVa8MeT1Ngj6Y+t8p3XQZtR9oKv8TS3VZ9TfYcg=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH0PR10MB4860.namprd10.prod.outlook.com (2603:10b6:610:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 13:53:00 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 13:52:59 +0000
Date: Tue, 15 Oct 2024 09:52:58 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Jiazi Li <jqqlijiazi@gmail.com>, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 2/2] maple_tree: Add some alloc node test case
Message-ID: <6zslkyydiamukudqgakplkxfr2ie6jfdnltfinnishseb3twbk@eszq5q3gkgwo>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Jiazi Li <jqqlijiazi@gmail.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
References: <20240626160631.3636515-1-Liam.Howlett@oracle.com>
 <20240626160631.3636515-2-Liam.Howlett@oracle.com>
 <20241011011759.wbw56sqgmhzjwo4k@master>
 <juxyinlfa5gn6pbhvae34xamz4zx6d5lmbkfeo5uwg5hu4ctj2@ruvlfmtbx7ji>
 <20241015133125.aixhbw5kunbme2nt@master>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015133125.aixhbw5kunbme2nt@master>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::35) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH0PR10MB4860:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b905dcf-e84d-4a61-bcbf-08dced20ae39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mOkfuSIJDjpw943qeNY5T+mcZZR+e5jyRPwRHBPmTygo4Cetdh9SQ97n/IcV?=
 =?us-ascii?Q?60WThtMeoNKKiOZpvHeilRObX2PnkCd/TFYUCnKCuefdE7doz57KAyVIdbpP?=
 =?us-ascii?Q?oCfowtsHPyXFq90BF2FQCEDF3lZaDEx71NzDJAYIDG0bLx38PO9l7ISUeE2U?=
 =?us-ascii?Q?cgJQGgpl4iVeGrp/6jsBOYRyvarFeseMIS6Til7EyFFxBYgnUHdt5/U38Xxv?=
 =?us-ascii?Q?YDsaFngIsZEWZ53T6dTezRI/E0GV68zTTclpUDL3WYqvBgLIbR3MLK1ihuhJ?=
 =?us-ascii?Q?LlC6KSk2hazPy6ezEo5rk6ACTKw5I2vxDQ8geHwsccmEagyPAACIevb1UJg0?=
 =?us-ascii?Q?2V+YmIMUB4+GArQXrzoGD1plflNGhtG8UWZb2j/yCgq40dxLJowxW7PygHJC?=
 =?us-ascii?Q?WDd8skow1xY6V6GMSUTs+7hGKZHJhs+LeNJDdsZxw2IiCJ2ZSvvJynvcwLpu?=
 =?us-ascii?Q?TkOV0vGsUA8WHMIfgUnmj9OL2E0ehNRVO/A0iLJPh0HQ1a0rhxU7FQovoJhr?=
 =?us-ascii?Q?ea3e4BYyoCU4EruMJWY24kFe2oZ5Gzc106JbkrAI5NgbCwE55OQ2sVEsRtKP?=
 =?us-ascii?Q?5FHpx6GL6tT/9hJfFOpkpeb4/Out94pKHrIMjOPyR4crh6dATX5e+D2c9lLU?=
 =?us-ascii?Q?NPNaGzVkhDckJyCBr+HmKs+A2bbBdhs1H013A+D97WHJIcQT2XxYilSB+6PE?=
 =?us-ascii?Q?AHBnZfgRBZxENmjDH1ZSCJdUbQ7o+kKuXy4YJ+6d+lkiP7athTkultkiGCSP?=
 =?us-ascii?Q?Jb296eowVyx3h4wpfB9PcTY/mRCyc84rBUBK8+y58BruThSz5PU/JRN2UA5r?=
 =?us-ascii?Q?NgPb4BOnUBeqRUHwXCI9/ac/1xDZXpNuJ6cx6JSzLZkyrJdI40Hyy/sRKA7v?=
 =?us-ascii?Q?wfq/8q5ANof/qyySTjiy6ezqHcQ+1xnL08cLqZ5GqW+aezn16/H0t04hqxXV?=
 =?us-ascii?Q?+DPvhCvSOwprnjlAihk/Y7MxQpA64PVz/XCILbvAPZSZ5zb2BAIORGX5p0Kw?=
 =?us-ascii?Q?wXifkIvsYbDjcHrmFuDClFtfItAT6VjGCyyZ7rPTD8fBNrzcz+RJscyqpsKs?=
 =?us-ascii?Q?FCa9RzflpVua6HQzXd5k5PducdxUnag8FaoQq2lddoUPGizIOhZaaHLvJ/6q?=
 =?us-ascii?Q?l55I0OESdysPDjW3OKQI/wkdTpj8ddUFI3gg0zmO2qAKqDPmeKhO22uboy8V?=
 =?us-ascii?Q?aKwxj+xOEgHOv4wx9o/I2UyrN/lUYx4IvZjsW1bhjFb2y/PS2gNVXPWHZXCj?=
 =?us-ascii?Q?D6AyWZi/i7bS+FAyNIIX6t8IVDFxWw5UYTdpB4yGDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vBUcpsxhG9ThyWFBzgjJ6GBqYdt0+eXFcescKFIzpcuzvBXBh3AGDBpcwdld?=
 =?us-ascii?Q?7MzrHHQtnlIi/JeSgMbjUnIZOM1paRN23B296IXFyb0Q5iqiF5earAjCT08C?=
 =?us-ascii?Q?4xmDK8ovqaunZOp7fW7vQmXCY3RLivDacfpHE4iJHYQ1l2/eoi2s/bCPdVYc?=
 =?us-ascii?Q?2ILd0tNWUNgh0/eeZDU7Lf/QoNyl41vjB9uNuJ1hOmiP5M7ZYRv9bMt31KMA?=
 =?us-ascii?Q?p9d4pQb6+R4ZgSH5+QhEgQt8yHdy7RY1RNyPYcGniPud6nQWkGGWlCib/vfH?=
 =?us-ascii?Q?JR99W1Sn6Q1JbSfTUoFyd37RF0snO1pf6XueRjn7dPFd6ce/0QRY7Og5kGX1?=
 =?us-ascii?Q?n8hnazBMRBDLne5WEeGsYmm71MyLqVE2twJ1eJqkQvxEhIu2+kjcfOt0exR7?=
 =?us-ascii?Q?Sdj4szypEvIwEAoNgy9wjfvZZ02nNX8YcIITQFNPnK754aiK4cVVXw/g0LbF?=
 =?us-ascii?Q?R5GrTwnripgI/a4l9Yjul5gEXzqmX91pYngj20h7MRBQVuU1dheNwkXI/qD9?=
 =?us-ascii?Q?FHgSAFMtz6rvf4ZJiSOUZpsLBJVKWUfFC1Kdu3cxoYbsR+Q2qIWijWriz4CV?=
 =?us-ascii?Q?ORnnXeaz3oLsJTXHJdX6+SmmSrjnvnrGRyN7riW2THIsox7cu5rS3gLJiL4R?=
 =?us-ascii?Q?zzUEZU3M1AEA43zRlcCYGd5q3AIK+P/4oDzBRX3F6OmhBC9Ihs3C+/SDbJvO?=
 =?us-ascii?Q?5o03ncvUdIh6m5ZvKUP2mL8m6D+1AlRA8AoSSK63Hz9tzCIaD2QR2gIuHra6?=
 =?us-ascii?Q?P6n71TPGyH4+2rMpFMBSywvmH/08YVkrAJZCX/JiET12cOjVP9tkB+wH748/?=
 =?us-ascii?Q?MKEX19BsFHZtZ07koul1ls/wZO7+t0ULJUw3PjZGp5HBqCMy/hoaifHXf+ue?=
 =?us-ascii?Q?/rf24hZSjmZOW34AtuQmSeHVEzkRo0I5+i/zx5Gp6eA9rmpb4fKCJYB3rqoH?=
 =?us-ascii?Q?+IeQuYJGdqrcRSFwJzKZsnkwCJqOi7gMp/Qpu5f6a7Yo8fVRXPrzsQhLix/L?=
 =?us-ascii?Q?0T0QJWz98t8zMgANisE5WYmv8Ana5Uw4nN394kJFc4yMyqNqEbxDg88XgL5Q?=
 =?us-ascii?Q?enWBhGJgcooflmBVt4WFv+PGA75OoBmHYrv1YjJK0jktC7l6UPFTmMA0qxni?=
 =?us-ascii?Q?gBIh9oDmVflf7+ETCCqtofPH3C7PJlqTL+Fq0XIYebhfDvVXfVBuVGoH2W23?=
 =?us-ascii?Q?4CHAqsdBDeVvY9mktVl5i4r66DHcpJL//TVUR2dUl5b8VPgsmtNaS80uYQUN?=
 =?us-ascii?Q?1xPW6VQL9nXL+l8OchRWtfDvYZEtM5U5XukWmDrtBu/Q+lZCWkk4M9OfZvGr?=
 =?us-ascii?Q?0tHMAOLmNytEt0o/9v/QgqB7TSBgsjNBY4o/05L3OYi4nz1ZfOXOqJU/vS5z?=
 =?us-ascii?Q?4iKlmlvHr0LtSvZvax31mmvVx8oUWRM5BagGrmjIhJHQPx8xxZIuSeivnJlZ?=
 =?us-ascii?Q?5LeTwkHhJCgvFL5Zlfl21oKxDBFSkrTskG9bSxE3Riz/wiwyGp5nYC6NOsDE?=
 =?us-ascii?Q?BDjuHX6bEW0cvnAaO3bGaUTdXTf4UBRBDu+YFI/SWcsTiqn27wA4qpnoXU2V?=
 =?us-ascii?Q?XSHPtdQTO6tHTLun7oehVLWx+HUXjzKpZN4KeN9T/vLCN/oLhdr8TCMnJk/W?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JaVHetOkPS8z2n8u7ih86or0MSN5sav3QVrM9+2Yi4JV82QwZcqniI83Lyl1z54V6oVi9tMZXrqiDiLC1FDeb57E3UvuaQnLRHIWhUs/lSxA+kY9jphmr8JZnJ9x33Koe8GZEwo98sL/tE3mZ7AAaL1WwLs1AEaBU0mHk9oQPADrB2vuVxKNMhBUnpX3dzc2VX/J0X3tcnjpUJLfkRBncMrZxHi/veSF2gKcbEI3g3STXhGH6zDuAMoi2Cp5GlqJi09PfaZQu7YLxWjfI6fch3mcanv4eE5pUA+QT2VLMiWlgAVAOToskQUkA9Jfwwuoh5hbbBdRPPp3csc1TRpQLVbImLjF/QbApNujxrs0VXR6L7TQBIHYM9bpZ/6YYOLhuBPOfRyJwaZcHvD0ah7BeG8c3JhpdFq46ZUW7JQBz6G/uKlHmlG2B2YypP3+mXam6LLxzrJF2+roWa5Apuj4GoO+82B32yHNSPFAXf1d1aBTMxmChvBJnP//qJj2dFwmXsuU89qYGYvU577WXi/unQ63RMJndJvMUPpZNVETQom6qKokf41w/q1zd4IBsuOfwl3hxesf0M3wR3BkzoNbXJs8cBrZ3nARNcn1cKUarB4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b905dcf-e84d-4a61-bcbf-08dced20ae39
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 13:52:59.9251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J84zLbE9XksuNwvVPgUP9E1NL2ZHfJJwbFdY6d+p6mScTXBNG0SeDTNK49NWf9oAuQin4qElasoyjdwT/PsGbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_09,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150094
X-Proofpoint-GUID: xPK3BYv67fCuBMxgA4ezEWj4G9jtKwgw
X-Proofpoint-ORIG-GUID: xPK3BYv67fCuBMxgA4ezEWj4G9jtKwgw

* Wei Yang <richard.weiyang@gmail.com> [241015 09:31]:
> On Mon, Oct 14, 2024 at 09:15:07PM -0400, Liam R. Howlett wrote:
> >* Wei Yang <richard.weiyang@gmail.com> [241010 21:18]:
> >> On Wed, Jun 26, 2024 at 12:06:31PM -0400, Liam R. Howlett wrote:
> >> >From: Jiazi Li <jqqlijiazi@gmail.com>
> >> >
> >> >Add some maple_tree alloc node tese case.
> >> >
> >> >Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> >> >Signed-off-by: Jiazi Li <jqqlijiazi@gmail.com>
> >> >Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> >> >---
> >> > tools/testing/radix-tree/maple.c | 22 ++++++++++++++++++++++
> >> > 1 file changed, 22 insertions(+)
> >> >
> >> >diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> >> >index 11f1efdf83f9..b4b5fd9f294d 100644
> >> >--- a/tools/testing/radix-tree/maple.c
> >> >+++ b/tools/testing/radix-tree/maple.c
> >> >@@ -462,6 +462,28 @@ static noinline void __init check_new_node(struct maple_tree *mt)
> >> > 	MT_BUG_ON(mt, mas_allocated(&mas) != 10 + MAPLE_ALLOC_SLOTS - 1);
> >> > 	mas_destroy(&mas);
> >> > 
> >> >+	mas.node = MA_ERROR(-ENOMEM);
> >> >+	mas_node_count(&mas, MAPLE_ALLOC_SLOTS + 1); /* Request */
> >> >+	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
> >> 
> >> I am not sure why mas_nomem() is here.
> >> 
> >> Without this one, we still can trigger the original bug.
> >
> >It will fill the maple state allocation.  Might not be needed but
> >doesn't hurt.
> >
> 
> I took another look at it. We really need mas_nomem() here, since we call
> mt_set_non_kernel(0) at the beginning of check_new_node(). 
> 
> So mas_node_count() just set the request count and mas_nomem() does the real
> allocation.
> 
> Any reason to design test case like this?

There are two types of testing that we do: ones that can call internal
functions to poke at stuff (like this one), and ones that can't which is
more like what users can do (lives in lib/test_maple_tree.c).

Both are important as this checks what we think will happen while the
other tests the integration of all our work together.

As for this particular test, the two parts work together most of the
time, but if we run out of memory then we need to test them in parts to
make sure both are doing what we think.

It also means that we can easily set up tests for scenarios that are
harder to synthesize using the external api - but they can happen.  I'm
not sure if this is the case for this test, but there were tests already
setting the allocations into certain positions and this is now just
another one of those tests.

I hope this helps explain some more of the testing work here as it is
extremely important.  I'm very pleased to have this setup to recreate
issues for both fixing issues and ensuring they do not return -
especially on large refactoring, new features or algorithms.

Thanks,
Liam

