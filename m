Return-Path: <linux-kernel+bounces-412965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAFC9D11CC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6AE31F23398
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CDD19D8BE;
	Mon, 18 Nov 2024 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d9+CrARd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pY7NOLxd"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BAB199953;
	Mon, 18 Nov 2024 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936337; cv=fail; b=YA7nQvSE0DdvUv1wVfgmjBKvhXaD2/fsYANplEJnIjL2Swf/uJiqpV2MGDhTikxLk9ZmoaDWFXqSwIAIwx1a7D4hz5XtUbmBeNFGEF5AYiuldrahdo7ovzgEy2iAS+HedXiS6sfkSdNnCVhtT8XeU7RJwG7sUThx7ibR+xCoMsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936337; c=relaxed/simple;
	bh=IVYzZ1PoDtchWalvmNoq2kzhW1NsCbHG6cHGR1sh9l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OMvNhnjk+UZwQKk0fLoGz/7Itjdawb4vg0DytNBZmu0okls/7NEFSjLM8gkQfeHtItHIOL8YQt6xoYY1VxpIoSyqRHbKS6BpME0/mjEA7IaNG6HiBqY9fo+jclS0QO9S+bjdqS8Koa2daTXFUKZqaJim5EYTPRy2vqAJTfC3lK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d9+CrARd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pY7NOLxd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI8QXgb032644;
	Mon, 18 Nov 2024 13:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=sX9RRQGppf8xOuudMG
	QFa6dZgxoyS7DNxYIcNVQ3Eqg=; b=d9+CrARdlM7TTf4ADldn8WQV6kdSFYWwyz
	DUF2baIRRSqyxIXcamONHG4864idGexp0RsTiRi4p+FbOmeXXyVgKkBmNePF/aEe
	zIAQSuf9ruaQPbUMUYY9Rn4RGDR1fKWuu2J72LE6Ce08rOkCPiiwz2OCEYgBF+NW
	ny0JOVI/vaW2qA8qBxbC0r2mGHOeffCI3Umi+S8iR/3nh2oa6Kzp4tlxh8JYVMDI
	lznlmk0+BcSt9j1yeBzsHRsqx9lklMpwlG5aaQsmf4WjHnPp+EstlpQ/GI5+a0PM
	v5RcN68u1eTp8Z0qpvj9Lj6tmTs/e8NDJLhc+RCes41awwriWHPQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0sjm2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 13:24:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIC1CGY023316;
	Mon, 18 Nov 2024 13:24:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu7e90c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 13:24:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHp7lhT0i97iBdY5mJyV7gNGKhoscOx6lVJcnCjQm9JBkIoOcBljmMi7VS1b+jfe2p69Bd74eYlDHr44f76qmKU3PMd1Jz6rAI1pn//drpOZB0vcSNRXa5X59NK4Dr8cmTkX2rpfPpkClhTiRyYjFLj1Miq10y+U9755EZRRLL5pvD+1vBo12n61497k5OkpYrGaoZxzxGoVG/o5CKJFEu0f/w2PmPzmk5nh7cwbQNjy8ZeOVAr1kkeMzlUsgZcFBeYFQSNvr8K37f9Grr6shy9WEXck0H802pwnaYgWdjn8gLhQvFpSJ5Ns065dzqq45Q4YGfdGcQA10zLu9NUdDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sX9RRQGppf8xOuudMGQFa6dZgxoyS7DNxYIcNVQ3Eqg=;
 b=r4G11J+vew+eSIQ8cvd3ZnZzj1qFiRYyPK2lRcfxlw6hmI84RDvxLxeUL8+7/sVpDcAmi4wMg/9WpfnxPGYBED6ij5xo28MY5kjnSvWo4uS3y1Ek58E9tS3xtPi94lvEbmqDzV9Xo19nqDWczfRw2VcGDbDOs7/9sQ200UvA9ZqzgBxIf6jUe5ZrDxv59OMphn6nBROAc3QsCTI/8TI+j5P2AL2tewvX6UlLpGiz6N+2ddqHVWhQRkcKYs1fb8SGhHnIFiKzIUnQ8WwOBeNUbrxqIgVeb+ewm5aPNd6Gzbj3+iFnCc85cxDPQjKoMxSzwdgEYc7ysGr05mbKNgYoow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sX9RRQGppf8xOuudMGQFa6dZgxoyS7DNxYIcNVQ3Eqg=;
 b=pY7NOLxdBcMJlQtgHPYfMn/8GmL6umFDstiPuZac8PPkFCZERlpQlsMgza8llU41Tg1/A64m9+kFsMgOIpM4//dz3eYbXIuUZX1jwnNGR+JzcW+P4dE3/JcpZfybmgyJPE2sgQOZz8oDz+xJ//J97l/zc5b/m/bHuIklxIIt1Go=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB6169.namprd10.prod.outlook.com (2603:10b6:208:3a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 13:24:39 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 13:24:39 +0000
