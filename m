Return-Path: <linux-kernel+bounces-385680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1459B3A45
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7914C282BC5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1B71DFDB2;
	Mon, 28 Oct 2024 19:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jq/hYJuP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uBetAWXt"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E921E18B03
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 19:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142891; cv=fail; b=H+QgukMSCnbsyuztcuPxtily/0BsHMJ04NkBSS7S54mrlaNxlcHLGbMlqqwDiBQN+mFYulAXGinx1tFowD/2iYsFU0SQbSGg8/UBCR7UyJkLzCHA2CeW1y7qGTF1KHFxAytAD+dYqrTNbAYN8dvACO0EodBg0AYU7aq4pugI6AQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142891; c=relaxed/simple;
	bh=LuGC+S/HVKqx8KidVL8tm8V9jszcXa/6q+/dqDrz+2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mF4EdrBKYy9GuuZqmYlyDaHl3ay2wMlqZXxdOa8jIg9ylZro9dWNrzV8AQPPVtmVWJlMGE/wGVUnBEpHNPjkVEjBNBrE5AUCaRGNZ9V1kk82BjdiwXX2SRxvRNjl8wFgAOeUNJv5WhScc5EuHTANdOPrWkpVfwWAoCEyA3L267w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jq/hYJuP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uBetAWXt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SEteIj031501;
	Mon, 28 Oct 2024 19:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ZfOe3egXLspWVtafed
	JoKrjpCM+0GVlwB53FktvK8kk=; b=Jq/hYJuP769KwdC1wBIpgZZriaymt+8wOm
	Kk/jlgvisoOEfAtwUivZSdcQprl+50QjpvKNPpq/aMNO4G7iMcbNVGNkPSNkvSBE
	u8V+uZhiz18kf9YR6dAkUFfAdPl75/MKcS4F8IE9UQscc/RdhGWPIMEtP8tuTrzf
	6MIDWhhLZ1E3erHl6PuflwQrE55Tl0V6eoLSayBh0t7/n8nYuZ5sq9qHW7GN+22E
	WIVDaZk0ILzfbg558cPdg9qHK1GuZy0tmAUqWaB2kMFPGAo9AvCZZlKx/WEHLwhU
	iEPmCQ+3NI+XVmmsuu1WMNBYRVQUUqYgDpbZl8EeWSHJ/jMApYWg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdxkru4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 19:14:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49SIicxG040236;
	Mon, 28 Oct 2024 19:14:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hnamwd2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 19:14:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4FgN9F/hv+18pZP/gsGHs4GEjZJUrzFcEwSlmY1Ymjd1BvfoenZxhvWFOfe8tFgvD9UWCm2uyxqQtOf7qZeovvmIqgCBAatZ4kQHFqEqhO5b9FZ8jNgfiTbx4QUYvCy1tjhzenEamqrADtoZ9kRRPQCPt7smyvO862knnZiZijGgspl0udUsIDHIChZSq7eQ4WNEaj/wlpwF8ciidDuLpPkMcibvAixqJpdFi6/QPWBNc9ka61d3K0HXZRqyfNt+MRML2rDJ19/onJ19tSjphPuWa4+qo2k0JywtuQ1R200ngmYVOtNli30AFavS6uXP6C/b6HTWes0vID0vgkoBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfOe3egXLspWVtafedJoKrjpCM+0GVlwB53FktvK8kk=;
 b=PUqnAfbu3CmUyAnubx5CvZt9RQeNSXW6UBN7lEbM9lpWIakGJwN5kZn3ZSegz2wej241RiH5rGaLq8LtOkPSCh2dGZ6qmFe+cayrJb9+PjowgzUrZmNXuPQCvhllaHBFPJIeEPhMGMuwyz9v/7jcEiRvOlF4JYO+BCuedqsdaOX4ZpL+kYI1ABkaU9RRxIBADStDtdED9cD2/cWxohmKFN7GZ01Ai/7pnsxOqJ1SliQXF/uGqweLY6vj7DCegRzSrdAVmpWGJuthJgghCyzH+zR8uAeiwuXs1pkm0qKYBGJJA0i6IRnrRgYPyHd7sCqnHiCceJPSpT2zYnb7pIPgNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfOe3egXLspWVtafedJoKrjpCM+0GVlwB53FktvK8kk=;
 b=uBetAWXtZzjZoPw6qXMN+lyqD9DSdNSH3CYtUOGdQomGnf8B2vKgbVbMpK+T+EN8+9z3mmf84CTcxlJYmuXn1McbNvhoa5nfmYC0aD9RnFACcE7IM3OmLgooXqgBDIMcptJGu41nvWw6REeMD5nbqKkWfmJzXLJVHibMS9jghrw=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BLAPR10MB5075.namprd10.prod.outlook.com (2603:10b6:208:322::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 19:14:26 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 19:14:25 +0000
Date: Mon, 28 Oct 2024 19:14:19 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Xu <peterx@redhat.com>, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: [PATCH hotfix 6.12 v2 4/8] mm: resolve faulty mmap_region()
 error path behaviour
Message-ID: <438f50c5-8b8c-444f-ae85-10e5151f3f24@lucifer.local>
References: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
 <6e8deda970b982e1e8ffd876e3cef342c292fbb5.1729715266.git.lorenzo.stoakes@oracle.com>
 <61461dcc-e455-450d-9c01-5465003fc31c@sirena.org.uk>
 <c24a174d-c8f3-4267-87ae-cf77fa587e82@lucifer.local>
 <CAHk-=whD9MrPwPMBgVG16T_u+my8xYtZg2tUGz932HeodVX7Bg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whD9MrPwPMBgVG16T_u+my8xYtZg2tUGz932HeodVX7Bg@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0391.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BLAPR10MB5075:EE_
X-MS-Office365-Filtering-Correlation-Id: 0930bce8-4799-46e0-3875-08dcf784bc9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M81WnUrXMqzCNa7za4bP1s9IBzwtrTOYk0hCG48XSQxiAIMHKl05aKuaHeQS?=
 =?us-ascii?Q?fj3fyMQv++TtmW1YAxwna0ARtXXrGrSje5RKgAv8BbqQILvjv8NNyOph/kx0?=
 =?us-ascii?Q?TK4Rc8dv+bLkJ7GBMFNQ/xzI0AA0/VVUkSJuLF1mkqVWdjzCjaNgVVUKVNTg?=
 =?us-ascii?Q?3VFlrZ/sh0TI3KbQECd9w6Oy63YSihYc5IwNw5O00ouYsAB3OZ6BskG4JWU5?=
 =?us-ascii?Q?R5dxqKAXL4waFyIyeNYMLMdoLNQbE0MbsIQP74EbFSc/W7Ylfewzqv6flCtV?=
 =?us-ascii?Q?UO43vkRBKSfEn6N799ormYOU6OyPj60aoFRaHAUy4keCW7WocNlB0HmGGE7C?=
 =?us-ascii?Q?kj20P12+j35+4N7Uc+uIeTysFs+xrWnEy7TKbEcF1Gqp81Yv8XRv0B5f9qfb?=
 =?us-ascii?Q?p3u2HTVUBQFAM2xWgShlmNvwlJEiTSuEFqWF938WdVSVhbe+A9s4mBcMleG+?=
 =?us-ascii?Q?9t1pAmVIu8jwd/rQqjzlzYNURDKhp8lqWbiR2cjvQ9W+pCOAyU36bHJ+m0sY?=
 =?us-ascii?Q?FMEqtNbNI6I2+dvxBvMIhOFNfTt8IJjygQIheoixkRn94mhq4+FALEUXWlbw?=
 =?us-ascii?Q?rv0DZTlm9WBWHNYwjs/pJLwHS+xvhqSJkc6YiAPymSrb/go7KiFdhYmf/NA+?=
 =?us-ascii?Q?m1OZ2k1yNAOD5f2dFcj6q79AfY/qeuV4WQUdubYUdpq5l0RtyICU2FCJEEMn?=
 =?us-ascii?Q?7cirrCJsM73WkPO5tQ5yei+Sx4INVx4CFieg98i5nyU0iemcciPFtBlV5D4U?=
 =?us-ascii?Q?wBkSV9qx84JIc+sT5wDtDzqW6nU7fUqtOf2smsR/BvDaLJmhqhaTub4k754m?=
 =?us-ascii?Q?AXnKBKdASiTXv/3X3Kim9EN1vqoKT2+9OW/rZLWitRqGmzJISPEkrh+iKhdN?=
 =?us-ascii?Q?6M4nKkP6vnAU5H+uGe5nZYn7T6v+y1d1ZiCulVXznv2RV/3Od+iWgnDMRiW5?=
 =?us-ascii?Q?eN7OJ/wEEgB3ooqMsef0tmeFTaC/urPdIlVzHuwGBSLbrgOukkMmkdzlEmY7?=
 =?us-ascii?Q?pt+FwzY8w9qeZCPDRK9bpc/pjvkkF1Tnjdbuwq1rsh8ibQMGAB12chKlaSNG?=
 =?us-ascii?Q?d70W0j0OQZkyU8l1zlxFTwysJC6wa/9/bgUdWypGCWfgZiQqkOYCCY02dNZV?=
 =?us-ascii?Q?h8XxhRlj3AQgrXweHAe/0+Mcmc1wB0Rqc4g+3Elm13Pef33p2v2M3Jqk4Pa6?=
 =?us-ascii?Q?Jlk2xRgEQJE4LDV5k2fZ7K+SKdH+pFJJMpdaZgFh5qo9SWBIeA0gqKCYJDL3?=
 =?us-ascii?Q?IJM7Ru2gjSD0tBTdJZDCPw4sOYcoZ9dPEq6M+PNO5k/FCgCI+M9KXjcpzTHo?=
 =?us-ascii?Q?bU1DjuIIOJ0KxRXVtlelR42d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gI+kcFDPLHcqHKbkz6tTBgUlk9NiiRmfLIog5966Jdm/Q51JjXQCbP/xQ3+s?=
 =?us-ascii?Q?uknEvxHbmOhUVdsjbzs6KGwB4sH9owa5Vzd/Tprxy4rAL2NKr87y+c6ztZ61?=
 =?us-ascii?Q?/Hj2ONysgWSEvScb5Ccw6tWFFrqa2zPPeAr/SPjkzDciCOM24IzHDXZKmLw8?=
 =?us-ascii?Q?Tq/XdBPTZPjCXRtNMfCD9RqPbWJB8eHZi7QDnCG7cK9JdzE+re8cWuEK5p5u?=
 =?us-ascii?Q?bhszLacwSEr5+9H6Hh9D2V0IOKLbzKMHkjUMuuddgqXEUTmnvHUr/9zTy5aq?=
 =?us-ascii?Q?PzJ0YNoCPpQ46h77NRO69NGIDmwLnCNaRx7f3+ryKB6hikIqofUIOfNI+lpg?=
 =?us-ascii?Q?2fov8vrADX+Uu6Akzzo1pW4DYdNSnVmzTK3ttERaIYQ3BwfYs0dDkM3aGmO2?=
 =?us-ascii?Q?hS9sB8fCZ3VrZZLuRfYfhY+yhCyVerMggUzYnIgr0YyQKWo0jdQmx84hqHg8?=
 =?us-ascii?Q?odVIYe4GL+I8tnwnH9dd5RwTna2FDKkTfQPUTgScwwXch0fCe2N9FM0eaj5y?=
 =?us-ascii?Q?zEBL70pmsg2fGnpLRRYvnxPkgVWuVFuXR8W2UT/n5I3QizeREXbjXTQJWZdx?=
 =?us-ascii?Q?i9xweAsNaOF9YgbSukKEr+uCQKnVAJmbSxiBkk9LkQywPcw09WxGpFe4QVfD?=
 =?us-ascii?Q?oXCe3nB1qZwppdmkXDuRVxFkKdIlA9+QcbD8GTrUEL/D/G26m7ZZkKDdFu9M?=
 =?us-ascii?Q?emKIzHO5+Yo6DxntyGjQ2IdfJdLNv55XfRoShubiLG33+Gn0LrHbVFq7gjM+?=
 =?us-ascii?Q?ovz+TY8glDpxTer4JqiCb5wrrz+la3TjjL91M18u+xtl5YeMyxqvQrAGPPqf?=
 =?us-ascii?Q?+QBkfFaMVrJsBk1JpFH6ANpQDtWc/4iPbevL6ZEGtpLUgVPB4wTryTJuNBfS?=
 =?us-ascii?Q?9sMlaWkZhxGDkyoYaOYN8FEovHHCFmgYiR5Y5UAjaecBjJ4JcthvcppMPoPF?=
 =?us-ascii?Q?8RwyEhPLTSdceE+koCNlHlkwiuDXsRacThtHvSGPU+9TdW5e7YVgJB/GbbkR?=
 =?us-ascii?Q?U2B+hRXBbmj0XT6meGfAVmpcKjCuTcijBgONjy4wpiqBzY4vftIpuAloYAsZ?=
 =?us-ascii?Q?R6c0krCEg1i+cV7f4XpUcqyUOMI+prrmstO4O1Avb/6H4NDJ2hNipyJq6K8j?=
 =?us-ascii?Q?LDfU7cTIPp6UZ7yfAR/DbeD9JaNW2ms+RlmaNG2QqOMrBRPaFAUnulxTNo9w?=
 =?us-ascii?Q?uiRyJVX5FKI37tqvLXVMHQckMlMV6BNcucR/IQBeG5fhQLh9Dmev3o8HYPg8?=
 =?us-ascii?Q?naiuqzoc6vpmi54VTm5TeTr0adMoLvgdDnVJ9duhMZDCZ1PhYHqRq67uRSRL?=
 =?us-ascii?Q?MewC/ILmjOgXlIxCkPun1fkS2swhbtZcv6yqHHvDBzhjknfEKgtOgeuxPmoh?=
 =?us-ascii?Q?5n8kym0Ws/KGx1goYHw77wfUQukqVIcQWf6YexJCUHWPuJk4DXTGF6ac5Krm?=
 =?us-ascii?Q?H1luYrkIOIvEhJjlivsCmDv6ye/Ww2r7YrPeX351djsZBwGZgyOOwFMIENY2?=
 =?us-ascii?Q?JEo4J/D9mi/ZiwOcnQQI8X7EwKkBajHCVzGmvWUCmg2Ku1fnW44MZaEtC/wj?=
 =?us-ascii?Q?4mVVxgp/QH7bkIdMKnlWcTeSeSO4W0wdzBICi03lquGwn5tw0B1oM/FZ/Wfl?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5dbMK/GDbSVQumWE4RDjyUaQJCaZQv6+W5tfI5ZvRXCCX8MSyCDbvXETP0lSbA7BFYeo3OrYddr5o5XqJuoofu7DQMaQire9DhW2L3fQ8myjjeYZHumlSfC6kTC9Z7ShqUwBPFsKnko8KyPA77//5+KRK+5D+6dDIABrVCeatPLEiU3fJW1sV0NPVm3PF0aRob9ffiHuArr+yDFjNr4mGd+XIZe7goYfT2aZWPFRA/nkIbc/DjoUIomUgNH0UuBd/X/Oi7Wgwn8XI9w6OVtaji8qO9ptnOjDDkYiv4hHKMkVEo+V/mCRqDH8LnACqUPX0awvL/d3LeC6cUILmX8jOLjkYhZ+3hPRoglbjxcvPsOp0MWwI9fycyjS0V4SKIcVJAlM7WK8k+xEONymaMlSLTcw9SccYR0V6FY+0sKrfUxiOQYlzJUt/cxl7yCciSw5mABhzRsDLTfY/Hw3HAaab9A1QT/UVkBa+J2xk1GXn0xqCTC6YBVUpxglm/ellChfZMc1I78fJOyfR2oHlZxdzh40zqK0T1iqp+MlS+CjDick054bcINPzBiJ8ezrP0BR6d/3scdRkyl4EQ4ctjCDnB6TlN7hXKOBZXNB3Bpt9AY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0930bce8-4799-46e0-3875-08dcf784bc9b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 19:14:25.2822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Hw6MjOUoIu4etAS7g5ZIeJyVwqsq6aUl3SFTT0zdffSGt6o2hT9/uxp0YuxXVp9Er5d4ck+Z6GoLefV/TZV/Q0JOw3mLTAyOg/yg932v6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_08,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410280150
X-Proofpoint-GUID: AFY2u26JKI4SHqwxOsDnh6MNCjyW0VSc
X-Proofpoint-ORIG-GUID: AFY2u26JKI4SHqwxOsDnh6MNCjyW0VSc

On Mon, Oct 28, 2024 at 09:05:44AM -1000, Linus Torvalds wrote:
> On Mon, 28 Oct 2024 at 08:57, Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > So likely hook on your mapping changes flags to set VM_MTE | VM_MTE_ALLOWED and
> > expects this to be checked after (ugh).
>
> Gaah. Yes. mm/shmem.c: shmem_mmap() does
>
>         /* arm64 - allow memory tagging on RAM-based files */
>         vm_flags_set(vma, VM_MTE_ALLOWED);
>
> and while I found the equivalent hack for the VM_SPARC_ADI case, I
> hadn't noticed that MTE thing.
>
> How very annoying.
>
> So the arch_validate_flags() case does need to be done after the ->mmap() call.
>
> How about just finalizing everything, and then doing a regular
> munmap() afterwards and returning an error (all still holding the mmap
> semaphore, of course).
>
> That still avoids the whole "partially completed mmap" case.
>
>              Linus

Yeah I was thinking the same... just bite the bullet, go through the whole damn
process and revert if arch_validate_flags() chokes. It also removes the ugly
#ifdef CONFIG_SPARC64 hack...

This will litearlly only be applicable for these two cases and (hopefully) most
of the time you'd not fail it.

I mean by then it'll be added into the rmap and such but nothing will be
populated yet and we shouldn't be able to fault as vma_start_write() should have
incremented the vma lock seqnum.

Any issues from the RCU visibility stuff Liam?

Any security problems Jann...?

It'd suck to have to bring back a partial complete case. Though I do note we
handle errors from mmap_file() ok so we could still potentially handle that
there, but would sort of semi-undo some of the point of the series.

