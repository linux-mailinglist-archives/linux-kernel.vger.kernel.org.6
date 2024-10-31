Return-Path: <linux-kernel+bounces-391322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9EA9B852E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D4CF282D10
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE8018593E;
	Thu, 31 Oct 2024 21:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FZaPZGKH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f3nP05LE"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C40175D35
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 21:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730409708; cv=fail; b=c6zF0ydtZ5S13jCxj/5xv2EpOgSwFPzzuN5VDNiGOqy1c1iV8XewBFqfetMGoco6xJ0QPlQPocQlaPAFIVbC/3HLOltHi1foXEXOua4ZdcfI8BofFoNyPL3DpWKhRXaV2avYZ2RnF1DGSYU8EaNVVknxPqSA21qhvuGVayP0DiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730409708; c=relaxed/simple;
	bh=2Adnzm3vdOO8G78X9E0YB6fYsc/Un2SxFMm6vHpnAu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lWoK7clk/xXMwxQDkYJYixWFh4OVDodV/Ve2FQyAAQ6z+VVHHL5xw3X35vRtHEuM0BoWwBoOsZGy6/J9fg9h5k1nrObCBZSk2UT9xDaknlEo0I8byblsTVsCBnilVRdl3KaKmz4UjjRsXo2QaAE3qd2mvwCrcF6Wy2TxXG2g0JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FZaPZGKH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f3nP05LE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49VKrr44023492;
	Thu, 31 Oct 2024 21:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=r0ZuUg4RtJQCgQ2+Ff
	oug40tGMiQkYvYeIGYLab04Ok=; b=FZaPZGKHxiEp1GCKH5gid7dBsbG/BgWexU
	nhWbKai1aEEj2pVItCNC+NCGdsuJHooU+ht4o7RYLuprYGdpiMqfgxWR2OEM9jfp
	SI/nytLz2Pn9t3SgKV0iopH5EM2Tfmem/DKYCCvc7E3yT3/LiIHN//aILwgX6iXh
	0L7fPGQidoQ+As/QE/WUKxsK3AGYbMEtMCzQl30lNAkDO+nOtbRXfR2xW3JEOskr
	VGH6UvROggCxhGVsp4+4BHcPNHXNNDbknWtX9O/A9vJksMl0N7I/DdywZ2+y+Axn
	NTpeVfzcT/e0KYPm/UUdxcLl/kQObLmvnAnQTR7ewEVc54lQgamA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grysbagr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 21:21:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49VKoYvU040324;
	Thu, 31 Oct 2024 21:21:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hnasadh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 21:21:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pyn55cgXZJQJxbXr0DqQJmBZyzzHwNvY/CueToP2JQV8WRZX0PBBkZhYFm5gVHEJ1AWrR6mwStqCnrJkO2MB17xY7jW3VjLmyMg/X/QlAcLZWMrL2HenzB/rUyI+CidQdNAhBDC3TXxMOsW78uPhsjCrKnpcpC9buCQoxjElTqwulQV36Y+vG72t/1Wsv6Jh4+Yj9khL4z4wIyEO92A9GL57wjErMjx2PMFapJ7ujFKyGk0xZ+CJFmq1R6MAGy4cbhF17Pc/0/73CPtH+t7u9KRS75fuRxutEOKWpwAmWefK7mIzGZvjY+HyFNf6Zjoz7JFW/Y7OPdbQwN4bysMUGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0ZuUg4RtJQCgQ2+Ffoug40tGMiQkYvYeIGYLab04Ok=;
 b=OnM3UWQ/NUKkbO6I0pBIRfOkDKsoxRzC/ld+py4eOFl9Q9jhRUb1u+halv++IBqdL9BskVo9pjmGVXJX6m1jip6ssXDs3ShV4VRXUR/x/RTyEheAkIRhV/b05TLU1v/ST5wUDYhZ3T+5dBdoscZmi1B72yOzrL2qCimayXzZyfwwo4Ev/LBKeqgK9gzgokWskcmDfJWvdYWGDTZEjIga/lL4musc9KdhO5EJsjzDToUeHXYQtvm0xgpNxkPjy2i/Y1curMgdw2vVCzzLY92il17hAjEdThoba9ELU9+VkkI1CTqAKkYjqp9MgeAHPCND204dOUbNu6jNFQXmlkGDFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0ZuUg4RtJQCgQ2+Ffoug40tGMiQkYvYeIGYLab04Ok=;
 b=f3nP05LE25PTVD+oh59P7/DfgYKzB75Ly+9FIzoW3ZDqh/jJdCxTOwYY13qH4ZZOHnHcx+D7gl4gFfvzonjzQlw+uoiNYDsWPTNYLWH3e2A7/wqIoluM2WToUk/4goNTfIO+D+0f/TN/JxgdBCzSO+ktQkuxgYr/gO7GVNvjZD4=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA1PR10MB7553.namprd10.prod.outlook.com (2603:10b6:806:376::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Thu, 31 Oct
 2024 21:21:27 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 21:21:27 +0000
Date: Thu, 31 Oct 2024 17:21:25 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2] vma: Detect infinite loop in vma tree
Message-ID: <nitzqi2v37ojb2ron7bjwushyxwjw7yq753z42un7eotzs3vpm@6kr5xblggaz6>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
References: <20241031193608.1965366-1-Liam.Howlett@oracle.com>
 <20241031134815.81766b263e87f74a3e31471e@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031134815.81766b263e87f74a3e31471e@linux-foundation.org>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0036.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA1PR10MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 7841de05-a7bd-4087-5547-08dcf9f1fb03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SyleIhqxrH4KPJbP8/l3M+KrbIO632xkfiho59YJtP4qJ6mLFXqU4+ukWCIt?=
 =?us-ascii?Q?McP3XxxAY/hOBZNq4wGVYcSg7/oLtxDHlh+gOGTwcOQ4zgJ76kpQZFkXWZbR?=
 =?us-ascii?Q?7BoR9ChA7ofOOB827dmrjdWdqjyn3f8DwzX+1uHOrxg8sW/9Vej9tb90ZDgA?=
 =?us-ascii?Q?QJCoFCpzbPlBRcKsNOK+4JwsKGSowh244hsA//f5hqolrtxc/R4XjI7IloCB?=
 =?us-ascii?Q?d5IM9ZULzWXMb5uCYV2htDjgTh7+WEzZ1rD/JIcqKLIN2ng6E8wxeroGqmPY?=
 =?us-ascii?Q?r5QrukN6u7BOCJkvbm35BIrFLpxp1kEmsmoDu6saCeZy8CadeAoD6CvisM9L?=
 =?us-ascii?Q?5lPZEIYY/bTIuZ4sHb67dP5loFhS6Y1gH8nv5XEWEN9Vht2b1UnblCtaRqow?=
 =?us-ascii?Q?XNrXVFRVcgSo1egCF8o2Z+IlZon5ELtr9Zz9IsmOAFD1qmeDA7hCf/p8eNs2?=
 =?us-ascii?Q?R42K8tlzUSRlrkjIsVwrQCkzkJHzh6EOY2OO9+XUJRAiE3ofEPg7IKpLU5EU?=
 =?us-ascii?Q?cIuWUOnealnG9/0FQiSBVKWx1jbE7kC13Nh1Hg5KokYqIdzH2gjCkh0LoUiY?=
 =?us-ascii?Q?GmtN0KspXC3WcqwIRKxqiC4gghXw+7zyslpSidhYaXhaBQIh+pz/uz2pd0/B?=
 =?us-ascii?Q?O/I1EZnml+8BHaKnyQ4j1DVeMm76aWm5N9w5c5H1Rh8Cc6pIt7/IyqQZ5iU6?=
 =?us-ascii?Q?puI5sM/fIAG4ZRYyFLOC9WeuE+IrziIQII9g25p/FSb4KgSxuflrDOkQTS6y?=
 =?us-ascii?Q?26gtsyESEtvD+95VjmNyx1igztG8pASG4iykWXr365dczFe2o+nEND+W724p?=
 =?us-ascii?Q?3aJ+Aa+E/YcjOT3eiKiNU4lU7ucqetOo7fQOAEwCb2uBuwNc/JRwcR1VkgVF?=
 =?us-ascii?Q?HROGl9g7MsD0LkFvEGCB/UisDL48x9acvZL83ppWWioTcF3z86Q+mwNDsHNr?=
 =?us-ascii?Q?yiMc7aOhE1nNSxRyJzQvSzEDiZxPqg6Zc4056r3v9sg0HYEznThzvGEfpJ/5?=
 =?us-ascii?Q?PXrNkSyxHTbs5crgIEttTxi/mdHMbTAkzXhlZDTdIA+jwqnUQKNKKrsY+BjJ?=
 =?us-ascii?Q?D4FVECKa04tHA4DGvD66xHAA4nkos/Wsz53HE9spXf9wBMDXt3JAEP2Ln5Rw?=
 =?us-ascii?Q?ONxfY9eX2SPA/yEuAbOO0eTNB6MU5y1UfAA1Yo5sZWuFOyUuAKrxnUUNXpgc?=
 =?us-ascii?Q?26elDKT9DEbQxD/ro0j1+YfSagQi/RKKv9LW+z3TeNGq7rUU9Ks8qIuYF/gW?=
 =?us-ascii?Q?I48zUt1K1i4oMLg1E9l3vLofCZAYPtrpSsmYkGt7bUNSSwNoj6dwCX3x+yW6?=
 =?us-ascii?Q?X6UxXhdJxX3Je+LvjtONrYdA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8r8CFOSrkUk97XuDBsgsHgyxY9tsuKBA1MBh2mbAU20Bt8NziQM3j/YdPWSc?=
 =?us-ascii?Q?iuMO4T+nFUG8TKw1deMV3x0bN/tOCAmr0sYnTfYZj8kdJwPWoROGdSWr4psG?=
 =?us-ascii?Q?akpCpEgrkW/2Wopv11jD8wvjsHM/EnGK5L5j/mCKR0czZZYqjQeeOTs+aJMk?=
 =?us-ascii?Q?K8DVTwSrY6BK9AfBho06hr+PuZz86L6DZs8dLbP3/czkUOW5W12W4U/m8sG6?=
 =?us-ascii?Q?/Fqu7ikfP2NwR2arqZFSRPMVBBtZs2ND0SKSutOQ8mVK1okoHBMpWYAPoIcK?=
 =?us-ascii?Q?hkbbSXW7nIrNOLVeNMK4gsqGxbM6VzgbSJkXZtL5nOHSGM2NPyvJ5JSL1Rc7?=
 =?us-ascii?Q?UjbRB6EWuvnoioBqVfw8YI3WUghFvYDqElOcTilNTb+3u4vs3L90CNH5oY/m?=
 =?us-ascii?Q?g+SzN1wlig/cyy+E9AKyAKwJ2blb1ySx2clYVbxvFZWrrmVYgh9s8+JHLjJc?=
 =?us-ascii?Q?KG3mddozDgjyOdA/3evQgrhdOhqL+zE40ZSnekYpFfHTbDnC0TKTLdVFXcfS?=
 =?us-ascii?Q?1Yxlu/FAYw5V3KZM0WUH5aPI89q5Bp4myJeuHV3ilkzYSGLq6of9w0xdZ6XF?=
 =?us-ascii?Q?if53Jy38DVyJDq0DeHwjUI6n4pCdI1qVZi8vNa8+1a0b5NakFEQe/+V9qn7b?=
 =?us-ascii?Q?DIgtA8wcAe2BD8zqOl9pAwtOz1tGStH531JHYkCRWFbZIryhqWZRt89IZaPo?=
 =?us-ascii?Q?fsevRVe92FzOlz4vXuilAIreiRDkjYAtxAItDcb0TxR7xWTCq3WKos5mTyUZ?=
 =?us-ascii?Q?DIkY6EB7P1vIl/f5rDdADiebZUGiGt1agc5SLKp8h7dFNpzpXXXP2hGKiIEE?=
 =?us-ascii?Q?wQ0mgIi3Hz8mwqKKLeTnQ3C4QwhiKLvR/2mffAxJdSjbYuFeN/PAu+k6CLiV?=
 =?us-ascii?Q?Z2ZlkplY3GvAUDxrgRfsUDehvNJVHHwPVtXVy9ZqwpGukoXj6QQcr0CzB6AI?=
 =?us-ascii?Q?HQzyiQijZkC+wF0Y2rnCxWiXj2CH0YbI6ZQWM/NeSdEMKd38A80IfyTPcecB?=
 =?us-ascii?Q?3QORbwZnCIS7Esm8U8ODTV6XLsvqmbfOZIMXrHNtt0OyUWoOSTTMkuPv2gGY?=
 =?us-ascii?Q?22fC+s3iBuJMNgXe+0/AJYYCLLKVpDELocmquzinXXaWA8ng9Cld38iI0qh8?=
 =?us-ascii?Q?aZ3X4qE5ffAjeWOycuOvFf1hL5LVeKrPDnDpDpc9xZPzPTgaLpZJiKNXlcP0?=
 =?us-ascii?Q?/s5hPRP3Bve9Puo3dd/re+ebQekaC/oT88RZYr+pSPyAWsz5dnEXAVrSyBCV?=
 =?us-ascii?Q?IrSj6bDIWQisPE8/AlqQotiN04oWc7bZWZ0nBGtYGXOYsIPPhfK4dXWgEyXF?=
 =?us-ascii?Q?qQU8MQ1RYgeCM9B/tnpIvrPKjh0gcN7RmK1xGp5CWXxiv4uQ/8kF0/gvOpCR?=
 =?us-ascii?Q?8DaXDfQkNGjQIHQpbrNmHthQWcuR44DF3+NcyV1HKiSbj8uTgF5LLAGcCyS9?=
 =?us-ascii?Q?iat9jsYRit0BjNJvYoFv78M/DOzueo3ad1xrvPYfDb729GqF8m290BDLeTHP?=
 =?us-ascii?Q?CFzj1dAgQR3BBws9XwF/FcLNFNggJhdId1wsO7siUaZnV1c3eTjZaWrWN4Ya?=
 =?us-ascii?Q?JNC1B8ACZnYYUWZGcrGvS8Eip4DO2etMl/Y8dPGk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kbpe4lc+anLypzeQClfZVvLZhwTzthw7nlz7dtDTi+FQG0K6YVuirdVjThgkovCHiLCP5LsBr1a48qTjId+IZsqiAOZ+8Xqas4EdQ+nFaVknFpsDLmrxLlMcD732eFeGoduAFpDbhpmWFmjhjPlmoxXIqFsXeJvHwNx9EtljbuljGHCmJZ9pT9tD9byc8EPtNvvNoKp8mqzXlYtt4202UW8DhrERFIKTqHXuNlq/U2qrEt5fOYUulgu5vdGMsI0GZzP2Tk1/siysqw2V/dwH/cVxan3wafhDFuxYzzn44kCXsT0Reoc21bgmaYY/dg/SBXSpoiMUJ6mQO9cdF85rROmacAAvIXOLK/SiDoesiz6XIDq4OyyaHJ2LN4zQg+6aJQZjKrSOAzIumXHapTUWpKqx+HIVeKEVApgouiaeZ28CNl/Ux3lindy3MkraAz/3ba1Yu98wmhKE5ela5gLogB2E2ZOLjbX4rtWh8O6lphObOPyp1giryvdc9uyUxPfhQ5SLt3Wb5wWzeglYDdSY9e8x2CvsY0nCi+27Jxx5vApNK741OujCcBbzQiGLHicr4kibcM6fLu8uJwgBf7Yjm4GvJxZXOlIzQinDQMZMWR4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7841de05-a7bd-4087-5547-08dcf9f1fb03
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 21:21:27.5053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSi5ih5gQLzpUUSId+aP93pqFfYtHEE/Y0J3/IgROONpGcveu0PmDpVluiErX1hFTqZ5yJMYp7U3djqBokj2kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-31_12,2024-10-31_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410310161
X-Proofpoint-ORIG-GUID: XP5iNAGhTmjTtfw7XkYbm9xNuaRj1Mvm
X-Proofpoint-GUID: XP5iNAGhTmjTtfw7XkYbm9xNuaRj1Mvm