Date: Mon, 18 Nov 2024 13:24:36 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com,
        oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com,
        peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net,
        paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com,
        hdanton@sina.com, hughd@google.com, minchan@google.com,
        jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com,
        pasha.tatashin@soleen.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 2/5] mm: move per-vma lock into vm_area_struct
Message-ID: <6ccb903e-b743-4b12-b30b-5b7f55c0bc30@lucifer.local>
References: <20241117080931.600731-1-surenb@google.com>
 <20241117080931.600731-3-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117080931.600731-3-surenb@google.com>
X-ClientProxiedBy: LO4P265CA0266.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::8) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c33f6a-7aab-439b-f427-08dd07d45a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ThVtKuDzIg3+jTwmeeMZ+ifdd8fZr1DkzTvlIE4of2koz0hXcexvSDjcQlHi?=
 =?us-ascii?Q?ttyAp0XMYnIidgaJueIa+WEfW3PhIVp0BtgjDwavZpGqI4RrNdtO/hR3bQ0m?=
 =?us-ascii?Q?fzUNTvBNJTjwXpZlzP3QIZSkr3j4p8k8y7PT+l1FpridvUTfy0s5QRqLk3Rt?=
 =?us-ascii?Q?wGK2ciNC/xVekscCXkN5N9FRCnMtcjPZ8DGpb/wMxLPi8JtSm+eLshTJEfGK?=
 =?us-ascii?Q?VD6DeCoHjI21/KUUly6eIFe9iIybhmVYikxOub0TT6gJ381bk2zNn+n0MQa+?=
 =?us-ascii?Q?KkBGIFNVZMQDQpMWzoa/9zUW4HuztrkiRKRE7RftGcfzeLN9h5s1IVq/yUU5?=
 =?us-ascii?Q?URR+tO6B6BSiqXgcG7hvwQyKXnT8kgNIQbnwS+PHe8YA0tOjGetFKBKxBpmw?=
 =?us-ascii?Q?I9oTinyAVJ6U8YE1dMV7HxRueLr2E4fjgingn5ONnyexMRIB7Ema01XG0XDs?=
 =?us-ascii?Q?swHEzld1OW/SA35LiV+Lee72AK/E2n+0eYkxbRFaIa4T17P78w4Wu8xTpT0R?=
 =?us-ascii?Q?FxijK005buVm9S/pjeEH6dTy2942FbZ7lhPl44k6H2l4ikDkCRwmc4sihUim?=
 =?us-ascii?Q?gQ3TVZEQysOoA9BMBr/5QerBBI67gdFxHiQl0Oxf9hkUehstJNoUHPid3NPh?=
 =?us-ascii?Q?E7AV5clo8K9DYo4w65o8MeRZaaSCJi3lVfgddabivQ9yJzPoIHrWnTIIBSpi?=
 =?us-ascii?Q?G/2hqmSpbcwJKya8JVjQ6ALN+EUIOUdSqdUFoXDjYNsuPCKGfUVeg3JVoNeE?=
 =?us-ascii?Q?rnskED9U1wUmIg7FdF4dKEenf8lkYemGydhkXXHTrRL+PicNlJd9tUVQIqAe?=
 =?us-ascii?Q?PK/qqBoqt3XYFcB1l2lpn/0Wte2FH4C3ZB+uy71GCZmFLf7U2qquj+oHFp7o?=
 =?us-ascii?Q?TfFn0vXwt578IrXYLiwN24TCpoTW+6Igz0wP7ChVOHnz0lRCDC9AP1BzGR+t?=
 =?us-ascii?Q?6EDCrk72xIf5Jv6sEnst9UQWkOCBpHYBHChvB8S8UnHgAwyEilbNVlpudFU8?=
 =?us-ascii?Q?4FLOzKjNskFIzir80sxOReLvPTmSmDErHdq/D2fw3abq/GzYkUrucr7RM8JY?=
 =?us-ascii?Q?S4nmevsJlBs7AjQR4jrJNHxeUjRipo5WfFzGasKJ5qZggLwlwiSjYzhhE82f?=
 =?us-ascii?Q?Zi8syGuiG+w36eKQ6uDvHxJUvI2PLl5fylMBIUaD5UV84TVUwkDn5vdx9hZE?=
 =?us-ascii?Q?OeVaS3w8VP3qnV/1ueqD1IA5mBRQ6pVG3PoOz1fMYCig7XTlYzi08ZhBwxG4?=
 =?us-ascii?Q?jE5I7ZoZRLRSUU+gKvm1Ca/HEmLTNrVyE9nUmrexwA7anNWdgTUquIVm9NBE?=
 =?us-ascii?Q?boMbW6gn2etDPB83cSwg2Db8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qKDF+B/ZSGDbqDWWQSAO+IsUSh0PNegm56sFxsYsF2HQHVhKjg8SCfvewrib?=
 =?us-ascii?Q?7RLpuuX6KmmBgefGvl+fdoPK65z547+2QnDdj+eXYrfTkhrZ3mU7UHgYo5sQ?=
 =?us-ascii?Q?vugSHHq6JHfW6K9Md3dTkqgdpD0DM56kN2Fz6oA933dJMJi35oZitsSE8H4+?=
 =?us-ascii?Q?u4Yedj8nccT8vH90HhGtmeVoGITFvDCV4W/Zv84bQoEaJhJ46EEG+NfJCeRG?=
 =?us-ascii?Q?6RnTjKM1DHpyPfaS0M1p5o0X0ignPbvsITnB+le8qkfKwiFd81eULCvYCRxZ?=
 =?us-ascii?Q?T1vSDPDPPhhuwDR0Lnjm7zhAc7LILpuGXMphiTzBiojRnuvKr1BLvb3G3fE9?=
 =?us-ascii?Q?7XyBPg/m0TLzCTyW6YW1sNwE1Pw04H8DZ5DIUw9Nk9r3gy+M/XFfmCwadKCG?=
 =?us-ascii?Q?HRDEEF2sRmIFNEKzEp24k5vpL7wBjGBkXlCOtv2QnNa8qNMRmYj9u3VXz+Ii?=
 =?us-ascii?Q?cUudRVeBOycYsItjkmLF4A57AHKijBk02J/CGkxzzgUZQQDCh6HRw6+z7b35?=
 =?us-ascii?Q?A6gs/wBcgrdHGA5wP2P+2NyNFocGRXVDQf/zodUbGQNiIWfd6sI/uQ3ldFcP?=
 =?us-ascii?Q?7UUGpF6AVYVjug7eiKINa0cVrq7kDZEzHF6ndCBSDWcbOZjm9uM4HcQxr/FR?=
 =?us-ascii?Q?72eOeBp8uLYNPhzE/nNA+PdlnPhGVvf3hgpZy1DpEb8rdR+mNBjvBs0pGPBa?=
 =?us-ascii?Q?EzWO/giHoALbAhYc/4rcBUJOInR51ZbHSIk2SLxqTtPZ8/sdnNpWXRn3tXqt?=
 =?us-ascii?Q?fhPGF7t3jzWaCezwHi88jNnSKkfBwq33PuVxf6jTI6vxDkvkAvPXXmYzBUEY?=
 =?us-ascii?Q?UdHzceNwkdjOZGPDEm0N3ztoePzaAjNzgLXcg+h+LUbkwbWz57E/m6VU2DAu?=
 =?us-ascii?Q?GrixZqQzptF2dtPIl2CJqvwjbUA2dwQf96GQWljkRVtapi6SjdCo3+Kh14pd?=
 =?us-ascii?Q?UuCSVGBswq5kIRfOquIJpjM8ec9fK6F0cezV10C6NiRFWsIaI3IrWOV5wpF8?=
 =?us-ascii?Q?CVzygBySxr8u7LX43Je7YBN3Dfp+1qAkhq5waA0LREOFF97P91CTSqx6v2tb?=
 =?us-ascii?Q?tvlvRC0oSYzlHWwrX+9hiTZej9XotBQI4BRiJVn4Wrc07MqUUW7hGpnT+lB+?=
 =?us-ascii?Q?1q93H2HekmBqv7i/HN7OnD+JNPqrldfruQJKCE9+dL+Bla4/dir6Y6s/izyR?=
 =?us-ascii?Q?u9DetXAbzPKYDd8EkUMl+Ciy3mjO+guzZzggmmAPGOPY2BcmdvwfkA10I+aO?=
 =?us-ascii?Q?Hh9v8k70LHynoWrGkTGk9qEC1kzk7/xSjFR0kWf+goRUp5eGCk1CHTXRndIA?=
 =?us-ascii?Q?w845paU8E7aB4cKWxN9J8EEN9KABbvpRs0kFtDa6NFFvAqztz8q5o8aI8ml6?=
 =?us-ascii?Q?t8lOac2MI8E8hcV2XaJm6QxtHFziR4gjEHczaanjLTUqFW3t/Yte25myJe6t?=
 =?us-ascii?Q?m9rtG10/qfvVxYSn79jL65HFGvKXBVCLvega3NWoe0ZGPKEZzTPjaYWZxMpR?=
 =?us-ascii?Q?gU/DMQON4n+oKZ/67AwgUaKoD1jQf7qCTfiCdPudWtb+7ZqAaZToAFtbZ+rV?=
 =?us-ascii?Q?DZFWJW/IoTUOGH/YfTTpWOug7Ok+rqkuIfqBTJ7jPLHBpVqbVtU2K4u68SR1?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CZE4xTESENfKJkvw2oEFYji//T/qqIKYeulEWLi8FZ7R9ZcWSIBRxM3Cw2wWixofAyd3nGemnWcXGzdK2qaH2e9NJneKotiE+9S69Gaqz1OmX3MYXqBwhUqYvVx0xAhAvYMiftTL27oe6tUEd9zdrM00UlY3Nc6zad2DoZbEI7vYFSGncW4hOy1xgeolQFDbbedCcFhTnWPJIwb7OKtp+D0iZl4RoPd3I9UeMJWiC29ASkrg98TpvJ9LyyJosEMsiBujXOc2MU7qpM5YTVNDFtNHdhM5qarrDAQbvy7ssqa/yfYPenYrsnKlpPYjnfvyDbRTATSP6t2t05b8G/r6zCy94E3sDJZobjDCSD2oDWrQzs+VbZssoA2nVzitixIdYVIRlFXu+pQBnTC2JOyKhfUvcpRqi1qvkrXdTy0EaDinOA3VO5edekIdO2jOm4kGnzUwH0+Q44d6zR8Rf6AidoWx+1fvfykVxF5V6iddj/ojeP9kesl1D/Smj9+RnBNSai9Nf+gnhquvi85aje0diihw9SXKmZjn6WnWHr+klUeY9jk2aeXzUnWNhlCWJn8L91DkDeoLmEZdVqouNyp+KeUJ3FQ3G9tRgFZAugcXlQA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c33f6a-7aab-439b-f427-08dd07d45a9e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 13:24:39.2595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3JhqwkUWkqmnbxX4+/6bHjEvKtUigFs8Z12kFWykhn8OR3GdiZrn5csAnVbftle85hxqdFWSbarA8eJA6hRyz4VW1aHnYgxrCJSyNx/VNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6169
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_09,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411180111
X-Proofpoint-ORIG-GUID: rDKWJWtKisD1c6GvyBYeh-b98QLa9rCq
X-Proofpoint-GUID: rDKWJWtKisD1c6GvyBYeh-b98QLa9rCq

