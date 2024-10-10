Return-Path: <linux-kernel+bounces-359443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F8A998B92
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E874280793
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6701CC17A;
	Thu, 10 Oct 2024 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X0cK43+m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tEMgVVBk"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A9E1CC17B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574130; cv=fail; b=omK0r5PMkdvue12UaNDyIGa/ilgHjSFI2fHXj/DxzF4ksFCFdnn5xftwh0QMHUbxWLVxK31YtT8hrr+luF1lRSmbwv9jNEaqkulkcuyvhB38uCjARimudnfxkVynd78VTHGC33tlb3rcYTO2RyE9AYwICsyYWRopYeWpo+5ntxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574130; c=relaxed/simple;
	bh=eOx9hQfSX2FK1A9yumqTae0Wt4pCenvm7Vgs+cIDSxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K0X0kNBXoNOyrYRnFA/vQ35Y8x3JxyTDGl1L2HJknZQ+HLZsLvDdTMw8UFHcsJIIZ9EdyPqEnrfaBS/z0kjTTj4lMk3lbtbuBtyjWvyiRJZRsSBxast86jWmnk+pNDoPQtMx2l396wKNOXi9Kq6RmfmcZw7NC+OxjR0sclYC+RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X0cK43+m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tEMgVVBk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ABMZml024958;
	Thu, 10 Oct 2024 15:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=FaepQikAFLGP5womBb
	SLMNgZ8V12+FFGXk6LAegNaKI=; b=X0cK43+m4wR7NCXlmNMXqzvlhEyoabYINu
	vFJmc/w4gIpiY/S/DqZaJpGuHDMK2SmY8PHREweey1gtcH4/W6KDPV0OJOCDUPbe
	AMNZqB9qq3VXzA1ddOysDFsbWkk1KWxB+NaCfRUrhl9MNyygWMOjDnc5eT5VFkYU
	QRlh2GEmioCgVlWDd0HjS7mD0/w1QnCTKzJ5IgaLtf1pMQZ8VGO3avU1NBVdfY/s
	OtZIh/Tom3+AQeG1H4RIxfK7SFhNSQhO1+jIEes8KxpUCVrDpCU4Y5tPmFgh2N6f
	jObT5YBfJgqaGHGap5rvygCew6fWKzmcBvMtOr4xOnkZiexANscw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423034ud92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 15:28:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49AEWhF0015316;
	Thu, 10 Oct 2024 15:28:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwa6bfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 15:28:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysohMG4b1Jc2eyzoE0tKJOij1bMfMyGqpTx3BCta0gxS1xK8P9vi6S0xu7st8Uin7X3/0ouuoEsBxONT+I7CsNXb25B3hxIFHXtMrWn9hq3cQx1WjxKrY+06h0YGg1OMTFdpSTuvlZJNYoGMchDGPxlG1oJb5Vyh3/i/KwCgXRYZ3oBiV34nqIItCYTc2xO24RkdYmqAEiCHEU7OnMjg2OUWa5rjXs8SKviTT9qzPiab0Nb27PBd3N42EuJZNmu6fJAnuB5//aXKk72zgtbUv2UgAhjComx2kt294upVo3O23d0F1uw/8K8dFXC1KvOY0JJT5kU+NhPgjOzN1No04Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaepQikAFLGP5womBbSLMNgZ8V12+FFGXk6LAegNaKI=;
 b=fybRz7xSu4kNjYYQYD3OpKE4CE7lrvSeD0nqLx8MnovJyY6d8pnx2Qu4F/aSg/fwY/qDn+LsELLFY1kHh9cfKOPlYOnrr7E1fiOOI6H6uZoIU6Pm0vkfalvfh1smnqWbT+ZgiLNW0ac5zUpBADbrmSqrLj14xa3ed+o2WDBIe0eKgsg1utncj/8+J884iRG5uqhL3U4Ho+DNMrbnuCl4uu4PrFjuvMMjDKBqQ690nBpGcMvOUpAtu1T2rvEXnXWWuFF/ja3j2RN0ESVmyx+hp1IUp4taLtJ09zf+pWyeXoeU5uBKlk++NZ2MOEiZ23y3wP0B1zBb+K7rG/7it7xPDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaepQikAFLGP5womBbSLMNgZ8V12+FFGXk6LAegNaKI=;
 b=tEMgVVBkF/dManRQRgbMF3vvQHkUmW0zwkYf3n6ksmBk9gbTe4g9f9Rn7lnXjYGIGke1rOcaT/nNbiSvrl1ohUDjnNHmxu2vOJqaGjZ4Nc69x2iG0Vuff3yyifR+N6wtJeBLJtDEzF58B4JRyyPLEq6AWkDP1p/kflPEz/zS4qc=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB7128.namprd10.prod.outlook.com (2603:10b6:8:dd::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.16; Thu, 10 Oct 2024 15:28:22 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 15:28:22 +0000
Date: Thu, 10 Oct 2024 16:28:18 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: syzbot <syzbot+39bc767144c55c8db0ea@syzkaller.appspotmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] INFO: task hung in exit_mmap
Message-ID: <72188763-843c-4e83-a25a-90be2d0bf9c0@lucifer.local>
References: <6707f080.050a0220.64b99.001c.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6707f080.050a0220.64b99.001c.GAE@google.com>
X-ClientProxiedBy: LNXP265CA0038.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::26) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: c422c5f9-a3eb-4cbd-0a15-08dce9402ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cXjoIDXvNe06XKcQ2bO3HhYul2BvokUhmdOIYS0AELz6VCHqqksxUKJ6dXgY?=
 =?us-ascii?Q?SZgJmZlbEW2UJ39z1/PbQdD10XT3yI+Qq9w/WnjGH2qyHBnDxkTytZofMSRc?=
 =?us-ascii?Q?YfOrW/pQg8W1vz/1WTPf8CerTl6yIWdg3zOr1ucVquaPu3vayVm1FN+jROMH?=
 =?us-ascii?Q?1bwmKd1uXzJ8v6rrRho5nzKnZdyOLdqAe7mXHYcJ6cJTyCeIm4Xtf6l5Gs23?=
 =?us-ascii?Q?Vcot8qnKFRBEQ/OziczNz3HzumJXr5i2JVqZgeWNLKkAVfQaz34iNoJJG66b?=
 =?us-ascii?Q?WR/1Fj1dTc3Bd7W4XdAlZ9BguwV3Iv2vZF0xYkWRFy3tBp8aKhMEA7uwOerm?=
 =?us-ascii?Q?Ea0CS5l1T9u9nrJexZTmDucRUGT/93RAGpUvJoXh1PxFJ2JHh1VnLnOPonB6?=
 =?us-ascii?Q?1VDCNdHkUHjoXFDPpJ48DQT5RSn7PVjNSeGtEI4UPzIIn6SbVv7MiIbUPu/S?=
 =?us-ascii?Q?gqU5jAZmSZK0fmdEBWpBeQnNd4h5AI+QLUqmIN3IGQQR8/V6ze86WddXkhoM?=
 =?us-ascii?Q?iJgUFy8NU8JMoxMnGnr4oJIPYGeCMXXP9htnaiOjYEJ24Ps4OYaWBoET90T5?=
 =?us-ascii?Q?+EatUdM5W9FDN67/9TSHoS+g7fTUggMIWl95DnJ56xllt7zvebWDjLVoPodh?=
 =?us-ascii?Q?mgQaD7fesr/fqhNlxnelGjZW0tOEVVTidYYZOOxwox1cGKWUmyD1ndIp/WOd?=
 =?us-ascii?Q?ZfNobm3/+1CwWN5IvFqM3pYbAD5DE4iiADg9Ktb5Yo49Q3ElunKTiHjrCIll?=
 =?us-ascii?Q?o5ZsKMEji+DdXUV+qAo//c5r60hmFkUXZ5M/5QqSS/qTEZsfiiLbyLBqK3aJ?=
 =?us-ascii?Q?8//NyYS9T0AYJKSlQZJTv0tF7oelnwC8j0uR3o0dAA6vYKkXox0bRmPspCVC?=
 =?us-ascii?Q?9q7+QzteynrwoD5CimAPC4gES09vnVzSY3hfJeHK6PwsiodJ0Nn8MXMicgdH?=
 =?us-ascii?Q?s7T9Rsf4xC7lXtZEHFKg5cAlqjkeGRb9zFoN1c569KR+qcunQAs0Rp/QkwfO?=
 =?us-ascii?Q?4DmG1C0EwmWrMLHPO3HUwGfJr2NIf39+iQQuG7eqwhEAq4nISQqIp5YREL33?=
 =?us-ascii?Q?+eBoUXKkgyYhULFOB5HhMMKTheLVJA3EtFZuHg5ohihjx0RUGHU3vIp/uBmo?=
 =?us-ascii?Q?MVFkKQkeo8nd/fqgDD+iG3XP/cl3cKoKfeXt+aiwcCtperYFDFdidGmIl+fS?=
 =?us-ascii?Q?YwhMWWAKyVTZ8fJXOErT/SacTi/gi7RVy1Gv4D7wENeJ/yjLrtpzcTJE9MY?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6q0EXPxeaReVqOjWl4e268gKYqcRHMmtgnV6fW6RNj4cnrVoVKpQu6NDwL2W?=
 =?us-ascii?Q?VveQldCmVNJJ6yqsOR4cKEHah5FJ4yzLLUo6fwo8IEbc+xyyoBH5xDMV9ivY?=
 =?us-ascii?Q?NB5qyYdSK2m1nTErlRXFtTHX69XjnFnYae3VPUAa7Kf3AbA03UXPh4f2XEiB?=
 =?us-ascii?Q?DuPpO+UM7OA3SYU9wCnzYkPVy49dgbjb/DMOl8QbvNNlhlBy1QW/0w4QYVbn?=
 =?us-ascii?Q?WD+bJCzz5R0i8LSeGRTKQqExMNzJgtuy69zt1+0zmTEWWw2577FFZAdB/aSA?=
 =?us-ascii?Q?hrgiTPQC9408mdqCRGQsv7BJe3B7v2mwxvqeguD5h8H67h721DYUrz5HBpAr?=
 =?us-ascii?Q?MPdFf7hC8ecm2tuP1LyT6oMo0Z6V89i2ouO5OlPvQPCyAPbLZWK9PxcLa7EB?=
 =?us-ascii?Q?E4HPEw13kWvWdh8uWolApiH20IemoD5ycc8mg3yFwVwRBltdIdIpBP5a5Bfz?=
 =?us-ascii?Q?j+a1Jfh56H1EUWJmE2xaAmXQ69Yi2C7KBKPLjnHEqFo8hotByIi0xcMGlsm6?=
 =?us-ascii?Q?YkyBOsdar7/b5k4wzKPcGo7oq4BCukyxD/aYT6NUFxJh5MM8xsttK//LOvxt?=
 =?us-ascii?Q?WsIm+6WlgfwXUukwOUVZGpJ4+jR15c/cpv+d+AThu/1DukKvujt+aHCHomxv?=
 =?us-ascii?Q?zzt05/cubHHBh+dSWc8dGfMZxtF73KoPAEnJtIl5YtfI6BkwArPXqpQcAH5+?=
 =?us-ascii?Q?sELeqbmVcJw8gya/y8HNmZqaC+gHLZDqsHlkJxc/IJBAoE13PAoc2rgDtdb/?=
 =?us-ascii?Q?oTwYWD0tO5P5HWQ5p/rpAc0TPQnB1RngC45Qgy+enJxqiOit+WStTiBATfqm?=
 =?us-ascii?Q?6++y1XLZpjrXvj3fXdMFET9Nxq8ow5JUPIWeyYmZeZUjOZ0E9jdK0J5ZYGlW?=
 =?us-ascii?Q?fZEnlNgq/x6UAmA/2SWwbtSVubEQETG+U3x7sUiUhT8CxqqjXbqq8Aq54Srq?=
 =?us-ascii?Q?IYYqUEtWQmnCH8MCXz4lFZ0X8eVrbkFPAD7J9wqUlFq77UFvDCN4UTkXHu7F?=
 =?us-ascii?Q?0cWEp5TnoSPgR3RsLilCTjSghiF2n1VgmyqxZ90wzwMjbztwVBCd463C0Hcy?=
 =?us-ascii?Q?jk/jMXTz7O5Q5uAFdhvr3H96P86L9q8uEXSh7cmM0rC2TAXb5TxCdHOqmi3v?=
 =?us-ascii?Q?62VvmjtZdp2TnAvf7jiGvR9/0YBx1R71B+9bJziJMX3e99A4B9hTx0hX7iA6?=
 =?us-ascii?Q?MQ3hmwmXLg833NLdYNxougpWzbEVpWf/Ks2UsdY9vlTMbx6p3XEiQ4ta8UmA?=
 =?us-ascii?Q?YMx9eCUbThweEncK1NZEUpKm/o8/L0UOGBPi4Fd7+twthyyaMlG72b29Lhgf?=
 =?us-ascii?Q?b7VxpbFkJIzSg0wAZ7AVjFp1O3ZZApQZ9Sf580nkNlux4Qm47zLpq0BgQRR+?=
 =?us-ascii?Q?WbrO3tWkcnyctUYokqzDOEnTBNcnWTz1lxT5lXjf2UArkivE2HPCkW58CQtK?=
 =?us-ascii?Q?B7VOhuH+Z/4pvVJohLu6DCNC7L71ZQG9MZ25OGkAuVXMochFUlrSHmABGjFO?=
 =?us-ascii?Q?VeWIGc590pkXOcgObj25Xus1slifVq4W1wSnpG3ZgdMnIIU6UL4fSOLk8L1s?=
 =?us-ascii?Q?6YcjCKCYgQFjZR/NhMoHwHwxRa0xev5suZ4E8ezyALTgC4EUaeIaqUp4FMnE?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e7KAlkrqvlJqgUZ9HIKEwA6t4eb1O8gCVxVchO4IVi5WxqH5Ns16ZYqy62x1VmM+NHWYS2nG9rTTPh+Isasrn/cwMe9wqm++E4SRQ/dNKdilbYKHebvVY5QsaEvgUgqXZ9dJvK4ZrPHLvFYV4sqbhydQKgQ5TO5T6uphdQ+SXsOdrlTO1dob1qINibKH6fdXpCvPVJ2y7hu2j8UYdGKqUM+vJIOcX4C2eMubSzBPgbv4wbl53npit/j8k8RnFFuDcTTxS/U2gIdolX/F2dMFGtx5xRbVYfzrTaoEJowYW9F6yxPUb31EzC3gPXe7MDE+W8MqyBSN2ReyoVFXmK1SmZjXAgdA2+dk5pzFDV9wugXfkxgybTPVKNMA+XQGCPo+zSfr93uecSEjaTDWnwii9Y738kBl/FOEGacoiNNacFgzpLQXFFQ7xVOCcAHjN5KWLgXhZ6+zR/f0Y/VkY32x/x/+qqzElKgLHjBt+XmpXrs+dtbhab+9U85bKCCayPWh5abkQStQ6YzoWLhG9Adg6SESgkmsdApd0a8jGQPH8f8UypZuGCDbO7kYAev9FSzVXreJUE00ZpqUK8hnoKa/o2cxelP9Rx0wL2sTF6Ukuvc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c422c5f9-a3eb-4cbd-0a15-08dce9402ccc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 15:28:22.0953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgRowU+4gpCs4HHfyGDBsfB27E2ZK2VVS65CA0/Lt5nLoggtDG9dy7W7+50wfRdEr4ocQYjlCuITbFopeVumagLWHjqmCii4VYmeu/9jm4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7128
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_11,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410100103
X-Proofpoint-GUID: lTbI8eHwCl-_CmO_MuWai-7hiAAum_ww
X-Proofpoint-ORIG-GUID: lTbI8eHwCl-_CmO_MuWai-7hiAAum_ww

