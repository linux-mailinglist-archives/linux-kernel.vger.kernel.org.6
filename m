Return-Path: <linux-kernel+bounces-361288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E05D99A643
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA84C1F21F8D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A092194A4;
	Fri, 11 Oct 2024 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hcmVIyku";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A6WdCfXh"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A850B198A3F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728656806; cv=fail; b=cioxxSOXbWVNKxyoVA9N6q4y8L0rQdiwC71PLjRo5sqW13fSKJG5Vb/KnKBTpcRbvt7kWwqEOkhx+Ik6C5TyKU97i/OlLwRNClKtwDVovDqMMtTd/G686smBcFx4/Oo65EME6b9qU3EDXsc7qRLUWa9ZcrULxiim69lCHjzCBgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728656806; c=relaxed/simple;
	bh=pNn6C8inZhML/rEynuOqZ0XOQnpApMOjjnfmah9rnm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f9Hgq/MckYwVcP30MjHwTcBMK6sOQArqgafoyNxZYtUgQ3sBz6Pa0DlJzgkz0E//BM6TdVvO0Trq2tJSMukBh0udHoXK6oN0qZbF9kgz6Fuz7E6qN4YdTHrLAkmUT2SaVblbYdfssa9ei23QP+Qcm6mJskuMjhHbtxvZyupODyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hcmVIyku; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A6WdCfXh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BCpX67010300;
	Fri, 11 Oct 2024 14:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=D+pSdrJViu53z+Q5qV
	4ndBp2YZg9kZKf7lv37Z2TbkE=; b=hcmVIykuA6PuqYXDc3L3qM0o1sXs05DRnh
	nqyRYpmOJbOD6N6CQ4JrQ4Lgd0WRiyktesuaRvqhA1FeBe0UCWZNmj3D82Lqwc+s
	RU9y/RsYrLW//m9Gn4SgHwDxPmsLgiU4kAhh531rMzBv2wDgynGLrBqcozgTxL/t
	uPhBi98IziS8tKXApnLosKcBjBnClFOhLP2fWeMPXbbE63DHZBJeAG9y10bvpFif
	vnJdARApclWRI/x9ENn47xJxRMVigA5Cw39crm1VZv5vjc2rgy203PBspGnDmcZN
	IB5ULFO2OM2V1LaDru6M6GdbcYHXcwkcC9mMofZACGS2fGLq77iQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423063vxsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 14:26:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49BE3tpM040314;
	Fri, 11 Oct 2024 14:26:29 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwhpxg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 14:26:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyOzIwN7l9jcg8ItwBZe9k4YpiCTiPkHWj/08Q+v5ePsXEpZn+RvzAUdTdfwCt33tQbFVV42hYtK8h0mclWRs17QGxA1cx064zCc7Z11pDWu7JsgZ2T+dyGPCbfxZF7Ho1TY6TuUikJHHVTXpE1XlKAfCYrofScE8iseVqov4vILf8ARJlbOgvcM5J5Ik6FjrGWX35pHt76O3Mv30eeKC2fmn33u4PGXZtIJRZY4D8/11xYWtT7LKtMCyVZPLQJ07AejPeQGNsfI+UBc2Aq31m1c8E3bzsFBDz4TRShPp53FXiRsz6mLBPDOyMOoviUA/ElcjBsCoXkunSkHmBkb+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+pSdrJViu53z+Q5qV4ndBp2YZg9kZKf7lv37Z2TbkE=;
 b=JQiJ0EMEKlcA0lutrNvC86UtY5WdJLeiT9SWxbM9pLYLWzWUs/B2CCoxK03JQA13ha2//0fsdJThqcztFQlON7odtERGrOCZmjNHoXpwEe2/yZnZxwRdAOe3Wv7FIGN/slFANkCNjkx7QGweuAXVjfJfUAO443U4XmsZmInGsEbCMYG3YYIg9YEII23yHBaAGCNSm709WOl5jZAIpDDEp2zDZRrERnfuOx+/4Z8q1Ls6LWXnbEWDAEm5oPuA2L/eyRMKaovbVrz1Sr6r5kjOFBqL8+Bz+tadWOETsDhpgMq+6fsmN9Vmf2qX/wERSdDMYoFeqPfYFfj4mdEkmrW+/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+pSdrJViu53z+Q5qV4ndBp2YZg9kZKf7lv37Z2TbkE=;
 b=A6WdCfXhF3YktP4VFP3XjwAkScFu3Os0lhJPfGBtX1MfjcEqu/CUT44skPn94WJqORdBkAnPF8TiwUdFUf+hqA3+a//GcEGh3+uMgCaCPm/sgEE/EnUbsvDc//GR6d/XIhMirop9qSJr6FQO/4nOc+mVo1AkAUUnGL0UwI3PXAE=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DM4PR10MB6862.namprd10.prod.outlook.com (2603:10b6:8:105::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 14:26:26 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 14:26:26 +0000
