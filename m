Return-Path: <linux-kernel+bounces-553939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B027EA590ED
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38AF77A2E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10B1225A59;
	Mon, 10 Mar 2025 10:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S9xku10Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XsuDQgbw"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE8621D5A0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741601983; cv=fail; b=SUX86R31BwFhOhCm5BU4erZ7SCJXN5ob0tXuPTr/O6R/ruLGboJmYJLoJS2Mc1L/8Ms1J2DcSMa5NC65qdrFJW+Al5qGFvQAwwcqR9wIfXHSoZq2XL06tAzlIbEXKEPact/NHYpSX33W19bkal4OQpkv8b4IKd3C7QBy1GKdmyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741601983; c=relaxed/simple;
	bh=Hndr70ykioKwQnfVdo8bpTPI8p+QmvdH158XH1dVZrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fP9Bl9L8pJaZOpHVt1UJHbiGZQPk204qb+eI59HR0DMhT05CEgIEjG843rpsZ8Izac0k7ZrJd/1UwrdpPxng4Thlju9n/ouDWA9B/LpHTSIeHav8Z/9/xeWalp4qrl4MOO61PsLVUhdmE21tyBH2Pln6SWXB1okB11eOZOl6PWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S9xku10Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XsuDQgbw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A9Bddh001849;
	Mon, 10 Mar 2025 10:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=gRwi1uvY3YzuksiBO0
	9vp4+0WMEXxWVrJkOs+IeQ+5s=; b=S9xku10ZxDKojZYtK+8gqdLbQBGvyWW7cs
	Ji79i4YHKASLADL0QnzOF0FcSiAdQ7tmg14VAkmCB3YJ4z50DGvepS0gs22u6RnM
	24DlIP1QXMgnC29t4D4bmeEMq8RESxrj0iQVmoTE4QTy1VT1FU/qxqHubaby37++
	67bekQiLlAIKQEKF03HhO6jXYRkEwXcJShAen/i88kFkxecOa3sl+InZKn4LcYsC
	rsdhIon3pE+/giyCCfKYLQKSwEIQmPzxxBukqFBtwTKW0Q67M5TGc+Mh6oOT0mOg
	ZYXOq8imOFWfmXhoS7XW9W6Jj2TtCVPZZSwILqOC7xV2A5VFc51A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458cp328nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 10:19:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52A9863l017076;
	Mon, 10 Mar 2025 10:19:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458cbdmfvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 10:19:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2kpUKJZlUBMM9cHk22Ce3TgEiW+g26upLyIFHxKJPRMK0TNUW3/5hg/2DFMIXOA8QsyMgBPX+oHg73mcYJuH4dL0MQznT/BXqU60lAmAPM50H+T082LyT7Nf6N4PnCMEBQHNailfRDFPhl7IgAC1WBrspVGd+IKb3XOYHRps1ckODOWYze5RRV52FRNnxA/X3MYRI3MdCqdsM33r2NQkWXb2vyfxbXf47cBe+ghdI5zRBeBSmgsJE5gJz9B+VaK0HeLLf+2/cN3bx54Kefqx946Ii769znPYar6TAfgNsBevoAhR/EobwNN1XgshWYoeSgp1E5ykZIJHikGh5Cexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRwi1uvY3YzuksiBO09vp4+0WMEXxWVrJkOs+IeQ+5s=;
 b=lGEGmy32H0Pr9a1vvlgjpSKDcCHXubRIGfEp9Xuu97ju1A0HjmlFC4OQHLDVXeUA9HAIg5HX2jKmIHA4qXOIhOdxYuhazBCePM91wJrs9VsfE+4W9MdfmskG94auz6wppqsMSU5Ca2R8VzhdV5DLOS6/HsPrkUg2oJ7Wu1w9QYeJEoelvGjdhbTeOtw0QtEihzQ4+dlkG97nIlmSg3k095hBs3FhR4ERI+FtbiL87UXEf6QPZJb7EquXVVclFGbyKBL/LkasAsYOXRx9tIRGqLIT2T6cQX/ue3spmwUEx9itYdLhf+GzWXxn8rhmRNm16WQpc0lE5PisdShgIDLjvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRwi1uvY3YzuksiBO09vp4+0WMEXxWVrJkOs+IeQ+5s=;
 b=XsuDQgbwrpk/Ei4tYYi3zYFH7vkAgUqk72CRW24oP8wZfYPN5BqmiDO3Vl01APIwvxvuWEsdOE4A6tvNHPwkyBfsRYA0wpIlzF4APIhGJK4smHUFoNur3gtuteaPC8UGQGFBL5wDe5FrswrHiuyI1lLj2QH3M/H6+rZeWpPR3HE=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH7PR10MB6626.namprd10.prod.outlook.com (2603:10b6:510:209::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 10:19:20 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 10 Mar 2025
 10:19:19 +0000
Date: Mon, 10 Mar 2025 10:19:17 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>,
        oliver.sang@intel.com
Subject: Re: [PATCH v2 3/7] mm/mremap: introduce and use vma_remap_struct
 threaded state
Message-ID: <f3f1c8cb-b553-44b7-8c7d-7ac2e267f849@lucifer.local>
References: <cover.1741256580.git.lorenzo.stoakes@oracle.com>
 <1aeadc40d377fff8796b7c114cb0351c92a68f20.1741256580.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aeadc40d377fff8796b7c114cb0351c92a68f20.1741256580.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0194.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::19) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH7PR10MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fb68071-f04a-4cb9-3d33-08dd5fbd052f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lkxR9PZH/t8qUmcGQ/qIQHevyhHOxDbPkqmjV3uMxMKw0Fw8unw+/XrhEFkG?=
 =?us-ascii?Q?C1DWWkEFyvZdBhC8d4FVcH7Mp4QpbyMZXICXP00tQSJaj25RB3tfRyY2J5Ol?=
 =?us-ascii?Q?Zx2+3wP8ef1SSgCOTv13wQ9Vzys5qhzh1E+iNUmcFJjazbf/h0bKaoz3UavW?=
 =?us-ascii?Q?GHW7m5rCMfYWJoi3Xa+ZPAly2F6reCj2SufU7b8PDV5xGfXwHx6Q0gHdLH8s?=
 =?us-ascii?Q?dEkKmmWz1JgvS7Dlc9OU/XX1eqROF1EOoYFXPrxMxmdUHA7Lpmtu/1egZxpv?=
 =?us-ascii?Q?ui+adCJnEeFFYsPdg/cSzBFYC4ZXF5bxT6MLOyeSL9HvuUc24Yvj9/rKVg3H?=
 =?us-ascii?Q?5BU2vv9aM2wHoAoMEM/X56KotvJC+FZJX2o1UCQ55yZecT8MaKROfeYcCUKo?=
 =?us-ascii?Q?4KBo1S2dIhcQ6atD11KVwRAdGqixC0uszHspcpt5+Ba7Frl31a1fK2LfsWtc?=
 =?us-ascii?Q?Qj/UHJEljxDfpnBMaoaKQbBnEURJ2O+9kHI9Umy6eH7ykbs8tMtva/imQtQI?=
 =?us-ascii?Q?CViUyBm83BUPFNgneJhGdLyhx+d+RQS2virf5srtyV4MdBNIl6o6tTYPwhSZ?=
 =?us-ascii?Q?EnWgMwNsSOBSpxw/64GDPBVQLHgmZuvD4ULSFfBeKHE9AnCj6Byz78ldYyGl?=
 =?us-ascii?Q?sZ1bJOnjQt8zWTNymHaxT1imeFY8BEFZxzWJzxkK0QfjcaDWZTUbV/T3Y62g?=
 =?us-ascii?Q?5wHt83oE49hLSIFRwlaIGwn50YQjzUWTt0yNHJSEl6OnkrO7kzAwno0+2Lsx?=
 =?us-ascii?Q?jAWL/AK54Sfh4/+HXclcED0z1iKlgLpGN9f6IAzIDCqtInlyCvkLCqrlfWhJ?=
 =?us-ascii?Q?U11kmwYUn6wINeEGW2qI5gmAQ3FdyZnnbLT4LmhQ5f+zv3SzbGMH8UwKR2yD?=
 =?us-ascii?Q?gca1AzM2LWP5aMivh3mOC6N8DxIoJUmtQNFMtj0/ESlu+7RDtDCNMsp4iS5I?=
 =?us-ascii?Q?KzMbIn+RsNcuVvpY8pE7CzLroP7f7dXqd70kP1BvWwSPSwFlhwxNCNBegdGh?=
 =?us-ascii?Q?RJRH+TWFFfzhJVyfxVNO+XvglbQEu4Avahfz2XiGOJcGYp2MK+Z8LTl5B0IG?=
 =?us-ascii?Q?V/MecDkOosrZy/cjX/+7+1ZJ6VK0gUDceCn36J+mlZa1qZflG7xvgYdvWIbH?=
 =?us-ascii?Q?FAYRp0tJbppTi0Rru/gmMZvQvT45C5nUbOx0agvabps8EldXHEjmKQ3KMK0b?=
 =?us-ascii?Q?Y4QjC0SVn4B+wNjpBNmLPL3wbA+fLDZUifNOOP+q5xybREiBhEuHiZY61is2?=
 =?us-ascii?Q?ouGxFtoS73cAg0XvM7KZclozcd8tYHEZcHWxpbGPtjtsX0QvIdlPWd7cwe7O?=
 =?us-ascii?Q?KsX6u/TRJVAvZK0FDkAeeUDyxkgFkA7D5tiSjzL2fTqawIL3LgGs19pYUFJQ?=
 =?us-ascii?Q?g8zrKUDQ7u4eMn+klcO+x+9ghzoo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DYdvBheigjhJrzWIgjZ8Uid4wLr94V1LuUxy+cTAnmXetBE8XB85rwVf1pZ8?=
 =?us-ascii?Q?l/TeQqkBNkaFbnUUs0bsRp9bdBrUuqzbo4Nci/LnlAOuRPddJd8+gZ2K9EcY?=
 =?us-ascii?Q?+qAYoV245h/9HsaVJPQWN0s9PK12lD3/us49e/kCOu9oQm8Oqcr2wb0LHgUp?=
 =?us-ascii?Q?S4pfff3JqIxcPIBIoZG/A3Ux/Z1NF5Pz8A2uIKNFTotsLE2bhS4ZhGF9EP97?=
 =?us-ascii?Q?TTCezCt1p8VXavq4DFGHPuMcMPn/OZaNeGzBzGTL4RL/Sn6Thwolkomzd/Mt?=
 =?us-ascii?Q?31vnuW2i2OR0v+6tMrwZmiFXsAtEBrqg1f3ImydTRbVYCJikyoQL/bcTcJN1?=
 =?us-ascii?Q?cN6k1nsqD70Fjm+aQQQOnn7HOLuvOaC1+O4DFIK0hApYnWWawteQH+ZdwJ5y?=
 =?us-ascii?Q?slHbhkFyI34nt99ihBVgrFgXMC2j7i4tdY5SdT03DzhWwAzp83iF6rdh370i?=
 =?us-ascii?Q?7tXQpMThVyvSd70ycgHiXkqbWobjNYaExVnC1ktfHJqGSgaHMiWylOT6HpLM?=
 =?us-ascii?Q?mG0fJdH4mrNgRAZzZwo0WkfWgD+x3NNyiQBCveTI8Ow5dkXixsQrbnRImz+3?=
 =?us-ascii?Q?oqc6ddu3Vz2dQSgKkN+JHYlhCVUykcDyhXVWZNTkfx22Mmvr2XmhEG9aN+/c?=
 =?us-ascii?Q?dm1vhmeQlE+LuduTI+MOKwgztMUw+aq2mZRSZHft7Kt/R7y1CMZFw4YxISpr?=
 =?us-ascii?Q?Ap5MfmD8eqrTgdNvcSwvhmuhCPdMtqiFa+3V0IoSXrXTHj4Lttjcrga6X9Cg?=
 =?us-ascii?Q?Ub+6Mmk8Gzjn63e58GMVJ9i29JTG3m8B1m2Jy0/RvTj31s9G7Q62nqMo7DIT?=
 =?us-ascii?Q?b2fPgR4lg8PybNusb5USQ7JaHNEb85m271a4dimERgmbeBdk5iQqep9XuNkS?=
 =?us-ascii?Q?/im9rQ8Mkr2VxEZ6lQYU5eMiJxDQf+g5eW7vf+pay4yUVOAsIY9GjgmKXgGI?=
 =?us-ascii?Q?iuEojK3ltSR8KOvx1zwm6lLm/QBn0zSA1MEsrQk0bWRcHtrnstTo5JoO46xg?=
 =?us-ascii?Q?mwZlbwihYsG3M6+3JneAn8HXY4iqDRC1geenMILX6s0bXuwvLpRqmvcvEPwg?=
 =?us-ascii?Q?QdAa6hkNcxcOt61dlr8gM2VTo8eTNv2vBZ77c/hffWtW80edmLsCHSHx58kS?=
 =?us-ascii?Q?qn7TVnBebhw04c5oIz6K2NliEL65+uVVpkAHOHHCBnFudn9ZMOZEleWuzAF+?=
 =?us-ascii?Q?AW34k4tKQ/+j0I5BpCj75//L24bfCjf+HAnrr7CQAGNKEN0wdKvaNPBrGI6V?=
 =?us-ascii?Q?eOEBy/TYjRfzBpC7ICwBOCmucQ0Neqn+cOI95aUAGF3C3hu3yHts7QyyyjgW?=
 =?us-ascii?Q?NQnvtC3io/iFGwxOjjVtP7YJxIq6blFT2+dF1Fa9oojMf4646+OeECshst7F?=
 =?us-ascii?Q?HyTA4X6Zl/Edh/vOHmB+WARiobXF8faei6cVdQjtKcup9Db4UdFaLX1yE5k1?=
 =?us-ascii?Q?s/O9Yp06zDndHgv8wocJC02gVAjn7gK7klmtzMUE4/YYoQXAj0gUs8peXGJC?=
 =?us-ascii?Q?5BeomXzABZQ3FIG5QWVNKHCXZoLHlAO79+nADNYITXza1REZYZfJHYYgJ6nl?=
 =?us-ascii?Q?W/wUikj+NU0Ag1SoxoXgCWZ4PgbVfPzS8tSVjG3tsGIQfGj03ypgA5vXrg2I?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Zqt6n5rERoi1txCrFt/7GRfG4ryI8Z87AspFPhhdJFRaWoJz+Wad5psNV5V4Hw9xgblFeuTxs9ca0fj8zN41YrAoGSk9LQ12eIviFvl63ZvHfJEpMS5tgrtL3DGLcg472u7xYFyLABKOCm2HuY17nF2BSE7odDrTxTim55OXEzeXSSRwd8h+xw6m4HpvcvayXaiod/wNFw3c9HB2w6X0EZpPLMQsGb5FpRU4WWmJ5cYgNFvXsJETd3oYQ0pj2ZZsOxy1XKOYYHm3R7gECWuVy+WDPmxP8KeXJYvgRNNXtxBpHnwUtZv+QEOHBc87YsikwYkSLhbhgokT7mFlPCCU51PbVbya+4Vgd83QvZ2fU30EBrZ2RACLu3rbeVJR20TJPoRNkvf/uTtds87hlLGzHXo0BWb2+doixvnbfHUMLM2ulyv+LMDhtr85+A5XCV/06yjIMklkQi8E50e8NYnhE920v8ypKuFv0z6DyocNB6+Rh/whwwdtuP7Y/bqflugtI2DXcZHodUJsfDORqI/SyWFTZGuPKaYA6HPU2IPRuJOxA9QbsaPRCQHdC/vtt5V270wlVkAAdiCR1oFpO2sY5LK+ABRrE9h4HRzm+UMR+hg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb68071-f04a-4cb9-3d33-08dd5fbd052f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 10:19:19.8813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDN0WKRkRwJ7kyZaMKai6b8Gknuhxpyyt7CFVNyMh+Q1g+H/6Gl+brGZN6jLfs0MEefBTJ7Kaa6wtCGJEGU/x1dLiAf2lH06d1iG8gHMBnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6626
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_04,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100081
X-Proofpoint-GUID: To7RlPn9VTaDgS0f97Ja7-4WLuBFbQAC
X-Proofpoint-ORIG-GUID: To7RlPn9VTaDgS0f97Ja7-4WLuBFbQAC