On Thu, Oct 10, 2024 at 08:19:28AM -0700, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    d3d1556696c1 Merge tag 'mm-hotfixes-stable-2024-10-09-15-4..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10416fd0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3fccdd0bb995
> dashboard link: https://syzkaller.appspot.com/bug?extid=39bc767144c55c8db0ea
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0600b551e610/disk-d3d15566.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d59d43ed3976/vmlinux-d3d15566.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e686a3e7e0d6/bzImage-d3d15566.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+39bc767144c55c8db0ea@syzkaller.appspotmail.com
>
> INFO: task syz.3.917:7739 blocked for more than 146 seconds.
>       Not tainted 6.12.0-rc2-syzkaller-00074-gd3d1556696c1 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.3.917       state:D stack:23808 pid:7739  tgid:7739  ppid:5232   flags:0x00004000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5322 [inline]
>  __schedule+0x1843/0x4ae0 kernel/sched/core.c:6682
>  __schedule_loop kernel/sched/core.c:6759 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6774
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
>  rwsem_down_write_slowpath+0xeee/0x13b0 kernel/locking/rwsem.c:1176
>  __down_write_common kernel/locking/rwsem.c:1304 [inline]
>  __down_write kernel/locking/rwsem.c:1313 [inline]
>  down_write+0x1d7/0x220 kernel/locking/rwsem.c:1578
>  mmap_write_lock include/linux/mmap_lock.h:106 [inline]
>  exit_mmap+0x2bd/0xc40 mm/mmap.c:1872

