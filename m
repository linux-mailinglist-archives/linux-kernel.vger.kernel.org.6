Return-Path: <linux-kernel+bounces-363084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A2699BDB2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38C71F21B78
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B84938DE9;
	Mon, 14 Oct 2024 02:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S18Zd+rf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jT0tdebj"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2173200A0
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 02:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728872552; cv=fail; b=McmRGYHW71opFbjKhAuczY4tjFQGCY0m5R1JKZAbOFTyEvVJoItlxHYQoW9KyPW3JRSm/PnXU1m8foHqR1nqguy1XdartZ0yF9p+OZ/k2JlF+pRd26mDDLEZVso0XMpe8yk31EP9LKJi+U6u9P31JzyQX09Q3GjGOtP752GVXaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728872552; c=relaxed/simple;
	bh=sETWTD/yQL9DQeoF/HxhSG/GuRU2ijhqwBEeF5yXJEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QGLS7Gt38WOX5Okm0atcQbWRZhz6R8BKfgsx9fak6yizzPsxD2Hpu4oAmQ4NVg7qQ7tmXSTwHrDDY1ZB8QE6yydt1mvav9mPEiP2TfN/LGYDwFCxe3QxniygIHDXgP2/KgUHWigI2kPTrFfctzZOzgIqYvVWxqbN3cNTSVyGqWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S18Zd+rf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jT0tdebj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49DNKAJl022698;
	Mon, 14 Oct 2024 02:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5WKzfmiOX/xrGZDq9/zgrO7EmQ1eP5HEIha7Q8lLwLI=; b=
	S18Zd+rf40lrT2BDhJ5tCMvgWsEmOUpul/+eX2GMmqMR8CUksdTuiVMypViNgZNT
	2fIUfzTNQ5RN9V8D74eEPNpOAsi6dRbceZUWi1re1fKSOe+r0NFTmBeUS0ApH9WB
	8efpw901jW3JiruNkB6sXA1ZMO+XZbD1LTJmIpKhsasZPFErdFI076Mh1NAuXlOG
	nelRRQfz/8x9dB/OWiUhkUkVXpWtzfC3D3OoNyh/hRP7B4lD+sf9zQCbiPyAWRUh
	gxUqAHF1LxvG1y39t9oeEZwCP/pqFvFpIoMQv1COUM7Cnjesw26q5tl3KrmnEY/C
	zSsxPva49t7Vzr2StbCj8A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hnt5fcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 02:22:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49E21di1036106;
	Mon, 14 Oct 2024 02:22:16 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjbsh49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 02:22:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAX1mFQiKrUy5yJa7t3ZaNwQ079xStiT5A2HJWNOwy1Ksqw+BadArBtALVQ5QrMjmcqIty4d7Etdl3LJnH+eTsnlj5oyOYfkqm4ZeK58PZMaLz/28eIMDNx3/9TaHJ4OaOKu38lCxUA+11JityB+tHN0aBd7gIsXGE22p+DMQJhb9Khp2CV/by4jMgEQgIpnUkk8ilxgpEFEqGk5GkovXiSojBq89ySgQN5aHyclP+PaaMHOmgIgad05Vrb9BpLpqbEmBYivegkiwgr8HwbNYHvQ5DYiEdDGIQK8e0t/pYtxEKIwTBp3GW0+PV8cLtku4hbJw/rXIO67nhYteaYbkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WKzfmiOX/xrGZDq9/zgrO7EmQ1eP5HEIha7Q8lLwLI=;
 b=URBDULIYVUMDqQD3BnSy9yOPUbX3cllX3ohUy1InBmpDDwhmgRtdEVbnNYc02/vs+1bv1ILwYSJnWbk4PZ4JRtp0gX2zNB2IXiJvKYAeXaOZyWlcZbYpjo8nOreIjRF6qdTGMvDiNfvYx8ximhOXrBsw7S4pR3a5RU9I0EIPO/huhF52HTzvpH7sfatDephGY2DnvstxGv4knQWS0zl0MR1tlwFsfJ6DEayZ1HoVTeXpRbi6S27QqCvq0L0U0LZFnN/ULM+aTzX0PkcwS52r3JfCcAs0KfY63zkEEL+qCjXuEMWsg3xJEdv+OPeVBZww9Hq3WPm+hLQi1eap5XIcJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WKzfmiOX/xrGZDq9/zgrO7EmQ1eP5HEIha7Q8lLwLI=;
 b=jT0tdebjKXsG2ZYrm3OJym7G5uVZY9jlO5wRiDgkc6+f69s+BISJ6wi1ycldkyXxB+RSX1DbIhChB6RCX/e3adLuobSYEVBC8URVt4bwU/3NFnG5Xo0rjPEEAfHEV6G8TslccdnUgRPUQ0jV0DOnDPboyQsQHJ9vs3Lp6cfcGqI=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BN0PR10MB4950.namprd10.prod.outlook.com (2603:10b6:408:12a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 02:22:13 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 02:22:13 +0000
Date: Sun, 13 Oct 2024 22:22:11 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        syzbot <syzbot+39bc767144c55c8db0ea@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] INFO: task hung in exit_mmap
Message-ID: <oluo6mk6zlb4wk6zul6hd3joasqjms3jwexxbcacewp537eenp@37gwchfwzddi>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sasha Levin <sashal@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	syzbot <syzbot+39bc767144c55c8db0ea@syzkaller.appspotmail.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
References: <6707f080.050a0220.64b99.001c.GAE@google.com>
 <72188763-843c-4e83-a25a-90be2d0bf9c0@lucifer.local>
 <ZwvLJKnyWuaKp8NL@sashalap>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZwvLJKnyWuaKp8NL@sashalap>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YTBP288CA0014.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::27) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BN0PR10MB4950:EE_
