Return-Path: <linux-kernel+bounces-412381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FF39D084E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74942281C75
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 04:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DDD7E0E4;
	Mon, 18 Nov 2024 04:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jhv16Q6H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NUmipqA8"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1735B28F3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 04:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731902835; cv=fail; b=itO00FRhTSIx3SqES5ld2U2K+zJTT+jZWWQQ2ywVlITjQfRRaQwVBtxxHo95a8al/kaWxKv3SU33GAMHUz/0kaAvypX6UP8kGd5xbyyQJjDfmmV4G8TX5TZ5f3fMsM+WzInBs+LUR18tSIKCdkTJM+1iQcjo6iDSo7jlPXO3obo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731902835; c=relaxed/simple;
	bh=dNC/oKhplVXSyMnBFGGlHmfJ7vXheK6WE1kihHx3Dg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JbJUA1/PrEE1TvdMQzKOMXqMN2RCd4mP4jRQo0oCGZM0Ivw8g+atsv2sCJASs4+huoqwuq+iMBkhTlpRIebZ7PNQptf8IM0Uq+YHCw2ALjAkNVtUrNTDS6o2jq6ya0i8Z2kLKzn20P1nbejnfx3JLJFWvySG1TXFfco9TXLEFeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jhv16Q6H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NUmipqA8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI1Bkft023104;
	Mon, 18 Nov 2024 04:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=XK6LE/w6GnEIu+sWmD
	pmtQnFvgE2LFW0+i2k03z2nis=; b=Jhv16Q6HbVruTZwQhsXqU3ZVKsLJGuuw6b
	SyceA2dm5Xqg6Tqzefw3YQ4SxxX5bz0COC7Ek1S5kxvga/j9uSXrGiICZh1y9AJz
	iN7XkPsCAX+4Cn4BaGJeyHYfj8bb5IX5pwqisA5rg/ckdkdqHG/2l6fppjzwD6YA
	e2/39cptG3UoU1L3N9cTYCP/WTxjOaCtpJEjHEtHQ1Ct0ynZ7U1VMcSYcazbbVBD
	2UNJahWuQe6M47h1+mQlrOxR+Ldsi5WuQzHW+NFqo0/jHxuC1MdlcMKUjXjbrxN2
	ZsFqdv1ihcWtEn1mCPcicbVCUWBxu7NmQn1X2wKbc25fekwfvzRA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0shu3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 04:07:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI3XTF6037339;
	Mon, 18 Nov 2024 04:07:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu6uf6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 04:07:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpU8fu3f5+dz1t5Lw3UQuCT2r6XZJHursJ8DduXUypOvDAzMS3fAt988gno79j0R2bxsaWD4ub/8bx6Qfbl7zNdxyfyCFkjKIvFqAtpIbLeq9FmMTXcJxSNZctTzfsbz4QJSgeIlbYiIpdG4/E8jaow9QdVDGKy2KBUrSJQ47g0/hhr7CfBVQZ0pNAjnGm5fbB4yOuGwAH0oQzM7SbdN36WXETBNidSqEJoxSqn+BEuASs3v1qCjkzzSMCAmoOBVsSbyIRUe0Cr3Kphuy99jl4KjBxyl9a+KyTsmLmCT7PEATd91WNPT8k8V9jyg+B7uTaOXd6x6zpnrIBkKLAWwCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XK6LE/w6GnEIu+sWmDpmtQnFvgE2LFW0+i2k03z2nis=;
 b=CGsKbQWOx28JBknKwZjjw/OmYjJFGjQC+c6CTsqL70YtoSJS4mLj4AlCfM8PmlgUrrOnQvBZm0gNno8btozFxanrTvJ1ScxVw61EntmydO9pKWUsxGNJvdeOSx7ETk1MhP8el+Xh+FT/vJN5yUAgpAdnDa0akk/wDl5vszCxU8vgtOvBKkHMIIhfbzydp4ARLFtIyI5aRKNqMPdz1CE6mtdbX7PLQGGXQEXt5FEEhDdx1eLsyB5Pgpi6sBhxNdRcxS6fWlcnokOzuVhApVa1Yl9Ruangh5sg8uUVwhSVMeXdGe/KvfhwWai7v//KNcqa6QFhRDUe46H5gFEYQ0ysBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XK6LE/w6GnEIu+sWmDpmtQnFvgE2LFW0+i2k03z2nis=;
 b=NUmipqA8xrWNIZPpIwR93vEwZkQDwwJohy/6upKkj7PVgq8DKxtWQ3wUpLP/5L00/XpMq7Y+IGP8on0R8YgxYE8cFCFk99IhUc+4S3qdo2IVoDkvt0A3aOj2h1XLkYffVnYGo8k6yicrsjXaA8u7zySex8df3XgT0tNMz4i+eKg=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH0PR10MB4744.namprd10.prod.outlook.com (2603:10b6:510:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 04:06:58 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 04:06:58 +0000
Date: Sun, 17 Nov 2024 23:06:55 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: syzbot <syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, jannh@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lorenzo.stoakes@oracle.com,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] general protection fault in mas_store_prealloc
Message-ID: <i2eu66jkrzkudfoa4dmxbxvvsb77pmneou52wg2con6nbdjuov@apux3q3iqjme>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	syzbot <syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com>, akpm@linux-foundation.org, jannh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
References: <6739c892.050a0220.e1c64.0013.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6739c892.050a0220.e1c64.0013.GAE@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0304.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::20) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH0PR10MB4744:EE_
X-MS-Office365-Filtering-Correlation-Id: a2838a48-a2ef-42c1-1df8-08dd07867245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4CDRo5dYs7jd2/XJ8yD7oWjJYKfVYgQGtFvjkHrpePNP+v87cEVQIn/MvTXT?=
 =?us-ascii?Q?VfvOG9eJWHKFRqNRj1cG5P9i5u66jJDzeH98vGyZ7r8UfwhTVMK4Oyhvu4ms?=
 =?us-ascii?Q?zNTZQQPObXBu3TLG7gt+AVoHn6vidYa1LGn+OG6jsM+bREqRsol6jwcOBfLe?=
 =?us-ascii?Q?x5QYL9KP5CTRCVf6SgVrX+vOq2Bx2stm/SV50Whfs6vKy/2iEN1W+WabOOoY?=
 =?us-ascii?Q?0OCvVhJZH7xi3q+nitgBxEdK73cusvRO4tQGrDOPOmYFXGVNsk6r8xJ5gcF2?=
 =?us-ascii?Q?XSvhn7xEqR57KxBFFtXDtAzKWOWUUHn1l6VuzjrEmxUyZk5hOBXDMVAZf2Dt?=
 =?us-ascii?Q?pGC9laqLzsU0SiLXpdk9EOFr5pA8Ap+WFoVSKrSpjMBO3Yo4XaRdjsN/xg+4?=
 =?us-ascii?Q?BnGgC8mSH7MbkL+gWhZJmxu6X+tWvtMu/xNYHmauC4SrBCztCOD/XhtpsgKV?=
 =?us-ascii?Q?Ew4o0JC+9Kjyx/Oe3iaUbVAV5gSD6En65lgnQWl17g+FGX21MOGf6uk+b3QS?=
 =?us-ascii?Q?TrEGnqDU+iMpZpAoi1oj4LmeR2DnCQZd/wDqsAFOk1VLhwcw8xwLRvSRwlhI?=
 =?us-ascii?Q?TGIz0V4Q3fZ+/MUmn77xpPn1EHElNcCGvENhPHcdPVwTNhqpfvbgxHAaxulZ?=
 =?us-ascii?Q?KW5SjQkqxJTv8e3zcB5TXYp3dTN6s0wtRTn5wjtgBz/jsoD0Mi3t3DTE7adC?=
 =?us-ascii?Q?zhm2C7CiZJqBSBSexYhvISRkRnyE0wgL6VrBt65s1q/7MN8Np1NU7TYH3W3H?=
 =?us-ascii?Q?qvBrhaRpIfotMZ/xZq7Gle+vH5iCNepITrElck9ag7MhthLW9MvN1etOCQrA?=
 =?us-ascii?Q?zuk3ZLprM5c0vnoN68EwrxQ898Rzzt+LSDJ0ieASpup2MklEtaeZEPS1clQm?=
 =?us-ascii?Q?P/ruvE96e4Zwod0OHcI+ETGNXh8Kcy9VJ5GFE+h0COq39QgQ8w96DGKPKB9D?=
 =?us-ascii?Q?L9ZPb+8R/kg4mmCKi/9IKete1l5N/KBKDTPTXamRKB3ntESX0MLDc/VXePRr?=
 =?us-ascii?Q?W/d1ptCORsnV+rVEZHgutNahYRSaVEz+qpcOiLfCkwq0FjwV1Fle+HNoC+w9?=
 =?us-ascii?Q?6QOyzVF6FHOPuo8K38p0Y2IdZI6ppxMwWyp2wP8wOXXMMq1gGeHbDOCfWx73?=
 =?us-ascii?Q?2T+WhxcTugrMTl2WJwBb+pHCQ+jyPKcVQRT2yuhVta4KKE1qUO6bF/Npg2Oz?=
 =?us-ascii?Q?mISlxdPYrBecmWePyIEK2nxAgEpU4ngRyLHmKgNoC1XRRjNZwiNti+0YUVYj?=
 =?us-ascii?Q?0H2cS8XjSHTK7nMJJ71SL6nuwKTj97Tep2EnVoGkqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QFN2ui/wRIXVQ7trZh/4qsi8hLa6E7vra82B4U3YMX5GTGC4+n6O+mYkHTV0?=
 =?us-ascii?Q?11HPIGNw+ql/1y/fvQ7PBfliSa/i4IkN/3jUqEl3pWBWUPO2k1uQkeoVAvSN?=
 =?us-ascii?Q?2ONO78ADmPSF29+z1NkaHCUXv+XtFg31dNQFVsMDOh96XVFIVDq4LQXjYYfC?=
 =?us-ascii?Q?m3WWFNg2trcaVtQIjADB+0wX7yh/eT3jOc1yAwu8K8SRHCiu7+HCKwqnZpa4?=
 =?us-ascii?Q?0XKzNK9JpYykAbLdE4K4S+kTUGtZo1f+WcKeAVgEWbrgNjlD8j5MHs6pfJB2?=
 =?us-ascii?Q?3Rcg5GVC9GW0/DIZBHsNLzW+IOg7mOD+MEHW1kf9Sl8DpaZlfFxHQeBhuCcC?=
 =?us-ascii?Q?Ja5XnB2iE8GdLoAi8WODA2d+6Yf3gm2YGBlM71zY6hYecJNSVWbtdthuJXa8?=
 =?us-ascii?Q?Newqg4o+ImHsO2xJ0LKSprMqljctI/0LbTKqDR3T19dc+UfTSSKWPaErTJEy?=
 =?us-ascii?Q?m1Jtdv7JI2LdHmyE3zuQ+X8H0U6eNo5hyRb0ZQKKbQUIaeaEC6yjFVxJNWos?=
 =?us-ascii?Q?usE8TSYh5tLNpOY8NB41JAOvC6OtyMK23qfKO3c10OyE1gXqJtit3f0Kp9ya?=
 =?us-ascii?Q?o1m6YXpWpABlLF/BGu3teQ2nlQIwCy1La/zTRwrIrjRY7DR8TeLHRUyqF9ac?=
 =?us-ascii?Q?n2BOKXqha2TEPDdPMTNBDXfnk/HnYTGGWK1p++Rd49nx2fmk4qAMBO6AAtvT?=
 =?us-ascii?Q?JT+NA82PuJDt2AOV1vJ2TJHEw9PABHzvIil0ey0VCFHb5qglqlQtCeacOdcQ?=
 =?us-ascii?Q?b3ukqamtiJoCZuZkTG3L1LubTxXdcYQsqqvwVle5d9ag4/PS+tvE6vnUlRQe?=
 =?us-ascii?Q?iEXYpFmUwufPvMVHVUlH80wuY0CojjHNcPMDzUID4zSo2q0KSJXv48FccjiR?=
 =?us-ascii?Q?TOLYFL/F45C9GnDi5heYvD8vWvkUQw53J7WPpVjyDhEYWST8rKeRdhqDZkSq?=
 =?us-ascii?Q?K7BWbuVvzu7nF1ZLSATg309Yg//grQ8lXi8OiBAe53EP9OhhXH6h0/eiMDse?=
 =?us-ascii?Q?DfLPED0S2whF06/zuxT+memfhHqIcKftjePCrPiqELdeqpRaPk4zPgb2hCjR?=
 =?us-ascii?Q?L1djQ/N4V/Xu6q1L0f/HtWbBuBWS+xpozdmT1DtPqRllpaJJGp3E0jkdff3v?=
 =?us-ascii?Q?gF5llz4eBYl6E948lAkwW//LBUEozEW+dH+8IQ9bj0tU7IaqNVJ8NfYpNvuK?=
 =?us-ascii?Q?uuTSdwiZsm6Gvm3YbeZqFq8vCnQ9etx0LLVbsbWn13aG+hX1TXYxmDtvcGGy?=
 =?us-ascii?Q?Aq1WHuK0MonDBqX72Oq4tYudVardU8pJXLXrryCiGbN9SAPjb/fOBjpHSH5P?=
 =?us-ascii?Q?kT8q5ETSqESkbj0Sq4u11uRJo7tcMKAzUsxLdNmDcornHQCf/baY+OfgXAlZ?=
 =?us-ascii?Q?+EC7srq1doTfVPpi4mMN1ZYjEJ45+KAlqcGcsoQI06mo8gDu8DIAgU3CVDNX?=
 =?us-ascii?Q?DfaJVZFhd2MoS+A2C0Y0cuXMRDyK1hI+T9e1QpjJ/OMvr8WMrfXHV5YdZ6ua?=
 =?us-ascii?Q?61HZ7y8OH66pCWoPGcaq34d+kG6J1sB8uSA8eQZ3K7THMEpxAOZyfAyUJil4?=
 =?us-ascii?Q?2PykcWqsFyunJXB7LvGL01j+kxphO3pyEpL08kRR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wlrO3YI21yNqHG5TCrBxspI2UmQcZxaAaaorjyh78xs6jGz0sP5TnDpiQTL6cuIWwDk0pyek8wliymCdTb2r71VoxOw2t7N9DaP6yT/Xr0GL1We+qhHs7Ruk5S2vu9JYsb/Qn9C2Wo9rUfFIwgsMA2OiK13/0QNRCjMBySotw2pWTpgta7/VI0j95+hXXBVCPysdhmzQD2lME7aiusheyZ2esJcHSndwnH+Mkgd1/zdjy9PIjI2bt4MXyOlCSkJ44WIozD+rFmiCFPFn+M0EOqVq+tb7g0Ga8dg5EBAqwbGiMJ3jKvRE8xwVR1zVde1nR5ozz5MjlE13LxOguDhpR+PnGpCJ/luTIXNXUlycW1AGkgEeGrJu4sYaaAvmgajHv0Hb5PrMIrnX5JA2qD1mOz5uyKFiIv6NAV+04XUMHzK88hqF18bxizi+TiXDABmdCOWH93W8mLNk2G13gGRk7h4HG/8v5WDT5iYRdN39ju1p9Nksm8Q10q03FASX6Jn8CIoH/YWP+O+1jVNDxwFX3ibtIZE688c9b21LXtkdqoDPILaBlO/Dr47WtOu5Wru3FtzHG/7A7wl1pumhFjmM4eD02SoRpzpJ7RjtaOWGg6A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2838a48-a2ef-42c1-1df8-08dd07867245
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 04:06:58.2232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YaAQ+5pRluctL0Ag50X3Nykwik4ZPOFQc/HwEZyjP0QKw18N+mOYo6NTwlZPdy077EI7aR7R+ZbRgtQDmTQyAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_01,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411180033
X-Proofpoint-ORIG-GUID: KZpHXzvH4Iy1h5u_LINr9uEzLrEHnhvd
X-Proofpoint-GUID: KZpHXzvH4Iy1h5u_LINr9uEzLrEHnhvd