On Thu, Mar 06, 2025 at 10:33:59AM +0000, Lorenzo Stoakes wrote:
> A number of mremap() calls both pass around and modify a large number of
> parameters, making the code less readable and often repeatedly having to
> determine things such as VMA, size delta, and more.

[snip]

Hi Andrew,

I have a small fixpatch to address a corner case below, please apply!

I have checked locally and this applies cleanly at this patch and causes no
merge conflicts when subsequent patches are applied on top.

Thanks, Lorenzo

----8<----
From 14a22fa872e19b468b6d06c15205efe77e460ce4 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Mon, 10 Mar 2025 10:13:17 +0000
Subject: [PATCH] always check if !vma

We perform VMA lookup in a couple more places which, in theory, can
unexpectedly fail to find a VMA.

In these cases, correctly indicate failure.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202503101328.442cc724-lkp@intel.com
---
 mm/mremap.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 0ab0c88072a0..af022e3b89e2 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1066,10 +1066,13 @@ static unsigned long shrink_vma(struct vma_remap_struct *vrm,
 	 * replace the invalidated VMA with the one that may have now been
 	 * split.
 	 */
-	if (drop_lock)
+	if (drop_lock) {
 		vrm->mmap_locked = false;
-	else
+	} else {
 		vrm->vma = vma_lookup(mm, vrm->addr);
+		if (!vrm->vma)
+			return -EFAULT;
+	}

 	return 0;
 }
@@ -1108,6 +1111,8 @@ static unsigned long mremap_to(struct vma_remap_struct *vrm)
 		 * this can invalidate the old VMA. Reset.
 		 */
 		vrm->vma = vma_lookup(mm, vrm->addr);
+		if (!vrm->vma)
+			return -EFAULT;
 	}

 	if (vrm->remap_type == MREMAP_SHRINK) {
--
2.48.1

