Return-Path: <linux-kernel+bounces-407814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF92A9C74AC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6CC1F25D10
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068CD201039;
	Wed, 13 Nov 2024 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Br8yg6FB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Krf6qxoT"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B40D7E575
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509046; cv=fail; b=ZsVCcFdyl4pINAcugQER4YSiBjUuWh+8T3URn4A+SX0RSqQmtbJIv/iVWB7eSmTgmaC/8oFN204uP2ulD8uDnG6Y5WQ+Kzj2mjPTVztYYqIX9imwpKLi/Tr2X15pGfCKm5baUMsCQfp3pjC/BIr0kJyiGSKOAFNOgfz61/Cf6ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509046; c=relaxed/simple;
	bh=r/hHczs8uJU2EIvKqD6gpJnbGrNgOCxDdDpJJMmddQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cnI167PRDG5IsxXpf3fD+v7eVOVRDay8f08bDd8xZeNcc1R6fIKgDjXuBwWIAbNfgq0pAiGn8+s/tuPaBV6V1VggvTrUgmuItO5PsN4uHcY4yQ6+IOuZslOWpubiDY1/YkDRBtQuFP/NE++g0jWzidHUT4usQoiNIMfbzrTrENU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Br8yg6FB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Krf6qxoT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDXZFe027314;
	Wed, 13 Nov 2024 14:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=OTeaYRmhmkwQSeI+Qr
	oPFn2lsPyNYYV3UD86YEwsatE=; b=Br8yg6FBm9d3R0DJK7bEsBK0zknmfHPtFL
	yqhRUiQqFYFND3pk6wogmCcFzPOWcYEBtIuUrMzyp1sg3Zg5R7BkQuFZkKnaVrRr
	AHCDYuMp4YuN0cu1E6FmX9WIbGDr+PJN6UE6eT60LWKFU0lyjKO+jc7xw7/XXqcI
	KBeur1sGaBacIYvTlruFG56cgmfJCNy0knXpdOythuOOXYaC5r8xf4a8AzFmvl6q
	oDOUD2sifWqmYTFCN4QhDFYO5D6xqLO6uHvnlmXkCfvJtvsQzmy1DPt0NY6BFEta
	yV+0vv/FLNYRlnESxD07DnPeimrDrbWAylOj+A2I6I2baDtRUZZQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kby3e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 14:43:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADEEW7o035872;
	Wed, 13 Nov 2024 14:43:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx69ddan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 14:43:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMXHpZlm4xbfFAwyMwM6igaYd21fpApRR4gV7PMxk9sEwjb03I/oywFE+bOy5+QEBowxc6HNk8e35KcF2GqKqyGA3sSRmGZ2Opkiffk+KaexdRla6UZ3k1H+9WR0FombYl66jnBGUi9Q2/k87KEz8zIIr0e7x3L6cuck+l8pKHC3vm2f0HdI54QFgpaY3zTVoFFBspPLqOnQIVz018pFOfs6KZGXf1p5y2ENqolTKFr4TOjhPn/mGr5nq1LvVKqtNcxvcNBil2ssQEKBWeqTSziMOBnW6YFp/6blgDx365d0mZWqtaEHnjvImC6OrqDu5VUz8M3sr4BpzZFXh4qq5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTeaYRmhmkwQSeI+QroPFn2lsPyNYYV3UD86YEwsatE=;
 b=J7WOe51RyAbvnggEMD3i9Q6IOu62isx9yTLZjHF1e5emE5sxD0+1kT7hbwK2nNP4WEGh6ZzRhhd/DpOvG/XhrOYTg9IqSTmrItWaEfXtudkn5fVIZnT9S0wQrI6JgUJ7EsjO0r+5O0QLK+7P7No7um8QI9QsidjN75A+eaRfus710SOQyPmmB8VXOLhgUOcfTFBfDmgvUPhAvOYeBN0sqAI4OkVrYMmaERVbWwnWZ5DFp48KcM22HCdXSAAVQ54ujwbf9XxG723lkPu0aaFATZimW/66PA2w74z77C8OSkM2GhoYQvSSM8PS5YLz8yfQowrvRL8csoVcWuj/jJqD9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTeaYRmhmkwQSeI+QroPFn2lsPyNYYV3UD86YEwsatE=;
 b=Krf6qxoTuVteMSEBmvKj6FRLe6bE2VPyhBOcaPvVYY6soJotqhLbi2ZdnKPRQYyEc/v0yjiHbeaFbJBWqiTIU8RWKalMY7bm4AL0WsnHOvIv+7d7cxtvWXFJTwneEDDtC2awInrKfW3DAvwBcB/tqkCIa2eipgfaqN2sNu0HDq8=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH3PR10MB6740.namprd10.prod.outlook.com (2603:10b6:610:144::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 14:43:16 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 14:43:10 +0000
Date: Wed, 13 Nov 2024 14:43:07 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com,
        oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com,
        peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net,
        paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com,
        hdanton@sina.com, hughd@google.com, minchan@google.com,
        jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 3/5] mm: mark vma as detached until it's added into
 vma tree