On Sun, Nov 17, 2024 at 12:09:28AM -0800, Suren Baghdasaryan wrote:
> Back when per-vma locks were introduces, vm_lock was moved out of
> vm_area_struct in [1] because of the performance regression caused by
> false cacheline sharing. Recent investigation [2] revealed that the
> regressions is limited to a rather old Broadwell microarchitecture and
> even there it can be mitigated by disabling adjacent cacheline
> prefetching, see [3].
> Splitting single logical structure into multiple ones leads to more
> complicated management, extra pointer dereferences and overall less
> maintainable code. When that split-away part is a lock, it complicates
> things even further. With no performance benefits, there are no reasons
> for this split. Merging the vm_lock back into vm_area_struct also allows
> vm_area_struct to use SLAB_TYPESAFE_BY_RCU later in this patchset.
> Move vm_lock back into vm_area_struct, aligning it at the cacheline
> boundary and changing the cache to be cacheline-aligned as well.

Thanks!

> With kernel compiled using defconfig, this causes VMA memory consumption
> to grow from 160 (vm_area_struct) + 40 (vm_lock) bytes to 256 bytes:
>
>     slabinfo before:
>      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
>      vma_lock         ...     40  102    1 : ...
>      vm_area_struct   ...    160   51    2 : ...
>
>     slabinfo after moving vm_lock:
>      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
>      vm_area_struct   ...    256   32    2 : ...
>
> Aggregate VMA memory consumption per 1000 VMAs grows from 50 to 64 pages,
> which is 5.5MB per 100000 VMAs. Note that the size of this structure is
> dependent on the kernel configuration and typically the original size is
> higher than 160 bytes. Therefore these calculations are close to the
> worst case scenario. A more realistic vm_area_struct usage before this
> change is:
>
>      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
>      vma_lock         ...     40  102    1 : ...
>      vm_area_struct   ...    176   46    2 : ...
>
> Aggregate VMA memory consumption per 1000 VMAs grows from 54 to 64 pages,
> which is 3.9MB per 100000 VMAs.
> This memory consumption growth can be addressed later by optimizing the
> vm_lock.
>
> [1] https://lore.kernel.org/all/20230227173632.3292573-34-surenb@google.com/
> [2] https://lore.kernel.org/all/ZsQyI%2F087V34JoIt@xsang-OptiPlex-9020/
> [3] https://lore.kernel.org/all/CAJuCfpEisU8Lfe96AYJDZ+OM4NoPmnw9bP53cT_kbfP_pR+-2g@mail.gmail.com/
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

