Return-Path: <linux-kernel+bounces-407750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2009C72F2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A131F210CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595E4524B0;
	Wed, 13 Nov 2024 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Urbt7gmf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H1KNce5/"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689D4B676
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507109; cv=fail; b=lzaITxwrxjyAGlx0BUcN6RPmVjrDFte3QP1h3l7sRVlF0PxpxvgkP1kACE+sZVMaW9aNS0Ip+EljUgDfKsB/cybnHuMEe66P1V565cotvG2buJ6/8pgOqyYsU567Ezn/2EypUaYE/OST3noxmx++wNJIz5QtwgKAbBtB6YSFVYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507109; c=relaxed/simple;
	bh=xJUh6IGZygfQO8Zt35pqJDIX1zvtVGP6ZvIEYy5Hts0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CAcpikqmZ8azNNJ6WMZB8513c5TRC/bL5fKr49/4h7cIMlP7yBpyGtb7tEr/iD2nfW8e5oQXKi323UMr5miJFw8DjpB3urp2ZPle3DVPOOgaAszi1tvq5w/nxY0p6Ipo5Bb5+14pUcL4tFVwk0qgPfzezmYholcrEhP66z8v8iY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Urbt7gmf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H1KNce5/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDXWsu018897;
	Wed, 13 Nov 2024 14:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=TwaL94ygrGH03DPZvn
	dhWJgordWrKQPRgKdi55Y7ZsU=; b=Urbt7gmfkaXYZWaWlbzXx6cOgOrTxOvTdu
	qzV/InW2T1F3lpAHynA1oTXNzdfTBwJWjMY8E7PoL8iEHObpzdJOi0l0a4LJRqK+
	d12jkOLG5Q0VELrsz5T/2yydUja2SbXqMQ6mkbtKvIpxoUNbntjDAWhZm+b6nmj/
	D+qggZ5WZGG3lkOYoAYry4LRZaiuoTa/vSt0arYNxJ5VnFZppw8TNJ0/Z6anhf62
	jz2JW4caZyz0WZFT8m/2K2oVrcPNes/yyqjGmYQGv4gFdHWUqSiLP3kWj4vk6qy/
	Z3/1rtr9q3oHe1pR1TTa0K5pObPR1DCgSKy21bdCtWOLBiXp8DyQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0nwpwhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 14:10:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADCAJGP025914;
	Wed, 13 Nov 2024 14:10:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx69cebh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 14:10:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ot42b4yjXq7SPVl8f/ppgLltnyOAYAjelCXZYM01vPv0egviMPFoa0hCMIxV8llt/5tAvKqG5DlDWv2h3CZYKRScUDEAgP7PIvvVhB4wUiyN9XvFz81q8xIz0bRyErgwC8EyC/ndQQBzQmFED3NuxPgbsr8gNnswx9hcWy3wPcHXlAEhc7CIMvTBfbulCZFyjccHHqcbjsSQjL6Y8ZLNSjgtgEwKNO5d1T6/dIjFd/rGOc4AXzr+TOl+VWE3QqESHbd8e1Bpxqs04h7G/rznqb//S2yqbC8QAXLaLHx2BXrxzIC3xLJCRfh0GxGUaM92vavsMwwAdsA5g3O4+uM7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwaL94ygrGH03DPZvndhWJgordWrKQPRgKdi55Y7ZsU=;
 b=Sh+3ZcJH4P8RKSxPvMTAPz8k2VrSdfaOvI7UzpdyW4sbtiIk4VQnKxLEla+F4xF8dPQ+WVX1NIvlOL+oRrZc9trkrxafD3WzrXELDx4MrBukOBSVMEPL6vhjR0TyDXOGMMDb9aMR3S0ZPeRUt8AsxJMkV+HSBZhjLudD3vpVk/ARIq//rY8g9lfFJBff11H8yz20IO2i7svmgCVZ8f5WpzI/pNcZA1uJad2Z/Kr6seuxQNXofvcoOJ9h2eK/a+bbrrk3wrrxvn4XQEEZiEH1njRMvnL64eaZDcRqYO+K6FBvvkkduutuxOBZTVkN5fEtO1UkGmTCJ57RzfAZHUiOiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwaL94ygrGH03DPZvndhWJgordWrKQPRgKdi55Y7ZsU=;
 b=H1KNce5/T24hl+WGref7L1WdoPXytQqM/wAX7cRVS2fdtHDjGQgWYRmTlTNPpxfVjKKJcBLegztB6P0lyVZ4yNmoEPQSMeg9smtLJAhAGeEBYM4UcLJEAALKrZ8x8sXmbVIF4pxoONkv4BYsdd+iPmV8Dah6xpcfZrYqtSZVYg0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MW6PR10MB7616.namprd10.prod.outlook.com (2603:10b6:303:249::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 14:10:47 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 14:10:47 +0000
Date: Wed, 13 Nov 2024 14:10:44 +0000
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
Subject: Re: [PATCH v2 1/5] mm: introduce vma_start_read_locked{_nested}
 helpers
Message-ID: <16442026-5237-4dcd-9343-99a242ddb7a7@lucifer.local>
References: <20241112194635.444146-1-surenb@google.com>
 <20241112194635.444146-2-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112194635.444146-2-surenb@google.com>
X-ClientProxiedBy: LO6P123CA0058.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MW6PR10MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: 06423d8b-fa53-4a5c-0ff4-08dd03ecf836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gpNYooxv/5djkAfWBbYTKte15VyAMyQyJ+CMD4Mj+0YqR0MbHQTmjGMM9QUm?=
 =?us-ascii?Q?VHhROqr4f7Wsw63YveNUO6H2Oq+utMnuvoOwDSRyawDlC3M3hK3sVZkdabC7?=
 =?us-ascii?Q?JHED65zTYYi54LVwuXn5OPTTDtB+LptuVSXr0wTp4yJtlOkhowxcRFgJZ26j?=
 =?us-ascii?Q?4D1DlX7dKyunpz7RgIDGv3rLKo+P3ps3pgY/vhGL4JwyCoy6Poz6CLD6780b?=
 =?us-ascii?Q?uHfjnv0keJFgnPHM1Tq3+HKvmk0LjFEL0KbBMTDhPBCyIdB6YI/+lE4n/Hay?=
 =?us-ascii?Q?sRq6UGxzrgIGYY3HAsoWqcQLbMllWijva1qb9+e13b3z93Z/wsY3Qo+bEtc9?=
 =?us-ascii?Q?Z7dLXGXKiPG5Cd3SibX1SVJEY87bINmPtehkIbHv7fJN8m5zjwhp3wMdQHpO?=
 =?us-ascii?Q?NirfyxmGHxeoX2m39B4CqlO8HzEUv18z4e2W6dHFeRgzMKfXG+rS0CSF3olZ?=
 =?us-ascii?Q?xYaSAEK4bYUXkGb5AXbfT/N+BeaYh9J1+nPw5KxNAUpNGtGLA9DCnmZtF+f0?=
 =?us-ascii?Q?Llr1od8+aWxKkZ1e+902xubIUFt9OCfMPBnoECm5HW29TxbLZ5JQ1XwkDQ/m?=
 =?us-ascii?Q?44+vtP9eYMfVJPNSb/clGEaC8CDQ415ZNYQ9FEE3JhuCqOaJ014BHdJ6wJxh?=
 =?us-ascii?Q?KCT7pcwoDQw/yo7mksEmzISiyFSxnLAXO9W3jnc2mAqLmFpQSSDmkOl7e2Si?=
 =?us-ascii?Q?bloBk9oYaWGHvDwc0+ie6/NHMT1FqT6pU6S05as6eCC8rS0x8zdty1i3pmtH?=
 =?us-ascii?Q?97/i/rVZdM/kAHNzQ3wARBFZR6wkuywdXzxj5yM/YomncdYBWyNI1TSGcfth?=
 =?us-ascii?Q?fTkOTPxRuUcnf8/PumlLsJ3GOG/AA4FSUkBkwr0Mjobjvtz9FooV6Bqn9Lep?=
 =?us-ascii?Q?l7dLSHWYQNHg4Sy8+lL7YCFiBwCCVABjjMteekxjuCWrYAuBICCMwwWx05tf?=
 =?us-ascii?Q?JZUDIFsmYfxGf0bC2x5DI9z3nDVyz3saPc/fDFmvAAROpj8tAbYzPA/DA8Jy?=
 =?us-ascii?Q?3i9eIJthQpQmOlvzcNpytn5ctYGlz8i+hTlY/Kak4PUN10IWeU+Vg4dDAPlS?=
 =?us-ascii?Q?5NcsTuxdEIB6b4gM9lMDdgodE7E7GFC0hJF7l2k9PKp+hOjbtuiHosesZM7T?=
 =?us-ascii?Q?uuRewhXITc3mVN8av4nuOPCo2grijkyMsr1RVdQR9MUyZ/DwMiXkIn61/8Fx?=
 =?us-ascii?Q?ueKbjFzOR2tKbcDlQaVcfPN+U/SRyejRUpS4LR3COMZA2DnH3HQEkJ1N++mE?=
 =?us-ascii?Q?U1BFGmc1QZVrmwPLEQoX2n+h3uF3U+ehkWIC4XOVw0wRBOGtUGdsNwb+Xh2H?=
 =?us-ascii?Q?rK4wpqrrwjGnZTMFB1s7jkXo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qC/Xbe/1FbMDqKY7hkI4i1j0hqzK/jl//1sAGSammPDKqEDGLUaBr4y5+gtB?=
 =?us-ascii?Q?0WI7XN1H4t6XRi+0dz5BTXRxfst1UAuWfZZkioGvF+Mj9IhkfFEbuk9VQA/R?=
 =?us-ascii?Q?nB7I0wJICCK44RH84DB3thIXVuVqc/HRF7nDsqg4zcI2275JDfpa50+fGDk3?=
 =?us-ascii?Q?whM4GZC5ZfYLkPZS25TBAv/x68o6s6tMjGCQJ5HtYoaCq73BPFN3/iixasbS?=
 =?us-ascii?Q?PPwwSbJSrMYr7ywUwxiPGOpy9S1bleZuwS9haijV+yu/eI1NJAs6Wu3l3JKB?=
 =?us-ascii?Q?ZFVbVKqtOGVrzIaL38cq/ZGIyb9lQchlP4ulEboReKGgpJZ3njFeEP2KcPi1?=
 =?us-ascii?Q?b6UKhpbJK6HCK7W3/pHdiNgfp9BQ2885qULOcGOyF6WpYziBclkwe+pnpTfN?=
 =?us-ascii?Q?HCiLVrtezFTdn4ZII8C4yJtsvHAlqdBX3kY6EAIFpqN0O7WlntahhHajHW6/?=
 =?us-ascii?Q?+ixWIFzFy0el/QEgLdp1MwKzxiPxmGTbtAShHtIbhd8ktpuf14Ags3O2Hu0j?=
 =?us-ascii?Q?2liVOfhRwVWDJqDZpj5XLxvPdWzi7IqrLhE6qnK+tn437SrPztl1k69wKLtP?=
 =?us-ascii?Q?SZw6wqu10TWpuJ336Hfy1skMzcBiumszSpHBr0HJXQlZ0hx0pHaTjelciZ07?=
 =?us-ascii?Q?rgz3rzN7LS7EZ9IJAJlQpa0iFquWA0coV50auu5DTQpoREOQ4LQwYgBKCb5i?=
 =?us-ascii?Q?bL8K/0v2tFfFpeyebESfq/CRogmo06/adFNL9zMBevuRUbCOf17SDoyG68kl?=
 =?us-ascii?Q?BhSxOek1Ob/Fz/Slbz2veajTgiBmJ96Oq2SNW6xl0c4Sd6VSR18xGt3AveU7?=
 =?us-ascii?Q?p7WOotRGFT83K+LRaUFRiuDi8ONrVhuE1HVSUkVeXROijSM1iLL148vz/4/4?=
 =?us-ascii?Q?gHNszEIJoXWyhS6Bm9Iblr0ipI5O+d5Hotio1ExK1Rv5u4NwuDTTZB2antNP?=
 =?us-ascii?Q?ywmgl/LRzmjZOcDMF8ljZnfMX+Ijt107qs/9JH0XpBgE5GyRoEaPz+yd+Fg5?=
 =?us-ascii?Q?bOeHnCZpSip8xIlp3hoBvY7TCFrGeYDdcKNRk8DWWkZKODvyHu0pcBeWntHE?=
 =?us-ascii?Q?zs4SLxDQ2CtSvdCCYwRMl3hN+oXJTslvtAAjSrNfVIsRzZ9RccT1uTdCwi9b?=
 =?us-ascii?Q?EebW9DZhizJm387un9olXz1aUlf1bIdsor9UpYV1DF0Jtmvic1+DqiY4oIh0?=
 =?us-ascii?Q?tG+yO8aVz/DhAzrcR6zM/NEExNWuB5qQ40n5XbObgN5avhgeawAH978d4u/t?=
 =?us-ascii?Q?+xLsJjIZu9rF+zpjoP8b8Tac5PLhmnqPSvk0zzzpgqYcWLw5M+WJKoGd3Sy2?=
 =?us-ascii?Q?knlMFuaMpZuEs7px8mxBQUVZXziyU73+njcoW426DWB+R/PZ+Q2PUtrqnoG3?=
 =?us-ascii?Q?f6m8vlA02AloJL0AMZJdvmpZCYrX8dWCqFq89jU9ppj+v5GsMt9HesE8ziRt?=
 =?us-ascii?Q?W7JGBoZaL3uh9bnui1kj/ZtCPJLAdvIcGlc/q5QT3ckQEXTEPo08tOktcQuw?=
 =?us-ascii?Q?rkxFXx5Bd38UT8tNe+cERMEGS7gcL9fmBUxzWVVt2DXF1pSkgiyYn5S+lU5X?=
 =?us-ascii?Q?QPEzt78T4io3IEODo/sMeq1JOBF9cGXowkMBZ1g7Sw1dyEQbC2zXo021bPwj?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H1W/PpIQ64kKHErbAomEN7maKPdojw8+FcbBf3G4441jrduRYXx94zzAVIhbHPYY8te2V6Bq4qxEKyR11aOSJIHsPdpQbhnkI/io/MJboX0H3FNFHe4pZ5Q2k9/uZX196bwoBOBsrclRL/5vjSNB557Vv5nd+df0hir4uuTk9ksHheyYKTCa7YbjEYQyEhO6IE167oQD/Gx4eP64A3QIOvmwbFsad5lNW+RSAdVEdRL57jBC5CCyhM7hcgKiBuFLvSGGwO9hRoF7JEgsxeNDkFpXWZhfvyKQX9SZ6n9x/0QCwGn99dTvpqlbS6zsuFG1Cs6brUyukFTlcPb83HQq7TovmG84XD1XJeT16eRXtYf0OVpYNsc6jA7Tdo1GbYMezIE4SfPnXA7b/FXrOIrerBuKnliYRERjvaQCtO++Zxf2uZK+oSIaSNx8OpcgFAATOPEqUpwHDFStMYKI6k0R3CRXkSrj/+Qr3F1AxsbZWlWVVaneZ4McFNrhUdkRXto437vF4pF3pSLUfgaAXj8LrKT7d7z3GM6u50QYTVgKSgW3vu8IX5UaFzpfvCiIcoCXHiNF3noZZ8tZjA91ZcOcGb2Bv6DIg946xlTlICI+HXs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06423d8b-fa53-4a5c-0ff4-08dd03ecf836
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 14:10:47.0787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTclhp72Fw/+j8stpnHW8KkVBf/7JhyU6MxnrtTjtMypYGw2OLz5oGbw/qBtfbJF3fONc7cG/KPBeGZKMJUlWWRbwJOxUPnKe/SvGxrWp6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7616
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_09,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411130120
X-Proofpoint-GUID: 1bwrelQ4l-f6I4asVVjyvBsGexJwQwiB
X-Proofpoint-ORIG-GUID: 1bwrelQ4l-f6I4asVVjyvBsGexJwQwiB

On Tue, Nov 12, 2024 at 11:46:31AM -0800, Suren Baghdasaryan wrote:
> Introduce helper functions which can be used to read-lock a VMA when
> holding mmap_lock for read. Replace direct accesses to vma->vm_lock
> with these new helpers.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/mm.h | 20 ++++++++++++++++++++
>  mm/userfaultfd.c   | 14 ++++++--------
>  2 files changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index fecd47239fa9..01ce619f3d17 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -722,6 +722,26 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
>  	return true;
>  }
>
> +/*
> + * Use only while holding mmap_read_lock which guarantees that nobody can lock
> + * the vma for write (vma_start_write()) from under us.
> + */
> +static inline void vma_start_read_locked_nested(struct vm_area_struct *vma, int subclass)
> +{
> +	mmap_assert_locked(vma->vm_mm);
> +	down_read_nested(&vma->vm_lock->lock, subclass);
> +}
> +
> +/*
> + * Use only while holding mmap_read_lock which guarantees that nobody can lock
> + * the vma for write (vma_start_write()) from under us.
> + */
> +static inline void vma_start_read_locked(struct vm_area_struct *vma)
> +{
> +	mmap_assert_locked(vma->vm_mm);
> +	down_read(&vma->vm_lock->lock);
> +}

