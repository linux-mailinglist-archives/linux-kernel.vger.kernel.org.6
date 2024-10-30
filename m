Return-Path: <linux-kernel+bounces-388986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F289B6707
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2D61F2171D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5653213124;
	Wed, 30 Oct 2024 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ChrNTJq3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iHD/Ornb"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7105E2139AF
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300942; cv=fail; b=P8n3dB63fUj7jKp8gR9pZ/YHU8RqBK1JBZYkxidgqoCiMDpvym+hj+hke8sKc0Xi6CXHli45CiKf3gtiOF7QnDJreuR3kaERUjR8G9Hq8r+jV3eAgMvJbX6fBwCqcng5AYD2D3Rzw4DupyL57QZq4QMTwVeo+NvAH2DESX/jB2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300942; c=relaxed/simple;
	bh=ugQAZpsUJ+CpQI5gLtF191vXNWFq5+mWY6uCYq0D58Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NDyF8zKIceo9+PhhhMnxbZBAcF7Rm30mmMQGLjXQAl6Ei2TezvFLyvFu4ylN/DM/cC5T6Gj+ukt7B2aaJh8WuO0YLZzpFywoZ4GfkQAJBtSZM68FMjnS3g6eE9TKjPl8YogaCp87Zo9WF8OgN684PYN4oLR2C+vA+8y1GpgBF2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ChrNTJq3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iHD/Ornb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UEF53F016523;
	Wed, 30 Oct 2024 15:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=fjTlIkVz788ET7ElY0
	nmDa9cqxHxZxmNvwZmR2N2oQs=; b=ChrNTJq3VU1Lrw0LCRMULZayH8yG5opIDn
	ZKLNBfQjnqjmRUoEAvf5KF/DOUHrD/Qp4FfuYeV2u1Y6IoDTuTGmTGXp/bVcsPu3
	ynkSeDFhagRnIlg+MDOz+sxeilvg3ExP5iErAPqz/zuLFvot8Lhgwu5yBw0/Lbnv
	UWlomo1D95aGgqufEHK1Du+QRDRdgckZIvY+DJYxZbA3SwQR666Vw+WgLqU+fsz0
	diJR267mFvG+iJJWxAnX97arb4PjVHwXvKX1Rb9U4ZRKZANbXq4GFWxcN0sAE/49
	HmAn9moc9jZtDSyyaCIjO5FjlxyHzOomoCdUhZm0fqhJ90PmfwJA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grys89gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 15:08:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49UEhjOw040035;
	Wed, 30 Oct 2024 15:08:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hnaqpck6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 15:08:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6cstBpUt3mosS3YkxXxR0XCgC99TYmiFbY/cpvvcKoLlPAAIBmlFt1atnR2hFoX19c1T0vkMPFgfUOpieh+aHQQgdBK1ggs5RLRj9pzLjXBq8ivevUfHnOaW7QXXfGSkzxVI2wg/d0tkXyPwuY5rXYQC9yDDfRv0Ya8hNK8YhLkZP6nfI/Dhkaz0dfxjkCk5NKw7SO+eA51eDQeZsb2BXVag3mrMZzHxFOxBa8W+sSPZHyhC/7GNr+dnPlGgS44LEKR9K6ZCJURmG2VeTl/pOImED+Mwxtkw1O5y0T+wTdAajCBqnQEmw2AAYTLswtajfNLUQVJLwJ3AFezm8dPaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjTlIkVz788ET7ElY0nmDa9cqxHxZxmNvwZmR2N2oQs=;
 b=jk1EcX7VO1+6JSJpq6/payWtev7tB+obT04VfgtpqOWmTquywrn6PTQdyW1b//BUUJReAmenlkXkY351HXAfK1l1aCYGHi0PW5EmtjOBV8e1CZRcpgkmNDxDEy/Kxk8VTwIr5mYXWw3tJUCQaV6HSn3i6XLnzcrWU66n9yP5eGqx13pAGA1Qll3oRE0/k+ejMue+1amGf5Aw6hiFaQMydPZI1whS9G+ewZJqpgMYKA5bmCLG6ghUM5OL2So7bnnLXVeVTGo9TbVc6an9ShE6X70VIbc/x8uGAcp5bS6Op/bn+OACmcYhXb7Sr5/xHyMo67Lau2y1aglXkubPGrAStg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjTlIkVz788ET7ElY0nmDa9cqxHxZxmNvwZmR2N2oQs=;
 b=iHD/OrnbQjIUPF3AT9sF669UayNUCFlnsMmm9hz289Na7gBTwhH1Q43eTK6uNnkQlMm326ivp7YsC24rN34EqpijYp6r1Mxqi0DF95LACoZ+4L4XV52c4QJ/rHCChjRy7JytObtdOGEpnJTg3OrESY4Rt6ZqQpWtz+l5RoUkZyQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA2PR10MB4795.namprd10.prod.outlook.com (2603:10b6:806:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 15:08:28 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 15:08:27 +0000
Date: Wed, 30 Oct 2024 15:08:23 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH hotfix 6.12 v4 4/5] mm: refactor arch_calc_vm_flag_bits()
 and arm64 MTE handling
