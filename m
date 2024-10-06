Return-Path: <linux-kernel+bounces-352425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 245FA991EEA
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 16:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51E72824B1
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 14:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920761339B1;
	Sun,  6 Oct 2024 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nvntAkni";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wy0h2gTt"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C0A5733A
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728225108; cv=fail; b=HUto+dCW2W7D1OFSuxJWt5tlJZL5a/ai9pOMXx9ygM7W6SkOn1P6nFUULhrtC/vA44B6LhF4AOPMugNexSgSRaK6Fqsyt1sXlohohjuIk2loqdaSeWYALdVsU+9J3RTJ92anRNEzZJP/W8sZcRF/MexKN8R0FBI4Ktp2WJ6dlW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728225108; c=relaxed/simple;
	bh=qGENiFZp86f37BngkF3d7jqFRwHXIGvnidEyJ51k5Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bn/RlEqLAF2QEv40Qg3c2EnBjCMav+A41wPeXZSlJ5GdritiPEDOzyJXEIGzXEp1fciZC7YzAU7McFIzkMHhKSFZaOH8zFca8ctx1K5LVCchq/Y0PNgKaLHh0YK74KB8OO+DXreuT50v8yjUY6ZLLc3v7UWvdafdPntxDHX/FKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nvntAkni; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wy0h2gTt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 496Dq6nA024584;
	Sun, 6 Oct 2024 14:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=4Lg6VrKyaS7104OK
	VdExCZZ5RMmQfWLZzVMLE0xno7E=; b=nvntAkniyp6JoHZCEBfaK7I3ubEzUBn5
	g+UPdTXRhiJVGoDnzqc1DqcRCRuEVvLMmBpvV/gYtv8tBeh+/HmktcdeVmb10/jN
	peUxjYSClpvLrb4dEf5iNbqAcX6LQq9NV1YJ5Qe4oC5xDg7hBa3Bmsq6RJy8lTId
	O2QO1aOUuiMUVUvvmPtno8Guyb5YBeJWHAj9zZuDoQtt31OOjdzxw/L3A/3KHOAd
	/tgw9t5lS7uCW1NzX9/GAPOpN1XRCFiDM9op4eX6U4+HzG1cjhk/mvQCk5UNoAnE
	9yHOXLdqe19sh3hthcGCS56+lN4gfIlPrb+uNtzQ/SdoNp+5InsUfQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42306e997j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 06 Oct 2024 14:31:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4969UD7u024151;
	Sun, 6 Oct 2024 14:31:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwb5uxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 06 Oct 2024 14:31:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftMd0MZ3PgqgbBVqfTalYUcjBsZv2NHIQ1H1163xn6vXCkAWDbPMBMGIZuQnNnQDmAqZFfypzXNsE5Te5iLTwffoz7mHz8ZpewIZDqQy7mJbpKVEVQEIUDZKQ0HtUWf/+qyhm4oQbwFftmVcrKu2XGMBiW2xs+G+buZ+m64YFY/4PmGkz8aTPRp1cJFLON0CsAZY/eTfERyXbx+1aFSRegvuJCGTqCysmWQw0F049em4zzozv8G9sxqrZqF1/lJYBgLRqOA7rmwK0Vvs4BN5JXyjw6DR3IxTJ2dmpKuKQihvwiMTBcSvp/rLupK09oi4zx6cdtgE9st+PlIsrQPlUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Lg6VrKyaS7104OKVdExCZZ5RMmQfWLZzVMLE0xno7E=;
 b=yDghcdjOw7ZMCcptzwdlIF9a9TluLMpWKE0ENO2Zskd3G+TzTgbda5LHYglE64LVwDYCJF9VY0Xx3fBxcQZJF4u0iBF+PXVVdcbg6gSv6GQZ7jwFEnCkxtrJfSN5+K24vPkHjuFbKleoKHl1L9FWnmDDxX4HY+e2Cry/6Db/NANGUQTQRIFISSf3niAWtwVp5DMgAAVi0J0Isk1VRq9Fa+sEJBu1PWU6pWbFafjVMrZFcMXXoF62IHVeZMJHEeHdjaWugbgn5kZGTUuSeWFMe5yeQDoBAW502fxQdTJ6K90UnqU9R6SkZvHeu3UCwdDQSmZ2QmjmX7pbkHH3PEyU3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Lg6VrKyaS7104OKVdExCZZ5RMmQfWLZzVMLE0xno7E=;
 b=Wy0h2gTtn0W+NVB8rNtPn1qgcVNO72gb4aUhMxo5ZsblwdJuw0lI0UZbmnbGvG0BXMvl/SGP7zR3kSbedXjmH3VWLTYCpDQtu4KYZxJR/WNhTKsDQ2rjTSCt1XfAk90zoteA6pVNwEyUr6mdGDhUFGrG6wfU8Xq0nlx3NFPoyOo=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH8PR10MB6503.namprd10.prod.outlook.com (2603:10b6:510:229::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.21; Sun, 6 Oct
 2024 14:31:17 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 14:31:17 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Bert Karwatzki <spasswolf@web.de>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        maple-tree@lists.infradead.org
Subject: [PATCH v2 hotfix 6.12 0/2] maple_tree: correct tree corruption on spanning store
Date: Sun,  6 Oct 2024 15:31:06 +0100
Message-ID: <cover.1728223996.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0160.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH8PR10MB6503:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d2f2444-f02d-4b4f-d525-08dce6138a15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OH2ufI6fS3WnC6t9uD4Dno09q44eJAGf3ADGHPt1IFy4cqVLgkZRAhtxsVJb?=
 =?us-ascii?Q?wTgZoB1wpVzFVrHWlP2aRs3shwE6O6x7fMdGsvDBFfJu5mjEE/jJvU2Ydqh7?=
 =?us-ascii?Q?1oQrrKgubICtcM6BBjawK+ZA7n4fukVFS40i/6X4FI+4q/p01sKnO8qtMU4C?=
 =?us-ascii?Q?t8P96Yk2OxIi3XbfkCapFqAdYkMl/cgdZhCPy5hheNzGYiMBrbFmvPlcZGpN?=
 =?us-ascii?Q?+hmrdhew6cpulE+vaXyYD7V0YD9PfqVOiiwrw0LIk2X2R2hl1uoFqz3wKxOy?=
 =?us-ascii?Q?SGjeVA2s/Dp8u5Z5I8HbL7lREHH8Fn5H3ps9IBQ+KIrfg9q03Rmh2gu5oZW4?=
 =?us-ascii?Q?yVQ464Ce4/U4IKOyb4J01RcEvrD2Mfsui+GdD7zoi9Os6iVKz3po2hlza8Jw?=
 =?us-ascii?Q?0Yui24DpXQxVbSDybRbdhJv/6aT17TZ84mh31CBpbOrZGZu1Gz4vA6mzMapt?=
 =?us-ascii?Q?k9J2IwFYhBUh/W4jmxumpwx4Xy6N3l8rQ56akXP15hweYGMn1UfIdLNWw359?=
 =?us-ascii?Q?li8/jm/8ThduU49zRYiK21Z3WNOxPY4GDgCI2YWPKR2ApZu2zwJN4AcxBE9N?=
 =?us-ascii?Q?D+0P3iDnzZ8X5hL3QOagHZmcIfRPEdutwII2kWB/lDAhk3B0UwLxCe5Fg0IN?=
 =?us-ascii?Q?cnI421UvB2+MOVWJS1a9OiOUnouF5TpTHBIsCUbiRfTVbcKM1zkKB/YkTqLJ?=
 =?us-ascii?Q?9Jnjm4OxKgcAQAzbu4prMfTM8gBA3I44rv3wLWtLcJuWFbZ3fVBnbyC1QJIN?=
 =?us-ascii?Q?76zhnbBJ9vHnT+GvbVZyo3ELbpqTAHBcCTBISxvGEZN0WGw/fKDcjDU1iQdB?=
 =?us-ascii?Q?472qmkyIH6ito2TtkND5Qmv+s7fAHc7b47p7ZTwWPNeSldiaGp6u6H38bCBz?=
 =?us-ascii?Q?d8klqLxnak5ADfjJ319BYdvBdCtmgxoZHaCwAyHAgFpnWRh7NxYzDGK5yUG9?=
 =?us-ascii?Q?bB3ZQAhX5uNfypdM3IxOqrYWu6g4gsPLOPNxxp9QqcvgKICEubmWfVA3mxPq?=
 =?us-ascii?Q?lwFQsGVGMHpRZO8rz3NCaAFGUoHTx4u/bg5dMHO2I9qCxcCXKJOsZdyDVXyx?=
 =?us-ascii?Q?4AglJh1+15iIrMX8OVgUugJ6/jd7y329D/Yy7G4GjCv0AYWz8TOQ9SLESM7G?=
 =?us-ascii?Q?RDKhY6tCt2OWeMwsZfCFVO2unAQIpIpdXINrKH7tMr0VTjnFvL3W3ylcbMVB?=
 =?us-ascii?Q?8QqKPk15+rUNts4AYCY+wndQgHpffBe+Rix6+aLqEwf8/B2uaVEv5RoxV4X3?=
 =?us-ascii?Q?dakpZhn6gZ9S5C8Cq63hDm7gWZfAf3gvV6u0CENtVQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jc1ZMuKHZdtu1jg6hqjGw+nDrnK8JZAerIvVB7CAP/ko/aHbF4R0zQ18GYeL?=
 =?us-ascii?Q?qf995CeDiOA5Rd6fLxCbrPwk1fDVyw6hj/o8oqEyakH0UCL1JN+FvJRWTsmR?=
 =?us-ascii?Q?kn/zTbJZDZuTtxFYpbGosxFGp3lRCmonRhqVgjiE1Ro9ShqKvaxxPVZ4zbgS?=
 =?us-ascii?Q?Pgx+lBMvyvm/Xh/2wj6di5tm1DdDgaSo2mMeG+sgPnf97o1zT6CRH+nP/FHG?=
 =?us-ascii?Q?Q+TKsnjsF5I5S8ImatZmWBGaRqKGW9+JiRtpH+QbLUjWTh5vINalrPU/6eq2?=
 =?us-ascii?Q?7i86Zj7JUWroUJsbGTpUpvLB4tRIK9NSIGTcxXUq1BMQ7FpAzo8sqeN7T+1v?=
 =?us-ascii?Q?GhVfkusJp0obtc/ZSn3SHEMDxWoCuhVIDUTjKmPbwEbqRaBeITn6JuEvWsEm?=
 =?us-ascii?Q?KdPt5rT1d/PofXWobRW5N359L+i/ISCXgFbVLjGkhEvDSrf6VzHwGeHGwkpK?=
 =?us-ascii?Q?Ie1VQBP5EAdMP+4FVCRd95h0ecRfwo4JItTQkU0ClxlDzEJUzMrXRXrN4AIF?=
 =?us-ascii?Q?XLIrxSvEYqrWA8v2xHh4PbOxCwKXw/RaIzmzU8m/31r5mdo0ehbQ8Y+5//nl?=
 =?us-ascii?Q?K4zv3SHCh+Y2ZxdJ9km4x79sEHs/zbpstIX7cVglTJP5g4/hI+Tj13rEpm0+?=
 =?us-ascii?Q?0x92J9A09CNw9LyL2LNoNde71yvwO0SJNr/b+b/SqvjD4uk7MngG27WUEgGP?=
 =?us-ascii?Q?eSoe723lkYkxCSt+lLiCKdhRawCYYKNtvc7V+/mkmXTgDdi4uAqyGcrBewR3?=
 =?us-ascii?Q?7boEjv5VVCfIP3zng71jSNucGNT2agV9zq1yScbKOMRYQnaJQa7LRRK7fEDF?=
 =?us-ascii?Q?ixpRr1T+x0rynTTYbSrcGaBWDbO8vD6F53deVZ/1gKLO2t6lRXz4ATp7BE7e?=
 =?us-ascii?Q?1M3vNq/w/pV6eItoOzIC8qdyYt5JHGQsrZPEe9yoo+LuGYsa1AAjExEYD9x/?=
 =?us-ascii?Q?KZbOG+8NWowNRyTAQSezftVKGQSZ8smxvB1TsaRNru4x3iGilRwVkz5uYOSn?=
 =?us-ascii?Q?AWU4wT+teO78oefoO3mp/3+9gszVJ4HgWtYuondrf2cGkoxwg8eY5svlbwMJ?=
 =?us-ascii?Q?SdSSHLaLCMtOcBDwhLDvtami4m/twcZxlKkFQtLw3k0fx0M6GWbnV3wlhsGb?=
 =?us-ascii?Q?UBNYBSdhgirZnxOgQ0gfsNuuSBlqjzeMOz/HjA1rpX3YEe60ilnijOTiOxPI?=
 =?us-ascii?Q?KNT3ggp3OkXfMwD4k7kMRgUqLGUTN6axQnaHU5F7UZx3XwfusfCMzaCjaRTT?=
 =?us-ascii?Q?y5lx9ylpcMLwhmhmSGYJ3GYOmU7tkn5JDPmdKUaSr18AR0/hHc5EMLSB2Qfd?=
 =?us-ascii?Q?OP5YhPA5vs37SGNGFPHT5pgEHUWZcu+AYHxS1Vq51WfiKe+GhCwuJsqUrKLR?=
 =?us-ascii?Q?FGvgBIqgJj2FYb+prb4wECRUtQEgzWn68XaUgbWoJ8K0a46ZIzQgQ792arl6?=
 =?us-ascii?Q?cy1RAeJ6rpa9trtl36ckECflcndTF4eS93+64Fdy+QBTM2axjtafb/5mrJey?=
 =?us-ascii?Q?nJzK0uV6u4JCp+pp8Mj7dm1eXcuweaRDRV8LjOs/0HSXUJREj+5Wdqy4lqQK?=
 =?us-ascii?Q?+NOspOLgcX3vsL2Lk+9+YSvQnjxe6gJRsQGgXF3RViQogC7PpFxqQ9v3taU0?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s9lnyaTxXw517bM77mesNie1aLonC7n1U7Hb5diWUSswqu12ltrNU8/L3QiM/U5un/VymmgoJJMYEBb2futQbaAHtlcj1qWdAKU3b3aSDPgxD1ZFKv0JPO2GVcPuT+I5R5JJUCZwkRTSp4qfl+z7mcuex/1ZWpS6LIsEWhB7sCYoV17LvkLOGORDTiwwQ/1CL7cLvfMpVVUDAU+AfHvj68JE8JJ8mP0qGzIkW3p848Xzt+Epgu3CQaaTVxEvS2X6BVFTsu94VA0jTTm/moPm813Ld2sFSSbgCE4UfEpVgBPIAx2zk7KnGae+9K4PH3XJAheu5WphjJxqQiObCiiEJOQz7Ws6w7y6xtAQqMvEVcJ8I7hiPZmPHYy/lXYTf/qWEjOXCa6ZxVD6iulxDXPkXBXvN4YxVKwUcoC1HqxhxGwG/4ZJwlJHgi1ZINqHkFBMA3/cLTbBtJiXHnEs5IfombSMBE7trcSMeC7eUb++Pf0kvNQ77WDNSSBkri+bo2O03VJRp1VCSnChxYSdl31u9NIkWdb20tbhZ12pgJ50FisgpPIGq2RJWiV+HIqYS5tnadXWExQ7VPR4EomDws5RhCq93j1dYZkHM2nXVeiYmTU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2f2444-f02d-4b4f-d525-08dce6138a15
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 14:31:17.6243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v81ufmDQSpK/VYyvVhC45XtdA9j73zvId5QNlvNXvCetbCJwRUQKLTDKyNPqKfIJw3bu4B6zQqBQ3tl0E+i4T4b0p3+DFw39GPxVg5KAqVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6503
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-06_11,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=961
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410060105
X-Proofpoint-GUID: uNa2rpViyG1ARU_8VW7YJQqruBxqg7JU
X-Proofpoint-ORIG-GUID: uNa2rpViyG1ARU_8VW7YJQqruBxqg7JU

There has been a nasty yet subtle maple tree corruption bug that appears to
have been in existence since the inception of the algorithm.

This bug seems far more likely to happen since commit f8d112a4e657
("mm/mmap: avoid zeroing vma tree in mmap_region()"), which is the point at
which reports started to be submitted concerning this bug.

We were made definitely aware of the bug thanks to the kind efforts of Bert
Karwatzki who helped enormously in my being able to track this down and
identify the cause of it.

The bug arises when an attempt is made to perform a spanning store across
two leaf nodes, where the right leaf node is the rightmost child of the
shared parent, AND the store completely consumes the right-mode node.

This results in mas_wr_spanning_store() mitakenly duplicating the new and
existing entries at the maximum pivot within the range, and thus maple tree
corruption.

The fix patch corrects this by detecting this scenario and disallowing the
mistaken duplicate copy.

The fix patch commit message goes into great detail as to how this occurs.

This series also includes a test which reliably reproduces the issue, and
asserts that the fix works correctly.

Bert has kindly tested the fix and confirmed it resolved his issues. Also
Mikhail Gavrilov kindly reported what appears to be precisely the same bug,
which this fix should also resolve.

Please note - I am intentionally holding off on cc'ing stable until we've
had a chance to be satisfied the series has stabilised in 6.12 as this is a
highly subtle change.

v2:
* Majorly improve clarity of commit message describing the problem.
* Add a reproducable test.
* Add missing maple tree mailing list to cc- list.

v1:
https://lore.kernel.org/linux-mm/20241005064114.42770-1-lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (2):
  maple_tree: correct tree corruption on spanning store
  maple_tree: add regression test for spanning store bug

 lib/maple_tree.c                 | 20 ++++++--
 tools/testing/radix-tree/maple.c | 84 ++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 4 deletions(-)

--
2.46.2

