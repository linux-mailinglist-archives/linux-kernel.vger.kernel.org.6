Return-Path: <linux-kernel+bounces-255632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC04934303
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308081C211C5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B7E193073;
	Wed, 17 Jul 2024 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oCaIEyoE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uT53cubk"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D054E19246C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246896; cv=fail; b=CNrs2V4ICvrZc0qe2skDiN+PNOzaNntM9NVMYfIV4tTxD5AK2rEgsT0aCZX0rcQjnqWlhPqUW3llmqNCjcoOj/SE+bJRceWCbh/yMU20CCc25kWUNNTbui92Q9qFlCnSKVlux8TICrD98K2+xkrJIqjycUqbWBw+itm8dp1vku0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246896; c=relaxed/simple;
	bh=QfDC0mpheV9PFb6i2zs2NlfgTcNaTwy49v3X2Kh45Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PUBNr+ockHNMxXELdcW6TS41bY+Ld17H6TlSMAER9Iq0/8RjaHx1VIsuqFYKVDSuyulIdqJ+R0zAWYhoKgD0eXtX0GijI9qtJ6rgFDuHOlqvriswELfD0L21u1FuzMjL6R5EHWZ+rELIsEny3TqhxKulVNjkCbCi9ZVVQ7QQPoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oCaIEyoE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uT53cubk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HJsRsR016988;
	Wed, 17 Jul 2024 20:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=BpN5Sb+yntfE6ooYu+FyKWdD7AXq/Jrvngs/MG7YjtQ=; b=
	oCaIEyoEOOKweepnRY/O17gDQ1KYf+NiviAOEN19MseRbz8orrvJYpuYufitJbch
	8FJCmDpv2YtIcafbr88bWrj+3FwqkQW2XJflTGkY0u8WiUD07R6NCDQnQFngs4xy
	nam+SYrNboE9Rc7lZP+p4plijOoq1vQ+cveBCcAkFvsYBdNorzExGH0zJ/E0xuC3
	aozqm6iifoVFN0TeJ1PmlwJjLYwwcGGp3Qo91aCHnhx9RwPanHXZAe/KKoNpzWEm
	09rceZyySoYd0zWXHnrX3H6lq6Pj8sH86yhiJ7S28W5ybK9ZWP/gF9lI/2gdBNi1
	q78t8eVEEQefJ32f0hqtDg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40em3m0344-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:08:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HJFPQn021621;
	Wed, 17 Jul 2024 20:07:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwetrpdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYYAjfuJEdtoe8HscfTsht7RrpE00gqgYTMaDwUGpv1Y0QZvzaOckc1qc19L9Zi3xdIpBF2wFUBLiM9Z/WAdZ2z+7TEaWSCh9P6kWUowY8JMCeT5bhmhPVjzDiN+SBKfp/hYKaG9TTd7qKi7PPFhjiBpP1S/YKPnZr3VUnxywuBRYIjvoBgviZriS5J5DkCqj2sIvH0dr4FONyRq/cGTU4T2qx3tGwL/UaY7Kgi448OpF/poUIQ+ED6O66brVUamWzeuCGZ7NP+o4pepxWRg+CTBpPPu6nZ7nYeZC+pl3f1nURNAM8y0nJnzv1J8PGjpkP+09mUPi9f1XS7Rgcf4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpN5Sb+yntfE6ooYu+FyKWdD7AXq/Jrvngs/MG7YjtQ=;
 b=pdSgowjc72smq3Wh68L0XgDgeBt7Pfp5rhdW6XiKKwX0eCrSYfuUmRwq2g4F6DcjlPqyYefDUNTLTFZYE6t56wVbxxHr54UKRqtN8TTZHIgZsrmeccY0qlNTTcv+5DwNMNkprIzDopDRol+yAS9OcTTkPuLvEOV9JnlFLJtXJtPYuUHPtq+mNhIdurh/2O6Ee5eoCh5qK/rbPGqjz6PwIiif/N3MGMp43tdAOhehwpgV8aKo3s5bA57lhbcnHDr/rw93CG8MkWZL9F0zgu3lcUCJ/BtqPGPZyqb6ATDWda1DLmrADaphxD2099WeI1wHE9y/+JhY6zELv0WGHmkaCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpN5Sb+yntfE6ooYu+FyKWdD7AXq/Jrvngs/MG7YjtQ=;
 b=uT53cubkZd08e/vKU+Xi0owlAcr+NyteekPZpA4YSl3o5Jh1Tm3byvpBzXhlS3KpaEVClu3CjtBzS89OnxrgByBO47QfWiYSRcx9bb4k9BNlmbRmX44MEHn2MgZ1peoMVyf2MLD4iSvwUjZkTTm3GVEgQfOKvCIBvuPFcg7SIMA=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB7694.namprd10.prod.outlook.com (2603:10b6:510:2e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Wed, 17 Jul
 2024 20:07:57 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 20:07:57 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v5 20/21] mm/mmap: Move may_expand_vm() check in mmap_region()