LGTM, and briefly tested in VM and looking good so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/mm.h               | 28 ++++++++++--------
>  include/linux/mm_types.h         |  6 ++--
>  kernel/fork.c                    | 49 ++++----------------------------
>  tools/testing/vma/vma_internal.h | 33 +++++----------------
>  4 files changed, 32 insertions(+), 84 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1ba2e480ae63..737c003b0a1e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -684,6 +684,12 @@ static inline void vma_numab_state_free(struct vm_area_struct *vma) {}
>  #endif /* CONFIG_NUMA_BALANCING */
>
>  #ifdef CONFIG_PER_VMA_LOCK
> +static inline void vma_lock_init(struct vm_area_struct *vma)
> +{
> +	init_rwsem(&vma->vm_lock.lock);
> +	vma->vm_lock_seq = UINT_MAX;
> +}
> +
>  /*
>   * Try to read-lock a vma. The function is allowed to occasionally yield false
>   * locked result to avoid performance overhead, in which case we fall back to
> @@ -701,7 +707,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
>  	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq.sequence))
>  		return false;
>
> -	if (unlikely(down_read_trylock(&vma->vm_lock->lock) == 0))
> +	if (unlikely(down_read_trylock(&vma->vm_lock.lock) == 0))
>  		return false;
>
>  	/*
> @@ -716,7 +722,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
>  	 * This pairs with RELEASE semantics in vma_end_write_all().
>  	 */
>  	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&vma->vm_mm->mm_lock_seq))) {
> -		up_read(&vma->vm_lock->lock);
> +		up_read(&vma->vm_lock.lock);
>  		return false;
>  	}
>  	return true;
> @@ -731,7 +737,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
>  static inline void vma_start_read_locked_nested(struct vm_area_struct *vma, int subclass)
>  {
>  	mmap_assert_locked(vma->vm_mm);
> -	down_read_nested(&vma->vm_lock->lock, subclass);
> +	down_read_nested(&vma->vm_lock.lock, subclass);
>  }
>
>  /*
> @@ -743,13 +749,13 @@ static inline void vma_start_read_locked_nested(struct vm_area_struct *vma, int
>  static inline void vma_start_read_locked(struct vm_area_struct *vma)
>  {
>  	mmap_assert_locked(vma->vm_mm);
> -	down_read(&vma->vm_lock->lock);
> +	down_read(&vma->vm_lock.lock);
>  }
>
>  static inline void vma_end_read(struct vm_area_struct *vma)
>  {
>  	rcu_read_lock(); /* keeps vma alive till the end of up_read */
> -	up_read(&vma->vm_lock->lock);
> +	up_read(&vma->vm_lock.lock);
>  	rcu_read_unlock();
>  }
>
> @@ -778,7 +784,7 @@ static inline void vma_start_write(struct vm_area_struct *vma)
>  	if (__is_vma_write_locked(vma, &mm_lock_seq))
>  		return;
>
> -	down_write(&vma->vm_lock->lock);
> +	down_write(&vma->vm_lock.lock);
>  	/*
>  	 * We should use WRITE_ONCE() here because we can have concurrent reads
>  	 * from the early lockless pessimistic check in vma_start_read().
> @@ -786,7 +792,7 @@ static inline void vma_start_write(struct vm_area_struct *vma)
>  	 * we should use WRITE_ONCE() for cleanliness and to keep KCSAN happy.
>  	 */
>  	WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
> -	up_write(&vma->vm_lock->lock);
> +	up_write(&vma->vm_lock.lock);
>  }
>
>  static inline void vma_assert_write_locked(struct vm_area_struct *vma)
> @@ -798,7 +804,7 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma)
>
>  static inline void vma_assert_locked(struct vm_area_struct *vma)
>  {
> -	if (!rwsem_is_locked(&vma->vm_lock->lock))
> +	if (!rwsem_is_locked(&vma->vm_lock.lock))
>  		vma_assert_write_locked(vma);
>  }
>
> @@ -831,6 +837,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>
>  #else /* CONFIG_PER_VMA_LOCK */
>
> +static inline void vma_lock_init(struct vm_area_struct *vma) {}
>  static inline bool vma_start_read(struct vm_area_struct *vma)
>  		{ return false; }
>  static inline void vma_end_read(struct vm_area_struct *vma) {}
> @@ -865,10 +872,6 @@ static inline void assert_fault_locked(struct vm_fault *vmf)
>
>  extern const struct vm_operations_struct vma_dummy_vm_ops;
>
> -/*
> - * WARNING: vma_init does not initialize vma->vm_lock.
> - * Use vm_area_alloc()/vm_area_free() if vma needs locking.
> - */
>  static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
>  {
>  	memset(vma, 0, sizeof(*vma));
> @@ -877,6 +880,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
>  	INIT_LIST_HEAD(&vma->anon_vma_chain);
>  	vma_mark_detached(vma, false);
>  	vma_numab_state_init(vma);
> +	vma_lock_init(vma);
>  }
>
>  /* Use when VMA is not part of the VMA tree and needs no locking */
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 80fef38d9d64..5c4bfdcfac72 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -716,8 +716,6 @@ struct vm_area_struct {
>  	 * slowpath.
>  	 */
>  	unsigned int vm_lock_seq;
> -	/* Unstable RCU readers are allowed to read this. */
> -	struct vma_lock *vm_lock;
>  #endif
>
>  	/*
> @@ -770,6 +768,10 @@ struct vm_area_struct {
>  	struct vma_numab_state *numab_state;	/* NUMA Balancing state */
>  #endif
>  	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
> +#ifdef CONFIG_PER_VMA_LOCK
> +	/* Unstable RCU readers are allowed to read this. */
> +	struct vma_lock vm_lock ____cacheline_aligned_in_smp;
> +#endif
>  } __randomize_layout;
>
>  #ifdef CONFIG_NUMA
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 0061cf2450ef..7823797e31d2 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -436,35 +436,6 @@ static struct kmem_cache *vm_area_cachep;
>  /* SLAB cache for mm_struct structures (tsk->mm) */
>  static struct kmem_cache *mm_cachep;
>
> -#ifdef CONFIG_PER_VMA_LOCK
> -
> -/* SLAB cache for vm_area_struct.lock */
> -static struct kmem_cache *vma_lock_cachep;
> -
> -static bool vma_lock_alloc(struct vm_area_struct *vma)
> -{
> -	vma->vm_lock = kmem_cache_alloc(vma_lock_cachep, GFP_KERNEL);
> -	if (!vma->vm_lock)
> -		return false;
> -
> -	init_rwsem(&vma->vm_lock->lock);
> -	vma->vm_lock_seq = UINT_MAX;
> -
> -	return true;
> -}
> -
> -static inline void vma_lock_free(struct vm_area_struct *vma)
> -{
> -	kmem_cache_free(vma_lock_cachep, vma->vm_lock);
> -}
> -
> -#else /* CONFIG_PER_VMA_LOCK */
> -
> -static inline bool vma_lock_alloc(struct vm_area_struct *vma) { return true; }
> -static inline void vma_lock_free(struct vm_area_struct *vma) {}
> -
> -#endif /* CONFIG_PER_VMA_LOCK */
> -
>  struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
>  {
>  	struct vm_area_struct *vma;
> @@ -474,10 +445,6 @@ struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
>  		return NULL;
>
>  	vma_init(vma, mm);
> -	if (!vma_lock_alloc(vma)) {
> -		kmem_cache_free(vm_area_cachep, vma);
> -		return NULL;
> -	}
>
>  	return vma;
>  }
> @@ -496,10 +463,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
>  	 * will be reinitialized.
>  	 */
>  	data_race(memcpy(new, orig, sizeof(*new)));
> -	if (!vma_lock_alloc(new)) {
> -		kmem_cache_free(vm_area_cachep, new);
> -		return NULL;
> -	}
> +	vma_lock_init(new);
>  	INIT_LIST_HEAD(&new->anon_vma_chain);
>  	vma_numab_state_init(new);
>  	dup_anon_vma_name(orig, new);
> @@ -511,7 +475,6 @@ void __vm_area_free(struct vm_area_struct *vma)
>  {
>  	vma_numab_state_free(vma);
>  	free_anon_vma_name(vma);
> -	vma_lock_free(vma);
>  	kmem_cache_free(vm_area_cachep, vma);
>  }
>
> @@ -522,7 +485,7 @@ static void vm_area_free_rcu_cb(struct rcu_head *head)
>  						  vm_rcu);
>
>  	/* The vma should not be locked while being destroyed. */
> -	VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock->lock), vma);
> +	VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock.lock), vma);
>  	__vm_area_free(vma);
>  }
>  #endif
> @@ -3168,11 +3131,9 @@ void __init proc_caches_init(void)
>  			sizeof(struct fs_struct), 0,
>  			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
>  			NULL);
> -
> -	vm_area_cachep = KMEM_CACHE(vm_area_struct, SLAB_PANIC|SLAB_ACCOUNT);
> -#ifdef CONFIG_PER_VMA_LOCK
> -	vma_lock_cachep = KMEM_CACHE(vma_lock, SLAB_PANIC|SLAB_ACCOUNT);
> -#endif
> +	vm_area_cachep = KMEM_CACHE(vm_area_struct,
> +			SLAB_HWCACHE_ALIGN|SLAB_NO_MERGE|SLAB_PANIC|
> +			SLAB_ACCOUNT);
>  	mmap_init();
>  	nsproxy_cache_init();
>  }
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 1d9fc97b8e80..11c2c38ca4e8 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -230,10 +230,10 @@ struct vm_area_struct {
>  	/*
>  	 * Can only be written (using WRITE_ONCE()) while holding both:
>  	 *  - mmap_lock (in write mode)
> -	 *  - vm_lock->lock (in write mode)
> +	 *  - vm_lock.lock (in write mode)
>  	 * Can be read reliably while holding one of:
>  	 *  - mmap_lock (in read or write mode)
> -	 *  - vm_lock->lock (in read or write mode)
> +	 *  - vm_lock.lock (in read or write mode)
>  	 * Can be read unreliably (using READ_ONCE()) for pessimistic bailout
>  	 * while holding nothing (except RCU to keep the VMA struct allocated).
>  	 *
> @@ -242,7 +242,7 @@ struct vm_area_struct {
>  	 * slowpath.
>  	 */
>  	unsigned int vm_lock_seq;
> -	struct vma_lock *vm_lock;
> +	struct vma_lock vm_lock;
>  #endif
>
>  	/*
> @@ -408,17 +408,10 @@ static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
>  	return mas_find(&vmi->mas, ULONG_MAX);
>  }
>
> -static inline bool vma_lock_alloc(struct vm_area_struct *vma)
> +static inline void vma_lock_init(struct vm_area_struct *vma)
>  {
> -	vma->vm_lock = calloc(1, sizeof(struct vma_lock));
> -
> -	if (!vma->vm_lock)
> -		return false;
> -
> -	init_rwsem(&vma->vm_lock->lock);
> +	init_rwsem(&vma->vm_lock.lock);
>  	vma->vm_lock_seq = UINT_MAX;
> -
> -	return true;
>  }
>
>  static inline void vma_assert_write_locked(struct vm_area_struct *);
> @@ -439,6 +432,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
>  	vma->vm_ops = &vma_dummy_vm_ops;
>  	INIT_LIST_HEAD(&vma->anon_vma_chain);
>  	vma_mark_detached(vma, false);
> +	vma_lock_init(vma);
>  }
>
>  static inline struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
> @@ -449,10 +443,6 @@ static inline struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
>  		return NULL;
>
>  	vma_init(vma, mm);
> -	if (!vma_lock_alloc(vma)) {
> -		free(vma);
> -		return NULL;
> -	}
>
>  	return vma;
>  }
> @@ -465,10 +455,7 @@ static inline struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
>  		return NULL;
>
>  	memcpy(new, orig, sizeof(*new));
> -	if (!vma_lock_alloc(new)) {
> -		free(new);
> -		return NULL;
> -	}
> +	vma_lock_init(new);
>  	INIT_LIST_HEAD(&new->anon_vma_chain);
>
>  	return new;
> @@ -638,14 +625,8 @@ static inline void mpol_put(struct mempolicy *)
>  {
>  }
>
> -static inline void vma_lock_free(struct vm_area_struct *vma)
> -{
> -	free(vma->vm_lock);
> -}
> -
>  static inline void __vm_area_free(struct vm_area_struct *vma)
>  {
> -	vma_lock_free(vma);
>  	free(vma);
>  }
>
> --
> 2.47.0.338.g60cca15819-goog
>

