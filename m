Return-Path: <linux-kernel+bounces-335927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0771A97ECA0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3641DB224FE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDC519CC13;
	Mon, 23 Sep 2024 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jpbW6IgM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V/1LcLN3"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96DD19993B
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727099960; cv=fail; b=cs8013hCrMnTMeUHCtSyxqetGISucbUddgfut241NK5z82t6nhx7azJVYwfJhQxrOVIiWhkqQttbUnR7mE+UlTXc02gdVFF0SQIeU8XOVecQ/641dhpuEkWEXLwGHfWI7ZgHUHJa0Ew5Q0vEGh4dH8EkuwYZ93AVGeoyFYT/vLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727099960; c=relaxed/simple;
	bh=if6Dkltm3By2AblncupeOI3dGFrIsG9iIxvm3Q9lBMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mXARKNalI+6mLmO+nPYC7qHOwd8X4yfrnFRZx2M2T2bMA8NYjGcWAPqZATQO0K3/0Sdz0Lp+pPK8U/zwIIozpX6USQmNG76IhZWhZ0MQalJMMfGHycYx7WPWDXdTkUzqY1JQbjWGUFL3cNUlm3Iyms+JLmU2SsO3J8pgsex5rH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jpbW6IgM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V/1LcLN3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NDsU9e000403;
	Mon, 23 Sep 2024 13:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=DKXPENcodCFBXEp
	sXaCm0oKTh+n3x5dkqF0D2GY92dc=; b=jpbW6IgMFqp2yqKUq1c5DlyuvzYgcbW
	aL9Wos13Cdc5bEw6JuK/0xwuxXh6Cgj7vx+f4QUfBF9U/cXXvNhevJ3BmmGzC5VH
	MiUevd2usOYHEKGNpSFNQqmn9sIV7XmYDU+cGjQo6Aevk+kF+9LDENExK1vixNuV
	6OzQTVVwwF7CnJtu7WVLyOMfeRFt3OCQU2NLHaApB53PhvAvPvNVS8zO8JDMOG2t
	hMx5SJVAjkB4w9G2K3Fv+4IRde4Sop4l//7QsmvboszbPQWj+7+9QFfMEFOP2pVb
	4b3DsoMYMlMD/ZV9IEhMYyiXbpvBFm7s++tkViay7TzzIYDjaQJuh7w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41snrt28s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 13:59:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48NDj7og038771;
	Mon, 23 Sep 2024 13:59:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41tkc4dr9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 13:59:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEpcUfnOURbPi/e/BFhMnGvEnEKl4A68oQZVV/Ucnm7Cs7xwnLDqXmX+YuFHwNpw8YoU+zu1mJjZq1ZCokGa1mX3BWBO4ItJWNq18bURuzLFK1bIUUuSWajb60ZuSUX0u3RQQfDGHnzrTKx1UcCUC6hBOLBiSP4X+s3QoZ7LKj2yZm3mRzk2K6lwg482tD6RnTgF+L6eS+hk+0NQf1ERwG64Yj8WWMxtjapBJwUVqDPSZdsPIXmU/kVbUvT4l+aajLV9T9UnOTu4O/FZkFkLQo4PQTkoaOvLn+KOqvAyDiJ78PsXQOrWnj8BNVSFMITrdYKIX65rS8lk8ugPsWHvng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKXPENcodCFBXEpsXaCm0oKTh+n3x5dkqF0D2GY92dc=;
 b=xNCA4GV9Gkoa5NFCep1dys3UvROz/Cg2k6rbw8m+aCh0yX8mU7mIXIGLzO7ZmPNKlloCWwjJ2CJAUeFQ+ieFqmG2eFGTDALgdrqOWcpyjKti+PymO1jNjKWzbuRMrpoxUkOxq0c/4uigdBRvpVjvTgDukz8SXEQjjB92apwtQwC5/nfAvklZYVSxnq96T84tl0plicKDk9oem5g4ybcLFfdKNbSgk40Y3m4FcvlwXFaSh2WyFAvytl/w6TuT1P6334ODzKq9EB4AEhSfBwAdYXxjK3jHOYTJpDuEFKPFo1+2rlDwvkIJG/tTv9Cq2kDlvp6WxI53iXzBEtHkbIxcRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKXPENcodCFBXEpsXaCm0oKTh+n3x5dkqF0D2GY92dc=;
 b=V/1LcLN3VR6HccvewHWBpYbeKyFLlWwiRKG2Qubuczqp1RLL4Y4LhZ4wZ0Af4BA33AiwzYKNUDwYdsj7swa+Q+0QCmQZBTYuRL00OzzlObZPjH6avZlszVo+dIBmrzLOD7Cpr/lgIt7763cdCGkdPC1fkrOaKV/uBLvdkhLkLEo=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by LV3PR10MB8058.namprd10.prod.outlook.com (2603:10b6:408:286::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Mon, 23 Sep
 2024 13:59:03 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Mon, 23 Sep 2024
 13:59:03 +0000
Date: Mon, 23 Sep 2024 14:59:00 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Marco Elver <elver@google.com>
Cc: syzbot <syzbot+e01fa33e67abb0b3b3bb@syzkaller.appspotmail.com>,
        Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] KCSAN: data-race in mas_wr_store_entry /
 mtree_range_walk