Date: Wed, 17 Jul 2024 16:07:08 -0400
Message-ID: <20240717200709.1552558-21-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::27) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 6742c728-1243-4ea8-c0c6-08dca69c2680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?d1XnepONywIkVt50e1BlPFGlOKT+LeJE75heLCj+ba+PuS7UytO9fOPEFhQC?=
 =?us-ascii?Q?CNlPBH9FAaZNggR2nRmeACvC1PjIkCFZpOLI3Wrh152HJEZHTvRK958dxB7g?=
 =?us-ascii?Q?+TiqWL4JuSqC/nMYEDrS64KrpPdaicaj3WocpH8TOOZ2/FJNuNtQer3TqECP?=
 =?us-ascii?Q?8jKReRvEI0y3u7+UcVOPa7Wq/LsXge1z8qVms6jh82RciZgMLT0vk/oavomm?=
 =?us-ascii?Q?pkvupavp2PQInJveYh94dA0ehLbd9GhkpXM2kGruy2sd0B92tjs21BG8bzg7?=
 =?us-ascii?Q?7mnPgPnaGGgPo/6dVt7CS/oNg8KhpwfYTrt4CYV1QBDuwTcGp0TTnO8zIsH9?=
 =?us-ascii?Q?S5TL4KREphgReZvNV1v6jGH6BgFIfs4vqg+8KCsp+YdsW2LnOBsP9iB4fHJ9?=
 =?us-ascii?Q?6cdtunxhcLOpiE9Lkjq7Dp8a693pKeB8pppCETfkZV99Nd5DuL1a9dn01Ecy?=
 =?us-ascii?Q?jIxB+cNQ6frrCGu1XjtloZZAxRkB4ZnEZhnCk1x5hAe+dyeODqTLvim90DUX?=
 =?us-ascii?Q?zf/HkxR+fBB0xv0rjU5ROcD0mWGhfwpUO5cCM7TKetdOlFPutJM/BqrXtC8Q?=
 =?us-ascii?Q?G+gbNqNB5phLjjQQqPEOfiBlbnWLZ3DdguOm8jhiM0qHAM3LaYu1rnKTOR+V?=
 =?us-ascii?Q?mYTXqJNe/1/E1Km+eLNXoiljL+KKB6NTkyqJ6Ex5VQ3p9kcEjs9+FRZt8trJ?=
 =?us-ascii?Q?mCAXBbJ/+lQNIA1D9/72NpI3uEZLCRbUlQlYnAkzmASlyOGc0bAZX2DcSoHZ?=
 =?us-ascii?Q?HKy/eMJ5sbOC+myT26+PsrbVGPFxF81tNTMxhJ3diNdABG9m0HrEhq3smbN/?=
 =?us-ascii?Q?l82TQZvZBjdfB2b/8iBqFOt8dIjhAAal2c0cNVO6TOaVR2539SNcxW06B+hm?=
 =?us-ascii?Q?jyOBezoMsliJSF1sVd0hlBZ3NcTTxq3KamFcdCtlvotGppGzwDDePQZCi8W4?=
 =?us-ascii?Q?hGDB8zH/PdLqU3ZSx48r+AQEkDphy9YQfwgeMHt1vmsD/10KYBLTJtGUvg3w?=
 =?us-ascii?Q?fQDmg6kN3CmFpd1hAl1bLDscpIWtjLA+J6wcGHu7UyfQRNJPD8QRq5dD1353?=
 =?us-ascii?Q?ggsXiRiuUGiWREWIv2zwUzPBnb7eEnXwm8/syxRv9HOFsP4NbtfcIj8rZUR7?=
 =?us-ascii?Q?HEGys0wl1Ax4lH7KSSlWQSdhQvPOVHC4gEeqUJw8Y0g6JXVFeuReRWVhZ4qy?=
 =?us-ascii?Q?QgN6i5Wn9AHJJ9AGT5FOr4u4XCImK++JsgMSlBDIWE+Qk7utCWBWUNvCNXv4?=
 =?us-ascii?Q?XC3VZEvVmf+CAIlZBBOFUymHTwOQ40qizUwnMfrTioLmIP1mZ0eESNSaBWOp?=
 =?us-ascii?Q?ujeZJ8/xspRlRNgZkJBrJYRE8QgCXVzDpRuwEWF23j6IIQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?85KhO5mnJdpPwZ1pWRPBOPcKwXrfES4Xmos0QtJmHh+CRhFxHgAiha9npubT?=
 =?us-ascii?Q?8MFZt2kMG+FXIzLKD0mtJKmt7gfPAWGhKLLjUFRBmAdkgcTQ5momUrl58LPW?=
 =?us-ascii?Q?z0DIvcZn91mFneIsciNRsA12Qlf2FP5NfUenrpuVD1d9a6DxqUI6pXxCE9UN?=
 =?us-ascii?Q?Y9rzmltnswbfWo4I+5RPB6DgZeYP/t2QfD43zfLHHquQ1oJyLIicT/76wv4O?=
 =?us-ascii?Q?UgW6VlgEFHnUF+Vw0l8zHeshO7M11GpbNb6kSlzw8Czq/RI0P85zVMaFSrsI?=
 =?us-ascii?Q?wQbqRq5CRDckrETegDqchu7Zm58PHFx7p4KdJdpoF2NMHzJDL8czqbX8qA+V?=
 =?us-ascii?Q?R/xs7yubHUSpQJeya5pR4l7KNrcjtvSlQqu//DQINVPEKK3mwn0r7RdA/EJx?=
 =?us-ascii?Q?old8emJOwi12zrNIGZiXxxDbzZxLE1Yxf4Yiu3A9lVpAOMQ7zzX7YdTO8c6H?=
 =?us-ascii?Q?SB7abAhKa2P+BeFGQTUdH+cP6ODXVYOmO8LirFShI4ZWaUln94gaEVedMibM?=
 =?us-ascii?Q?GHv2qSAcluP16CwIJiWIRdEgzBiDRaweHF7qj99JrniB3Dq0i96r+7CgKHmE?=
 =?us-ascii?Q?lhTMWxOvi1/V9CNTAgJWz3bFHSZqjt/CFPyEI0sWsRWBXdN7wb0FX4BuO16O?=
 =?us-ascii?Q?DX6CNW1DDPDDINW0nTVzEwZChc8RGbCR6WzZBB1gL9w0v1NNkAmE4UaSx5mi?=
 =?us-ascii?Q?bfoJg+6/4Yb6Z7sMcM2Sf9bH6dBE19vLewMcJ4p/9AwOqreZSoEYWtIPXANI?=
 =?us-ascii?Q?1OxNLh5K5KQW0m7HflOpcitdbP8VX/g5AFcdp0NXyOExQSUOkvTi1pyyEfjv?=
 =?us-ascii?Q?Klr5AJ4kgY4unczXNB3WDIt+Reft6VRGA+n9Gf6PoQ1yacugfwMuo9DihaC5?=
 =?us-ascii?Q?onXbHSUV+IbUxEhlRBa0pcFoEmZcuD1v0XZCs6CkO17H4mUSHJqPIGCsemcp?=
 =?us-ascii?Q?3FjS2Nh3dj4y0InF/RnI5huNO/M+aLmHUhacUbhgPSAJIAd27hnuaz/brk4W?=
 =?us-ascii?Q?QXOC5k/SahG2Vc6JKfSU7dxoSebHnlcM6g2MH0Wh99PjASh/WB5oIl9yVB5H?=
 =?us-ascii?Q?1v11QTNmTVtKyKhLvCg+y/3adjykG3mSP0uT9gaUfwEf8JjdkmyW29jTWUml?=
 =?us-ascii?Q?8K4qvtNJ73TwuS/UMYnxy+2ttNucssCifbVnMLXZCOMWetc3bwBBDjGSejN0?=
 =?us-ascii?Q?6K3tfaXwoMrHojH5GEiukVJtLFZVTPAGwrVHVPcQLFrXIkP6lbf0yBOP0lL9?=
 =?us-ascii?Q?v8hRlH0zITKaGK1Jxp0vem1bsErKa7Mn2/vL7CMzalLZRYh9LtEMqU2aSDLq?=
 =?us-ascii?Q?7toV4wMmQ5XbE6jMX7DbcjghBmzDOMaosXY1l5qcbOq//GAOofkYl7Sc0G9k?=
 =?us-ascii?Q?94KvpP4KH93wwG6ifUGyZ3EGiWbOppofVrbzY5iX4uGATCiMa+7mpG184e4x?=
 =?us-ascii?Q?5Xv9Yfpt+4iEUbdOxe0UDo8M4oTP4WfASwkxoqtB041EIBqrGg/rWpcI4GgP?=
 =?us-ascii?Q?mexUJ/inHaQfwgYAlDidMmIfFFPhA76sEUe2g/IahDnVX4RGXbxqcdgE6Yaz?=
 =?us-ascii?Q?xxMcBjl4C588dREJMT/KttQ9lbMwsfPWezoUy28o2SWeosCsgbg+gBoaI/JI?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0ukej8JiF1LNZymd6+Ehlb2vaGQ+vZTTEVdYZgfu/eMXNVFGMTzAYSZ6IjWvIbSlZkplLkE9sZYER7MaIEEqTDtmBtwOUh76pwbk/aWkU6VpML7QBNuSAfAYbXVHbBTAPjXqOi4D6uKmOQPmSf/Z5On+1Sq/9m7aKWlI6gNpXRCCMFWvzsfXkooWxTNMvCUKFrycQxKPsId7suyftdYPG9Mh5aqEiv7G1l68BPUd2aREiaPyrHIna1x1bBHvSkiIANtdvMkOsLabWRx/KWzBqudhb9PTwV4AnBzD7YPhN8JUA02U2AZDMDqZJ25IrVQPwzFXber7eVU+aENJHFaOacSD7uuOtGlWEX7tqKfUFH6+FKcaZc3WdOXKm0vqBMcQVb/FC9HwothXN8TNW23x4sjftmJOwuRvYBnxjHSQUbQ+GMhIxXBq2xRZ4bFCobTvsi+p/jaGCuAOfqlpZoLII7aRf38kIYIVwQFL7t79mCETD3lS8eSBXAQ2zbM1Xq1t/QZj8gZOkX7rJXxFqFLI3aMf202Q151PiFypJqHpa08EbxSEHIvHrtq2PYkqPnPTF6T+TlsCJXWxpRgNATdOiS+/rau7h24xFbLOFjhedi0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6742c728-1243-4ea8-c0c6-08dca69c2680
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:07:57.1984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8nYccWxoLGSDwzKGcR/BA9QTJc19dECB/2OVhXj+4Yn1qB3N5sSbaXCQ9q9vB1ahRavjTR+GK4eAQIeQJ6R7uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_15,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170152
X-Proofpoint-ORIG-GUID: sgIgW5COgo9dI4b_YDTuOfL861fMObY_
X-Proofpoint-GUID: sgIgW5COgo9dI4b_YDTuOfL861fMObY_

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The may_expand_vm() check requires the count of the pages within the
munmap range.  Since this is needed for accounting and obtained later,
the reodering of may_expand_vm() to later in the call stack, after the
vma munmap struct (vms) is initialised and the gather stage is
potentially run, will allow for a single loop over the vmas.  The gather
sage does not commit any work and so everything can be undone in the
case of a failure.