Date: Fri, 11 Oct 2024 10:26:24 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        Kees Cook <kees@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>, Seth Jenkins <sethjenkins@google.com>
Subject: Re: [BUG] page table UAF, Re: [PATCH v8 14/21] mm/mmap: Avoid
 zeroing vma tree in mmap_region()
Message-ID: <2rdgyyn36yn7ey5oopynmkerpfx4ghdazhgwh7p53z7oaf646h@7hahj6yyowgv>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Linux-MM <linux-mm@kvack.org>, 
	kernel list <linux-kernel@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Jeff Xu <jeffxu@chromium.org>, 
	Seth Jenkins <sethjenkins@google.com>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
 <20240830040101.822209-15-Liam.Howlett@oracle.com>
 <CAG48ez0ZpGzxi=-5O_uGQ0xKXOmbjeQ0LjZsRJ1Qtf2X5eOr1w@mail.gmail.com>
 <wxvj55hptaogh2yxhhfftaomwzm6ifek5xu3uobbdsaabdmjll@t2ixdotfhaie>
 <CAG48ez3Ao_XkT0LKHfZsZSEZaoDAc4zRjitKG=P5O7R2BOgHxw@mail.gmail.com>
 <btu3mxc7qn33vux2jtzewuavth7ziq4xb6nudiu5kf7bs3bejm@e7btayqaavzh>
 <CAG48ez0e4Zv3g2uHGzhrCmJcE2XE=160HxyNy4YAhEfQKKFNBw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0e4Zv3g2uHGzhrCmJcE2XE=160HxyNy4YAhEfQKKFNBw@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::32) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DM4PR10MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: efb2c566-229b-4376-c5a2-08dcea00b096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yMoc7n57r7Utl4eJ1EmKfyWHQa6pRlDX3vHSZE0JGbnMUTxpkvjBvk9osOBf?=
 =?us-ascii?Q?dBjZMIXZC6gLYzfJghrR9hgLODqg7eFrNL87+KhNxwgKSZMxZf/ehXbgJiwH?=
 =?us-ascii?Q?Divnkc0gBYFiSQWr2eCeDFt1/4LVfaJB7xSOWyZE2oo/r6Z9IBzjwpJfbsqf?=
 =?us-ascii?Q?IDKAUhTaYpfmc/ia/+hpK7RNphQk1ZVSfBX8d17COvakw4GNtrABRE8lew7B?=
 =?us-ascii?Q?XUmg69P7gj3ZZ0aDRETQMIAYqtI2gHa/XcXd+DyFl/srPfc3NtnTEGdCJolV?=
 =?us-ascii?Q?QyOHaKwjnd3be2vstsBcIGjrSucyn+ZwF9e7FiBN9eYCiACqviblX8J7Tnvh?=
 =?us-ascii?Q?TYDlN8xHueN8RjLM/kwg7W6GQeHa63cDqNLKtc9GXwes8bNGiy1dkGfd34/V?=
 =?us-ascii?Q?VXSLzolRgnURsiPHiU8MooNGPetHS7n474bl/+Y2FTeTuVtpCjaAioYO6ooY?=
 =?us-ascii?Q?ToT8OFp2fkKFq5TE9Lecnpi722fKSRzNLjw4cTtykjfFBMmTytbxL94pTQwZ?=
 =?us-ascii?Q?OERlFZV7IXCyLVlC6+4QgN8pwf2h9W/kNG4Ap4MR5Tx0Ouoty56gFvu27Ecz?=
 =?us-ascii?Q?DTPAjwjBDzQY3qwGL//T5RnivvnM0KQT+NGX7nTVLcJIDLNgRaOdHkyqVl4S?=
 =?us-ascii?Q?k869/Ayt266sk7C2ybjCz5wv+lCnAz1N0HQFQESOTRdPcpzi3IZGxKUasijC?=
 =?us-ascii?Q?xXvLTwVDiKZIAFEIz298+DhEQKQVfzK0YqXsQ+KeHCJpRtracn/G/Hb9BW2V?=
 =?us-ascii?Q?O7B6iIzbwrp4B91dCtL9rvvm7tef+DzyY3KQNfz+GVhA0QniRaa4l7JsXC4/?=
 =?us-ascii?Q?RE+BX6zcd2i//F40I90MvgUgmxgIRSM5TACkY9GP2yTliU9ZSWEI64yArW8q?=
 =?us-ascii?Q?ONN1EquN3TOqrGQyg7RmyPwPQlPHWCbaPO2owWmXWtxFDu2ffcnkm9Dj6fR6?=
 =?us-ascii?Q?T+IgaCklKwcWghey0zzivA6A9+/GwNyJecFi0R4Zpqn//A5w9Xqm9/7DOAIW?=
 =?us-ascii?Q?h2ff86X7h7VaoxcHdFMVtfG0mouRGjRfEc/x81Xc3xutJL9ogkEprw+S0nmc?=
 =?us-ascii?Q?LVi83nkhiovuhcnAg8FYrgJ23Duwp6vc+Mei/1qc3sE9qoU1Sqfw7dHPrMys?=
 =?us-ascii?Q?f72d65HR6NGBrq9mdT67Oec7X+7fj0Lb7BKDSX4uYbEyhtBkLJ3aTyO8SOzE?=
 =?us-ascii?Q?xELrmjht15JoHwFM+WJuzTyILXn7okK5Pf2DwXxR7oqzpAsQ9eq4J0usD4uz?=
 =?us-ascii?Q?77D6T1WnVGpXpNvFEUF4ct/+bXKtWAunje+XjimRaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X8L1yZ3Vp9SdDTnKDMSYT8q+GR/oeD2SWU8w3KbwjVCAaV3U74mlxeFKK54I?=
 =?us-ascii?Q?j4bECDkozdQsxjPUmveGTOB/kzpPs1n/8QXB+g9QAseYNSx1zppgNO9svFI0?=
 =?us-ascii?Q?hpGIgP4H0U8+GpBS5KIB3HqBzkfV/nOo6PD7S0Ac7V+57uB1ylXtTFpXO0lm?=
 =?us-ascii?Q?Gnryr5lSLE/RKSirIuqJNjmg9PePXjzV9/F+zQz197dc/wKJvPyusQr+WkMT?=
 =?us-ascii?Q?SLCQSwFT6tEMY7euAduJjN+IlA7JsOZ2lQNQ1m+uPUNLgtljy14Ns8eNl0yC?=
 =?us-ascii?Q?4TwNf+RIDUrD6dAxgWLWH1M4tbwxBXljXxPdnoiBe0AWmF1BAq9YP72c39KB?=
 =?us-ascii?Q?3JYr1i8dPZuj7N+FTOlnGzhHAjN3PjJd7lYmxw9zEkYj9VaRjtG1fPtGD6oK?=
 =?us-ascii?Q?taOP2hVLh1fXwtHzlGugKx9zhiFlwpYoQFDoqI3+WmqQXyNkgaooB505ZJlM?=
 =?us-ascii?Q?Zz8kUAiSI0DBbEcFF1pgr10eey7W53px/vxPCwf/ss8PN5/ST5yE7+vsNSTr?=
 =?us-ascii?Q?mr9y8+akhxkHdCSQ73EUCZDdxRpEuPySddkj74tp45I29QjHuQkERZcZuDIt?=
 =?us-ascii?Q?C9ZyzCi0VGmSX74tR2Gps0Kyc/nfJcNA5Dd7k79kSOvWX5TX7Y5iB9EdCBWZ?=
 =?us-ascii?Q?bHIZRVoXuJwY63LZYMRP7LzGDNHvsR7z5SeuCVjzAqK6dNqIMEArig2EAGsl?=
 =?us-ascii?Q?bcXuItU5EaGMyUNEzWJmmJ2R9bxJkQ7+Vuqzc2ivRpiWuD8Sf7vXvQO6HcZb?=
 =?us-ascii?Q?TAAai8FYf+B4FOkXL3EuhbL14VuMyXKP6jDsbjYi6n3EC2SU0kBa9GsAyqLj?=
 =?us-ascii?Q?pg2TKtOEV1Xg35d0hKG7TRnqel7k/b0hyiQPu3WlFfo+TUOTcd8LeIgNRGHa?=
 =?us-ascii?Q?dTKqywQGz4M3NUnWSfrKMiLa8e/Ffi4WUbyANNQuLFZBUa07tKG1hosplZyc?=
 =?us-ascii?Q?RIb6egfD1DvFwRKP3J8SvwP6Lqv41lUhCMro/uexapVLkJo66sBlUaVCmF1Q?=
 =?us-ascii?Q?wad2xCXEkh//yeMjoFUhg4PYMultRG3/fTvr40C88dJF0yc1lK06GFR/e0Xx?=
 =?us-ascii?Q?AZHSCANPH1Qhl32D1bmUeHlNTIukol1Yegyo1BI98turHAAPwQwLWMce/2iQ?=
 =?us-ascii?Q?Ji90Vphyveqsb6Wi92r2cEtq1a84yq/lqSxbj8wRE3FjRt1t/5APZYNJxBKc?=
 =?us-ascii?Q?oxpF2TIJ84g661vSb3RgJISfD4yatXGwXqLReNxv3RPYNeykhm2fG6S7Fll+?=
 =?us-ascii?Q?5k7faSkdZPArsVUQLpddY/xkNdluqbPtftvHgnARU8x99PfVQKJ1jslBE3zA?=
 =?us-ascii?Q?qPHMeto1pDL0aZzaMvvVqiLYjxGW/v4COMe7/Bvpi2VBGL9duJiHn0xbcp2R?=
 =?us-ascii?Q?ABc6c7OoX2DfFTLFzzjqFgp2mxdh5PtvBwACkjX4kEjP7r9383p3fGb8VlXf?=
 =?us-ascii?Q?Qg3/ccHzIRkatZkJ5pX1NR6wLHa7RDLFW6m4gk/94ZOpFNlqFHr/6VQjKoR9?=
 =?us-ascii?Q?JPpatliATFxUc8pjXFn7Dob6/Ui7naXneDZrtUg9o6i0kuCF0NShBT1hgLHt?=
 =?us-ascii?Q?097YhUk/a/9uMU1ERt4dRUQsgew+dcXz0MEomgI+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W82Xj4NoF5mTUqc/Ik/OunoXLJY6afzO/sKGWGklR5HqsiyW04Nagd0JpnVs2ZPKGBOJDWqxMyUp6xaOP6AMLMI3sAiT6B9QSEEyb0gXz/PGfzxlIUHrkX9btaCE7Yi257/Ysjskeg5cqvcWPCtJIV9+jKZaI3MvCQrs78YNPj9Ntt0g97ea9CNRPCRZ2LQe+O4AVBpEPpa61iwVzulSeyayPVmaqwBcwSoO3ryJZdEwj7R80bUk0CMSV1IR+lQLVjkAjwXf36z6rMc3QKX1glG6U3QRlAHJQlw8dZCtMAv7fNisfwK908uZI8FAH80zMI4Wm5B+oCx89vUlTYLdeXDozcqDQ1rcW9GyMh/E74AOR1dOBKtrC2Nw0yNFAzpCS7W9/bg9J4s+ch1NjlHD4kcP+tPlKSVsmvPdrEGPP3Oa7bBnEiWuhRCsBPsqHDcxJjTpvqbf6bPJlHxKs6I0U1qfyA98+sDgjmhzR4JoIJI9Dpw3tewcUU7s2lT2C8CDu1w1DKLnTVeuwHcdxUNJUunaBXPAwsO1Ks1jFt7QvIxMUVE1w98YZ2aX7TTamX0U2Vmol9rFUiUvuPjlStShduThSvWaDVAgbqSKYbpkg+4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb2c566-229b-4376-c5a2-08dcea00b096
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 14:26:26.5961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LfX3aMf4cqFpqUjBhdJsARdZl5T6iRwjAgEC6R4Tm9hU9ZNK0Gxf5YwujZw/5hD9buRG24a2N4DvwdpBydiWkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6862
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_12,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=923
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110100
X-Proofpoint-ORIG-GUID: DiDZtHD9a5IqiWJYecj5RDAyniOJGb_5
X-Proofpoint-GUID: DiDZtHD9a5IqiWJYecj5RDAyniOJGb_5