Message-ID: <6f327776-e22b-410e-a2ed-1b90c7ec76e5@lucifer.local>
References: <66f12f17.050a0220.3eed3.000b.GAE@google.com>
 <53e80bb1-9d26-4885-81fd-6fe816b4980b@lucifer.local>
 <CANpmjNMJWLq2H-Wdrx5SjPjc566V4siqod2Gy6-Dms2sn2+8PQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMJWLq2H-Wdrx5SjPjc566V4siqod2Gy6-Dms2sn2+8PQ@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0506.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|LV3PR10MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: f8225f80-1029-4b49-89e8-08dcdbd7e1db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D6xhXl8MqOj8DiA71W7JGkjEngihXQCdBjr/wIAESfMnRHvj30mVbvP5mfSp?=
 =?us-ascii?Q?1nSfvOZDGqjYiXKi5VUx5Ta02Mz4mqnkd71ky0Pio/nD/tY5R4KCssFPyyw+?=
 =?us-ascii?Q?kKfG5/dSV7XwBkVA/tFIxBJCDEjvB6QyYU3CNkMpWNrdiERTmoIypZpEp1sW?=
 =?us-ascii?Q?x7d7ESih6l4rq860uSO8bGtE4YyxmecmoAOIxGVY2q4Prhs1P7TMII+TbLOg?=
 =?us-ascii?Q?D6eGJgg6Rd/zZAxBgE+yb9B1Uju+4orQ0huQeleHVKEEphCweLTC5XOxzNQV?=
 =?us-ascii?Q?J21mpu6eGqxv6+i3r9Ass+RFWkXYlUuG+0DNl2FjrEkskcD/Upk/eSF5AeRL?=
 =?us-ascii?Q?/6KKm+DX2wxNWJEce52Yw3sQwJHtZlZ+7vgY71gv3pLxr66lfRShonrrquro?=
 =?us-ascii?Q?4Y8etftPdK2RNXT+/67vtX+werH5D0sRQbB7uApJsesYr6oBHtt0tvoxMAj5?=
 =?us-ascii?Q?UWu13pn6HOyFCOAacytq2fzhWB1R8J/MnfQJfcWJ+HvJgZfjd9nY5EYy1MxH?=
 =?us-ascii?Q?BRLelb7nyNGK3/elxSr+qjVRN/9vpJvsn1xN9lrPsJ0Lje0XX0IHJNZzeDxv?=
 =?us-ascii?Q?+uQmacfzXhq+aRuZBz9H8L4v5MPeRGFnY695LIDKVgg08ds2zDi5/b7KGvwL?=
 =?us-ascii?Q?tG8Zyl/LKlZcUqjIPA/VEjWJhu3IzKuwTS0wyEI6bgKsXHwFM/w9OkPfRF1d?=
 =?us-ascii?Q?8521wwhOayxy7DYtI3vZpTRbwZcKUJotMrgWnic3jxQ1zStIiniEIZjCVhR6?=
 =?us-ascii?Q?P9aas6YUktIfqpSvdde15FKEPl+wRlNx9wTPiVlEmgoEqqwhPPk7hLOtD4Gv?=
 =?us-ascii?Q?umY9eMUf4DLjI0jIr8KkU3pPxeSeBvjLhaWpbSmc0w8CEYkfsIfWczAsAc+1?=
 =?us-ascii?Q?fkfblbCL6A9kEkgz8fzzMaxBMYkcq0q3IpPMPEK87e+jQ4hTkyZv+bAZuqDG?=
 =?us-ascii?Q?HOe5YtliqSm9Yofj4fo3sXLjnXAy3h4m/2IR8kvGIiexu38HHA6NokOnYCrj?=
 =?us-ascii?Q?ZUeHARp7iEQS3TwKVJhKfhXaKdRlrLL99PmM441u0CWZVLullZlma7VcSY2i?=
 =?us-ascii?Q?rR1kQpoqFsl5+Sz+hY0ZzVcg/TTtwEBXDjSomsPwfhdoOcZjLBJjCgsKFyE0?=
 =?us-ascii?Q?LGRiCusS356gL8pAB50lvoKowWYIXsbSyGnYPaoQBDSxLEl3KKY4+yoDzsSe?=
 =?us-ascii?Q?jMOxP5IrprYMvXBx7zY5pGAlVnWRAIUaIcRC+zSc9USFl502NUriIOuhvL6S?=
 =?us-ascii?Q?1FyiHbH8iyFw1Wcjkq34q6w7UGa3SCIeSsmvzZBdQNF1jnKp4LkBB2T2FBaU?=
 =?us-ascii?Q?7oo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?99zp4U6z7waxr+MdBUzSAuRRWgmHm1mxF5TESOEx9lUFCJTbvfPnoXecBaUI?=
 =?us-ascii?Q?67QkjsIHcUIl7CUCfk1vtc9qX8v2IJrxkGY0FVJHwC2E1PRHunizQUr/cxYA?=
 =?us-ascii?Q?2h7Oidd14HybadUWiGdDjHIuWx0RApw6EI4PCRnE7JoVnWv2BsDP+xwzPXHd?=
 =?us-ascii?Q?SoxgnV38ee4MWHBY8nq7oaLR50Hup+Fe87wyKR4AqWh5d//FBDB+fktCzKp1?=
 =?us-ascii?Q?imuhQHz2gEVLc0kaZmqF7nbAckU6Ly/eKDSaRH0H+h4VYp70dqwjSjNpZqAL?=
 =?us-ascii?Q?VfUnn8uo830DqVZc+hQrHa2wUeGwJVF/znqksKUdHrA8G8WF349KfR43hvb1?=
 =?us-ascii?Q?7XA/cNQhONJe1w/amKmG0hTQv2dqEY92uwKDEWO4GUk1SaivPfpFKEH1CxrR?=
 =?us-ascii?Q?LEf2slKKNlOynILpO8cy+tPJk7EwZXVKQ8S+m088EVW29ip9Y+T3DTQeyv35?=
 =?us-ascii?Q?CdQg2EWQXvYXcjJAJUd2UhkILVBCPX4OMkBDqmRRH2CN4Bwtwr/h+SS6+VPH?=
 =?us-ascii?Q?oSqm8yTO6xpDV0HonzCEJLWzV1WRVFBGQ8p2NWcC3PXZ9rmezbB+EoXjxt5T?=
 =?us-ascii?Q?3GCaybUfphXre8brWmSiEcH8Cz7m4CrDr5Tt68vcdYf3gAaZO2RCHLik6iC0?=
 =?us-ascii?Q?xJPARuX05529j8Zu+e4VYrCBf6PtmeXFN193Lx0Sx0yQDAlLiQ6un2HT3XJU?=
 =?us-ascii?Q?4VT7S5fO9IrjEmD2XxTbMFu2EvZphaxrowtp5GhlPArQipAR1jTXavKVOn8R?=
 =?us-ascii?Q?Uq3lLxHPnutHz7tiijaYs/xGRsyRSJPQZb25kj3AWwp7RJ8Sukchb4lQpvI7?=
 =?us-ascii?Q?OQr8loQXPjH4nGBk69XQfaHueiQ3Kk+jyyERjJ501sO0QXUjzFrgdF0PJ2uq?=
 =?us-ascii?Q?OI6FvuyvImaBoQfcwNauM0yflKkzt1OOS/Km1jCubt/fSoQj68mTpM9Vf5Aw?=
 =?us-ascii?Q?RrvpY9tFsYfCeiGlsjAcFuX9CRFLDLxuUPAlrgp50pSF/U6xMs49Y10acwZn?=
 =?us-ascii?Q?QOf2KlHcTGK0fZHFcPQbENayawWbpi0paFpezvPLTkHq4Fu81FY57L3QulmR?=
 =?us-ascii?Q?fkhL7BhScM10T9qXd45VjlFlZrT6O/eOx3m+VuMRAlUBnC8BkByFBHeyvW/v?=
 =?us-ascii?Q?Ld+cz4yv7WMo/R6YNnCirS948IIdNkgUA6K4iump5Zsqg8DQH1VxzRS669gV?=
 =?us-ascii?Q?UWOL+HXVu9VCG4Zeh7aJZliGUff/VmvRhtj+4h77SN0oCOTIhPtkBfjh6GSs?=
 =?us-ascii?Q?izsn8bRgDVThE6sH1WeYanTIUz/cofD5BAPe2pRtFxXcfpC4VR5QTLoxuAfP?=
 =?us-ascii?Q?4sAb4Wek5BNCKyrEQpYc3wgOouj6LIAi8mhiH3RYDzOPFdCgLEACsaZ2Ag0t?=
 =?us-ascii?Q?hG9QygwE5TreIvwczFiTYMrjdRDMjhs7nNj6Gl1BaeNjkvvDgOjrBFPVN7vY?=
 =?us-ascii?Q?FlhJQTv+ZsrchdFRlZbyRtmrR3AijGjQsuI2zPniQeJo8obKzzgFpGCQ2Svr?=
 =?us-ascii?Q?341g6eNFMB3GNeSG1fAbzlRjdS+QI4slMyhnKG/shQ3SaYMMFuyjUFxOY3TN?=
 =?us-ascii?Q?I6FiJe7fWQtCgWg3bFjKJ6vcq9qN+qf49YnzSoxRmAWijEttsQyAA9Z7liYu?=
 =?us-ascii?Q?XpzJpTk9+Smjyo29fMduARDgT2AjQcSIjTfh+X++a7SZdhkxxmyiJWp3m5Ih?=
 =?us-ascii?Q?MlbErw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L/cm06jssgWFOWJ0rzZvekIt5t4VPzFamFzNbjDmibnUHXOimlLIixecmUCqXUxllfx/NTa4qlyceyQSYSCIJdJcGFdgVzzqknJ3aPNsIT9BpbaPemtt2xKjVJq2ShdEZs7Vja9VcfnGy17ghrTLBcgk7GHViNJPikECMAftPW0BF2SK6d+rds8wjiANCJkH7zmEbWV7Imyxkw2hlMQxMnbYIJp93Tdad98SX8QIR1z9rwjuCXYbN54nDGok3fjvmgmguDCQFmNqFOBOOeGROhAC4U/oPIqWftQo9TIt/27KlhCQfUbr4oJO3EAovH0W9HQmg+0/6TMr3lqGB6PzqoYhyonQvcvKiNHYYyw3TELPMLS8XQsL8IAcndTPZbeOjcuXtszS4ZaE6iN1fb79V0Znz5l3EEMClG5QLUTroTI7XoQSPFG5FjTOiYZfo3eDfyQvLLBFLnHzqAN8WOnsdNUfkWWJjbswfEOloBalAUVMT61pgkXliPgLP6fH/7Mz+v9/HGDMZ+GDqDrVGLn2BF8OSfKiFjOpau5+CUBHSkA3FQfXdPBKQ4AofCtwNJWl5H+N7kHemry4o42KOkPYf2b5ZNvG5r9gjk74I/DGTTg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8225f80-1029-4b49-89e8-08dcdbd7e1db
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 13:59:03.4402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ud5O6qqXgzIQF04Abq7Q4BDVIRbJZH2mNNG6Y+SYoEFH5X+MCWOW4W43inz99ybzDH2q0MDXIcW0BmwWtpCD6hk5Ce8FlOcnC6x/adUMG5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8058
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_10,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409230103
X-Proofpoint-GUID: 9JQel4qfBNax6DSLZGVpxQOUmO09zClB
X-Proofpoint-ORIG-GUID: 9JQel4qfBNax6DSLZGVpxQOUmO09zClB