Hm, but why would we want to VMA read lock under mmap read lock again? mmap
read lock will exclude VMA writers so it seems sort of redundant to do
this, is it because callers expect to then release the mmap read lock
afterwards or something?

It feels like a quite specialist case that maybe is worth adding an
additional comment to because to me it seems entirely redundant - the whole
point of the VMA locks is to be able to avoid having to take an mmap lock
on read.

Something like 'while the intent of VMA read locks is to avoid having to
take mmap locks at all, there exist certain circumstances in which we would
need to hold the mmap read to begin with, and these helpers provide that
functionality'.

Also, I guess naming is hard, but _locked here strikes me as confusing as
I'd read this as if the locked refer to the VMA lock rather than the mmap
lock.

It also speaks to the need for some additional comment so nobody walks away
thinking they _must_ take a VMA read lock _as well as_ an mmap read lock
before reading from a VMA.

Again, naming, hard :>)

> +
>  static inline void vma_end_read(struct vm_area_struct *vma)
>  {
>  	rcu_read_lock(); /* keeps vma alive till the end of up_read */
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 60a0be33766f..55019c11b5a8 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -86,13 +86,11 @@ static struct vm_area_struct *uffd_lock_vma(struct mm_struct *mm,
>  	vma = find_vma_and_prepare_anon(mm, address);
>  	if (!IS_ERR(vma)) {
>  		/*
> +		 * While holding mmap_lock we can't fail
>  		 * We cannot use vma_start_read() as it may fail due to
> -		 * false locked (see comment in vma_start_read()). We
> -		 * can avoid that by directly locking vm_lock under
> -		 * mmap_lock, which guarantees that nobody can lock the
> -		 * vma for write (vma_start_write()) under us.
> +		 * false locked (see comment in vma_start_read()).

Nit but 'as it may fail due to false locked' reads strangely.

>  		 */
> -		down_read(&vma->vm_lock->lock);
> +		vma_start_read_locked(vma);

Do we even need this while gross 'this is an exception to the rule' comment now
we have new helpers?

Isn't it somewhat self-documenting now and uffd is no longer a special
snowflake?


>  	}
>
>  	mmap_read_unlock(mm);
> @@ -1480,10 +1478,10 @@ static int uffd_move_lock(struct mm_struct *mm,
>  		 * See comment in uffd_lock_vma() as to why not using
>  		 * vma_start_read() here.
>  		 */
> -		down_read(&(*dst_vmap)->vm_lock->lock);
> +		vma_start_read_locked(*dst_vmap);
>  		if (*dst_vmap != *src_vmap)
> -			down_read_nested(&(*src_vmap)->vm_lock->lock,
> -					 SINGLE_DEPTH_NESTING);
> +			vma_start_read_locked_nested(*src_vmap,
> +						SINGLE_DEPTH_NESTING);
>  	}
>  	mmap_read_unlock(mm);
>  	return err;
> --
> 2.47.0.277.g8800431eea-goog
>