X-MS-Office365-Filtering-Correlation-Id: a18563ec-1141-4748-2f59-08dcebf703b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vs+G8KfFWJ7EsxIJgVfY7YQ3VIDlB2hwG5xK1GSJCBFO2PTDQNSQIw6AUdFR?=
 =?us-ascii?Q?dyHGQ0FZoBeNz3FMMJ4PHlDgZZqobZkkAunADN/SonQq41U+kdUsuomkPsvL?=
 =?us-ascii?Q?dUmG6A1PkvMziiIUBKB8lMW9I92OLmk7KZYoPUbplbAIDps5JWhIpTyf/Yox?=
 =?us-ascii?Q?UMG5I2NUx3rqZCFuTXT/IKoAX1NVvmYtDUjXBw/iWAheRnB8GftdOHYrmyFg?=
 =?us-ascii?Q?IQSi9DjD7OjMyyBSidmLjPLx4Lnmnz9S5djBI8cyHDh+MSNgX84FIHED/1na?=
 =?us-ascii?Q?CTtzd8HpeLWAV5evEKMeAHASBo2a8SQ7vjPQ4VQRXqfzk2rMYx5IAOU7hS5I?=
 =?us-ascii?Q?dctSaIxAzZ9cvQWCuNvTBi7zA9odmjYN2VkCRQZccc0kO1Uwi75wTLSEQddI?=
 =?us-ascii?Q?TTV7nxUEJZoi57vCwAfNELX2znrPTJbtYMGUyaUWMAXWWCGEO//X5IsUL0Ov?=
 =?us-ascii?Q?cPNVvMO429JisjdjusGRglDFGNdWIU2MKuVzOZzNmT9lhLUtTVGUXZp++Y1q?=
 =?us-ascii?Q?7o0h1dCoumAG6DD08vA1sGfYUh490dab8SOjJrwBg6mKjn67BtNaKC45IZSU?=
 =?us-ascii?Q?8YKUvDjG+1Ppf1auUrgBAh2L+qowz9Hs2VxsYp3kCuF/b+xwyxpTCk5tbeM4?=
 =?us-ascii?Q?ONjd9bfhkWlgFh2O3BVaTRhwNiUGtm2qlvQBK3fveRkB32X4H9Ok94SJj9aF?=
 =?us-ascii?Q?CfZqDeUr2L+Tn/l4b/SPEKXKFJ8Za+sznlIb9GxpQnNUKKuTy69+whl21ycA?=
 =?us-ascii?Q?WZYF2FRLWDOfT/x7h09u3NXD1TYy+wgCus2SaXnFooHHdzQE+5A4mMvqgeB2?=
 =?us-ascii?Q?2WQQZgEWdf2XSgbspUmTI16vkpp11o/CMzA1xdwhyCmYVJPl9nSJQeS0Rld3?=
 =?us-ascii?Q?/rFZFyU0RaFl0kKzC7/jqlaF3zOkeKavaiHFbybNxS7kUg5ivpByxvzarYhD?=
 =?us-ascii?Q?XldDa7G8fRU9TmPw640OM3MY2Jk26blpIkazp91/6/WofZALtK6ML1eXbYgV?=
 =?us-ascii?Q?9yeegSZ3QgbJZhrzRBkZFSCxD181xgLhJLx7qznXZHq9O0aBP7eiLxuKNvIt?=
 =?us-ascii?Q?prHGkTWKCQ78WjqWlBWnT9AXTYSqRx5W1WoWoV89fzDjhQ5ljba1bvB0sJWH?=
 =?us-ascii?Q?1dHPytgJWjtb2vMcRG+GNHtiUIUJps4YB13+Yf2T8x4SkayfGEDjcWk3y85e?=
 =?us-ascii?Q?u/1SV4/y1KfkxiW3hMegeMyk41UnmsjbMTC+K6CRgw5/uiuiOV83v54EjII?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tiWoQHWkgnqWA/O3kqx2z14S+dx2NQGcu8Gc3hqk3wH0GZ90lQOAXY9Us2yW?=
 =?us-ascii?Q?UBKvcxIRFnwvzj/24rjp8UNJw0Vkmypq5upkJLGGARUB6mecL2zGEatuA+ht?=
 =?us-ascii?Q?kymIzc6YqtwVG+HoYT6OjAaGZPvBJhoc+iUUnBkVdscooc018T4I0SAbxAeF?=
 =?us-ascii?Q?RypwBZoZdES7ezISSvWJZGMEu7QKNVounL477XtQh+T9SOlDm2w7tmr+0R26?=
 =?us-ascii?Q?xy2xxxy35RVN3GhCBXEQeDE7eHfmtei7dHXk9doCNLxyjzukbQv/hhTln6Dz?=
 =?us-ascii?Q?+vjshauOCnScbWXFijjorgkcZdPRogEFcyWhbrtRUW1pQa41ksn/k4lOEE/9?=
 =?us-ascii?Q?UY6ZgcQt0Fe0BhpR2ulKKHbjUWgoT941OF0WzlJKJJbEd80RDdQy+9ihWKIi?=
 =?us-ascii?Q?f9BcYXshEWRcx4HkdbzVlwy8NVWkR63LC3EH2V3IrcF4+QOWczuiBihLrWnj?=
 =?us-ascii?Q?EoQodmibmCXXeT09yHTnjfiAMeUNhC4xzPI3gFfol4Rt6FA1uURC8cgxnEQE?=
 =?us-ascii?Q?FmafaKvWD4e3FiDmc2LNcS6FazmVJSfKxnjcwflPI66FW3aFbBpn9SCBahFo?=
 =?us-ascii?Q?kLLB8HTWWv03/767UopOfVlxtcpFosGoPZPJ3IU9Yr+JhbBzMne4Bxl0apmb?=
 =?us-ascii?Q?1OaQbHqPJ7A8NJO4m+zQgWg/SZHlUT1vygjAd4XO56ZgTaF20tFd11+cgSdO?=
 =?us-ascii?Q?CK2MjEIMpY1cumFWjLsDAINo7hxkdoVaG+iBdV00EBQ0/TyW3su3IA43hU/t?=
 =?us-ascii?Q?tkzjdbyPK/L/2SSME+Efk9uJP7t7RAqAwsx3mRGDKlyjv3Ry8TTBFI6ciCV7?=
 =?us-ascii?Q?4JMyHNLgSSfJKzx+kskoRLHcyjKZaf/aK4F9vmrejEVZZ2tPc94sHc0xydZX?=
 =?us-ascii?Q?uVoBSap54cnIH2Ow7n2G7GIrE58ve0apiLbB6NHYrw92wuIPRA7xFMJNrUhi?=
 =?us-ascii?Q?0oCvXqz28O6iF9FwstErch4Wp1dLnqTTxqoL3Yx3MUrZn2/x4lCbfM1nd5Aw?=
 =?us-ascii?Q?kuxX8pdbxdaJgFohvVbUoMKgPUbz7OIgIwO/ellwLhpsuKZFr4f5MkvalR2o?=
 =?us-ascii?Q?83Wi8Xni2nJQZqfzkyCeZSKhNSwrx8tKbfcNFIelC3D9XFW8i8bB2xODwsbk?=
 =?us-ascii?Q?a2Qb+GksPbPmGSbTi70kl2LQxCRoJvT+FwmJ4HeM6v9llxwkfUEjw8MQ1UV/?=
 =?us-ascii?Q?zRZ5YYtN0h5D21ero74Bxyuh21p1126BSknP6R0xvptRWC/DQ3MKPIWqZwzf?=
 =?us-ascii?Q?tD+hDh8w/e6Ht48wf+nHFNZYh8M2MutaU/sRWFNz/vJXZTjH6fG+MOkCPDlV?=
 =?us-ascii?Q?uLI1SCMDjs4Cc61wJtr3gqkbfUBMLV7rMyjauaFuE6AFY2O3t7CoUIk8JYmo?=
 =?us-ascii?Q?AvLSXdzTEoXTGU3w2ZL9VThuNSzHMmxanQltYEy3+V6d4XxFaip21KSGQsWA?=
 =?us-ascii?Q?y5l591R+++0drOeqBH3m+rZv04hr9b/kRl/Zb5BspX4YPbGKB8ZFwNtQiaSC?=
 =?us-ascii?Q?0X2B0Xk2Uqd3mrlKU2s20y0FHrMkDw95RiyimOZu8nL4JHD8kbRl+Z3oWdYt?=
 =?us-ascii?Q?jr+fMpzYBeXSg2MZ6Z5GT3QjnqahpvPLRsyDWgpp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ccO5zgPMmH6ScZ54fU38kNvlergHjj6z/Y82vxUwQWqCFYKfOukdCQaFc5mXNXJmuQGtMCfkGiLJshrv9nagFxw/6HWMG+yslmLo4VNlwrvA2Q7zZFTQXO8EdawePEW/snqs+419leY62GKSS/JbAcWyamScWih4dOz3dKwU2i5+EXKq1CCIJgw6EtZQ8xzg19xocz2a/y8Yta7Uwo1dvhOWVPjqj75P/Ha6lt7JKbpSn2u5iTbYzXgozlg9fRZsQX6g03zcqtDhvI2YOW5QVARJm05H7+rECtvEmwgQJt1bHQO4075X9LsfZ2TX8AhT8MFfZQAIZZgkzhNoQZmV1COyd2lyL7w2GNHTaoxv+UTcXNFRCPf03exVeiMqMF7bSV9IlcUL8NezmeKxjA87p+uk6oMrtYg3ZWMfFQUCqFOabGMPXeYac98tiJnXw+SxMtN8ZqrtAmNzRlEU8HfGoTycd3rLHOI6jkyq6zQBQioXTn1iib36nuDEjva/AfizUQJltYjoADwELtUJSnfGCifP//bYp3CLIbdEpz5eFe8f7FhGj3jBbJ+4C+Aiig8Pf3NWBtkLyw6mBI9P82hMgUp8ee5CwYQwMQBLQrmEVIY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a18563ec-1141-4748-2f59-08dcebf703b1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 02:22:13.2576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhnjaGynxsFa884PrXdgcOP5vUH1c0tP/PnuTStnESSvwkwxWcpNn4WcjN5iNPDvPcmnlKcAYC3Qnb/9LKIeHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4950
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410140015
X-Proofpoint-ORIG-GUID: CuILLeJm_EhTB-oxubnMMSWKvOtMrPf3
X-Proofpoint-GUID: CuILLeJm_EhTB-oxubnMMSWKvOtMrPf3