On Mon, Sep 23, 2024 at 01:57:55PM GMT, Marco Elver wrote:
> On Mon, 23 Sept 2024 at 11:44, 'Lorenzo Stoakes' via syzkaller-bugs
> <syzkaller-bugs@googlegroups.com> wrote:
> >
> > On Mon, Sep 23, 2024 at 02:04:23AM GMT, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    88264981f208 Merge tag 'sched_ext-for-6.12' of git://git.k..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1237ec27980000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=e6702f5f2b8ed242
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=e01fa33e67abb0b3b3bb
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > >
> >
> > Thanks for the report, investigating.
> >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > I suspect given this is so timing-specific, a reproducer might be difficult.
>
> FWIW, syzbot currently does not try to find reproducers for KCSAN,
> because it's too non-deterministic.

Thanks, yes makes sense.

>
> The best strategy would be for a developer who has an intuition for
> what might be going on to create a stress-test to reproduce.

As per analysis in thread, I don't think this is really an issue, as one of the
racing threads is code explicitly designed to accept and deal with races.

We do obviously probably need an annotation, but unless it becomes urgent,
will defer this until Liam's return to check and assess.

Obviously if we see more reports I can dive back in!

>
> > This suggests we are failing to acquire an RCU lock on mmap() (though we
> > have the write mmap lock).
> >
> > Maybe we missed an RCU lock at some point, but I'm a little baffled as to
> > what could have changed in recent series to adjust this.
> >
> > I will dig into this and see what's going on.
>
> Thanks!

