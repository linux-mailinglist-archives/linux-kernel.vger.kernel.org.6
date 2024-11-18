Return-Path: <linux-kernel+bounces-413038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 060929D12A0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB071F22984
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E653919EED3;
	Mon, 18 Nov 2024 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g+R+EbYb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SaP60zwR"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9BC8836;
	Mon, 18 Nov 2024 14:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731938799; cv=fail; b=Z07hqp4BUk/DiR2Ae3Mx9vZOtd6wQydaby6kejaNX+zTthWnKTEM14zqv21+091nEVsq1pRsmteJ7cwk24N7IrHmKEHyyeX+Toj9Fh75+SQgWTHOak0KB1xJryXby0NnIKY7nSOnExlShV/L3t76GVipVcAGzqwGVd7I50V0jSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731938799; c=relaxed/simple;
	bh=Oa8jit5pZwooHrHS9rWLRMTaPsgJAalifxiqSeUAp7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VPnqEVOVwdDm8eseUcETXvfUN4h3GLpfp8p/HlduO3ZwsnLaN+xe2tLTfd1giU6m5SlhMRBxXVIyIXw/jiH04YjaDzTPAEFvn+4XuWgaJX0LV+8ITRb7hs7uMIPklG5y3X6Yi72O1WicbB/LCYQKyk1flow07heR+6g+PYBWyCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g+R+EbYb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SaP60zwR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI8QYon009457;
	Mon, 18 Nov 2024 14:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=AYjdoW+8JJoBg/wA1I
	Nkq3XpPJUwPKDDPjtfcFvboSc=; b=g+R+EbYbnjTUYpi7bTZJOSXW3No9HyFNod
	q0SztBGUwI5SsMFy6s32KsTwD/C42UidIZJkSB/zpqYYr/7HU7kGFgxsXC+WfC0+
	CB0KfCC4PI/S2GuNZHD94l+6PSmJusOeUBGqFZwaCJrhOIP3uBF6sOyNIaUDivia
	J24WPctr+5UIZTs4X4wCGIqgX9A7CMEQ6i1QwEn+TdOI+FK7wj2nYlkxwZ/heJOV
	4e3otQj+VLJuEciJtddB2WXd4+En3+Rw2/j89cNCPofbrxYEsQHc0ZKwnJgC+6jb
	pkqSTMpBpNfS/bV1ztTH3aoBltEQ+SoJWDo0hILxasR7SvzK6GpA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtc2rck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 14:05:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AID8H96023282;
	Mon, 18 Nov 2024 14:05:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu7fpmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 14:05:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNYdfVvquRWVsRskqj77cySj7luPD5LXRU9Jih7pP8Rb2f8OESgNFTRqtuU2Mr7DklDAAxi2nBdVsLUmDmdwyQ1fsL/BS+bxvO2bbxR2TraenZNN71YbgCXDzYpvVbxlQwmrMm0KWb1dFUJOgDsHXQQ9nGniNO9kabNW1NLRuqRhjsqT4eI7JTi0eMZZpuH1oCcmuWiBEMvBAdYRafnkbXywhFPj0+nW0F8/t3AwKq+Q1cevG5JuB+kPzGc+5fjPUZCasw5s+rPEczg1r3jPrX0wlpIZ/UOE8yiO/oGZeYugxX1rmFTZcL0UT5OarQPL29K8rMIO92H/AjH2PPrmfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYjdoW+8JJoBg/wA1INkq3XpPJUwPKDDPjtfcFvboSc=;
 b=aX7QcXnRdi6dGZTSB0/iyLwj3HcHV39avUruYi30MhL7RxuokeEaj2fBxaf7Hfr48nFOSjMgDXW8AFwM/9/fenP3z3rJEeuQ8rn+V8c0hY0ZL3HDwkdounccpx3qif67z3Lb0GY7uQTqkANcFsCYCKLC8VBMRVZ2UbdDcBwZ2j2qpLjA+nlxJ90WbAkBqHFk5DvIOAuMwHqFgrEvjPWO3Kc2AbRov+ztdbU5gIYinWF0hPTovJaKIe9ZlSDnPd54qWB32LbEJMuTZ7lzj2eaKmk0W7O6fcUgcBl7fiDejC2zHMzIjotbWyFd3lhu9MUf5fwTlgXc90CC5f9L4Gb5VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYjdoW+8JJoBg/wA1INkq3XpPJUwPKDDPjtfcFvboSc=;
 b=SaP60zwRlUiaBqOIRT79IlF3CYhWPZ/4dQh/CPhHZYSiTySTYj1xy0prRwJQBLw5KMXju9CTUQer0NLx6TelRsvZjj6RzE34qvoXfjIWhJM4TdYi6qNpY87CSaQcvrkD8cMoKPeqXTT4eYkcvVf+GvNa1pGg28m9YShzyT7vFAE=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM4PR10MB8219.namprd10.prod.outlook.com (2603:10b6:8:1cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 14:05:53 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 14:05:53 +0000
Date: Mon, 18 Nov 2024 14:05:48 +0000
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
Subject: Re: [PATCH v3 4/5] mm: make vma cache SLAB_TYPESAFE_BY_RCU
Message-ID: <6d010369-c0aa-458a-8b08-c14febea2f5f@lucifer.local>
References: <20241117080931.600731-1-surenb@google.com>
 <20241117080931.600731-5-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117080931.600731-5-surenb@google.com>
X-ClientProxiedBy: LO2P265CA0058.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::22) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM4PR10MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: 44740441-f863-444e-3efb-08dd07da1d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wrD6IEh6/0HEslmxMNfHScPZjA2iEJQSlGqrSd4uLnb4KaIvUMQycnP76CPt?=
 =?us-ascii?Q?8l3BgGtNbVb0y/P/YcM17MEKk4r5GveRfPe+BygB5SpXB7DxE/nvFImPObg6?=
 =?us-ascii?Q?+eseJ6vzqXRXLAVhCZ1JyRn0/VXS1PwshWglbmu9/XX2ls8RHUfO6y5v2TEA?=
 =?us-ascii?Q?3RVciE9XU1hq2IgGHy5ZTcoasuVbMjH0TPWLLdO+PG11X7nCVKiUuQn+Cv11?=
 =?us-ascii?Q?HBoLjysfTPym6GxNoYW5IpV7vaotG7i8te/GSPnDfr2zjJVnwJ5SzYtfoIpH?=
 =?us-ascii?Q?Jf1TNGzlYos5PF5RM9Qw895Ksi4y44rdqkolH/imSwgDdmTm+cOMM7K2JHTz?=
 =?us-ascii?Q?jsirQYceTqAVVmNPPzxb3tzuZ1i5kxGnkBRyRgqxCEBDc9+/v+HsFn0Tv10S?=
 =?us-ascii?Q?uKwa2ifcaUMUOdKUzN8zAED1Q6/NuoOwlRcLokLPWkRbx2mBsvdOQ+1LY3OG?=
 =?us-ascii?Q?biw4amqcXj9J07HAO74wvRFzzWjbMuI1XrL1pvizKDNyT5NSK5omtoxwDHPu?=
 =?us-ascii?Q?LdNDluRB2KE/gi3wC+DUt+oURTsij2398Z/gQxi9i3gd/FF8hxgE7Jn7qiOs?=
 =?us-ascii?Q?e+1fUbtkAP3oABgwT9TPDsnOySfkkHBDGL+myAag4s5TdZX1Xop7oN0pZIwP?=
 =?us-ascii?Q?GMitB6djNYzMWyY887WFfQ/5XTTc/kGGP8E21iV6da/FJWFXc3zipbdRbCzc?=
 =?us-ascii?Q?fiO3N48zcLQ79njndjL+ybFJ6rDbdrddt+G9q7mqwDBJg5jZVK/LRr8SaBiV?=
 =?us-ascii?Q?vBhVYchcV5QFG1/j/qxHrwlE1/a0KrfJWzLfSdFyBrpg6snduiMnIh/7mUa+?=
 =?us-ascii?Q?PhI8u84CFSEP57V+mD7ilv2wbJED4teGXjDU4fPkwdp/LRaoLw63F11/fJwA?=
 =?us-ascii?Q?QEijOauC/oFSR3PEXmLqJ3TFKdqXIsD+hM5EWjKysKBiHjOyIb2E5yU5KgZh?=
 =?us-ascii?Q?Ar0iTn1bdupm5TURjj9Bu+ESnzPUKhG/1DcQc6kKpCviG8etxpt1Bbo26dXC?=
 =?us-ascii?Q?G1RFG8gD6SwpDFdK7aj6OvlBRmywUeTRQ5DA9rwqpZLK0/Lzb2SudxKdjQv+?=
 =?us-ascii?Q?Rr5Z2Q7eEnCJ3Zg47+R4TqS3GBK2G6Zrk0afvP4tpS56VC0V7tjkBEi+suaJ?=
 =?us-ascii?Q?jtRP09mGbmmDgF9g4eY0VZ/d7kpUul7TfOxPYxiEQ+uHbueI90hGUvBkdnus?=
 =?us-ascii?Q?t4ZmyGu/n0636CTewM0dqucYVgB5z5EHZrOeZQZA6OP0kbRRoC5/b5Rp5ZEz?=
 =?us-ascii?Q?74vGDmZjow7QOVbWCV8iC5LBAAP92cuOJ8bb10kiAUgwBQsDn/01WNYEinFA?=
 =?us-ascii?Q?OJg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KV2ihf/80AwLNH8KebLVXJb/RvYRmGEEk3iG78uy/YnPcQy8Y49UdqzTwWV0?=
 =?us-ascii?Q?ZjOYKGo1FiQOHYWytQqCMFR56K284EZip6i7W1GcBgcTlNrrLzQPh/NJnIHe?=
 =?us-ascii?Q?tAEOggNdZr7NGF+EMBeW+n/wSdGZze5RNdveHs6C5dw6hRmqOzFXrHrEQtwh?=
 =?us-ascii?Q?OfDyFFA+kPFqSG1Ib4FKGBBg1TYLDDQWShuFd2Nhf7eq5hI22eiqdBwG9M0e?=
 =?us-ascii?Q?9qTbQ6pvY7GoTzmGsErZXDA0JAy5eyajwX57EmYA86rk6E3S+mAnaZYSu/p2?=
 =?us-ascii?Q?M4Uyanwu00NNQnylRN55B8dXKNjMpslYUNOHEGstRA8Gr6lVsLWh8VAVf/Wu?=
 =?us-ascii?Q?Q/joFHypAlgiol86vNFhmtKrknKUTDnAPRiPLPmi03xKt8l2uuznrAZ+R95z?=
 =?us-ascii?Q?iY3AeCMuo8utrCF5xN9UwhKLhJe1a2ZVezqYiwvI4DUsAxDZqn0Lu4JiN9Qm?=
 =?us-ascii?Q?LdNAYh7zcAO8xund1Lh+t9yMsIvzcdwA26ODivhCc+7jThRgZDDscE05ThJR?=
 =?us-ascii?Q?9JD5PunxNB7ksuzWiSxEE2AvvYuead9iCpci0mBWXhnErRQr/wPdP3c39bQP?=
 =?us-ascii?Q?3DxhapBPFTxS0FvTfUiWyT6U8Hp5u2GKIYy/i8TJoavuj3P8wbFcEIpGGkCS?=
 =?us-ascii?Q?DwxrslPzgeu0gTD7uGZQVWF96kXHKj3yG0uzE2w3Id9udCL2nTtKL9piVY+U?=
 =?us-ascii?Q?tXI7pxrtCWne6gfjurSUO91i8oPaSAJJM/ITSGZGXWFhRGVw412IfF62cz08?=
 =?us-ascii?Q?RgfQD7iUAyKiJUCBkfEnJhHAo44G8IICw07x9sCg6hY/lVBBX9BeMRE3CkML?=
 =?us-ascii?Q?NKd7zFBYWpPxOlyZr80ulJxTkokLOLcsadcEdJl0xC/kMtJ1OD2KG19wltz5?=
 =?us-ascii?Q?A6Og8wvxA5nNXHdgI+cUHSEWjWwBl+gWStp2cfD6pZFc46ixFvY/adc21Fs0?=
 =?us-ascii?Q?0QJHcnzsahwz+auq4WeFiJdb98hdpgm325nDMefjEw3vrlhfaSSkT3/msJyP?=
 =?us-ascii?Q?rYR2izyjobsfiKha/kfHi7qhDWvwDc8wkKIZLG6TQND2nN8xdG5ei7/w2qZN?=
 =?us-ascii?Q?SRDy4vNC9FLJB/K1Rok6WyGlAeJ1X4d4YSAynCFWUFYPdTChMuNs1AK/w6A+?=
 =?us-ascii?Q?9ZgWU4DXka5kqOQnMdCUqYB36WVe7QYPs0lNU0ktr0hqSoGtK78prgZdjmhE?=
 =?us-ascii?Q?uQGJGOxMSTVojzQZo1R0LtDXSMVOuqkuQmBmskqgGpQVXEMELClIX410P44c?=
 =?us-ascii?Q?BvZRJPiioXlupc0RFKLCsv6JA/h+6qKb3rE7Jcfs8ui0B5kC45j0otCncY7w?=
 =?us-ascii?Q?nG6Dkz1bi0fgF+EK7lq30tY7vhxTMcJdzfSk3ZeZsm6IAh4JvpqO8+EdGx7+?=
 =?us-ascii?Q?WONUO9AT7UNa3iPFoKsee4VM4/CIi3l+smQkE/jvYMES9LOnQ626CFcpd1Rk?=
 =?us-ascii?Q?COodWlnu/HR9XCjPqxLdcEgLIgxulfqfANRbIQdBQps8yPuI3p4mpQsHJAGh?=
 =?us-ascii?Q?cZGdmSnvyR4K0PxtYMVJViWrVG4kcqhZR+ywS3ApqxCp/uZ8JEi138/2DSqp?=
 =?us-ascii?Q?3qLFkEtAH74CfBbL0DoGdwIS82aUdE9VZ0fLpK57ombXt7swJVWXu0Yr4px0?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s5hqrnZc8B/1FItyV5vhFRWmN1uAIRbpXziwUen6KEwfqQp5rJkmlJg6i4QWZlh+6MZuyyKAbGwtbsEKLaLMmbS6QSh3kGcd5330QTn1LJGHygQi8NBaOjbVrJlOR9wS3rhT9Q/AWW3rkoMEvfpqJKrObYlHTXLPbmoiARIMZ8fzHddRh73Ri0E0pD8PVIAEr1IEDC1lJX2XlQRzgPdCcj6p41VG54SSMIWaAYRlePnuU7bxSuq/O+W5Nz59luot7uvWpwvJ0lJDnPIB9PEy46s9WoBJb/jsjdSfYb1Xy7B9sY7gTGy1tHeAeP8JI7kk/tUBLN6cM5zzuqbyPiJNtEtmJDWL7ijNCUSOlLgRApVCQ9dOb/Gozv1qHYvS5mJEi//iOQc4ZkPXyeYPDdtexgK/2Kaf2CcRSTRxpWEy5hwUs8sg6+iVeYqx2NSEeaHo6AwqTs7BDoQXZmQKs4lzUYEUjatQAaZIUbG6gJCxhyPP+nYXq/IcaHqyErYOs0J2tzx/cmTVcP7qjH7PwLOhFqog4ad4MmilZF6xTglDYtcckt4NQbXAEPj0xjha2oclJCs/S3Cagx7CvfGhmn+uHpb4hriq1jastHU0RzKlZcY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44740441-f863-444e-3efb-08dd07da1d1c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 14:05:53.0677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPJUUiDI/D4/Dhlp4zzNQggnV9p//q6yC+lm6SRWhf/DTB7FCNecfs7S6wSaLCOTgPVFhgLbL36YRQ8qkWfSR7QCzDQHxGBtxuM9btNxnTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB8219
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_10,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411180116
X-Proofpoint-GUID: 6IBc-Sol8k_AzEjFsnetXi3JOvKSptVV
X-Proofpoint-ORIG-GUID: 6IBc-Sol8k_AzEjFsnetXi3JOvKSptVV