The MAP_FIXED page count is available after the vms_gather_munmap_vmas()
call, so use it instead of looping over the vmas twice.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 36 ++++--------------------------------
 1 file changed, 4 insertions(+), 32 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index ca752317adef..5e74f5cb7be4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -402,27 +402,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
 }
 
-static unsigned long count_vma_pages_range(struct mm_struct *mm,
-		unsigned long addr, unsigned long end,
-		unsigned long *nr_accounted)
-{
-	VMA_ITERATOR(vmi, mm, addr);
-	struct vm_area_struct *vma;
-	unsigned long nr_pages = 0;
-
-	*nr_accounted = 0;
-	for_each_vma_range(vmi, vma, end) {
-		unsigned long vm_start = max(addr, vma->vm_start);
-		unsigned long vm_end = min(end, vma->vm_end);
-
-		nr_pages += PHYS_PFN(vm_end - vm_start);
-		if (vma->vm_flags & VM_ACCOUNT)
-			*nr_accounted += PHYS_PFN(vm_end - vm_start);
-	}
-
-	return nr_pages;
-}
-
 static void __vma_link_file(struct vm_area_struct *vma,
 			    struct address_space *mapping)
 {
@@ -2977,17 +2956,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	pgoff_t vm_pgoff;
 	int error = -ENOMEM;
 	VMA_ITERATOR(vmi, mm, addr);
-	unsigned long nr_pages, nr_accounted;
-
-	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
-
-	/*
-	 * Check against address space limit.
-	 * MAP_FIXED may remove pages of mappings that intersects with requested
-	 * mapping. Account for the pages it would unmap.
-	 */
-	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
-		return -ENOMEM;
 
 
 	/* Find the first overlapping VMA */
@@ -3015,6 +2983,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			vma_iter_next_range(&vmi);
 	}
 
+	/* Check against address space limit. */
+	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages))
+		goto abort_munmap;
+
 	/*
 	 * Private writable mapping: check memory availability
 	 */
-- 
2.43.0