* Sasha Levin <sashal@kernel.org> [241013 09:29]:
> On Thu, Oct 10, 2024 at 04:28:18PM +0100, Lorenzo Stoakes wrote:
> > On Thu, Oct 10, 2024 at 08:19:28AM -0700, syzbot wrote:
> > > Hello,
> > >=20
> > > syzbot found the following issue on:
> > >=20
> > > HEAD commit:    d3d1556696c1 Merge tag 'mm-hotfixes-stable-2024-10-09=
-15-4..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D10416fd05=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7a3fccdd0=
bb995
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D39bc767144c=
55c8db0ea
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for=
 Debian) 2.40
> > >=20
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >=20
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/0600b551e610=
/disk-d3d15566.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/d59d43ed3976/vm=
linux-d3d15566.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/e686a3e7e0=
d6/bzImage-d3d15566.xz
> > >=20
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+39bc767144c55c8db0ea@syzkaller.appspotmail.com
> > >=20
> > > INFO: task syz.3.917:7739 blocked for more than 146 seconds.
> > >       Not tainted 6.12.0-rc2-syzkaller-00074-gd3d1556696c1 #0
> > > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this mess=
age.
> > > task:syz.3.917       state:D stack:23808 pid:7739  tgid:7739  ppid:52=
32   flags:0x00004000
> > > Call Trace:
> > >  <TASK>
> > >  context_switch kernel/sched/core.c:5322 [inline]
> > >  __schedule+0x1843/0x4ae0 kernel/sched/core.c:6682
> > >  __schedule_loop kernel/sched/core.c:6759 [inline]
> > >  schedule+0x14b/0x320 kernel/sched/core.c:6774
> > >  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
> > >  rwsem_down_write_slowpath+0xeee/0x13b0 kernel/locking/rwsem.c:1176
> > >  __down_write_common kernel/locking/rwsem.c:1304 [inline]
> > >  __down_write kernel/locking/rwsem.c:1313 [inline]
> > >  down_write+0x1d7/0x220 kernel/locking/rwsem.c:1578
> > >  mmap_write_lock include/linux/mmap_lock.h:106 [inline]
> > >  exit_mmap+0x2bd/0xc40 mm/mmap.c:1872
> >=20
> > Hmm, task freezing up or system becoming unstable/locked up is reminsec=
ent
> > of the maple tree bug I fixed in [0], which is still in the unstable ho=
tfix
> > branch.
> >=20
> > This is likely not going to repro as it's quite heisenbug-ish to trigge=
r
> > and the failures are like this - somewhat disconnected from the cause, =
so
> > not sure if there is any case to speed this to Linus's tree.
> >=20
> > On the other hand it's a pretty serious problem for stability and likel=
y to
> > continue to manifest in nasty ways like this.
> >=20
> > Can't be 100% sure this is the cause, but seems likely.
> >=20
> > [0]:https://lore.kernel.org/linux-mm/48b349a2a0f7c76e18772712d0997a5e12=
ab0a3b.1728314403.git.lorenzo.stoakes@oracle.com/
>=20
> On my Debian build box, running a 6.1 kernel, I've started hitting a
> similar issue:
>=20
> Oct 12 17:24:01 debian kernel: INFO: task sed:3557356 blocked for more th=
an 1208 seconds.
> Oct 12 17:24:01 debian kernel:       Not tainted 6.1.0-26-amd64 #1 Debian=
 6.1.112-1