On Sun, Nov 17, 2024 at 12:09:30AM -0800, Suren Baghdasaryan wrote:
> To enable SLAB_TYPESAFE_BY_RCU for vma cache we need to ensure that
> object reuse before RCU grace period is over will be detected inside
> lock_vma_under_rcu().
> lock_vma_under_rcu() enters RCU read section, finds the vma at the
> given address, locks the vma and checks if it got detached or remapped
> to cover a different address range. These last checks are there
> to ensure that the vma was not modified after we found it but before
> locking it.
> vma reuse introduces several new possibilities:
> 1. vma can be reused after it was found but before it is locked;
> 2. vma can be reused and reinitialized (including changing its vm_mm)
> while being locked in vma_start_read();
> 3. vma can be reused and reinitialized after it was found but before
> it is locked, then attached at a new address or to a new mm while being
> read-locked;
> For case #1 current checks will help detecting cases when:
> - vma was reused but not yet added into the tree (detached check)
> - vma was reused at a different address range (address check);
> We are missing the check for vm_mm to ensure the reused vma was not
> attached to a different mm. This patch adds the missing check.
> For case #2, we pass mm to vma_start_read() to prevent access to
> unstable vma->vm_mm.
> For case #3, we write-lock the vma in vma_mark_attached(), ensuring that
> vma does not get re-attached while read-locked by a user of the vma
> before it was recycled.
> This write-locking should not cause performance issues because contention
> during vma_mark_attached() can happen only in the rare vma reuse case.
> Even when this happens, it's the slowpath (write-lock) which will be
> waiting, not the page fault path.
> After these provisions, SLAB_TYPESAFE_BY_RCU is added to vm_area_cachep.
> This will facilitate vm_area_struct reuse and will minimize the number
> of call_rcu() calls.
> Adding a freeptr_t into vm_area_struct (unioned with vm_start/vm_end)
> could be used to avoids bloating the structure, however currently
> custom free pointers are not supported in combination with a ctor
> (see the comment for kmem_cache_args.freeptr_offset).
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

