Return-Path: <linux-kernel+bounces-544082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A48A4DD25
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45CA177068
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CA01FFC68;
	Tue,  4 Mar 2025 11:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bPJbPWVu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="buXYuwfZ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45733D561;
	Tue,  4 Mar 2025 11:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089321; cv=fail; b=UyhHAaPlW0mQfbDfScgmZrG7IQmnyRR1or06N9W2tKR19hQm46OYwGgTiN2NeukQxtQk10twnslMxahRmryP0O9zrJDt9RGRJ6xaCLQFWS/y/di2b2WF7I1iaU3i+nJ/EvLBwCNIuDiDnu064rHqAzjYV7eZEzlwJ3SPbH7vJ/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089321; c=relaxed/simple;
	bh=Vh7qzjixY04J1U8e5U5GVRerbvJx/m/ioC3uKOGsVNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y5PpWqb5UjdXQm/DTG/9YyjgsLBv1IfT/HK1iHzY8ZmO3bmCyhJB8hMVPvgBpRxMauKObN+6caSuZf8R0uJYt9Z/zO3HCkgOR5oImqfeHTwpFZtIhchsQiMsL2ecoIJaM+0CyTKah36gTt4jr473Uhb12EQeexmHGdWWe3hWKw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bPJbPWVu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=buXYuwfZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5249fr2t028593;
	Tue, 4 Mar 2025 11:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=dXhtmWotAg7sj9FHC1
	quGsB0LnhwlEzJN8qhB8w6+Lo=; b=bPJbPWVu7uXExoKc3IYG1RNf+9mdlNzZ7v
	6w12E/HLLx4nAJ/faDTsyjsm37mc0m6MP4isJPctnk9mo1rRNzRgprDboeekxMqy
	Vur+wr22PCqLXX1vkn12XXfObPA0R2M7csiEShPKq3uq1+I1CGiMmTckStOjqSj6
	FkrDmeGS23UHVGtnaqQgXAE8aZfiSGbH+B+yBv/Wbc6Z0LoUG7C9/2Mk9TB3LiDL
	z5f2gbM+cx87nGHXvPDvcsvGuSJMgnz4Xb7i+uhvLnpu674sJxR+aSPJA4sSXX2T
	QqAqDRSB1e05oNkp9QPBbzD3d9tFqMdOCRXbA7iGgcU5UjC8E8Mg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4541r44usp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 11:54:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 524BRXaF022488;
	Tue, 4 Mar 2025 11:54:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rwut45s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 11:54:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAK0vpoNBLPuV7V9yO3urRlJCOxqMnGkv9p7WbOApWVshG/OzCK2lL8lsB8yXws2iHskUiESfs8ttZCsbOh1/a0reMjaM2FXjDoqlzyDL9FlakKoSzZKIVS2UXhZGk1IBsifmYO5rdGCYDtR27fOk+HoPBF6ymYgV9waiHURDLQMSzeN4Ny3TStjnGmEsiOUI22yTYR1Sq76VE/4zMBomCYZXMNK344RZw2PZyjlIWmJ8aURSbdP0UT906OM8si8biifO+U2POWzc/BVKRQGzm6vHOqAI0O8Mwcjwjvf2vJw9kRbQQxNjlK1ANcHAp7pxinnW7m0tMHM4RtZE6L/9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXhtmWotAg7sj9FHC1quGsB0LnhwlEzJN8qhB8w6+Lo=;
 b=uMoPFepsOSyEBFGo6UnseKUauI10jkSAKoUMJ9+peOJblkY5e7bvZw9AA1QIiJzh81nPQhqJqj9QkcpkG+VuHGAzRdS4zsgg0BSxohCJGtGnm7jbg0rhoxcmcxYefljiH6DPbfEiphlZXIfHiwSCui8XAZ7pHyCeQkVAEgnsqPvTxzWGXF4oJ5AT93DpsMATSv9YOvr7elH6db4rtI35nPK61eOPI7ZN1N6YeicVYWIAcpNhHzY4AydyE/2nUw7tsZ1eGf9Jlpj/rm3ila2fUkp0S2M5RnrSuEorClexM6jzmXUzJoxQiddUlf2jMFOPnmH66kujtbWQ9adl/pFI4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXhtmWotAg7sj9FHC1quGsB0LnhwlEzJN8qhB8w6+Lo=;
 b=buXYuwfZkhJyZlEqnbm+6hWWt6/2hyiMq8s3385IYPwKj0dylrpAYuNcR02hwZOofG1edifd3gih48fy2vkNYyMc5mITR1a/oVk1sRQjbE0vY9siy/57ZsGl3+/7PTb/02iIlLhUJTQ2Xfy43Pg932QeO5CqYHir5Xgrv6h1Nqg=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH7PR10MB6333.namprd10.prod.outlook.com (2603:10b6:510:1b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 11:54:48 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 11:54:48 +0000
Date: Tue, 4 Mar 2025 11:54:46 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Trevor Gross <tmgross@umich.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v15 9/9] mm: rust: add MEMORY MANAGEMENT [RUST]
Message-ID: <f4b2411d-01d0-4cd8-b634-882558571c40@lucifer.local>
References: <20250304-vma-v15-0-5c641b31980a@google.com>
 <20250304-vma-v15-9-5c641b31980a@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-vma-v15-9-5c641b31980a@google.com>
