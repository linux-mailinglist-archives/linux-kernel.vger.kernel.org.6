Return-Path: <linux-kernel+bounces-335920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5870797EC95
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76C531C216E8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7484319C57D;
	Mon, 23 Sep 2024 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y22PyoJP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OFE9gizS"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEB91953A9
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727099486; cv=fail; b=n/aaEoIsWaAV2ghtEI6oDYHMZ7p9bzxGPlDBB1+tZOWDvANAtQQAKInA4R5AXkWc2u9xPGsRFLgFGeWh0F0+s0FvL4sdMxHGYr5jNhYi07AL3jbq+IEUJxcKS4SUc1ijYX9phBFEvJmSjlLN3nv9iu+jVi8aeg2VdLvnh3ZsTco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727099486; c=relaxed/simple;
	bh=ZHkmZB4Z7HGt0cIMHCPQhoQuR63NMhULxtroURFjTi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZopkdXMGXLUmJARNu0WFQkELpQb0EPyPTv+LufRW1YixSr7Oeo2fW5pXc3wDfPNKMU7ArMik6BqyBxvPFSlfCXmi8Zi37hU/yEbBHlaLUxuuVx3nmVSZSnJ9VgkdNdpXORNhcoVelYy5ZmoyUlFn2+n24HeaPS2gFc9xRjG7IM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y22PyoJP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OFE9gizS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NBiVAI018040;
	Mon, 23 Sep 2024 13:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=d6WY7YJHLbwksuM
	RMGoYhNmgXYGyIi5wStNKqHXao2s=; b=Y22PyoJPADNscO29SApZRVBW0tuDugE
	+NCB7kI5vFv7mGqiMAT43d9oANkH4I5BC4Rwi669tBUzHovnDVwv3EyyptjuNeiC
	hS6+k3GTVCD/Gfl6C94enT2xV6N7X7El+T9KItgE2kx5HmysW3Ilddtmt3fKaA8e
	FUUMIGXc2gMOabPEVT0utn8ktsL/ajWtPv2zaLy1Nz4Vjw7b8BD2YYAy8c0eIH68
	hAcgwvZPKQlxSRFQeOxbPO/Tl0o8SrU8VX6r4ZMbEy38+UwnddbTqVxAd25Vcsor
	Ig6dQqvNwxKkfKO4uonz9tZ8jJsoSK/kowTUmCOZZF2Vn0e7zlE1aXA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41snrt2840-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 13:51:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48NDe5kK038194;
	Mon, 23 Sep 2024 13:51:11 GMT
