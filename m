Return-Path: <linux-kernel+bounces-558790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BF0A5EB2D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 06:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD502189BC58
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 05:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0461F9F72;
	Thu, 13 Mar 2025 05:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tk4bgiLy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c4HW8k74"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5501FAC26
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 05:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741843831; cv=fail; b=WF5/f012IDsjG1CujfxxuxPcI4eK2f4L8dETRVcg9sokIneH8znYTxHOIQSb31XK6hW7t303yTXYYEyMu/T34bGlM+xgnLWf++oqW8MOkoBoLs+Ib3asYrdesaTGNCjTo5D2DCC8g1XPbE94cvbR1xLA5T/cHVqy7HdW+DbjIFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741843831; c=relaxed/simple;
	bh=f5NWrM5TGp6o6Esel2XHmFDirEDJSPdB6VDCTkDrR4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WlFt7GAO6FPjAtvz/4j6s99u7z8mMSJGmE3wYxhRZTUeVcdWYrNdiux55pUNxBBkD6ZE1RgYGGYDT/sGGCek45JsTAXjabBufpWKf6QWrxI2Jivso5kcJsDhdTfT99isLFtoz+hWZVncNm1rT2VL+d4F6elLu/9m5Sg6i/m5rw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tk4bgiLy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c4HW8k74; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D3tkr0008207;
	Thu, 13 Mar 2025 05:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ILeVxvxpt8BXmBqcRE
	Fn8hgPV0sJWRM6248PGE0ryX4=; b=Tk4bgiLyqtI2dIUKaC5UVvVz5ODAUqPr2R
	WclrRVitm2qVfPOWpYzu7rV41/eIb4Ej9OtR9jnOwGreiDDMbODsZCeUMA0mwfFf
	KRfQfGLkMtERQX/qF0NnhztIrPnOyEC/UhbGzfFFGYYEm8D798Rno2DYkqKdcGwn
	ov3mR1dqpT+b/BDQDFh6bni1lT1ApirvCIK11HBy516Q1OyR5KvcUY/SiOyPImdu
	sIdnc/lRCYHu/1UdUhkktRk4LH5uP16yoyzS9A7l/dxXafg+lpdPiXpywBFI/gsi
	5+kLdnIPso1gTk8jGCzouDzLOFRIWqwvuAeTYaQufOJ0OyTBPpxw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dufqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 05:30:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52D3MoWD012103;
	Thu, 13 Mar 2025 05:30:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn2782s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 05:30:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLZEFoWtu4L2NgZWkiv9wIICtVcTBKgLgMbaeR40+eJ7GaVDhqK7tpkUoQVtTkbnUpwYQQnpoLs0XOFywQU3P7EK9qqGbrO9huzub1MZiPaK5I+0OgAh6A5Q9NxHNUZicTyWqSBDCkmgPcgh8OD9oAXTWmp1J/8X+6xarrbudNcFxgwy0Jbh8uCrrlp33hKTKUfDTfV9gnQWTnf7w9fX6YbTP/rl6JAilpg8J+9BRLFj+bTHT5aR+JZXSZ6I5v7Y6oXWt/9eRdBm+0qS79HPbGla3oqSqSxgnSevG5i7wfc7mQ5+bUiNQx6+qhyt3fmHOi8qP+GkLF8bITjvXgzqlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILeVxvxpt8BXmBqcREFn8hgPV0sJWRM6248PGE0ryX4=;
 b=XL5gZmgFLKr7zPquoIT9Nry7FPOP07xoxE9jwaXnuwj8Z1ZGHIXYOWCu+qANpA7G6vTBEZG0WYr2xgrWiM5qLkd1rdFVNa2pE0/R/0SY38ermGKlqoKY4Gw3/NrzcFKR9lhtGDJY/MScDrvr0aZdrzOlrrsDwCmkecQCx0aTcEnnFsbQhKKpZ3kmprHxaYyPKUrlo60eOan4ThIKW1rRv/j29ys4xdQiVx2SzenxBio4EveGL6Mg0LVFWQo0nE7oGFL2ASIqSK2tNpQyF2GXGE4MnTHoHXu+0pEC0XVC5GN5J3mkzUmpksLotb0rLg5yYrHGfOs6EzjOl664XoPNiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILeVxvxpt8BXmBqcREFn8hgPV0sJWRM6248PGE0ryX4=;
 b=c4HW8k74QZEIDauwlw8a7iXhKmGT3EH5hNn2zgi1S0FXk8J8DjS3gc3AoSyaTEF/RuWRh44KJlt+ISqarR06xtIckrh7thknrzsmE2TVKsuNaEsi5E9OP/Ci5Rnnd8UhRf+29N6zS8EM+5nkQ3Y+1Raf78iuCburSvjAc+gDfro=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH0PR10MB5561.namprd10.prod.outlook.com (2603:10b6:510:f0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 05:30:11 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Thu, 13 Mar 2025
 05:30:11 +0000
Date: Thu, 13 Mar 2025 05:30:09 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <howlett@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/4] mm/madvise: cleanup requests validations and
 classifications