Message-ID: <b912f9fa-24eb-4abb-bd9c-ac0a14740847@lucifer.local>
References: <20241112194635.444146-1-surenb@google.com>
 <20241112194635.444146-4-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112194635.444146-4-surenb@google.com>
X-ClientProxiedBy: LO4P265CA0147.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::20) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH3PR10MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d23052-40b2-4b32-ca06-08dd03f17e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YG6j0aOmd2LvXEUfVaGGDHKKutJS+N9xF5w5bwG69PDWiXhkv3xo4X+XagJ+?=
 =?us-ascii?Q?X4Rf7DmPziVRANviDfyNk0Q4yP2x2KvdQCs0nhD94wUsexo94ZDm+IBdvgWS?=
 =?us-ascii?Q?iJLqvcTG7Hwfb3++uh8dM2hrorH4D68NYg0yLgaa4HZQmNskCipJ5Gkurtmi?=
 =?us-ascii?Q?HMOjBno0ppat0+OoJx+MKjeKRGQ/D1Lh3J0MKcFhajVu7MmM6C0vxym+Ewsc?=
 =?us-ascii?Q?80mIZgTqb8dWDeK3sxf+3lUaL/sfxumM+652oaSSBJnpxKm2XDcCBeGdFIKh?=
 =?us-ascii?Q?u9XZYsWIxYjIi5/HsQ4a1KviLtXuZU3733cN/Ht+ZTT/RLOQ8KWzcRd0JTUS?=
 =?us-ascii?Q?w4mu/5OJ0BPQrubVSNZwAfyhlHyChXVkxUXNCE410uvDD9v1VZUzk+835gEp?=
 =?us-ascii?Q?ebC5scOFwM0iUqIgoOKVO2A4q3SGIk9QdxA+9pleH90N0Yy1YKXyK9a4duaw?=
 =?us-ascii?Q?EHeTDig14q0Xp6h2qcZTtolImco2TVc1TriBjssJ9Mj+06dk6I80dtqwfox7?=
 =?us-ascii?Q?wjzghK/eAD+tg1Z+dloQmtCoI6zXabE4Uba7qRmrXEQBSf2k/WiYukxc4Sk7?=
 =?us-ascii?Q?iZafBwslznf+C1Usj+N7vuhjIAd7/YPhZIgibBlqKFD4MAYbBWsuiMZsN0jq?=
 =?us-ascii?Q?N7er+mm1APYqS3QETus5WBwLwhPEMPUMnOltgxkQYXZ+ZI0jbnMdaj9TRraM?=
 =?us-ascii?Q?cdYvnqEwRGghOmm2xP5uE2gLnrsjACcl8suy4tdlPGqSIjjJ/r81qGKF+3tT?=
 =?us-ascii?Q?40fgfD7g6zPAgArPCN6xZexA+H9mCY7Chth2FJLIk1oHb6RfkKDopTAFuF0T?=
 =?us-ascii?Q?odi3VA0t2+4uTXliMUh2nJOzSSTXwGr1Choetq6U+OkMWRNOAh3pCzifseK7?=
 =?us-ascii?Q?0qiMIluJqerKzqm2a62N/OPpLkDBLQ7cNKanssFnqXDMBj0hkRRSbdbipzYr?=
 =?us-ascii?Q?qwB883pw1SqydaizCJBo855sx+5X7tEmqgNwA0JXuV4wXKq3Rsw782Xen6xg?=
 =?us-ascii?Q?tE9RA+xugePOr6qYkJAIjB4KIlAI499Oe6Rz8jGZ9Xnh18up9sD1K/DWpcHp?=
 =?us-ascii?Q?XRAdog5vqcy20geznOKndQ388Df3a1Szhu63lCe3sILpKkAk7PFkdlzZHitM?=
 =?us-ascii?Q?fzFkPCXgcoWdqMKX2kJgRn2WUAx4p6dqwx/1mfd2lapgsL7CMyuXME721j39?=
 =?us-ascii?Q?uXMxxWy0Q8eQd9TPnb/Ze6PQaAD072kxunq3sEh3fS3tSZ34VtDpQZWShsCQ?=
 =?us-ascii?Q?ZyYtjkBWTuJpkjA58lLP/noSWBZbrmKnyppbP6ScOix3Ps3DpHCcCuHpk1Zl?=
 =?us-ascii?Q?/S86eTEhgNY5mDV6FfxlFufO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?73wNPs2lqsDTu7x7a857L4Sft7hKgx+O9dALchn5t44pT2cIgR2ryZctr+ML?=
 =?us-ascii?Q?FpTOM3JTH0bMo7pCu0Hk9AicUvh2Idb4Hg9x+K6kkieQm30bxhUhs5wEKJgP?=
 =?us-ascii?Q?8dCgRzOrA7UjS1jidcxPSmr2g+HSCuLWYDfe4uzPkmnSd31NPNopoZOXibg9?=
 =?us-ascii?Q?cnWJ5hzMNiIHPvjIFe0iGWFfkSilPgrQXgPGGhZIPWHCrtzXqctEyH5qRteo?=
 =?us-ascii?Q?0Vej+sXpak8HuVPbFh+NmolDuvtBfYd/IdiAN++JM4dPMZ66rjVAhbcT0w4h?=
 =?us-ascii?Q?qe7hqcOe+5QxVDkQxw/JRpWNtgJgBiD2jjSBH9E8t4CFz/v4GsA5QtHuNNWb?=
 =?us-ascii?Q?gZa+g9LPGmiMsgdO1XBSmK1ciuh8TaNa3tcJVMoMLgX/m7bTxHJOEIbDW0Hi?=
 =?us-ascii?Q?ZqwBFPeFUtthU7BdZt765PUVeLHNo9T4aU7pIRkt+HUvw3C2AOuPi2LAyvao?=
 =?us-ascii?Q?Mt2ioLgtPQZhjlLa/iZPQwEtzfZaUCl7f66uepFyfOYdEF7Z9XlMBECZTf+g?=
 =?us-ascii?Q?oltGzl/7nwvDiUfmfVbIYB/aMNGbMr93EvDOiTYzzGuA6WHr4RB7zQTq3WiC?=
 =?us-ascii?Q?7TPL28oZ6e933thBmL9zR5oqmXs3NylvHurcvSgaYBIL1CVX8EaNZKgULvoN?=
 =?us-ascii?Q?qehQb5raUAf0hxseEIN/6BmNsg04hleXazxsIpDPecYdIT0ujjrQtJOK8PUG?=
 =?us-ascii?Q?6apypTO6xDB4Saysmuopv1lz7aKZ2C3s9HXottvPOd7lz5Xcd0Yn0CYJ87t/?=
 =?us-ascii?Q?vxN8T6cLeZtOgM811pGRXO2nhboSGiZgV5pElTe8hdIQ3iS0bJkARik2jOtd?=
 =?us-ascii?Q?r80Z3OL47QDcXZT7uIGI4vglN2AaMWSMnf4++fjbVWKdnev5dm+4ntXytfJZ?=
 =?us-ascii?Q?fAh1RsIvND7WBxyjvOZdj7kta+hcqIf/xBYsR39smguWhr2yVyFsBUF+dHVY?=
 =?us-ascii?Q?Nbml28u1qqLQQKh3f/e22r5qob9130SYm1HW3yXtw6QdbM8f2fwj8BK6Nfwh?=
 =?us-ascii?Q?c1jPaScCdgU4GzUL5OdBZoGeNne4+XGC7WtuBbRs/F2vn7IkNxg2lpyBCoj2?=
 =?us-ascii?Q?PwSOZ8qGHvMXcpYAp5xDQup/S4zDDzr3zERd6fssRKKDYJXUQyyXMdB+8+1m?=
 =?us-ascii?Q?LZtAXajb7H+aWHyt0cEgxiZaE/qsaJr25/0RW55K5ygCo9wIxTQLRyye28Ze?=
 =?us-ascii?Q?zCpfy7m6cG2tzPHDADY9MABXigVJ/1PTFpfTHjNTjrTMxe1/GaPn/dql+m/3?=
 =?us-ascii?Q?nkL/DI4zQ/NIjWp3mNpG/XTv2jQKpc6sPNp9L7ChZ85qRWEJBAocGIYg2gVU?=
 =?us-ascii?Q?KBqKxug62lZyo+6Xv69UEMWUKLR3x6wFC2biZZeq54VJGxn+oZpgSjve4Wpr?=
 =?us-ascii?Q?t/yt3mn3s3rxMypvFlHMo8Bjv4ORjzTdlFkszCV8r2yOJSp13nbndOtmgB4F?=
 =?us-ascii?Q?7l6R4xVCIWXfvAiOf0CHSBLO7fcxEzbbGHBaM9fIFxguDLEAbm4FdIyeYFa3?=
 =?us-ascii?Q?cKEK/4Py+2AJ4ifrO5tW+mTQ4Te+xGoqPcrs6qXZNrFKEjhuyaNQ1RyDbb/l?=
 =?us-ascii?Q?5alNa7xILgW6NWaz8bgO/NsLhYuhtw9+xjQaRFTbgGUShKV8Mt6q21d36JAq?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7Ye2gSUHfs7aRGXqOKJ3Rv31AIs1m/h/l1ltJ97zfT3as+ImgEj2wa58rizs8jMsy/ripPv3AAKbyDH2Bn1snYQ7yW4Q+C5gVstqzLLjmaY4l+anrckSpnZnlE3T/aVUad7j+f6pAABRMzZnO7rUAVtFKmGvm+sOv7ayFjylFGu3yaMd+OjHV1fMVbCDJel54GCt+HjLx2UYS43z8bfrz8ibGbrIQ/fC/z772sLzpsLvRpCoddGcKeB1JUdsuQD9dNO9TLLyjUfn2pEzCZa/3kUk9SlQ0nw4DJWm4BhK9ZWbRBETerbKue0X2JAyrMCq4XL+Qx615rSc4Tvp4b3LhtGyC4r2DSR6GhEfJRozCnMdoPJfm7esWqBPhUqeioXgZCnNiilzwiWlCWUCAbd221y1nC40Cf00aJmemXRaJ9CbSuPaT9OBYymc8V7dsqK2YxU8KRTOIA2Bui/CmpqWuiy0IdUvhNWUD2RN2+VsXYbST8pGXpLncgU7+ocUbZZGRjO7E8r1QKF8sSJmU7G5lOzSzrX3PUw5wWq/GNrK/XqTxVhonW/Fm3YOEHcJT/vZw+l1VntM3r3kYK688AMoiJMDws1ISXg++CwgzyssMmc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d23052-40b2-4b32-ca06-08dd03f17e7f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 14:43:10.3175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMN9UGAFQcLe+pWiACgL8FduBiOUW8W/ud6mI3A9KzeQkwUk8vePf9pTipoLRuebEHaKLcr542q8etYjwskLghpMRWsfdjwjX8cM8ym7u9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6740
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_08,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411130124
X-Proofpoint-GUID: IKQbEJMTdZgriHfjqJVbchdzapgtU8cu
X-Proofpoint-ORIG-GUID: IKQbEJMTdZgriHfjqJVbchdzapgtU8cu