Received: from outbound.mail.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41tkc4deeb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 13:51:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IY+9rP5S1Va1q8tbZ19zMExccozMVWkEUocLQX7VbpPXdAyWmdGgzt2usG2IWCF/j7QIS6ZtcZEFqcC1cfvfReIOgW7Y8pxcsd/OvjBu5ACU/JZnkzl1gzPqXrXl3Ebdw9bzpm6o18f2LZ8rgCwuNPLarmGKWSSiOWOS+j81PkRlq9rulz/EHXa+oJMPpldcWkTDCVfQTuxmfrkkO2pUEhrUhhKa/GaBEdZ9ffZgkJBdJMU2DI7XXgwN4dh4sa+y37y6LXOH9H7vNGG3QOXAPz4pSJiKbN3L19HwfrJDHI0nM4lEfgtrH/GStGfionSa7a2H4eNqxjs6t/GRRspPNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6WY7YJHLbwksuMRMGoYhNmgXYGyIi5wStNKqHXao2s=;
 b=FVKgbIUx6iolfDkPTtuqfKGX9QSoDmjd455OaHFJxEkWLRknMhclc7X/6Hcm2t2553NlTXT+C9paWXeAM2XpHJVvmjkmTymJ/8MEuW0A2yOVqyLHMe8/2BtwEqGMF70Flod1t6Jakw9MVV+OrzlfY2WV4vD4pugaTUK+U7yMRO6wcZ8Ywcr+wd+buXkXaKQRhHXB35GY7+nXsa1HRipVnMO3ciZ91aN+bCIjCwlX1xqrVlaxpKC5f1Ci/1NbUJBKokWcFbaP3zp3sPjUt4tTFA/ML6ojTpWlXCk5nZF6cld/KkQNRAE/jpQ9kfFUwZOTURzit3D9UREZ9FhNvD3V6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6WY7YJHLbwksuMRMGoYhNmgXYGyIi5wStNKqHXao2s=;
 b=OFE9gizSt6QzqA7Dp+KjddhWCo24cgtMIcR4oQlJxaWImr2hCfJFKWpyEsQgntXh4zwSNk0Bi5id736VJY2SMeyWOFQ9RagJRxtVXbPq/8fGcSe0ULrB3hSV35IKqE8yOhQrW3A6pbq0BBwcgmB9ceQwS0FGu9fw8OBDPLU20qE=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BLAPR10MB5153.namprd10.prod.outlook.com (2603:10b6:208:330::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Mon, 23 Sep
 2024 13:51:03 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Mon, 23 Sep 2024
 13:51:03 +0000
Date: Mon, 23 Sep 2024 14:50:59 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: syzbot <syzbot+e01fa33e67abb0b3b3bb@syzkaller.appspotmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [syzbot] [mm?] KCSAN: data-race in mas_wr_store_entry /
 mtree_range_walk
Message-ID: <ba69f94f-8b6d-4906-a675-4940d990f170@lucifer.local>
References: <66f12f17.050a0220.3eed3.000b.GAE@google.com>
 <53e80bb1-9d26-4885-81fd-6fe816b4980b@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53e80bb1-9d26-4885-81fd-6fe816b4980b@lucifer.local>
X-ClientProxiedBy: LO3P265CA0030.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::12) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BLAPR10MB5153:EE_
X-MS-Office365-Filtering-Correlation-Id: a13a3027-9dbf-4bbb-5d0b-08dcdbd6c3eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hmiFlTYhUC4BQmWMbCU+icmqfMHN1YfGNHujBlMrskcnsUSp2fxLQFhR67Oa?=
 =?us-ascii?Q?LPAxCDhN0Q8wdOgNVoEVYjX/nPSQXtD9jq9aPZOvSK+faVbE/3WHOcUkXJQO?=
 =?us-ascii?Q?brNfI7Q4SQ2ejid39MtMtMtRfvkyVaQoe1Ma12Ehbu1M05Ja2BEg7RwU5mEE?=
 =?us-ascii?Q?toHIG4y2MA5Y+tFBu2DeE8MVwoipKOTWGm2blMKAMu2LfEXYZA2ZyHcbSxpd?=
 =?us-ascii?Q?917Ym+kY7733SRzMsa0RG8O3T3KhBzQvonLPDNEmZ25j6Nu/fXqmB5Fra3Am?=
 =?us-ascii?Q?lAui6uUohSzfVNC7RMbymJifMs2On3XEA+0qbi+XyhIa3AZkG0W78fUVlueS?=
 =?us-ascii?Q?oAORGAINxQVEaEgYhP9bJ7YWnlj/NR+9VLujWW7b+TJpbRfvryvg31InTmck?=
 =?us-ascii?Q?OPcwMRVSuJlHSRrah1rYKtxeT2c5NmoCOeVs7O5KS9KgpK/Thi7mV5D/zUZd?=
 =?us-ascii?Q?0X6P/Mth93uJO3ENjRT2/5DTRZsUcxxZUPN2953ZZLy2aBHD3Vhp10xnKKLr?=
 =?us-ascii?Q?qoLO2J5XFHOpShRRyIOCUI1Zqj2/4ACnfJiPI1SXcCf9iy1TXbxXSa1hmVgy?=
 =?us-ascii?Q?3cGKixcTe3KlMC2NGbwtNxuyqM8TueSKNx7RNsjOiT0v1d//RXlYc4T2MNDA?=
 =?us-ascii?Q?7Rq6cr3DEkrC4sNjCPnK0nrvvy52ZqKDhSLjN+u2yeAJXu4yKrkKkbbzLUH1?=
 =?us-ascii?Q?ylJMOEC/qeOW9/oVo0Qlr0f6JtCii7f9StvOURfA7Rt3CIgLFsqnjkA9KJxN?=
 =?us-ascii?Q?5I1zCktuaEYZxKDyA4ZSl1HoTw31zTOSbQ64YW0+CXr9Gy4bZVUbRdrNOyBv?=
 =?us-ascii?Q?pZn8BszgJU6xecDQeCw168hqw+/HOz0TE0Ccr583QLrfD5bbt2+GAsApWa7L?=
 =?us-ascii?Q?i+yyU1Fmt0qcSRQ9C7QAfjhgK9aEW/+A3GYF7FIsSfT2CoiwjM1hYBuO+3WV?=
 =?us-ascii?Q?gIwVIJib7yX2myyxXLE/qid42/IVUwxkx9j3u5KDlY6cu8CTWDF0JYvRb0uB?=
 =?us-ascii?Q?KNr0Gyos9fLdcEnFvMPwOpDp8BtbJLCxsfvic+okyd5niHPJOwCI6k7nM1wm?=
 =?us-ascii?Q?uyAzhvQrNxtje17+Evu4IFxEHdLdzu/fmWmO8od+BVPOSiLUwuaaKynluK4o?=
 =?us-ascii?Q?lEtyODxWjpCj3NEIiCnnX/D6RQO6eSfkjI7+bDgqjWwAqwU2zXK3clugp7rt?=
 =?us-ascii?Q?TUsN3VKm0vyMIbGT91HFirsYzID40hQIhUqu68Hmrl/wi1ZjhgNHg7X14FAN?=
 =?us-ascii?Q?FlUAgn6oXoijMAKXV+4VAU2IW1FoVejZ8QKnZk5k6gpYo5dpZUWcd9++3gW9?=
 =?us-ascii?Q?yDA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Atlqxr0uZLLyTU+BiZP0edRzBvuOXUrfQZs3ESPEYfXTH3WmqgWMzK3yqW5?=
 =?us-ascii?Q?7uhYEYgBlhDm3g+apJ73S+DqV1pqGWqA1J0Hh2ytnSv/VnyqOmcQE6gogI5Z?=
 =?us-ascii?Q?zxxo7RU4niTeuBOb2COkTj4Fh2kntH5B5L5dD8qLS2zhnOgSoeHTappiyltI?=
 =?us-ascii?Q?iaqsSn4T2KarnrdEvvDny1AE1wkp3vHzw2cD/aMIInjGdifL5eaHRDq1/gFP?=
 =?us-ascii?Q?0R48QDgx2fcRupat8j1DggVs5y2ZkNaFDMklwYThpS6dCHn3fzsxxcZzovNh?=
 =?us-ascii?Q?3BH0dGmmUinGBiWLgnkLEn60RTb6JnN8R7fmXUw3j2AKPE2EpGEXQChFtHrB?=
 =?us-ascii?Q?45t8fkAsZ7/N1CHU5fbfy9F85WI4E7q2hz6s2uKt7l+7IT2xUiGPUYhTO882?=
 =?us-ascii?Q?3yR/ZTDa9IgLZekuZF3iEXZJ747j6rav/XkX8DiixiwFR0ZhaHYsGa4bRlU8?=
 =?us-ascii?Q?QfT2ZMxETssWo6D+kawTbZxE/zyW28Pmjy33zV3FaGgsEwpBK0pKqAQu2z8d?=
 =?us-ascii?Q?gPW8oLJc3gaQeCVeuH0ODH8elCtxP4tPKUurdW7ix7SlWXG7Qm6N3AAGFLoL?=
 =?us-ascii?Q?jnapMUOp2MeGmrPui4kvGdOT0agRDNJSnJQigSAPoAf2orDt2ps5cdC9I8fa?=
 =?us-ascii?Q?vGe0ZOuwZuukvUbwZ85vld/k28r8yoVpLvQLkptmH1i+D0sa/Zp8v3D3gYxC?=
 =?us-ascii?Q?8dYQmGYd33C66uhc3Aw9xE72dIAr/mAWJnIcgpWD+CtpWd15rPJIg1EfHr1W?=
 =?us-ascii?Q?/7ArXb09VUrGL3y1oeAK6wMr/3qgm67kpT3VjblVclGBpv6hyh9miAj4j1xC?=
 =?us-ascii?Q?C3Mgac8CxXvzDCD8jxMnUT418JaQy13tbxcakRgvSn4Lo59dZcg6SUtMLse0?=
 =?us-ascii?Q?S1ns4n7PP87P4QYTJUSrYg//90B13UA6LTujIfS8RRWMFZho+ymgFjfwzydh?=
 =?us-ascii?Q?oKG723mvAhifRV1KktYU366FZbhofliffnBZq36NSSIZ2CCri+pKQohLkSF4?=
 =?us-ascii?Q?AJSJSLS6vckHZbIMfNXMItBR68FavEKT3vTJlm/LeoPEySUVYS0EnWJdQ4Vw?=
 =?us-ascii?Q?EkuFthKcJ8Wn2AYwW4cR49a5KjCB/FLgJgE6waXFJF5CH1zUCXsjd1qyoHSR?=
 =?us-ascii?Q?NMOWJggdvXHmGxUr8j2PHDndWnK3XGXhTUBpTKgU36o6/6xtPx+o2BPu3cNI?=
 =?us-ascii?Q?dexNKMrr8ieUH8tQJPkz1xfWrlgeW1ybtR3OCxrHz6k5I22z/o97dIsVYBXd?=
 =?us-ascii?Q?iL2lMip6Horc5gEnS/0C3ocJmC3Cr1KJEzvhDWIyIFnqF5BosytehXENahG0?=
 =?us-ascii?Q?vgPQ1OUi3zexL2X77ihw0c3aG+75FCnl0w/Cq4ca21fKQ7y+C6mbDarOrsn8?=
 =?us-ascii?Q?C/KrNWcExn0RzaZ22AlYqV7LkFiVqfBQP+c6DekUvwh3mzG/lcG3K2qkfSlx?=
 =?us-ascii?Q?s61QNEkuEwQ1QyDaEeQLqyM67X67VD7DHP26+P7fiEKVgpKBtnYwRN7XFf33?=
 =?us-ascii?Q?X5XDzCpwJXj09wA4ZQGKu13kn1+kIcCr/lWjjDR9iwF+qnY5C53BbSxCLJOQ?=
 =?us-ascii?Q?IrrmymRpev/dO4ll0qjmH7Z/+YSdaM/M4CvZhiy1X89as8+HgjL/LXtNWA5p?=
 =?us-ascii?Q?N/i5KFzkPPjGEdGCZbGQvdpzpnrzkLB9GJmImZhQtmhP4l0Fftoh+npiOoTY?=
 =?us-ascii?Q?u1UozQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DeUvGuy2bWYHl/imCXa9m9djLwuGsuqfhOyOHt0IJ3W0q7I5RX5Jrc0nfsbstUoJBSW78iA+dgxm9l8sIU5tp60tJCeu6n/BnFgyo1N1+S3QPVp+IEtyTJKBnvJeYUadoMcxNNDiv4/uBKb8HcMG4b1hf53KMB+6+kgxdMocngcT/0/WbK3jJkHZiXIZAq+mGbOfVd6GtOlUoR0IdaikbrtNfR1fs4Ji2UL0JJ3DbkesAIs0hi6FyuJ0ZQFejXW7rEuTCw9L1I6YhXREFoQq2bTtqANtX7OHcxrKckgauzs76cvGGZew9FVxMQHAYlsPa393vZcvvjcGyaS9kJWG23jUNGQb7ppGUgW2BRmPCYy3o//vHfpYWRFCGatiRr5V0WmdlJwPliyv89sGe2FxLTCCY/ASpOs1GgXXPZ61X1oNK/r6+uX5c6RDT7eKv1ffRDqP4KK+ybGCDEyGZFZ9d7DMfEk8ePSl5gWQLZGL3CPPZVz6085C+G9csi33piT50pTE3xPbqcpMSZGFb91JG0mL7pna3qJZRH/o2uE126fg/cTjM+IJBiMZhmyUcxHy+S8vs6C6JRmII8wHQWPZooHvashaafwSW4KH7s3gx+s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13a3027-9dbf-4bbb-5d0b-08dcdbd6c3eb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 13:51:03.8643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLVOH7Ck+Dx4QDqwRt0+v8Mx+gu3Gz0xODkYWIjZApv9Cjypkmk4CH31tKyokfG54XNVwG+j20gElbKZTed8iRcfLGRQOmpC4hIbIYGqieQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_10,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409230102