Message-ID: <add63931-2b94-4bd4-a8a3-b5754671b437@lucifer.local>
References: <20250312164750.59215-1-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312164750.59215-1-sj@kernel.org>
X-ClientProxiedBy: LO6P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::16) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH0PR10MB5561:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d46cab-9ef3-4789-1ab4-08dd61f01ff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8+bTAtDn6mE5jLX37AoRgs9n16HbRFkuVdSKNuFrGLyv+tTma6UqwFJGl/dr?=
 =?us-ascii?Q?b4BQd3TjWnVOKNxdRwKNNAwgh0nmx61P7y8pAOI+MNg/pWM5hDAh05R6ZEPx?=
 =?us-ascii?Q?Jnmv648KObD/tpJaTp4xfGH91/sVYHYK18fA8KRtV8T1Nn0lFNZARgpduZT3?=
 =?us-ascii?Q?75JRw6qTAfs5aekHokUPwrLbS8R20Ks+5sLa83E4SxMRPQ/mEdC8yoG1SSeq?=
 =?us-ascii?Q?gjn4mpxmDS/LUrRGDQL2W4QCvWvs2YWZXujF4CRY5auj+e62ji02tqKJtbIn?=
 =?us-ascii?Q?C2nEFYqZScyW8LdsgX58e6no+zHE30ksbIh8LYTj7cx0zbWZDM79wRt/YJnp?=
 =?us-ascii?Q?8XOXdMiv5CntCrD6iNiL4E+Ei5lYp6dn4L4szeOJVt/+4Xh40S28geCusI3o?=
 =?us-ascii?Q?ssjDAxoMlzSB0IQcrPxgeaO7qsFhpCoEpQYe8IN/7ElqFHyk5u3ldh44HHwy?=
 =?us-ascii?Q?nEkYK4uRfrMsJu0AwgMGZBQrvJOO8LYdAYkU4lVi5n13o81fVquLxu0I5NG8?=
 =?us-ascii?Q?0IV9takoiO+RgXAPOyn17Y8wKW5jVZ3QmLU/FjG7zFvT2nm0MQOuIg2OEFBc?=
 =?us-ascii?Q?1g3OG/2hI9rkZVXPluNpGb/MDrsHcL8GfxayZJQoZA6D5yBtdwJT871h5sxV?=
 =?us-ascii?Q?AFcGrx/o2Lxf/xvrRiBSVZiYQStv7oR8s+6TL3c+8PpJq+PrU5smzIi2tBYu?=
 =?us-ascii?Q?gsL1mRBc8Jb1YHElhrW/K7PBhLmUzPzxJ1Xfg369Oi+fAfzc1OqaY3XDZta8?=
 =?us-ascii?Q?zscxUg6pPxijg53ueXMPy5aXQVfhoFzcFa/OojC00h0Y1uF2tP6wzBG+SWHi?=
 =?us-ascii?Q?kO5pMtG2M8BzWx2dHIMN7ZgB/1djHFAyHwiQCaELIZnR98KOXn5DSNdfwHpf?=
 =?us-ascii?Q?9Lk70Po0Cf8tEZrJjMiRAsJYEK6VjnopN+3SxzGbCQ/770oKZSbPqVUP3/s/?=
 =?us-ascii?Q?C5Hq12Z3Bm68WgHXvb216BuZ0faSUJAw8r+6q8JTPxFb67kDpcP+sMpOmvHC?=
 =?us-ascii?Q?NkH5B8vPI9+XKOUXwkJGTXKoUkLkkWz5txp+2Nwaao6MDD3jelHLhdw31sGC?=
 =?us-ascii?Q?YdI5JJQx6Md0bjYVDxRXfITS5j+k7hrKKZusIm46l+3DPlLKb6g+/B1KzNXf?=
 =?us-ascii?Q?YAk+5dIQYIINCnkpYZNLJwrLUo4fAUWb0c/GIRSXDAOIhgenA0r3HpN4G9Eh?=
 =?us-ascii?Q?Ixiv5NKKyYXQTRYxlHdY8LRm3NtN3FYZA8CLZ0jSJdhFFuJqZghgKoo+X/rf?=
 =?us-ascii?Q?FoQ94QIlnLdbmcANHpdC/4sp9ZET46DeCyqXA5krIsHKWFVLQhT5mvJRSsgU?=
 =?us-ascii?Q?wFigclT6GbIDret9Ifl4EGaoldZ/Ybbs5KL5A/N61OlXtT0vcUALvWJDdwN1?=
 =?us-ascii?Q?Zi86HcL+QcQgsrzF8ySrukkzWbjjk6/deIDuhKBlVLDWERCe4Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sgMCIGiqE/mD1XuAJpxrhEnStYjfA+IQwd5c9AtnBA4jsLQVedWHxo+KjGP9?=
 =?us-ascii?Q?NM8qb3CL8xwObw4biQCCn1JGvkpjwlZtKP/k5Kp0C07qt8xKvXz7E4L8xD2p?=
 =?us-ascii?Q?Cd2PGCtMxU7x+sFhmtyf0BGzvzUrH5Bo3qF3K1r+MT2Wmd9M7IYOjcDYP+Pf?=
 =?us-ascii?Q?iExJvgfOn9fR5Safcjk9lYJ8GYKvjUmECdB089hZnUZysVkm5Y4Yp0ngdJwQ?=
 =?us-ascii?Q?rWuhJQsaiArg9RxQn7e8oD5pnm4OBL/ytWKde9qDs5N7qxJLtSWRXZkJzKD9?=
 =?us-ascii?Q?qnjgB5rRGi9+96kQedE0ja26a6GMh86iSGrnBshkqgfdpNv05BLeN0h494PS?=
 =?us-ascii?Q?CKT3g+5y/hfZz2Tlev5ncm6veYURZ5yPeANoWroaMInVHA9Fpg0+PE7gIAns?=
 =?us-ascii?Q?ckOo1N1tr0lS8m/DS+kzIwDqLEMbeFccm5A6yLcDJIh/zA0z6l2d7PjkryeZ?=
 =?us-ascii?Q?lLJgnVn2Jt8LAfKrzfK5FFKVWkd8H3ADX1wLuKBuDcqPtDrrJo4cEf1MH5Dn?=
 =?us-ascii?Q?knK1n5wvILB2ejbWHmnRfLYjdtelpTJD6t6tG+2LgNh1WfMQ85S7Kiw1/vRd?=
 =?us-ascii?Q?aBjGpqvt4cezx2BvOyIpih9ULekmsdTWNlePDj3vZnN4/vrAUT0P7YhVheQf?=
 =?us-ascii?Q?MQ2hfxGEHUSpxDKnBIjPgRrPLJA1yW3pqjB/q83tnDCTsrSYhdB4LKqZW4ei?=
 =?us-ascii?Q?mmTjonkqRlPxUS04W4QkW3GJMLJfTJ8cUbDZygyPqOVVIosWm5VcIMOaxlJe?=
 =?us-ascii?Q?1NbtPK8k6CRaM28YsW6FUSJO6uaTnZk6phiFrFtvtPAAKe3MqRl3Uk/xF0xT?=
 =?us-ascii?Q?wrkDqD+5utHei+PbB4LI/+sGsFvXP5b4A2IcyS+Gs8ia3PDpmwKIsSRcC/Jh?=
 =?us-ascii?Q?k825WoIARZ+SuaRBj83vXbMPdDSCR/XMPehaHN2iTVvi2cS5mi0UQI3B867e?=
 =?us-ascii?Q?xr7XbBpXyVxo9Z2h6GjTJ8dKHkh5gxGQzKDzWfwnpU97fP5bXFS0jZDIGMem?=
 =?us-ascii?Q?ppAIeXmARwEqk95Os7N+xK7fQmSngvjjPM995u2o216eJFEAg7Sm0O1gKi0M?=
 =?us-ascii?Q?39MUrgrn7CaEdLqavCfDLtiCqp2kxosWjECChJrgtcdTFD0g1K1jnPHz4Nj7?=
 =?us-ascii?Q?lNJamuxhz6l00/s1bacPDDSo9voAMpiz+DjS6tVIxNTJwsVHN1VCNHVhqcba?=
 =?us-ascii?Q?6/eYbbg22XJ4Y3QgJU0v/4TbApxuoyhJsKrFklmrT62cw+PB6dix6o8Cnb1u?=
 =?us-ascii?Q?3aZq8U7mXNKfox/36QAKlp2s30/OCKNC7LwSbn4byuJQb8WadNcTg+3TgihJ?=
 =?us-ascii?Q?UJ9c63E7ohFldN32ir6Tp9ErzvfEAl9P+KFuSYKk7ckJvwMBBA1MN1oCHHN+?=
 =?us-ascii?Q?UDR6LTuQI9lzD4OYmUC39pS1m13v3PLX28+WlZOWPXgv1JXNPF80QfEgYHvs?=
 =?us-ascii?Q?QghbceWUdY4HNEfjEQRs3lFccD97hBzJpwlYw1xvKVivVoj8jdr6WBlrG8wd?=
 =?us-ascii?Q?O+R7gNhAMzlIJBpuDr2ZmeM+iVIClEejVClZ7rQXddSL2lc+DkzS7JIo++SX?=
 =?us-ascii?Q?/9Z2GNEZLupx9TZUp8162OeTmZQStGFnWy+MdXnnZ5bF4wYNRtCk1m2f45Ki?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bMvcfhjr9eRI+qQKd4a6Z4hm7B9Buy1BYahhG2bXv9gMuxhx/A53LtO956YcBPRnWUWdGYu1/7gytHxfU9MNtOa9lTszD9ElUJ4m/VmdNgh0Z6heoNATEEGlQZH35sC5e7Ef/pRlFgabX/IB9gzyHBz0DI4aqKZu8bNFtbn77MKEynKBp6KuWb0m2nxIR3FvuudMhJdSD70sOU1y5hrHLXEUZHDx4xPuR43rd0kupz62+lg/dLafYCbFKVm/D+fzHCvBgmJreR4Xbipw4irqmqWzut5Mutm0kD4dyV+JjtIcQHla5uxEMq2WYGv53kHL/uJYuF12PmBbILWXB3BZuHco3wmpBj8wnPx+cLyReBFp6wzhxNLGU1uqh+LSpw9RMgFNG8PgAX0mc756EpH6jGl0Bt7kmwMNlhFZBsQdeutgz0Hml9PS7ajNlRAEhVBC89qCz5kJ/0tbb850+wSvNwBcqUcye2B9A3eEbjS/Do55OVrTYF8RqCUNL5yqH9p1Ofdn9y6is7r8awA+Nre/WyesZr5b1/qML2DwqcldcGUYQKWvoW+AMpmc8E6z17pXYYdkTPJAfEj8Nb418aqsNiQOX+1TR9RspL/L8kBoxH8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d46cab-9ef3-4789-1ab4-08dd61f01ff7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 05:30:11.3929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EM2a13W4cmjlMJi3GP7t2WuspkZHqqKclTvmeKCT93lgzpS1qpbylJ2H0M/vkPaco8UI9r7rhESQxjRxcSk5xQF7ZxLUiYiNOIxcc7axj14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_02,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=952 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503130041