> Oct 12 17:24:01 debian kernel: "echo 0 > /proc/sys/kernel/hung_task_timeo=
ut_secs" disables this message.
> Oct 12 17:24:01 debian kernel: task:sed             state:D stack:0     p=
id:3557356 ppid:1      flags:0x00000002
> Oct 12 17:24:01 debian kernel: Call Trace:
> Oct 12 17:24:01 debian kernel:  <TASK>
> Oct 12 17:24:01 debian kernel:  __schedule+0x34d/0x9e0
> Oct 12 17:24:01 debian kernel:  schedule+0x5a/0xd0
> Oct 12 17:24:01 debian kernel:  rwsem_down_write_slowpath+0x311/0x6d0
> Oct 12 17:24:01 debian kernel:  exit_mmap+0xf6/0x2f0
> Oct 12 17:24:01 debian kernel:  __mmput+0x3e/0x130
> Oct 12 17:24:01 debian kernel:  do_exit+0x2fc/0xaf0
> Oct 12 17:24:01 debian kernel:  do_group_exit+0x2d/0x80
> Oct 12 17:24:01 debian kernel:  __x64_sys_exit_group+0x14/0x20
> Oct 12 17:24:01 debian kernel:  do_syscall_64+0x55/0xb0
> Oct 12 17:24:01 debian kernel:  ? do_fault+0x1a4/0x410
> Oct 12 17:24:01 debian kernel:  ? __handle_mm_fault+0x660/0xfa0
> Oct 12 17:24:01 debian kernel:  ? exit_to_user_mode_prepare+0x40/0x1e0
> Oct 12 17:24:01 debian kernel:  ? handle_mm_fault+0xdb/0x2d0
> Oct 12 17:24:01 debian kernel:  ? do_user_addr_fault+0x1b0/0x550
> Oct 12 17:24:01 debian kernel:  ? exit_to_user_mode_prepare+0x40/0x1e0
> Oct 12 17:24:01 debian kernel:  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> Oct 12 17:24:01 debian kernel: RIP: 0033:0x7f797d75a349
> Oct 12 17:24:01 debian kernel: RSP: 002b:00007fff37f0d3c8 EFLAGS: 0000024=
6 ORIG_RAX: 00000000000000e7
> Oct 12 17:24:01 debian kernel: RAX: ffffffffffffffda RBX: 00007f797d8549e=
0 RCX: 00007f797d75a349
> Oct 12 17:24:01 debian kernel: RDX: 000000000000003c RSI: 00000000000000e=
7 RDI: 0000000000000000
> Oct 12 17:24:01 debian kernel: RBP: 0000000000000000 R08: fffffffffffffe9=
8 R09: 00007fff37f0d2df
> Oct 12 17:24:01 debian kernel: R10: 00007fff37f0d240 R11: 000000000000024=
6 R12: 00007f797d8549e0
> Oct 12 17:24:01 debian kernel: R13: 00007f797d85a2e0 R14: 000000000000000=
2 R15: 00007f797d85a2c8
> Oct 12 17:24:01 debian kernel:  </TASK>
>=20
> It reproduces fairly easily during a kernel build...
>=20
> It doesn't sound like the same issue you're pointing out, right Lorenzo?

It could be.  I suspect there has been a change recently that has
made the bug possible - although, I've not put effort into finding out
yet if that is true.  If the bug existed for a long time (probably since
I fixed the live locking issue in 6.4 that was backported), then you
could be hitting it.

It is a single line fix.  If it happens frequently enough, you could try
it - this fix will go through the backporting route once it lands.

Although, I am not sure it has much to do with the maple tree as I don't
think anyone should have the mm to take the mmap write lock.  If we were
stuck in the maple tree somehow, the mm wouldn't reach the exit_mmap()
path - unless I missed something?

If you can dump the running tasks when you hit it, we could get a clue
from the (probably numerous) backtraces?

Thanks,
Liam

