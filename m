Return-Path: <linux-kernel+bounces-361365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE1D99A73F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E0A1F23F38
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414821940A1;
	Fri, 11 Oct 2024 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZzTJayxl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mM9o+M88"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8449039FD6
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659549; cv=fail; b=iGZUfgSuTLK9khSBGf+3mbvGqK3zIsfa/aEChoniXDVBVX0+MsCJqtK/Z6x4mZsy8LJXfeFzgZSqfO7d2FQDMRf0MJduAVi4QtgEPnkKDe5AJ++bkm7FLLWwY4U9SK3DpBGBrjTliYi3qr3Nhygm3m72W4LOMk/ovh9W1If/wGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659549; c=relaxed/simple;
	bh=qTg8x2z8yi7+7EzPDtBCoNct64+ueryYE9CGS89EJFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mIP8KzeVyrUJBHlytoqH84dfhC67UPMtfjGFIDpcoB7ZeU6saC4KBu52/BNrlb9KVaPdzDHIw+QxKyRHOSKqE31Bb5LQPsggqqpYg9I5X3z3hdBDd7mwEa/D/8nrxjzElE5KusitFwtjEh5lrldcf2tU9Qm7vz51X3CTqgIKD8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZzTJayxl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mM9o+M88; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BCpXOe029745;
	Fri, 11 Oct 2024 15:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=baRaSHubwQBeTAWb2q
	b2g443sGaq2xA8PAvp7Nc1Cd0=; b=ZzTJayxlSL6y9Rx27MU/RdMEbjsNqm0zDG
	Vbq69Pn/NgR7cRW7J498x1HmoBciAwr4BXyKxDVlV6mabvy0amdqwMr8nz0ZV/AP
	/dPBZPy3094KtGfhP0NPyw2bqgAtfydiD2dkMC+A+43/E4xw+WYswpcPfNJcj1Pz
	z6rCaeJTOXXVhxmbfro6zP30IATb2d1xRc2vvB78/VYUILSnxIrJSlhI0G7o3ZpB
	9jMWY/PD6vi6snwIiU31lXhOOfnxx6di9sqZO0pyI4dl712gw2HS9i0QmSd0pS2a
	fzuBg7EHxVyn2LPtyAf5xm/uSh6SKBjCuyGXJEgfMrXfWC3CwpUg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42308dw1wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 15:12:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49BE77RL020623;
	Fri, 11 Oct 2024 15:12:12 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwbgca1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 15:12:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbrHb5tdoIWLFojcWf7/t+5j01DT7Jbsi2tgcOgGUSebbp9EkSWH0Eryk6z7Bsx+atAGduTRH8U4ckg0zNXlIcuI/Wi7sPHjf/N+hcbf0k7NhC0BboMS6uvT82G5eY2Q0K9/ZffLirZ4UVm4laHi0RzDQeG0snbZwqUXf/Qu0bN1kHnTgDu1ROzPadZoSa4YfjU0rFHWIUlo1JRd0q45ebPEA1k27jwID/MjrVLnv3gWSoV33S37++3A90zArmrppxLUUflBuVjulQgadQtu6v21Veo7WRpSix9jUavGG7EG/UDaLJitAewgi6d39N5NpEBQ+EQ6yCy00h5GZmKEyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=baRaSHubwQBeTAWb2qb2g443sGaq2xA8PAvp7Nc1Cd0=;
 b=POeY0GwNd6nkUE0xMdFt3XxEnXLBmvD6NrrXYSugZCaMeu/HQuLlL1vWTdS2j0FDEKyLFhEWveWDSR6TMK5DrWuhI9p1NvQuRPz/v0sVs8CHqiDNQ/F4jsCAXBZGeA0KA6jOXzHVqXV+6jOdm4UHlANwqfc3nVI4L8xqIigvPn+mKCz/HucbrGcTIksQ67/AogzCxiSZWV7wce75wNNFiXoFr5Rtiy7E3W4a0jCAcTxeJ+AscySXtsNWWMsvcsXk/oFD0c0bSEX4RJAiEGMkKdXmesE3FVcwSz2umx1Syqc4L3ymRB0e8iKEyUDMy9PRx7srVXPaVtUekkRDm+EdDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baRaSHubwQBeTAWb2qb2g443sGaq2xA8PAvp7Nc1Cd0=;
 b=mM9o+M88zEUb+pyT2ea2BpqnXQIpBBcU0GrDueC8UKzTBSGlD6N34JcQq5UicKBFtufgX6qMPfbcc+QTLp5OlKDa9x4BJzgVVMenaGWVkQ32aID+C/crSg1MX1F6AdOao/KmUr6eFMJPMk9Od+F0W198R0MshYdc9oiKnQOGxbw=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA1PR10MB6170.namprd10.prod.outlook.com (2603:10b6:208:3a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 15:12:09 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 15:12:09 +0000
Date: Fri, 11 Oct 2024 11:12:07 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: syzbot <syzbot+d207c41e97001109b49d@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] KCSAN: data-race in exec_mmap / vms_clear_ptes
Message-ID: <iwtvhos74gwrk5v5szlosnkusxqp6ubqy6ytkclkucbjwdw4zr@bwxyrwcnybbz>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, syzbot <syzbot+d207c41e97001109b49d@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
References: <66fa55ac.050a0220.aab67.002a.GAE@google.com>
 <d45f5c9e-be61-457e-9a38-d8fdd5e942b1@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d45f5c9e-be61-457e-9a38-d8fdd5e942b1@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::28) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA1PR10MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b038c8-91dd-4ee9-c91d-08dcea071370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IcnER6h79sgAKuwh8xKLaWn78031j66AdzNcHPPIHlWjd21fVbNy4cYQl8bd?=
 =?us-ascii?Q?mGtaeU5z57bUE6vSUh1y/7TzWFvOMkJ8i6fC9sQWh0oKLMZ/PD3XN+qlW1As?=
 =?us-ascii?Q?oHocF03HNleKvmVKRstYmH3eDgGO7ttiJIGK7T3V3SEf7dLJA04A4+jnc6ZE?=
 =?us-ascii?Q?Jwky+WTYccZXoiVWf1TxHMId247g/ye6q7Sv1bKYis8bN6jgvB2pcheKoXDN?=
 =?us-ascii?Q?lvqE/859fxq3gDs9lFkG2uFNsu2w+mg7LGeNVS90yIBMoDOqpuvTjkG62ceo?=
 =?us-ascii?Q?CNgX3ZceR6cb7UbRwXe32kJn/tYkDo1uOgaQ6aRZuRtrQWjhsoPGo2xOyTLK?=
 =?us-ascii?Q?gXjAVfJNNQ7e4Ks0Np9i/Xn15M44uXNKU9jF9h18WazjisiK1f0aWGmAmxFj?=
 =?us-ascii?Q?sHMeHx2F5vNnywXlL0xDVCBjdRa168cH42QrddwZKQQbtgFvDMSLMrwiGpzA?=
 =?us-ascii?Q?aEZ7Hbznco5jpCV3ZU0Be5uLSl82i0qxrgSjlQtVMO2WiUGmB45Js4vREhQp?=
 =?us-ascii?Q?QEb5WXQErORo9RHfc2fhN0qIWJMDU1lDAddWcnqtU8AZCeQj42/R++1ySwvD?=
 =?us-ascii?Q?ukb9HD8sqGTy7GQllA7md64+MvYHK7KueTEl91lrg4W5rBVBVRbUUCTVc7N8?=
 =?us-ascii?Q?g+rHQ+v4bC+kcFjFqZDed4WqfKzV74uFo/zXa43/X8qpi7AyQLputrGFu/xn?=
 =?us-ascii?Q?7xIFaQdhSL8DtevNSyVtuFekIaEIZNeBnqwElBHeiflMCDSa7w/Y6VxUCd7m?=
 =?us-ascii?Q?16nWd6L+3f4/5fCPkuGaKlRd7QKWE3ey66DZD1w2gIl3Hl1wwmZJfl2CAUMv?=
 =?us-ascii?Q?FREopVuRy9vr6e/R1aH4uuonByupmcPcqUngTHSoS/qgFIQDhuV4qSNsLuLp?=
 =?us-ascii?Q?FSG7VTknXPwc9k+/KWUdu5Gb3xyi6JAGasnaRKYKFHehMrLtfQI2VQ5Fiu4V?=
 =?us-ascii?Q?fCgA9CS3WI9YZJKAGMr4yy12Qta1Ee1aqyabp0fR9GpDi9IU2pp0+kZA/S3i?=
 =?us-ascii?Q?RwVjwdNlnc4tm96fSiTgbE2I6OrK4x7EnnJ+B23Wtzv+vkF5p5oiz2DfqXU9?=
 =?us-ascii?Q?XfQqRDDfxm3oUBVF1a+JAYPY6AqUqJN16fausbvbJ6R6DzfTMjYz6eugKv1m?=
 =?us-ascii?Q?leMA1gfIbJR4bFmkyWDKe7iBpChCoSP7ci0SXYc5/XwzLU8TWIdgmeR2umPf?=
 =?us-ascii?Q?qcoivdEUdCpKHXuFcZ0nmKE5WlLU9UI64GHPvp1LBAfNLtZPt97CtYAgOEyT?=
 =?us-ascii?Q?5EJACBQGJr1uOfKArCRo/xbVEtNiRh36bAuA3uU+jGgbhfrrn3A/9q0GrIMg?=
 =?us-ascii?Q?W+k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?REOPJ+/bqNSxJROJepADSOqeB8UcAOn+pXSs/t2W1JMKLud12IUhLaOdY8K4?=
 =?us-ascii?Q?URXwjWbOERQy8On374kFKiEmDaVbzMfBMxowjMXSBiTo7IdomCUCJ4PlN6qp?=
 =?us-ascii?Q?aEchOp4Z8h0d6RjciRorIht9PewRX2HQIjJA1IDANc8w3/K0MDp++BF4+FHD?=
 =?us-ascii?Q?rebYM4jf3pKdCe6pgNjIs3zzek34fSghvqZBQXjHGX8xTa+Q9AgE10CnfBYK?=
 =?us-ascii?Q?RGs7Lg62QhVDD4ODd/rQl4veECBzFnsQnf4YXWM1TxBQdKCMdfkrn8Vh9plv?=
 =?us-ascii?Q?yj/gZ7/P1Yk01v2WOXF5ZstcPpCaEbne7Q4AqU+5F4xMonVpRoR1IKe4BZz2?=
 =?us-ascii?Q?8i0TfqY/Mi0O4R3bHg0nRFJHQIoa+Lc0L0U2CahmrMFmFX9KoEk6ZvXxJJ6O?=
 =?us-ascii?Q?ksCRrqFEoW+xrrejMnN5FWf7xfrmKR2JVDM5lF+RFSUiVgLx/iCdOCziyd+M?=
 =?us-ascii?Q?1drwRyoUdi0EHIc0YdoDyBUoyUUwEQ7ucGe6ZGJgXEOPxz9SC2O7CufSOPYL?=
 =?us-ascii?Q?nwN7pAUT/3sAhFzn16ho9HDPyE8TXYmmbIwyj1AjDrSl/48T6uWwFTh2DEhy?=
 =?us-ascii?Q?aF5MQGdkVTKYKw/Clbh7IE0toLjDLapSIDPXFRemU++tRV2W0ze3XdKu7USp?=
 =?us-ascii?Q?fQzsoA/40W86KMBpRmke8aEy9gV28jkQnVjQFo6zAjhEBDQkm0pwICXybfCi?=
 =?us-ascii?Q?8E06Txg0cuzKl/v+iB3UTroKuFd/kphpM6szgw+rjkJqoi55kOV7nKdVkv03?=
 =?us-ascii?Q?eC8MuM1NrPDhOZ+puTLmD71/b3WChM127+7EElzrD6zQlJYATZueB60eINaJ?=
 =?us-ascii?Q?47VsXQKUYE6wLALvldkIUuwT9Ty+1A62IxUji9FfG7SE9AZuClpXPqMS3MxK?=
 =?us-ascii?Q?AB5VuDqbQYNoxdXO80tl0w3U1v8kYzZwlqy7n4vmi5s6ackUUnqxUIy2B+LK?=
 =?us-ascii?Q?H+vFDL8lVy77rVBPskqMd1Vp52j/ejs7xHtA7mZkdGGgXJDnc9UuPw5ENUvC?=
 =?us-ascii?Q?L9I5Dt4r9WU0HY1rLMbtEq3froLFaMfJQQdW6NzHl/ov8/kby8+wpVmFYUNl?=
 =?us-ascii?Q?DB85DbAzs7+oAfEr8R47quvFDxcP2d9YL0x2jH0jGchixojhvDJOIDlMb7R4?=
 =?us-ascii?Q?oDN1DXM1u1jW85Fz8H0JWP8w3yYIw8PXS60p/E8oL2pcgrh2WIeO6jJkfZ8J?=
 =?us-ascii?Q?P3l5QugvGOq6fBvQEDDy7bJBwltbwct6RGBs1lB7WJ26HO9Pag07ro4nXeAZ?=
 =?us-ascii?Q?W7kM48379pbPk6wUsvnyj18vPeey/FggIAvSwJG+xhM8tSg7RvkJwh9qhWHD?=
 =?us-ascii?Q?h1eM7AOa34O232aIfcgXiOxE55OKIXpTBA4+AMvrwZURPFPY4bfc4gQb/rRJ?=
 =?us-ascii?Q?gzAZ1sSsHox4FPw3Csgr91D+7V+CXXG1JECzkIIsJ05ukDKBkZhX51DlhtLw?=
 =?us-ascii?Q?DocL6vr6MgUuJvPRRLyykXyYLaNBiiLKHbZn4PbvNN5J4MeJCDYVdPLAV6G+?=
 =?us-ascii?Q?X085mQ37XHGbFY/zfnmt5rVXAF+t+jPz1qOCI+WBzqlQ+4om7cr15etsegYi?=
 =?us-ascii?Q?2NGvQgqrF02KUqt87eXLFgFRKEhJm90vAZkEk9YP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CmcazdYfNya6t+zsbytHyTST5n4Bpsu374qp4VEhiWh7BFSL+9guIPpjR/s9sow6zQgYP/wlwTSFrUwAwmegHkSCFPNbBqBZAW5dpd4t3o6vVZ8lqoNjMTUFgT+FARJcNxVTL+7QBEHvsrhNuUMIV2tbgdud3cX6S8kOUdeiUqXz1JSvGfhNpZaaQOFWoabt1y4eurXcVT3LHazeglSaCRjRBcN8j45HyLGXpS8XFFh/ahE5/e1ZwJiPmo0Z+emc7TJREVk7aw1bRZGut2w84W5OkPEapnJ4RKMge9NOhi1yCQ2B3+wXsosytaFW5onSCOP213vXZ7VqppERc6rZkW6Vd7WgX4Hzv/6PFkzpY3Sf8k81EwdckhaEbjLyx+HIRPc+Mq4WBmhmQSggMXASfWf0Nr1u9RSH8lZPrZ+CAAtUf56qwmMcGGk34/PsMDWtU7NiJeb5kiHmSIFHiMpjBrbHDmeX2Ba8EJXZH/Hlwzh3K/WlfRHYUNyKOCl2tp9KyHFC6+No+J72d69FbO6Q8/mRhTnf18Fnl8xBnanVEYkZRVn+yty0Ug0/CctDI1H5sOq4F4hN8sXjeSsDTY7hsUra+sVpKUXXYs3ZuoJo6zg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b038c8-91dd-4ee9-c91d-08dcea071370
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 15:12:09.3384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MkSsoeMYIQ+23tETxIoKdIqkHSByympMaE1UYsir/O4qgLu1AgUf40nddn/BlmbEr3hjMHDROkmRLL9oXjMCVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6170
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_13,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110105
X-Proofpoint-ORIG-GUID: Zf_6iHUmhL3WeRvGBHhdHG6Ltfu2bxur
X-Proofpoint-GUID: Zf_6iHUmhL3WeRvGBHhdHG6Ltfu2bxur

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240930 13:47]:
> On Mon, Sep 30, 2024 at 12:39:24AM GMT, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    e7ed34365879 Merge tag 'mailbox-v6.12' of git://git.kernel..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15238ea9980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=8bfe37bd3f5983d6
> > dashboard link: https://syzkaller.appspot.com/bug?extid=d207c41e97001109b49d
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/c86c1297298e/disk-e7ed3436.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/8313c0846b3b/vmlinux-e7ed3436.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/8af10d85db09/bzImage-e7ed3436.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+d207c41e97001109b49d@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KCSAN: data-race in exec_mmap / vms_clear_ptes
> >
> > write to 0xffff888102fbaae8 of 8 bytes by task 3004 on cpu 1:
> >  update_hiwater_rss include/linux/mm.h:2655 [inline]
> 
> OK so this sets mm_struct->hiwater_rss on munmap() via update_hiwater_rss() in
> vms_clear_ptes()...
> 
> >  vms_clear_ptes+0x1a7/0x300 mm/vma.c:1088
> >  vms_complete_munmap_vmas+0x170/0x480 mm/vma.c:1140
> >  do_vmi_align_munmap+0x349/0x390 mm/vma.c:1349
> >  do_vmi_munmap+0x1eb/0x230 mm/vma.c:1397
> >  __vm_munmap+0xfd/0x220 mm/mmap.c:1600
> >  __do_sys_munmap mm/mmap.c:1617 [inline]
> >  __se_sys_munmap mm/mmap.c:1614 [inline]
> >  __x64_sys_munmap+0x36/0x40 mm/mmap.c:1614
> >  x64_sys_call+0xd32/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:12
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> 
> > read to 0xffff888102fbaae8 of 8 bytes by task 5494 on cpu 0:
> >  get_mm_hiwater_rss include/linux/mm.h:2642 [inline]
> 
> ...And a racing execve() is trying to read it.
> 
> This is a bit of a tricky race, as we downgrade the write lock to a read lock in
> vms_complete_munmap_vmas(), which allows exec_mmap() to proceed (as it's under a
> read lock), and update_hiwater_rss() is called against vms->vma->vm_mm which is
> set to the old_mm and...
> 
> I wonder if we should just be referencing current->mm in vms_clear_ptes() which
> would avoid this as will be the new mm that has been execve'd in (and presumably
> do nothing)?
> 
> I don't think in practice this should have too egregious an impact as the
> process is being execve()'d anyway, so I think we can wait for Liam to return
> from leave to give his input.
> 
> On your return - Liam what do you think? :)

I think this always existed so I'm not sure how it's showing up now.

Before my change, the counter was updated in unmap_region(), which
happened after the potential mmap lock downgrade to read.

Perhaps the change altered the timing enough to cause this to be
detected, or saving a pointer in a struct is detected easier than
passing a pointer in an argument list.

If we change it to use current->mm, then we will be racing with the
switching of the current mm and the use of the current mm to update the
counter.  We may update the new or old mm counter, depending on what
side the update lands when finding current.

I don't think it really matters and I'm happy to mark it as a race.