Message-ID: <641cb1c9-340d-4b30-a036-261096defc27@lucifer.local>
References: <cover.1730224667.git.lorenzo.stoakes@oracle.com>
 <ec251b20ba1964fb64cf1607d2ad80c47f3873df.1730224667.git.lorenzo.stoakes@oracle.com>
 <f5495714-19ba-40b8-a3ac-fe395c075a36@suse.cz>
 <ZyIRbbA-_8duD2hH@arm.com>
 <c8760d0e-acbd-4fd6-b077-58b5c374cad3@suse.cz>
 <3f184fad-e0da-470a-888e-70a17419e206@lucifer.local>
 <a2c1e121-91ea-4868-bb01-ac6ee43257c2@os.amperecomputing.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2c1e121-91ea-4868-bb01-ac6ee43257c2@os.amperecomputing.com>
X-ClientProxiedBy: LNXP123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::22) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA2PR10MB4795:EE_
X-MS-Office365-Filtering-Correlation-Id: 9509e333-9a5d-460c-a573-08dcf8f4b52a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u6odKzhEnX9f+jIGUBn7Km06iZ61+fbTlmeoDsndUhGTftZPPTMnMpVOLVKp?=
 =?us-ascii?Q?0jwVkPA3vvFyFwTlFn/A5y8aaE4JBV7IpjK2/8wPjIyPxhCddVJayHnnXtPZ?=
 =?us-ascii?Q?ZguF7hpUujOBbiwIuSCr3yukaC13hmQQd+doLBRpERmjvjx3OnMa/zg0OB6v?=
 =?us-ascii?Q?jq1/mLdfbJzkkXDFaEogLFW/7m+kvkKiiQfgXRyRy6BL/wf4W29UF6QDnrnJ?=
 =?us-ascii?Q?hr7U4FhfFqvNX6Qi6/kdmKhaCCJGLhF7Jb8zywYHzgidm6Xlgdf8G1p6v6EQ?=
 =?us-ascii?Q?wTognq1A4TiQRWA+/6EJfoVon3zAFeyxDuG40L8OnlhVkT51A+cfu4pDVi0d?=
 =?us-ascii?Q?nVAMqnnjcX4PqwqWdEF5JAhX2PBLM6bgNb+ddgeMjhfR/pS56h+VrfvmRRw5?=
 =?us-ascii?Q?Z3T8kC0TPi9W7TbMFw8vtcDcs/I26TzIlGnhPfA34WB7OgtCWiVuiSj6iYw7?=
 =?us-ascii?Q?NZsIVbxuIj4C4NAXC0aCj6Kz3RZBOwuugxewqe4+8RGSmjdIDgTNDZXdEKCt?=
 =?us-ascii?Q?6nQRbCNVXvlPNxn7FtcHS4T3b84zoOQ4Ru4lJYq/KhOkn1Bne2u36sf6mjXx?=
 =?us-ascii?Q?zFfPqydEmDDLbeF6OVK8JrDQeybHv57v24tqao46AKGCMY69WXoOIkY0kmur?=
 =?us-ascii?Q?J7/BvnVQgxSzOTT9dqu6KrDpFrs9Y6OWrsv6jlCfyXaNvCvizRXAJOQTdKyh?=
 =?us-ascii?Q?8De7AUsbas2iMG+JfXl94nYgjSG9kSa5zLBDAi1bDB/Aqklo6mIaKJXysH4g?=
 =?us-ascii?Q?MLFLXsyIhHvfi8IYuvK+uxmIVpdJbgJZzHeT3mOf0rA2lxZcz8Gdn8ajbahJ?=
 =?us-ascii?Q?xFhbzpv8zeFNtHJYhukB72HKYkBQI98rYhNMPgvvwM9BXOCAEf9ekxoWuY+e?=
 =?us-ascii?Q?OMohzZqjeKAw+r/qUc9FKoWWGBb8LVpkJAcmiQWS1sFDk3lAZOP4ZKrlYBcn?=
 =?us-ascii?Q?fkDzZHWO1fCV6iNJCn2sKmf0jZ+ycYLhFekgKT5D4d4UvS7MNveUAn0pLFr8?=
 =?us-ascii?Q?IbZCqBujvPGAee8RdkKxBLLvQ9Kn7tv7db2lpucBSIUE+ML4MoUmg7kM6qbu?=
 =?us-ascii?Q?q1483odbrzbckjdAL+FMVu2ajNkrjFR17UyfmVhY5wH7cI7NUEzz97tK7eP3?=
 =?us-ascii?Q?EXfZ77Q3KCgspWFnCmxnGdthNmI7e+wtNGUgfRntSQQU8yocQS0StLfZUmcI?=
 =?us-ascii?Q?TNEfjOShJOjHHUQJ8N5ah+rLm3qFqENU59N2fkDxx6h5d97PTyINzbGJPhML?=
 =?us-ascii?Q?+w4UWo/5TuSmkIqVwMoq8TRHEO5VxkPwcjmJ2WmWRazh+kixUMt+Qbah2asJ?=
 =?us-ascii?Q?hze6//+v7CGqhWf0hTBMX7y+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S5t6Jvdfq3PmaNwah6kdcEtkTOglXJH1Ksws1ZqNUGsjAp57wm0mft+xOIn/?=
 =?us-ascii?Q?s8YKXPAObrcbSSyouPpYm3e1s16hxOPqdad9jiiQVwooF9NOOTzeE96z8srx?=
 =?us-ascii?Q?dpP9EIjtOwpReoyiz/weOQFUvPVnTxM3lSyZs9Hf+DMREhLdKBN28ZlW+l/G?=
 =?us-ascii?Q?m/VOZ0silq3HHjZX4ZadJRaTQJfdMO9ODNDMgoPieskS8dmDPk+dzySq+UmG?=
 =?us-ascii?Q?eKXFN+1v+Q15wyp9NDdmYJBD5k+4R3tyzijeCB/9YArCdrqClK2uc8ytu0Up?=
 =?us-ascii?Q?cjTsYBwdGlhxxxjpp4TrhLVLq2ha6RIsC7G6phODqlvWOdmk9/CLdyB2RFlI?=
 =?us-ascii?Q?ZJ7Lt6NncGQOZddpF85KNJ8XuoqqHICjTQ4IbpZ+nfUIUMssxXPL+hQHSiyW?=
 =?us-ascii?Q?otPnfCMbzK/037Xhuv2tuZdE5pOz6U6kVevpYCIxOALu6JAzgd6QLjPl1ugU?=
 =?us-ascii?Q?j0fNjtb4Ti6tLPl3IDHyAra4wxaahItNxyibnjiGsxXzhiIC6G73MJYlXTo3?=
 =?us-ascii?Q?B/26/NwD+xc/7JoAxHhcsq6Ne/nU5mYwHFwBEDsJxjIAl157xWK0vc3ZtiB+?=
 =?us-ascii?Q?ECUJfdgWt4U4H4sBS7mldFsPhZy7lssuBQVkubJ8RdOJ9wZZPkfWGTTo5lBD?=
 =?us-ascii?Q?PETrH15zpE213ciqB68pVJ9bO+fQzaK0uQErbYqI/B/t41o0PPebT4+sVR6M?=
 =?us-ascii?Q?vcRqN4VjzqKFRg3Za5yIStq0uuxmlX8knXxZWkVx/ih2J+TRtjR2MXXiOlTX?=
 =?us-ascii?Q?ghUS92hZRm+BrqpBhG33IiKGP9c2VWynYQbEzgEYTzYjzbIS9FozI6HqFGIR?=
 =?us-ascii?Q?9K3elcGHOQizBsA02Nso6XfrpMRdoVnqwJtJevz1CXmfAmdDNsCEO23nM+jR?=
 =?us-ascii?Q?veJgN+xDgbV2dw1w+6Syb7NayrE5MHEAUFdIZrLZE9PH7xV1oTRNvoTwLbtL?=
 =?us-ascii?Q?1j9guNfzha77rDRUAMdiR0xnmZuI5khTM1vdaWMXMGP0PZ7nnaZnijneQnSB?=
 =?us-ascii?Q?6CZcYpG2ymQjS4qC9Cx/xEMTGug2gYXcEwY3eSgTnFY8BwpAsLbNjFEOVSjM?=
 =?us-ascii?Q?9uoe6ZQLZ5xM7tGrSrNZHCgwP1hDgjfOXOyecO3qQoF92YKK9UHYn6qA8uAQ?=
 =?us-ascii?Q?qxrpEGoWq8bIXHYjUN139GV941Mf19IjhE4l2wSoRomd7Zl1k5DLk7gwsJC8?=
 =?us-ascii?Q?PnODFWhPopEQawS3MCkEhWcVk8Ykt4kKas9kDtRcjZZ9bcmnMQuxSvwPcJsy?=
 =?us-ascii?Q?R+vWhZ91nsDVeRkdSDEzf0YF8DPso/7LCUx7whRdrOUqVKZP0nZOlEkTuYuc?=
 =?us-ascii?Q?/kbrXZF3C4dY6mLWXR5OeMZ9G4QmpQ6RPPRs15zKu4AULMTNThsO9pHU1Pf6?=
 =?us-ascii?Q?PM3LQUvltVo8BFHN8IxN/5P6ecv/ZeSD+PfHZhkgRbfvFWYPSh/jjVPxis21?=
 =?us-ascii?Q?JxnZA1IIUKNfG2ugFZswS8V4/OXipjRYRGVodQQXdVZZ8Vf1bzKvlW0kzNqn?=
 =?us-ascii?Q?GJggR//+o7riXXb4LkqYesZ5CJXnL04qRZRW+x+pihlRA+My3zdqyLXOPa/J?=
 =?us-ascii?Q?dYhCVS50wsWjzdnwCMvsS4ErJsmVUCJj9+6QrmSq0m9MyBi6mhVYsR3fMnQD?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DWfE3gZi0HH/p6o0ZCpNWy63wdmH79V03tcp8C5UWnXOo6+LzwuP4A1Gq51u3J2m8nyteZjWARgFLb3Dhpj6unoSf219uj8pXQ0LwbsXyCkr6e4A13WeYc+yxnlLRRvPl2Zd+yftoBxkGnX/OLxxieGfz0BVxa8/hqzsbAMOhh2HiW6jXZAfyC/BFY8yQ5Yt/dFDWJxOSkHfEXagxlrmGQHh32CL2QmkWWWz0ad89N9cvcJCoOl5GGpz3evwnc9r6PDURtXmR/vhIXKoFi1ygL2lgy4p6EcfvM+5/5UEz6x+aKU1ZMqRWDYCSiM+ayhAEWnfopb0dHvzA+eGDkdx0uVK7bv5zjw3+++rBn/ddGZ2PDS5KglYmRXMjNulyEPtLcT4D7kJDQ1yVerY4stxTqpaggDuqL223yxxEngEmVoXN1K+BeWsquXUvZZmTIR+qx4sIukJbzkGoKQu9hde45zYx1KHyv2S+eEmQnvpoumBH6xid4k5QQzr72fjQcX/65uhCIh4JMe46pnqMPlDN7LdGCYb5H+F3BxX1BCFhz+dfaPYh+8YvVFJrZpiHzq+p1GI7v+DQRmEMpKR92JhFO4K6LUAkDoNpWplj67GEpw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9509e333-9a5d-460c-a573-08dcf8f4b52a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 15:08:27.7505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNTGsOogxqmABIY/rk+QJ+AZKdYWc1Qz/i1goqEbRwtpdHzFcCPEW45T+q/rdcLBy3bVz2ElRLBO/eRSk5Rk5wONLSm9V/vcoUb35eap6Ho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4795
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_13,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410300119
X-Proofpoint-ORIG-GUID: 3P373qIZ8u5VY4iFgzEuQf5GF2_O260I
X-Proofpoint-GUID: 3P373qIZ8u5VY4iFgzEuQf5GF2_O260I