* syzbot <syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com> [241117 05:42]:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8e9a54d7181b Merge remote-tracking branch 'iommu/arm/smmu'..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=17b0ace8580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a1eb85a42cb8ccec
> dashboard link: https://syzkaller.appspot.com/bug?extid=bc6bfc25a68b7a020ee1
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147521a7980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102e14c0580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ad658fb4d0a2/disk-8e9a54d7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1b7754fa8c67/vmlinux-8e9a54d7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/50315382fefb/Image-8e9a54d7.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com

#syz test: http://git.infradead.org/users/jedix/linux-maple.git arm64_kernelci_20241117

> 
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> Unable to handle kernel paging request at virtual address dfff800000000001
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> Mem abort info:
>   ESR = 0x0000000096000005
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x05: level 1 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [dfff800000000001] address between user and kernel address ranges
> Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 1 UID: 0 PID: 6421 Comm: syz-executor374 Not tainted 6.12.0-rc7-syzkaller-g8e9a54d7181b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : mt_slot_locked lib/maple_tree.c:795 [inline]
> pc : mas_slot_locked lib/maple_tree.c:808 [inline]
> pc : mas_store_prealloc+0x870/0x1068 lib/maple_tree.c:5514
> lr : mt_slot_locked lib/maple_tree.c:795 [inline]
> lr : mas_slot_locked lib/maple_tree.c:808 [inline]
> lr : mas_store_prealloc+0x778/0x1068 lib/maple_tree.c:5514
> sp : ffff8000a3e57440
> x29: ffff8000a3e57560 x28: ffff8000a3e574c0 x27: dfff800000000000
> x26: ffff7000147cae94 x25: 0000000000000008 x24: 0000000000000000
> x23: 0000000000000008 x22: ffff0000daed1040 x21: 0000000000000008
> x20: ffff8000a3e578e0 x19: 0000000000000000 x18: 0000000000000008
> x17: 0000000000000000 x16: ffff800080585ea8 x15: 0000000000000009
> x14: 1ffff000147cae99 x13: 0000000000000000 x12: 0000000000000000
> x11: ffff7000147caea2 x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : 0000000000000001 x7 : 0000000000000000 x6 : 0000000000000001
> x5 : ffff8000a3e565f8 x4 : 0000000000000008 x3 : ffff80008b4208f0
> x2 : ffffffffffffffc0 x1 : 0000000000000001 x0 : 0000000000000000
> Call trace:
>  mt_slot_locked lib/maple_tree.c:795 [inline] (P)
>  mas_slot_locked lib/maple_tree.c:808 [inline] (P)
>  mas_store_prealloc+0x870/0x1068 lib/maple_tree.c:5514 (P)
>  mt_slot_locked lib/maple_tree.c:795 [inline] (L)
>  mas_slot_locked lib/maple_tree.c:808 [inline] (L)
>  mas_store_prealloc+0x778/0x1068 lib/maple_tree.c:5514 (L)
>  vma_iter_store+0x2e8/0x81c mm/vma.h:476
>  __mmap_region mm/mmap.c:1513 [inline]
>  mmap_region+0x1650/0x1d44 mm/mmap.c:1603
>  do_mmap+0x8c4/0xfac mm/mmap.c:496
>  vm_mmap_pgoff+0x1a0/0x38c mm/util.c:588
>  ksys_mmap_pgoff+0x3a4/0x5c8 mm/mmap.c:542
>  __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
>  __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
>  __arm64_sys_mmap+0xf8/0x110 arch/arm64/kernel/sys.c:21
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> Code: 393b2668 972c43de 8b180ef5 d343fea8 (387b6908) 
> ---[ end trace 0000000000000000 ]---
> ----------------
> Code disassembly (best guess):
>    0:	393b2668 	strb	w8, [x19, #3785]
>    4:	972c43de 	bl	0xfffffffffcb10f7c
>    8:	8b180ef5 	add	x21, x23, x24, lsl #3
>    c:	d343fea8 	lsr	x8, x21, #3
> * 10:	387b6908 	ldrb	w8, [x8, x27] <-- trapping instruction
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