X-ClientProxiedBy: LO4P123CA0509.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::13) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH7PR10MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 59810af3-2728-433b-1078-08dd5b135d2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xdNhvJQK6yHEllb9eLsSAg9nZvLNEHQ/xauYnvDQtADO659Y6/yQmsend8TU?=
 =?us-ascii?Q?l0DbYnwBdkJqRIfMnbIYANBv28hVU8Nw3dFvoE8fc89dLLybrVavs57yY3Hv?=
 =?us-ascii?Q?3CLeE6BQs9HHnKfQHnAXNEVgQPqgwZgrTDbr4W6pOrn5Votw1YJY3fA+J8i5?=
 =?us-ascii?Q?MIxiTIHOXAbw2muxG2ls8o82+5OESHAXcXJ8WtMSRjViOuohsH9CN9cSsZBr?=
 =?us-ascii?Q?9v0XkzVRwM5tfeOH2L/QsALBV4EGC4O+bdCtACzJrSw6fbCEEZC+/PXjl3Kb?=
 =?us-ascii?Q?o2XSzxjf6sYXGxSWurBrgcBKQ2Lsc5V+5GclksZpOGC3/En7/MFdZm5ekAr9?=
 =?us-ascii?Q?cylBy+U21j4PUelwgiJWnKsyLerg3T1vKhzlirGNR26qgK46Ti0OQVMJQLWV?=
 =?us-ascii?Q?c4x099Hg3pawv9yvl0QwyiKtfD4OLgFOUc4HKrxXfIM6A9yhLZmVCHFjBlE2?=
 =?us-ascii?Q?8H7THLlTDpwZZHZbhSl6/nVQ6plcZTiA8VmVPZqASzWHuVpUEZwWlUtlIXCq?=
 =?us-ascii?Q?6w0BD0JEJEPdUR8Yansww+e68E273P4cTm8giEsUm9gwVjSspCi2O6VnyTeN?=
 =?us-ascii?Q?pUYNAFEh7ScjxNWXxToleGVpSq0Q4pN/VpGw/QIacRvUN4+z+GpDUegtfWhV?=
 =?us-ascii?Q?2EqiSaVQkGA4Rx+u6zBHQOI16KkRo0EoRERFVF11v0EhH3KHIHvJbUrUQFou?=
 =?us-ascii?Q?lPOzhlp7BLEX3fHcLw+S3tti57pruen4Fbmtpc+oeEj7RYZR7RTa2A+0VgsS?=
 =?us-ascii?Q?ddjtWe5zrHOqBPm075OiGOLKWyvErvGrsXhGRghY8T4LGxaPGmqZXl+rhKEm?=
 =?us-ascii?Q?/MfeX6+5iEYJUuqsMtjBlEgRkyKNQ/QFJUQn16WWToNX6w8CUssiLNPp/Iqx?=
 =?us-ascii?Q?28Ft2GzGDgGo57xEK8dNa+RJBVjATf/HoUbJ43jQRZC5mMfomzcSk2nTShpD?=
 =?us-ascii?Q?ynoR/GdGeoQ/rdFuvM0UrFqcM3wLcOncFlon0ovKSJo5eCH/F2vhOKFOaub9?=
 =?us-ascii?Q?J2t95YblB5ghRCQpod/Ddd8uBV12Z1H5CDZwchiGDnf075DMx5sl9L00zRBd?=
 =?us-ascii?Q?+iuCDcsVbTgo4lA68RVb92LqxM7nc9KnaZv8GEo9Jiy/To8LchVTeFofxjV5?=
 =?us-ascii?Q?nqnJkr2sdiBy3z6cTPf72ilrvPz3A1oztI4uLs7WZw2tfuXzadoJwjU3M/8T?=
 =?us-ascii?Q?xXqg2k1aD2ToNPzWixJ96cYGvTkLkYYlz7H3fxAD0Nju2JNowod719dRYRpv?=
 =?us-ascii?Q?RdbtbxVPKYY0GF2+4Mgxn5HgwnGth3+GId/L2qGWHzUT97WVgGT/ujvg+tzZ?=
 =?us-ascii?Q?Hg2VQ42CXbXqZzCNYAgJgDpzTxsdOAgjs0H4F5hd+sM0lg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2xZJdYpBt9rdG4+S57UT2wil/PVhlE0t+7Kg3UUqgCm8BrORuAg1UR1rLvA8?=
 =?us-ascii?Q?6l1QjXG/BPuqNzDMpMYQBuAwTLw8ROJCM2sx7bs2Q6IeEqIpAe+3dSVN8hE3?=
 =?us-ascii?Q?CIaDuHscLHf7ICas+6vMJkE0b2J6j4InEnhcqsJ8rF4s7rAsXMPGyHcvkG0B?=
 =?us-ascii?Q?UIFKrJWCOEGXJWRUtbjhI/ZvjWo5Z9FJ4WwMdLFICt/0BPcw9/uJwHmEx+FT?=
 =?us-ascii?Q?iJGR6RitFvBincHULfMNe0z4E6JerlVoe1sxo1htE2a86YcMq8fahDMN2Ukq?=
 =?us-ascii?Q?w1x4xE7jh3cbPtCX+Wqk7N70SBx8kMEMaLusEGs79LnUZFmh0Q0Wg7SbnlTo?=
 =?us-ascii?Q?aoEE+TuylD5sECUL7ncLt4Ma3DUTg1CLM1SvjjgK5K8iFJMwQCOB8IdzdKEa?=
 =?us-ascii?Q?PP6pKtfqU6f+vP9wl22PS+D+UxO+DWHhslp4P8aMTj9rHgDR138kcgDmCKDw?=
 =?us-ascii?Q?uGXO5uyeSsJBUn4LOA/1Qq0gOdfy5rLkyWKvFVE9KrY26JrJicWEzoPqrDof?=
 =?us-ascii?Q?MF0ikaG/7llIJI2fgyIhnPbi/7n3uVDUGytP0EvvH1+TvditLK2J3QdV33xb?=
 =?us-ascii?Q?FuTIl+EH/nw9siKyElpIE7+je0UG23HWKY6JjiMSYubn0W3SW/m+1CD95tZn?=
 =?us-ascii?Q?BUQh+EtG12VAEs6gg08bEX/9lfb9AJHozeFMRIXKmWnGJ3P7RPE95ZZxjpOM?=
 =?us-ascii?Q?EzlqPzeT38MVOzN1/+CozwN+vt3jij/4Z5egnFHSWH5+E46ddc4E93PciGHu?=
 =?us-ascii?Q?ZCAu8Z/eE6h/AV3fFqfhthsXzfiiFxoeCK3Ieg/lB1izzG7OxrcdgTA+jUY4?=
 =?us-ascii?Q?HVgHVCzLmoIVkJ2uF0oq9qzeMYQzgq0Ycdilznmci1eAK1SLVFnTP3QivevX?=
 =?us-ascii?Q?5JXX33qdE4mIIaBr1+gMN+WvAhH+9feiJod5ti1SAbl5FoGALfzrbMBYjWGM?=
 =?us-ascii?Q?d/0hu96nC99XHJTd85weFVqxCAHk0FH6+LBZ97i8OiIcvbmbAxIzBRjKc+6m?=
 =?us-ascii?Q?Adnzye0gT/AIpadJ5bhGMwAZAi1YmronVfLPjpxBf4MMtDHaoi57q1p2UWcb?=
 =?us-ascii?Q?0rxbfqjvsmZTauCPK5Tlr33PLxjpgQIVrjVXOym/DFYsiwNOP1gkJcpYEZSr?=
 =?us-ascii?Q?rEiOb10xQe5Xe+rUY9hoqzpZM36LD5BXgr85T17Bei1TEqW7rHkVjyQ4yn4f?=
 =?us-ascii?Q?T94ByUogPbn9Ec6vbeC62Ufq7lmfNE0BvlCgd8zfX+4nY7ZnM5vn7iBXNWQ6?=
 =?us-ascii?Q?XUvYXYS+XGmv/EdrA8KLLtXInLrepyZXhqNj2kp8V9S2gkQz0AF4VtAkkGH+?=
 =?us-ascii?Q?8Crg9ttYHOuxZ6K2+V/qZ+oMx8oQGR8td18dUIN/89D8WmsYYbuepQs9BjnD?=
 =?us-ascii?Q?lkFEMF6SWZBXeU/REI5EWQE0VMbIsi97C21M0XfGd6mivCsZWlWoC9bhI5Ix?=
 =?us-ascii?Q?tbl2RBZpSE/WkpjFVHfnh/8ttKm3+98qsn4B112ZGqeabNLThWyVqnloMtlo?=
 =?us-ascii?Q?Oz6y+64r8m4atBAEAh7XgpwPIxAi7o0NXxcRYYZjCPoQeZRo/ZfZT1v3k9bX?=
 =?us-ascii?Q?on52hHa1/tQX3N7WJE/ELAldWzvGGZI6TYWKtYSaJtjY5gI2hzKC/dVf4dkf?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZJqDftKz/daxdJEw6RQV0x/r34WoplcRxXwNSdYoY4ZqGfbYaZ+5m52OGQ2CnvINE9p+GhoYXjhx00bRF+3g9SZNt7Q5XkAanuf8skSp8Qu6J0DoLf6mOqenUiZO9SPfJ2XHoHnmaPFmlztSs6USKY6r0YgFlPlbbI6JT/TvKPQ5LcswyogM8RMWyBqgBOFZT6Gyw0YvZgNOXYLS7hiu2VxWBd5V3KTxSC3g32k/diyO73fZDrgqEE2lQgshZ3N9DxnaxG3bb+76AcRCQy6LLOY2CX2D/uVni6Qo2YAGZw7WuTBK3ab0FTwyg/mp/e8L2vLL5x5bW+Q0IMNiFcXqYbqZEsSXDtoIJ8v5NYmjSuQDPlLqyTzvHqVeOIoXDyRycg2jsaL2OaJ4ZMg24fHmGEl0V5Iv2W6Ba0Io6sCYny4fu5IWN9iXfFMArmQWIpKsEqYbqUn2zAWoOruI7vPxW9rdYmU/3Egj+JRukaaOcw8uHvLAgze7zGUFeuK5rqnAJWnNK5NCPGW2e7Ah9eU/CxVuYfCntLylImpKj+2EIAnlRK1EAchaYwDstiKM1i87R4CZyMKIQ5QmBaTdvz5Jk5ZDfXo13Hvqq6C4F8g8GBY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59810af3-2728-433b-1078-08dd5b135d2b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 11:54:48.2933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGmGJ4a85TNxdnhixtK6n8oa0rA8QQeoEPxNL2FOVGMdimGH0miR8ppV6wB0ksEME3ttuWjWImUNh8HN5+fLwRQIfos2uGlXRhVAsxVkix4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6333
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_05,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503040099
X-Proofpoint-ORIG-GUID: AegPGo0f-lZP-3htCgW1y4zJwOSciVTg
X-Proofpoint-GUID: AegPGo0f-lZP-3htCgW1y4zJwOSciVTg