On Wed, Oct 30, 2024 at 07:58:33AM -0700, Yang Shi wrote:
>
>
> On 10/30/24 4:53 AM, Lorenzo Stoakes wrote:
> > On Wed, Oct 30, 2024 at 12:09:43PM +0100, Vlastimil Babka wrote:
> > > On 10/30/24 11:58, Catalin Marinas wrote:
> > > > On Wed, Oct 30, 2024 at 10:18:27AM +0100, Vlastimil Babka wrote:
> > > > > On 10/29/24 19:11, Lorenzo Stoakes wrote:
> > > > > > --- a/arch/arm64/include/asm/mman.h
> > > > > > +++ b/arch/arm64/include/asm/mman.h
> > > > > > @@ -6,6 +6,8 @@
> > > > > >
> > > > > >   #ifndef BUILD_VDSO
> > > > > >   #include <linux/compiler.h>
> > > > > > +#include <linux/fs.h>
> > > > > > +#include <linux/shmem_fs.h>
> > > > > >   #include <linux/types.h>
> > > > > >
> > > > > >   static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> > > > > > @@ -31,19 +33,21 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> > > > > >   }
> > > > > >   #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
> > > > > >
> > > > > > -static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
> > > > > > +static inline unsigned long arch_calc_vm_flag_bits(struct file *file,
> > > > > > +						   unsigned long flags)
> > > > > >   {
> > > > > >   	/*
> > > > > >   	 * Only allow MTE on anonymous mappings as these are guaranteed to be
> > > > > >   	 * backed by tags-capable memory. The vm_flags may be overridden by a
> > > > > >   	 * filesystem supporting MTE (RAM-based).
> > > > > We should also eventually remove the last sentence or even replace it with
> > > > > its negation, or somebody might try reintroducing the pattern that won't
> > > > > work anymore (wasn't there such a hugetlbfs thing in -next?).
> > > > I agree, we should update this comment as well though as a fix this
> > > > patch is fine for now.
> > > >
> > > > There is indeed a hugetlbfs change in -next adding VM_MTE_ALLOWED. It
> > > > should still work after the above change but we'd need to move it over
> > > I guess it will work after the above change, but not after 5/5?
> > >
> > > > here (and fix the comment at the same time). We'll probably do it around
> > > > -rc1 or maybe earlier once this fix hits mainline.
> > > I assume this will hopefully go to rc7.
> > To be clear - this is a CRITICAL fix that MUST land for 6.12. I'd be inclined to
> > try to get it to an earlier rc-.
> >
> > > > I don't think we have
> > > > an equivalent of shmem_file() for hugetlbfs, we'll need to figure
> > > > something out.
> > > I've found is_file_hugepages(), could work? And while adding the hugetlbfs
> > > change here, the comment could be adjusted too, right?
> > Right but the MAP_HUGETLB should work to? Can we save such changes that
> > alter any kind of existing behaviour to later series?
>
> We should need both because mmap hugetlbfs file may not use MAP_HUGETLB.

Right yeah, we could create a memfd with MFD_HUGETLB for instance and mount
that...

Perhaps somebody could propose the 6.13 change (as this series is just
focused on the hotfix)?

Note that we absolutely plan to try to merge this in 6.12 (it is a critical
fix for a few separate issues).

I guess since we already have something in the arm64 tree adding
MAP_HUGETLB we could rebase that and add a is_file_hugepages() there to
cover off that case too?

(Though I note that shm_file_operations_huge also sets FOP_HUGE_PAGES which
this predicate picks up, not sure if we're ok wtih that? But discussion
better had I think in whichever thread this hugetlb change came from
perhaps?)

Catalin, perhaps?

>
> >
> > As this is going to be backported (by me...!) and I don't want to risk
> > inadvertant changes.
> >
> > > > > >   	 */
> > > > > > -	if (system_supports_mte() && (flags & MAP_ANONYMOUS))
> > > > > > +	if (system_supports_mte() &&
> > > > > > +	    ((flags & MAP_ANONYMOUS) || shmem_file(file)))
> > > > > >   		return VM_MTE_ALLOWED;
> > > > > >
> > > > > >   	return 0;
> > > > > >   }
> > > > This will conflict with the arm64 for-next/core tree as it's adding
> > > > a MAP_HUGETLB check. Trivial resolution though, Stephen will handle it.
> > Thanks!
> >
>

Thanks all!