On Tue, Nov 12, 2024 at 11:46:33AM -0800, Suren Baghdasaryan wrote:
> Current implementation does not set detached flag when a VMA is first
> allocated. This does not represent the real state of the VMA, which is
> detached until it is added into mm's VMA tree. Fix this by marking new
> VMAs as detached and resetting detached flag only after VMA is added
> into a tree.
>

This seems very sensible.

> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Aside from nits/refactoring suggestions below:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/mm.h               | 10 +++++++++-
>  mm/memory.c                      |  2 +-
>  mm/mmap.c                        |  2 ++
>  mm/nommu.c                       |  2 ++
>  mm/vma.c                         |  3 +++
>  tools/testing/vma/vma_internal.h |  3 ++-

Just want to say THANK YOU for taking the time to update the testing stubs :)
Much appreciated!

>  6 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a5eb0be3e351..245a85caf4c3 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -812,6 +812,11 @@ static inline void vma_mark_detached(struct vm_area_struct *vma, bool detached)
>  	vma->detached = detached;
>  }
>
> +static inline bool is_vma_detached(struct vm_area_struct *vma)
> +{
> +	return vma->detached;
> +}
> +
>  static inline void release_fault_lock(struct vm_fault *vmf)
>  {
>  	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> @@ -874,7 +879,10 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
>  	vma->vm_mm = mm;
>  	vma->vm_ops = &vma_dummy_vm_ops;
>  	INIT_LIST_HEAD(&vma->anon_vma_chain);
> -	vma_mark_detached(vma, false);

How did this work before? Oh I guess we initialised the VMA lock earlier right?

> +#ifdef CONFIG_PER_VMA_LOCK
> +	/* vma is not locked, can't use vma_mark_detached() */
> +	vma->detached = true;
> +#endif
>  	vma_numab_state_init(vma);
>  	vma_lock_init(vma);
>  }
> diff --git a/mm/memory.c b/mm/memory.c
> index 209885a4134f..d0197a0c0996 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -6279,7 +6279,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>  		goto inval;
>
>  	/* Check if the VMA got isolated after we found it */
> -	if (vma->detached) {
> +	if (is_vma_detached(vma)) {
>  		vma_end_read(vma);
>  		count_vm_vma_lock_event(VMA_LOCK_MISS);
>  		/* The area was replaced with another one */
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 386429f7db5a..1295c4cedaf4 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1570,6 +1570,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL))
>  		goto mas_store_fail;
>
> +	vma_mark_detached(vma, false);
>  	mm->map_count++;
>  	validate_mm(mm);
>  	ksm_add_vma(vma);
> @@ -1890,6 +1891,7 @@ static struct vm_area_struct *__install_special_mapping(
>  	if (ret)
>  		goto out;
>
> +	vma_mark_detached(vma, false);

similar to vma_iter_store() comment, maybe worht putting in insert_vm_struct()?

>  	vm_stat_account(mm, vma->vm_flags, len >> PAGE_SHIFT);
>
>  	perf_event_mmap(vma);
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 9cb6e99215e2..6afd5c2bd97d 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -1192,6 +1192,7 @@ unsigned long do_mmap(struct file *file,
>  	current->mm->map_count++;
>  	/* add the VMA to the tree */
>  	vma_iter_store(&vmi, vma);
> +	vma_mark_detached(vma, false);

Since we to seem always to do this with vma_iter_store() do we want to put this
there? Or maybe make a wrapper around the two if that seems not to separate
concerns enough?

>
>  	/* we flush the region from the icache only when the first executable
>  	 * mapping of it is made  */
> @@ -1357,6 +1358,7 @@ static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	setup_vma_to_mm(vma, mm);
>  	setup_vma_to_mm(new, mm);
>  	vma_iter_store(vmi, new);
> +	vma_mark_detached(new, false);
>  	mm->map_count++;
>  	return 0;
>
> diff --git a/mm/vma.c b/mm/vma.c
> index 8a454a7bbc80..1426871fa6e0 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -275,6 +275,7 @@ static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
>  		 * (it may either follow vma or precede it).
>  		 */
>  		vma_iter_store(vmi, vp->insert);
> +		vma_mark_detached(vp->insert, false);
>  		mm->map_count++;
>  	}
>
> @@ -1690,6 +1691,7 @@ int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
>
>  	vma_start_write(vma);
>  	vma_iter_store(&vmi, vma);
> +	vma_mark_detached(vma, false);
>  	vma_link_file(vma);
>  	mm->map_count++;
>  	validate_mm(mm);
> @@ -2369,6 +2371,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
>  	/* Lock the VMA since it is modified after insertion into VMA tree */
>  	vma_start_write(vma);
>  	vma_iter_store(vmi, vma);
> +	vma_mark_detached(vma, false);
>  	map->mm->map_count++;
>  	vma_link_file(vma);
>
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 1d9fc97b8e80..fdb60978821f 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -438,7 +438,8 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
>  	vma->vm_mm = mm;
>  	vma->vm_ops = &vma_dummy_vm_ops;
>  	INIT_LIST_HEAD(&vma->anon_vma_chain);
> -	vma_mark_detached(vma, false);
> +	/* vma is not locked, can't use vma_mark_detached() */
> +	vma->detached = true;

You're the best :)

>  }
>
>  static inline struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
> --
> 2.47.0.277.g8800431eea-goog
>