Hmm, task freezing up or system becoming unstable/locked up is reminsecent
of the maple tree bug I fixed in [0], which is still in the unstable hotfix
branch.

This is likely not going to repro as it's quite heisenbug-ish to trigger
and the failures are like this - somewhat disconnected from the cause, so
not sure if there is any case to speed this to Linus's tree.

On the other hand it's a pretty serious problem for stability and likely to
continue to manifest in nasty ways like this.

Can't be 100% sure this is the cause, but seems likely.

[0]:https://lore.kernel.org/linux-mm/48b349a2a0f7c76e18772712d0997a5e12ab0a3b.1728314403.git.lorenzo.stoakes@oracle.com/

>  __mmput+0x115/0x380 kernel/fork.c:1347
>  exit_mm+0x220/0x310 kernel/exit.c:571
>  do_exit+0x9b2/0x28e0 kernel/exit.c:926
>  do_group_exit+0x207/0x2c0 kernel/exit.c:1088
>  __do_sys_exit_group kernel/exit.c:1099 [inline]
>  __se_sys_exit_group kernel/exit.c:1097 [inline]
>  __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
>  x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f4688f7dff9
> RSP: 002b:00007ffea64ebf18 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4688f7dff9
> RDX: 0000000000000064 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 00007ffea64ebf6c R08: 00007ffea64ebfff R09: 0000000000028eb6
> R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000000032
> R13: 0000000000028eb6 R14: 0000000000028d0c R15: 00007ffea64ebfc0
>  </TASK>
> INFO: task syz.0.828:7756 blocked for more than 152 seconds.
>       Not tainted 6.12.0-rc2-syzkaller-00074-gd3d1556696c1 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.0.828       state:D stack:22384 pid:7756  tgid:7755  ppid:7346   flags:0x00004000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5322 [inline]
>  __schedule+0x1843/0x4ae0 kernel/sched/core.c:6682
>  __schedule_loop kernel/sched/core.c:6759 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6774
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
>  rwsem_down_write_slowpath+0xeee/0x13b0 kernel/locking/rwsem.c:1176
>  __down_write_common kernel/locking/rwsem.c:1304 [inline]
>  __down_write kernel/locking/rwsem.c:1313 [inline]
>  down_write+0x1d7/0x220 kernel/locking/rwsem.c:1578
>  mmap_write_lock include/linux/mmap_lock.h:106 [inline]
>  exit_mmap+0x2bd/0xc40 mm/mmap.c:1872
>  __mmput+0x115/0x380 kernel/fork.c:1347
>  exit_mm+0x220/0x310 kernel/exit.c:571
>  do_exit+0x9b2/0x28e0 kernel/exit.c:926
>  do_group_exit+0x207/0x2c0 kernel/exit.c:1088
>  get_signal+0x16a3/0x1740 kernel/signal.c:2917
>  arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
>  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
>  do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7ff5c377dff9
> RSP: 002b:00007ff5c45800e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 00007ff5c3935f88 RCX: 00007ff5c377dff9
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007ff5c3935f88
> RBP: 00007ff5c3935f80 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff5c3935f8c
> R13: 0000000000000000 R14: 00007ffe0400b7d0 R15: 00007ffe0400b8b8
>  </TASK>
>
> Showing all locks held in the system:
> 1 lock held by pool_workqueue_/3:
>  #0: ffffffff8e93d378 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:329 [inline]
>  #0: ffffffff8e93d378 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:976
> 1 lock held by khungtaskd/30:
>  #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
>  #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
>  #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
> 1 lock held by klogd/4662:
>  #0: ffff888072fda798 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock include/linux/mmap_lock.h:106 [inline]
>  #0: ffff888072fda798 (&mm->mmap_lock){++++}-{3:3}, at: exit_mmap+0x2bd/0xc40 mm/mmap.c:1872
> 1 lock held by dhcpcd/4887:
>  #0: ffff888032585718 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
>  #0: ffff888032585718 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x17c/0x3d0 mm/util.c:586
> 2 locks held by getty/4982:
>  #0: ffff88814b9860a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
>  #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
> 3 locks held by kworker/1:5/5270:
> 3 locks held by kworker/0:5/5300:
>  #0: ffff88801ac80948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
>  #0: ffff88801ac80948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
>  #1: ffffc90004037d00 (xfrm_state_gc_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
>  #1: ffffc90004037d00 (xfrm_state_gc_work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
>  #2: ffffffff8e93d378 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:329 [inline]
>  #2: ffffffff8e93d378 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:976
> 1 lock held by syz.3.917/7739:
>  #0: ffff888020fc5718 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock include/linux/mmap_lock.h:106 [inline]
>  #0: ffff888020fc5718 (&mm->mmap_lock){++++}-{3:3}, at: exit_mmap+0x2bd/0xc40 mm/mmap.c:1872
> 1 lock held by syz.0.828/7756:
>  #0: ffff888062c33a98 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock include/linux/mmap_lock.h:106 [inline]
>  #0: ffff888062c33a98 (&mm->mmap_lock){++++}-{3:3}, at: exit_mmap+0x2bd/0xc40 mm/mmap.c:1872
> 3 locks held by kworker/u8:21/7787:
>  #0: ffff88801b367148 ((wq_completion)cfg80211){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
>  #0: ffff88801b367148 ((wq_completion)cfg80211){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
>  #1: ffffc900015b7d00 ((work_completion)(&(&rdev->dfs_update_channels_wk)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
>  #1: ffffc900015b7d00 ((work_completion)(&(&rdev->dfs_update_channels_wk)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
>  #2: ffffffff8fcbf8c8 (rtnl_mutex){+.+.}-{3:3}, at: cfg80211_dfs_channels_update_work+0xbf/0x610 net/wireless/mlme.c:1021
> 3 locks held by kworker/u8:30/7796:
>  #0: ffff88814b6a6948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
>  #0: ffff88814b6a6948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
>  #1: ffffc90002e9fd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
>  #1: ffffc90002e9fd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
>  #2: ffffffff8fcbf8c8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4196
> 3 locks held by kworker/u8:32/7798:
>  #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
>  #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
>  #1: ffffc90003ad7d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
>  #1: ffffc90003ad7d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
>  #2: ffffffff8fcbf8c8 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
> 5 locks held by kworker/u8:50/9743:
>  #0: ffff88801baeb148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
>  #0: ffff88801baeb148 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
>  #1: ffffc90003f57d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
>  #1: ffffc90003f57d00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
>  #2: ffffffff8fcb2dd0 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:580
>  #3: ffffffff8fcbf8c8 (rtnl_mutex){+.+.}-{3:3}, at: ieee80211_unregister_hw+0x55/0x2c0 net/mac80211/main.c:1662
>  #4: ffff888059fc8768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock include/net/cfg80211.h:6014 [inline]
>  #4: ffff888059fc8768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: ieee80211_stop+0x3e9/0x4a0 net/mac80211/iface.c:777
> 1 lock held by syz.1.2163/11123:
>
> =============================================
>
> NMI backtrace for cpu 1
> CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc2-syzkaller-00074-gd3d1556696c1 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
>  nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
>  trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
>  watchdog+0xff4/0x1040 kernel/hung_task.c:379
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0
> CPU: 0 UID: 0 PID: 11132 Comm: syz-executor Not tainted 6.12.0-rc2-syzkaller-00074-gd3d1556696c1 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> RIP: 0010:preempt_count_sub+0x66/0x170 kernel/sched/core.c:5829
> Code: c1 81 e1 ff ff ff 7f 39 d9 7c 27 81 fb fe 00 00 00 77 07 0f b6 c0 85 c0 74 5f 65 8b 05 cb 99 a0 7e f7 db 65 01 1d c2 99 a0 7e <5b> 41 5e c3 cc cc cc cc 90 e8 ec af 4c 03 85 c0 74 3a 48 c7 c0 30
> RSP: 0018:ffffc9000335f8c8 EFLAGS: 00000093
> RAX: 0000000080000002 RBX: 00000000ffffffff RCX: 0000000000000002
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
> RBP: ffffc9000335f970 R08: ffffffff9a5fe1f3 R09: 1ffffffff34bfc3e
> R10: dffffc0000000000 R11: fffffbfff34bfc3f R12: dffffc0000000000
> R13: 1ffff9200066bf1c R14: dffffc0000000000 R15: 0000000000000046
> FS:  0000555588e89500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000110c310254 CR3: 00000000581ae000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <NMI>
>  </NMI>
>  <TASK>
>  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
>  _raw_spin_unlock_irqrestore+0xdd/0x140 kernel/locking/spinlock.c:194
>  __debug_check_no_obj_freed lib/debugobjects.c:998 [inline]
>  debug_check_no_obj_freed+0x561/0x580 lib/debugobjects.c:1019
>  slab_free_hook mm/slub.c:2273 [inline]
>  slab_free mm/slub.c:4579 [inline]
>  kmem_cache_free+0x11f/0x420 mm/slub.c:4681
>  __sigqueue_free kernel/signal.c:451 [inline]
>  collect_signal kernel/signal.c:594 [inline]
>  __dequeue_signal+0x4ac/0x5c0 kernel/signal.c:616
>  dequeue_signal+0x1e0/0x680 kernel/signal.c:637
>  get_signal+0x604/0x1740 kernel/signal.c:2797
>  arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
>  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
>  do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fae9a37c911
> Code: 75 57 89 f0 25 00 00 41 00 3d 00 00 41 00 74 49 80 3d 3a fc 18 00 00 74 6d 89 da 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 93 00 00 00 48 8b 54 24 28 64 48 2b 14 25
> RSP: 002b:00007ffcb450afb0 EFLAGS: 00000202
> RAX: 0000000000000003 RBX: 0000000000000002 RCX: 00007fae9a37c911
> RDX: 0000000000000002 RSI: 00007fae9a3f033b RDI: 00000000ffffff9c
> RBP: 00007fae9a3f033b R08: 00000000000000da R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> R13: 0000000000000003 R14: 0000000000000009 R15: 0000000000000000
>  </TASK>
> IPVS: wlc: UDP 224.0.0.2:0 - no destination available
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
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