I've stayed out of this discussion as my slab knowledge is far less than
others (e.g. Vlastimil), but I shazam'd this series today and the kernel
isn't booting on my qemu setup, and I bisected it to this commit, and an
addr2line decode tells me this is:

static inline void vma_mark_attached(struct vm_area_struct *vma)
{
	/* vma shoudn't be already attached */
	VM_BUG_ON_VMA(!vma->detached, vma); <-------- here

	...
}

And if I go back to prior commits, this triggers too, since "mm: mark vma
as detached until it's added into vma tree".

I don't think this check should be added in this commit at any rate, it
should be added in "mm: mark vma as detached until it's added into vma
tree".

I will go to that commit to continue this investigation, but we should
definitely move that check over there.

> ---
>  include/linux/mm.h               | 48 ++++++++++++++++++++++++-----
>  include/linux/mm_types.h         | 13 +++-----
>  kernel/fork.c                    | 53 +++++++++++++++++++-------------
>  mm/memory.c                      |  7 +++--
>  mm/vma.c                         |  2 +-
>  tools/testing/vma/vma_internal.h |  7 +++--
>  6 files changed, 86 insertions(+), 44 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index dd1b6190df28..d8e10e1e34ad 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -257,7 +257,7 @@ struct vm_area_struct *vm_area_alloc(struct mm_struct *);
>  struct vm_area_struct *vm_area_dup(struct vm_area_struct *);
>  void vm_area_free(struct vm_area_struct *);
>  /* Use only if VMA has no other users */
> -void __vm_area_free(struct vm_area_struct *vma);
> +void vm_area_free_unreachable(struct vm_area_struct *vma);
>
>  #ifndef CONFIG_MMU
>  extern struct rb_root nommu_region_tree;
> @@ -690,12 +690,32 @@ static inline void vma_lock_init(struct vm_area_struct *vma)
>  	vma->vm_lock_seq = UINT_MAX;
>  }
>
> +#define VMA_BEFORE_LOCK		offsetof(struct vm_area_struct, vm_lock)
> +#define VMA_LOCK_END(vma)	\
> +	(((void *)(vma)) + offsetofend(struct vm_area_struct, vm_lock))
> +#define VMA_AFTER_LOCK		\
> +	(sizeof(struct vm_area_struct) - offsetofend(struct vm_area_struct, vm_lock))
> +
> +static inline void vma_clear(struct vm_area_struct *vma)
> +{
> +	/* Preserve vma->vm_lock */
> +	memset(vma, 0, VMA_BEFORE_LOCK);
> +	memset(VMA_LOCK_END(vma), 0, VMA_AFTER_LOCK);
> +}
> +
> +static inline void vma_copy(struct vm_area_struct *new, struct vm_area_struct *orig)
> +{
> +	/* Preserve vma->vm_lock */
> +	data_race(memcpy(new, orig, VMA_BEFORE_LOCK));
> +	data_race(memcpy(VMA_LOCK_END(new), VMA_LOCK_END(orig), VMA_AFTER_LOCK));
> +}
> +
>  /*
>   * Try to read-lock a vma. The function is allowed to occasionally yield false
>   * locked result to avoid performance overhead, in which case we fall back to
>   * using mmap_lock. The function should never yield false unlocked result.
>   */
> -static inline bool vma_start_read(struct vm_area_struct *vma)
> +static inline bool vma_start_read(struct mm_struct *mm, struct vm_area_struct *vma)
>  {
>  	/*
>  	 * Check before locking. A race might cause false locked result.
> @@ -704,7 +724,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
>  	 * we don't rely on for anything - the mm_lock_seq read against which we
>  	 * need ordering is below.
>  	 */
> -	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq.sequence))
> +	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(mm->mm_lock_seq.sequence))
>  		return false;
>
>  	if (unlikely(down_read_trylock(&vma->vm_lock.lock) == 0))
> @@ -721,7 +741,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
>  	 * after it has been unlocked.
>  	 * This pairs with RELEASE semantics in vma_end_write_all().
>  	 */
> -	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&vma->vm_mm->mm_lock_seq))) {
> +	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&mm->mm_lock_seq))) {
>  		up_read(&vma->vm_lock.lock);
>  		return false;
>  	}
> @@ -810,7 +830,18 @@ static inline void vma_assert_locked(struct vm_area_struct *vma)
>
>  static inline void vma_mark_attached(struct vm_area_struct *vma)
>  {
> +	/* vma shoudn't be already attached */
> +	VM_BUG_ON_VMA(!vma->detached, vma);
> +
> +	/*
> +	 * Lock here can be contended only if the vma got reused after
> +	 * lock_vma_under_rcu() found it but before it had a chance to
> +	 * read-lock it. Write-locking the vma guarantees that the vma
> +	 * won't be attached until all its old users are out.
> +	 */
> +	down_write(&vma->vm_lock.lock);
>  	vma->detached = false;
> +	up_write(&vma->vm_lock.lock);
>  }
>
>  static inline void vma_mark_detached(struct vm_area_struct *vma)
> @@ -847,7 +878,11 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>  #else /* CONFIG_PER_VMA_LOCK */
>
>  static inline void vma_lock_init(struct vm_area_struct *vma) {}
> -static inline bool vma_start_read(struct vm_area_struct *vma)
> +static inline void vma_clear(struct vm_area_struct *vma)
> +		{ memset(vma, 0, sizeof(*vma)); }
> +static inline void vma_copy(struct vm_area_struct *new, struct vm_area_struct *orig)
> +		{ data_race(memcpy(new, orig, sizeof(*new))); }
> +static inline bool vma_start_read(struct mm_struct *mm, struct vm_area_struct *vma)
>  		{ return false; }
>  static inline void vma_end_read(struct vm_area_struct *vma) {}
>  static inline void vma_start_write(struct vm_area_struct *vma) {}
> @@ -883,7 +918,7 @@ extern const struct vm_operations_struct vma_dummy_vm_ops;
>
>  static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
>  {
> -	memset(vma, 0, sizeof(*vma));
> +	vma_clear(vma);
>  	vma->vm_mm = mm;
>  	vma->vm_ops = &vma_dummy_vm_ops;
>  	INIT_LIST_HEAD(&vma->anon_vma_chain);
> @@ -892,7 +927,6 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
>  	vma->detached = true;
>  #endif
>  	vma_numab_state_init(vma);
> -	vma_lock_init(vma);
>  }
>
>  /* Use when VMA is not part of the VMA tree and needs no locking */
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5c4bfdcfac72..8f6b0c935c2b 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -667,15 +667,10 @@ struct vma_numab_state {
>  struct vm_area_struct {
>  	/* The first cache line has the info for VMA tree walking. */
>
> -	union {
> -		struct {
> -			/* VMA covers [vm_start; vm_end) addresses within mm */
> -			unsigned long vm_start;
> -			unsigned long vm_end;
> -		};
> -#ifdef CONFIG_PER_VMA_LOCK
> -		struct rcu_head vm_rcu;	/* Used for deferred freeing. */
> -#endif
> +	struct {
> +		/* VMA covers [vm_start; vm_end) addresses within mm */
> +		unsigned long vm_start;
> +		unsigned long vm_end;
>  	};
>
>  	/*
> diff --git a/kernel/fork.c b/kernel/fork.c
> index f0cec673583c..76c68b041f8a 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -436,6 +436,11 @@ static struct kmem_cache *vm_area_cachep;
>  /* SLAB cache for mm_struct structures (tsk->mm) */
>  static struct kmem_cache *mm_cachep;
>
> +static void vm_area_ctor(void *data)
> +{
> +	vma_lock_init(data);
> +}
> +
>  struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
>  {
>  	struct vm_area_struct *vma;
> @@ -462,8 +467,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
>  	 * orig->shared.rb may be modified concurrently, but the clone
>  	 * will be reinitialized.
>  	 */
> -	data_race(memcpy(new, orig, sizeof(*new)));
> -	vma_lock_init(new);
> +	vma_copy(new, orig);
>  	INIT_LIST_HEAD(&new->anon_vma_chain);
>  #ifdef CONFIG_PER_VMA_LOCK
>  	/* vma is not locked, can't use vma_mark_detached() */
> @@ -475,32 +479,37 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
>  	return new;
>  }
>
> -void __vm_area_free(struct vm_area_struct *vma)
> +static void __vm_area_free(struct vm_area_struct *vma, bool unreachable)
>  {
> +#ifdef CONFIG_PER_VMA_LOCK
> +	/*
> +	 * With SLAB_TYPESAFE_BY_RCU, vma can be reused and we need
> +	 * vma->detached to be set before vma is returned into the cache.
> +	 * This way reused object won't be used by readers until it's
> +	 * initialized and reattached.
> +	 * If vma is unreachable, there can be no other users and we
> +	 * can set vma->detached directly with no risk of a race.
> +	 * If vma is reachable, then it should have been already detached
> +	 * under vma write-lock or it was never attached.
> +	 */
> +	if (unreachable)
> +		vma->detached = true;
> +	else
> +		VM_BUG_ON_VMA(!is_vma_detached(vma), vma);
> +#endif
>  	vma_numab_state_free(vma);
>  	free_anon_vma_name(vma);
>  	kmem_cache_free(vm_area_cachep, vma);
>  }
>
> -#ifdef CONFIG_PER_VMA_LOCK
> -static void vm_area_free_rcu_cb(struct rcu_head *head)
> +void vm_area_free(struct vm_area_struct *vma)
>  {
> -	struct vm_area_struct *vma = container_of(head, struct vm_area_struct,
> -						  vm_rcu);
> -
> -	/* The vma should not be locked while being destroyed. */
> -	VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock.lock), vma);
> -	__vm_area_free(vma);
> +	__vm_area_free(vma, false);
>  }
> -#endif
>
> -void vm_area_free(struct vm_area_struct *vma)
> +void vm_area_free_unreachable(struct vm_area_struct *vma)
>  {
> -#ifdef CONFIG_PER_VMA_LOCK
> -	call_rcu(&vma->vm_rcu, vm_area_free_rcu_cb);
> -#else
> -	__vm_area_free(vma);
> -#endif
> +	__vm_area_free(vma, true);
>  }
>
>  static void account_kernel_stack(struct task_struct *tsk, int account)
> @@ -3135,9 +3144,11 @@ void __init proc_caches_init(void)
>  			sizeof(struct fs_struct), 0,
>  			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
>  			NULL);
> -	vm_area_cachep = KMEM_CACHE(vm_area_struct,
> -			SLAB_HWCACHE_ALIGN|SLAB_NO_MERGE|SLAB_PANIC|
> -			SLAB_ACCOUNT);
> +	vm_area_cachep = kmem_cache_create("vm_area_struct",
> +			sizeof(struct vm_area_struct), 0,
> +			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
> +			SLAB_ACCOUNT, vm_area_ctor);
> +
>  	mmap_init();
>  	nsproxy_cache_init();
>  }
> diff --git a/mm/memory.c b/mm/memory.c
> index d0197a0c0996..c8a3e820ed66 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -6275,7 +6275,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>  	if (!vma)
>  		goto inval;
>
> -	if (!vma_start_read(vma))
> +	if (!vma_start_read(mm, vma))
>  		goto inval;
>
>  	/* Check if the VMA got isolated after we found it */
> @@ -6292,8 +6292,9 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>  	 * fields are accessible for RCU readers.
>  	 */
>
> -	/* Check since vm_start/vm_end might change before we lock the VMA */
> -	if (unlikely(address < vma->vm_start || address >= vma->vm_end))
> +	/* Check since vm_mm/vm_start/vm_end might change before we lock the VMA */
> +	if (unlikely(vma->vm_mm != mm ||
> +		     address < vma->vm_start || address >= vma->vm_end))
>  		goto inval_end_read;
>
>  	rcu_read_unlock();
> diff --git a/mm/vma.c b/mm/vma.c
> index 73104d434567..050b83df3df2 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -382,7 +382,7 @@ void remove_vma(struct vm_area_struct *vma, bool unreachable)
>  		fput(vma->vm_file);
>  	mpol_put(vma_policy(vma));
>  	if (unreachable)
> -		__vm_area_free(vma);
> +		vm_area_free_unreachable(vma);
>  	else
>  		vm_area_free(vma);
>  }
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 2fed366d20ef..fd668d6cafc0 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -632,14 +632,15 @@ static inline void mpol_put(struct mempolicy *)
>  {
>  }
>
> -static inline void __vm_area_free(struct vm_area_struct *vma)
> +static inline void vm_area_free(struct vm_area_struct *vma)
>  {
>  	free(vma);
>  }
>
> -static inline void vm_area_free(struct vm_area_struct *vma)
> +static inline void vm_area_free_unreachable(struct vm_area_struct *vma)
>  {
> -	__vm_area_free(vma);
> +	vma->detached = true;
> +	vm_area_free(vma);
>  }
>
>  static inline void lru_add_drain(void)
> --
> 2.47.0.338.g60cca15819-goog
>