* Jann Horn <jannh@google.com> [241008 13:16]:
...
> > > > >
> > > > > task 1 (mmap, MAP_FIXED)     task 2 (ftruncate)
> > > > > ========================     ==================
> > > > > mmap_region
> > > > >   vma_merge_new_range
> > > > >     vma_expand
> > > > >       commit_merge
> > > > >         vma_prepare
> > > > >           [take rmap locks]
> > > > >         vma_set_range
> > > > >           [expand adjacent mapping]
> > > > >         vma_complete
> > > > >           [drop rmap locks]
> > > > >   vms_complete_munmap_vmas
> > > > >     vms_clear_ptes
> > > > >       unmap_vmas
> > > > >         [removes ptes]
> > > > >       free_pgtables
> > > > >         [unlinks old vma from rmap]
> > > > >                              unmap_mapping_range
> > > > >                                unmap_mapping_pages
> > > > >                                  i_mmap_lock_read
> > > > >                                  unmap_mapping_range_tree
> > > > >                                    [loop]
> > > > >                                      unmap_mapping_range_vma
> > > > >                                        zap_page_range_single
> > > > >                                          unmap_single_vma
> > > > >                                            unmap_page_range
> > > > >                                              zap_p4d_range
> > > > >                                                zap_pud_range
> > > > >                                                  zap_pmd_range
> > > > >                                                    [looks up pmd entry]
> > > > >         free_pgd_range
> > > > >           [frees pmd]
> > > > >                                                    [UAF pmd entry access]
> > > > >
> > > > > To reproduce this, apply the attached mmap-vs-truncate-racewiden.diff
> > > > > to widen the race windows, then build and run the attached reproducer
> > > > > mmap-fixed-race.c.
> > > > >
> > > > > Under a kernel with KASAN, you should ideally get a KASAN splat like this:
> > > >
...

> 
> Or you could basically unmap the VMA while it is still in the VMA tree
> but is already locked and marked as detached? So first you do
> unmap_vmas() and free_pgtables() (which clears the PTEs, removes the
> rmap links, and deletes page tables), then prepare the new VMAs, and
> then replace the old VMA's entries in the VMA tree with the new
> entries? I guess in the end the result would semantically be pretty
> similar to having markers in the maple tree.
> 

After trying a few other methods, I ended up doing something like you
said above.  I already had to do this if call_mmap() was to be used, so
the code change isn't that large.  Doing it unconditionally on MAP_FIXED
seems like the safest plan.

The other methods were unsuccessful due to the locking order that exists
in fsreclaim and other areas.

Basically, the vma tree will not see a gap, but the rmap will see a gap.

Unfortunately this expands the number of failures which cannot be undone
with my design but still less than existed before.  Most errors will
generate the historic vma gap, sadly.

Thanks,
Liam