* Andrew Morton <akpm@linux-foundation.org> [241031 16:48]:
> On Thu, 31 Oct 2024 15:36:08 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
> 
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > 
> > There have been no reported infinite loops in the tree, but checking the
> > detection of an infinite loop during validation is simple enough.  Add
> > the detection to the validate_mm() function so that error reports are
> > clear and don't just report stalls.
> > 
> > This does not protect against internal maple tree issues, but it does
> > detect too many vmas being returned from the tree.
> > 
> > The variance of +10 is to allow for the debugging output to be more useful for
> > nearly correct counts.  In the event of more than 10 over the map_count, the
> > count will be set to -1 for easier identification of a potential infinite loop.
> > 
> > Note that the mmap lock is held to ensure a consistent tree state during the
> > validation process.
> > 
> > ...
> >
> > +++ b/mm/vma.c
> > @@ -615,7 +615,10 @@ void validate_mm(struct mm_struct *mm)
> >  			anon_vma_unlock_read(anon_vma);
> >  		}
> >  #endif
> > -		i++;
> > +		if (++i > mm->map_count + 10) {
> > +			i = -1;
> > +			break;
> > +		}
> >  	}
> >  	if (i != mm->map_count) {
> >  		pr_emerg("map_count %d vma iterator %d\n", mm->map_count, i);
> 
> It might be helpful to tell readers what's going on here?

Sounds good.  I guess I should have waited longer for a v2.

> 
> --- a/mm/vma.c~vma-detect-infinite-loop-in-vma-tree-fix
> +++ a/mm/vma.c
> @@ -615,6 +615,7 @@ void validate_mm(struct mm_struct *mm)
>  			anon_vma_unlock_read(anon_vma);
>  		}
>  #endif
> +		/* Check for a infinite loop */
>  		if (++i > mm->map_count + 10) {
>  			i = -1;
>  			break;
> _
> 