X-Proofpoint-ORIG-GUID: SoCxaiuDBAKqjMN14zEk0Glsc9qPCpni
X-Proofpoint-GUID: SoCxaiuDBAKqjMN14zEk0Glsc9qPCpni

On Wed, Mar 12, 2025 at 09:47:46AM -0700, SeongJae Park wrote:
> Cleanup madvise entry level code for cleaner request validations and
> classifications.
>
> Note that this series was a part of another one[1], and separated to
> this one following a reviewer's nice comment[2].

Thanks :>)

>
> Changes from the original series
> (https://lore.kernel.org/20250310172318.653630-1-sj@kernel.org)
> - Separate from the tlb flushes batching part
> - Collect Reviewed-by: tags from Lorenzo
> - Fix typos and wordsmith commit messages and comments
> - Rebase on latest mm-unstable
>
> [1] https://lore.kernel.org/20250310172318.653630-1-sj@kernel.org
> [2] https://lore.kernel.org/0f90d56e-5960-4478-803e-1054696c0cde@lucifer.local
>
> SeongJae Park (4):
>   mm/madvise: use is_memory_failure() from madvise_do_behavior()
>   mm/madvise: split out populate behavior check logic
>   mm/madvise: deduplicate madvise_do_behavior() skip case handlings
>   mm/madvise: remove len parameter of madvise_do_behavior()
>
>  mm/madvise.c | 128 +++++++++++++++++++++++++++++----------------------
>  1 file changed, 74 insertions(+), 54 deletions(-)
>
>
> base-commit: 733c75c2264b9de72a463f731507e674a32ff094
> --
> 2.39.5