On Tue, Mar 04, 2025 at 11:50:00AM +0000, Alice Ryhl wrote:
> We have introduced Rust bindings for core mm abstractions as part of
> this series, so add an entry in MAINTAINERS to be explicit about who
> maintains this.
>
> Patches are anticipated to be taken through the mm tree as usual with
> other mm code.
>
> Link: https://rust-for-linux.com/rust-kernel-policy#how-is-rust-introduced-in-a-subsystem
> Link: https://lore.kernel.org/all/33e64b12-aa07-4e78-933a-b07c37ff1d84@lucifer.local/
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  MAINTAINERS | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 25c86f47353de25c88291cc7fd6c4e9bfb12d5c4..3f610b3ab66ed5e502261deb867099fec6e4ab17 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15196,6 +15196,19 @@ F:	tools/mm/
>  F:	tools/testing/selftests/mm/
>  N:	include/linux/page[-_]*
>
> +MEMORY MANAGEMENT [RUST]
> +M:	Alice Ryhl <aliceryhl@google.com>
> +R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> +R:	Liam R. Howlett <Liam.Howlett@oracle.com>
> +L:	linux-mm@kvack.org
> +L:	rust-for-linux@vger.kernel.org
> +S:	Maintained
> +W:	http://www.linux-mm.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> +F:	rust/helpers/mm.c
> +F:	rust/kernel/mm.rs
> +F:	rust/kernel/mm/
> +
>  MEMORY MAPPING
>  M:	Andrew Morton <akpm@linux-foundation.org>
>  M:	Liam R. Howlett <Liam.Howlett@oracle.com>
>
> --
> 2.48.1.711.g2feabab25a-goog
>