X-Proofpoint-GUID: 9OooMQamXZ08IyJpYhYoXtYMWKWT1pZA
X-Proofpoint-ORIG-GUID: 9OooMQamXZ08IyJpYhYoXtYMWKWT1pZA

+ Suren for VMA lock aspects.

On Mon, Sep 23, 2024 at 10:44:34AM GMT, Lorenzo Stoakes wrote:
> On Mon, Sep 23, 2024 at 02:04:23AM GMT, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    88264981f208 Merge tag 'sched_ext-for-6.12' of git://git.k..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1237ec27980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=e6702f5f2b8ed242
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e01fa33e67abb0b3b3bb
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >
>
> Thanks for the report, investigating.

TL;DR: I think there's a race, but it's in code that detects and handles
races, we probably need to add a data_race() or similar annotation.

I'll leave it to Liam (who is currently on leave) to address annotating
this if appropriate on his return, unless this becomes more urgent in the
meantime.

>
> > Unfortunately, I don't have any reproducer for this issue yet.
>
> I suspect given this is so timing-specific, a reproducer might be difficult.
>
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/95bba355b2ed/disk-88264981.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/75966f4e5286/vmlinux-88264981.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/7f1578876250/bzImage-88264981.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+e01fa33e67abb0b3b3bb@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KCSAN: data-race in mas_wr_store_entry / mtree_range_walk
> >
> > write to 0xffff888114555710 of 8 bytes by task 9573 on cpu 1:

This is:

			wr_mas->pivots[offset] = mas->index - 1;

> >  mas_wr_slot_store lib/maple_tree.c:3889 [inline]
> >  mas_wr_store_entry+0x146b/0x2d00 lib/maple_tree.c:4075
> >  mas_store_prealloc+0x6bf/0x960 lib/maple_tree.c:5520
> >  vma_iter_store mm/vma.h:470 [inline]
> >  commit_merge+0x441/0x740 mm/vma.c:609
> >  vma_expand+0x211/0x360 mm/vma.c:1024
> >  vma_merge_new_range+0x2cf/0x3e0 mm/vma.c:963
> >  mmap_region+0x887/0x16e0 mm/mmap.c:1416
> >  do_mmap+0x718/0xb60 mm/mmap.c:496
> >  vm_mmap_pgoff+0x133/0x290 mm/util.c:588
> >  ksys_mmap_pgoff+0xd0/0x330 mm/mmap.c:542
> >  x64_sys_call+0x1884/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:10
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > read to 0xffff888114555710 of 8 bytes by task 9574 on cpu 0:
> >  mtree_range_walk+0x1b4/0x460 lib/maple_tree.c:2779

This is:

			if (pivots[offset] >= mas->index) {

So we appear to be racing on this.

But... I don't think there's an actual race issue here, just maybe a need
for a data_race() wrapper or similar.

The lock_vma_under_rcu() call is an optimistic attempt to obtain a VMA, and
will try again if it is unable to get a stable reference to a VMA.

On vma_start_write() which the above stack writing to the maple tree
invokes prior to writing the maple tree, we lock the VMA for writing, and
set the vma->vm_lock_seq value equal to vma->vm_mm->mm_lock_seq, before
unlocking.

So we know that vma->vm_lock_seq == vma->vm_mm->mm_lock_seq right up until
vma_end_write_all() is called after the write is done (via
mmap_write_unlock()).

Then, in lock_vma_under_rcu(), vma_start_read() is called which bails out
if vma->vm_lock_seq == vma->vm_mm->mm_lock_seq, which it likely would be.

If you were _very_ unlucky with timing you might still get the lock on the
modified VMA, however if it was detached by then, it would have been marked
detached and lock_vma_under_rcu() will bail out, finally if we got the VMA
and it changed (e.g. expand above), we explicitly check that the address is
still in range - if it is, we're perfectly good to use it.

If lock_vma_under_rcu() bails it resorts to the slow path, no harm no foul.

I don't know why this was triggered with recent changes, maybe a timing
thing, but I don't _think_ we have an issue here. No part of this code path
really should be different here.

If we have further reports in this area or any indication of a deeper issue
I'll dive back in.

> >  mas_state_walk lib/maple_tree.c:3601 [inline]
> >  mas_walk+0x16e/0x320 lib/maple_tree.c:4948
> >  lock_vma_under_rcu+0x95/0x260 mm/memory.c:6224
> >  do_user_addr_fault arch/x86/mm/fault.c:1329 [inline]
> >  handle_page_fault arch/x86/mm/fault.c:1481 [inline]
> >  exc_page_fault+0x150/0x650 arch/x86/mm/fault.c:1539
> >  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
> >
> > value changed: 0x00007f8311576fff -> 0xffffffff8529a680
>
> This suggests we are failing to acquire an RCU lock on mmap() (though we
> have the write mmap lock).
>
> Maybe we missed an RCU lock at some point, but I'm a little baffled as to
> what could have changed in recent series to adjust this.
>
> I will dig into this and see what's going on.
>
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 0 UID: 0 PID: 9574 Comm: syz.0.2084 Tainted: G        W          6.11.0-syzkaller-08481-g88264981f208 #0
> > Tainted: [W]=WARN
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
> > ==================================================================
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup

