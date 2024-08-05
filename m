Return-Path: <linux-kernel+bounces-274637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B19947AF5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB6F1C20D59
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2FF158D97;
	Mon,  5 Aug 2024 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OlAx4ukm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xTAbzBLf"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107151581E3
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722860112; cv=fail; b=FgS0EALYxXbRO8UtIIuaRQxRf2rXSYdZHKywfrnAW4tx7o/Da2K5at9Vv30SdwQzq9WOnaa2jFOQH9XxzgmgHFw7ij7inni4CZ1NkqbKq4smWX+o81PzGXn2EkBD29zd9pU9RzG5x8m8s2a+jNSxRpWIHvu7LKvppqlrNB8sXd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722860112; c=relaxed/simple;
	bh=mLh+TqcG4f2WpThq2sQ7RuR5ksHpKr16lcpJ1vlqV6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pXB+nDeDDH71f76jv9HZqI6vt5g5z2lJkMPoas3gAaL3hPyFNkyEhpPBzkBkjWBeK2x9tCZxkB0s0gFiunakjJBQyzCX313h/NzsMFxPJ/IRWEXP6Rslw28/RgsLsZwUgzXeQxauor0GVyZqcMGn711TxnkPNeLJAeZ8Df9qEq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OlAx4ukm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xTAbzBLf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4758fW4X028177;
	Mon, 5 Aug 2024 12:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=6Ple6hXc4jx7PabhHpYlqjMxMkcz+BvYXU8D+mrSt2s=; b=
	OlAx4ukmfEs+gSLRQBZnH0D+pTvqWbi7OZ8NSvgBQ1gdNWIl1bpSffN9GBcu2jQo
	Rs8UN1DRV/j+t9JQGEeNUlcF3PzTm92sh2uofPABLdtWzgXfkZHATIKpUC3pRczW
	TUFsDaKD6NxCY9/7vEid5E5EZQViT4fhF1vV476JYtlrlU5/AZHWlTAd/xucfaO0
	/1MGIICsVCUPP1bi5sGfMa3Nid9a9CQg49SoRkcjvWhduf4pXJ6SMNi/xvJP1KVI
	DKOCYZMWJRWuE9qm+wuqWgBjtyJuKko0LWJ/F9gNmGE0ixAZ2MCIud97k6Dyg3M1
	5TTzxgdo4+7+YlyhiZVJLA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sd3uje5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 12:15:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 475C1vkJ027390;
	Mon, 5 Aug 2024 12:14:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0den36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 12:14:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4ffaJ9mLd6EQrnGB+dfpsS2orI5yIRRkZlEyQ2e+cQDMScAf1wjvLYhNTQbfSIL5j5pmgS6gpjkars+LqSkSEVU3UVnokiEg+5XMXqtupqHzmKQFyoOYcibYbYiszn3BBXsz3PH6zqwhAXVkD/+aO0hz3Drj/yFHeXvC0vmbgqcd9aIjRyiAIzfPoD4KlXZbf4uJ+KBiTXkwDY4IU9FSsFA1s1IJOXMeSb+XVVYIxvccA/+Qk/XbLhZXLWCHX+453bHTlreU2ZqFjZb2lb3lP8tqEBxTDdkLPLZuoqZc1iROIDzxqfw0OBHzrcpwqi4U/oGD0Wi4Hdc6NtmSGwWpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ple6hXc4jx7PabhHpYlqjMxMkcz+BvYXU8D+mrSt2s=;
 b=rjL55n1Il4+CmyanNd366rDE5XA4akAtrMzf9nH2jUnFi2DUwFAO4wW1a52qmwgCt1FfJ4FNcTdoV1uUTBZZFjd8/btJBQQ6bSP+hJwx6n6U4O5Q+wsY14uCux0lHyIpdiaxK7WGi3qeqCX6F/H1m37zgCl5sxvlRxBpjU/dSC0Y2/uc5gUeaYPhRcyex45N4c073dKPeZZ5RgZ8UXW5XMQcIxXTi1r95A0/oEyWjfsRni+MrYMh69bR/nj15tsTSLdSGcyhZOuuoew/ABZaYp22KyAeBji5JD7FkViwTD5MTN0Yr+5gluFybSS8erEerjj7NMsMf+smFPQNRxGWMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ple6hXc4jx7PabhHpYlqjMxMkcz+BvYXU8D+mrSt2s=;
 b=xTAbzBLffCrPdrWZ2wxHFIhRvZw5Pno9o+JZxu4s/Xt4xdg5zAYKl1/1vcQfc4jtuRK+SbHPvJHCTa2sGkw47OFxYAxR1GS5h4k+E0QSMcNCmPIqvUizWVJ0VyJif9bs78PLrYBqCUSEyXqm/JWT/GF6MIUlyCg8hfXsM1NopWo=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ2PR10MB7760.namprd10.prod.outlook.com (2603:10b6:a03:574::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 12:14:42 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 12:14:42 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 08/10] mm: introduce commit_merge(), abstracting merge operation
Date: Mon,  5 Aug 2024 13:13:55 +0100
Message-ID: <3b04eb13b499df3ebf50ae3cde9a7ed5e76237fd.1722849860.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0415.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::6) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ2PR10MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: c221a2d9-754d-4ceb-81f9-08dcb5483006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E0mpvROksV7KBRvAq+cC3+7nmP55gq2ucU4u4PgIqZQjkCMJshYot8y63lk0?=
 =?us-ascii?Q?nGdYFVo+Q0NsIoqNNEEuEMosHu6pN7lU1oqeiaGw7BcsJrsBg5C100TWXlIy?=
 =?us-ascii?Q?hMVkhod4YofQCrG7BKVYwj08+KQeJ6QtNsk17F4ybv2bJKcqHf1Ad8mb4H2h?=
 =?us-ascii?Q?oPkoPiW2l5aTdTLutNddeK0mpoTtnBOxwLXk/nJboGdMboZm4WGoY4qDId7c?=
 =?us-ascii?Q?M8X1Umr4wIi8J08dsV2oL+OlLeYPpJ8IeLghCkNK5UOHo6KMWNv02p/TOek0?=
 =?us-ascii?Q?dWGBr1TjDeP+6tpaFqNBloT5okSXc1d4wFfNKHzqF16xnbGkUev+WAE1HByC?=
 =?us-ascii?Q?F+ThX3qTY5USHr6r3gntHT0gg0G77Qq9SYw56WOsejXZPnzor4FpLBVgCvfv?=
 =?us-ascii?Q?V7LbpeLNHlc9olPW93CQJDILEVXSp3X7ebdcjmgLW//1jOmCdHiZRZUDUAal?=
 =?us-ascii?Q?Zi8IdHA6J2BnCFIDkdkOQhLi2u+kTgpw9D54wJwtmmrmERrIFaN1AzWi6DL7?=
 =?us-ascii?Q?ZQbzcBmO6EUdZ07/zUTZQrkuaiE/jkpwH7UUFKjcMq/w4ilIkVvZp+mVwVWK?=
 =?us-ascii?Q?U0xQHFKybiejcIhgup4NNiJ+uj26O8tsRHKxPfeSkNsNlAaq6TdkhapOafu1?=
 =?us-ascii?Q?tYMdbcGvA7iJqhAlLcho64UOlTc9YiEl/wdUsWnGwl2EUysnqM/Z7DioP86p?=
 =?us-ascii?Q?erRnjZQoB8zrUpa9urow1zEAOaA0cJq3QZG7jQNbgGqerEoXL2FtuK+0Xovs?=
 =?us-ascii?Q?woZL4GMOiERdimGJgFSzodIXjGlqQhh3Z456rsVsxE+e6yHaHe4AphzWjgK8?=
 =?us-ascii?Q?eV16EKZ5pV5q6uC0HNHG+vbVbTsZpIfXvW37bU88wE6bhyaqcJPNcV1GBQ8J?=
 =?us-ascii?Q?BbUdFHShEFDguxpqE+CuqnGtgnCRHCsL194QNR3O6vYTj5nY1+pGPqgSkHTX?=
 =?us-ascii?Q?M/Xowt0VgtVtvJk2Z3p5EFwS+DxqxGLkPe4VJHbIcFtPaXi4a5+EgjV1MNlv?=
 =?us-ascii?Q?Rp3zrgqw+CFhCyzNCoELrM6rXDdDZi9R6nDZxavPZYl+RGD2hoRUkMOuUNJB?=
 =?us-ascii?Q?U1CZA63fv0j6CxfHD98zDnM0ThdZQg84AzMFPnlz7Mdzq19QiOYXsi9wzH7D?=
 =?us-ascii?Q?xTiA1vFI4qUH4yKyZ85l6wZlSTB5l40Sv5HQ+kbucj9M4LRdkcHO/0XbhAi/?=
 =?us-ascii?Q?o91uGX6QVXtCFJIIGingvzaKrEptqxgW+vfEaLFLxhMtvCAd/2LduBDrZ6dq?=
 =?us-ascii?Q?8Y36yANZWVw4U8LEUoeHBs94evRYgTWmZeLit1qEeAdvS//Ak+X+03yfbggn?=
 =?us-ascii?Q?Du5uFszRe2ThyX9ubVifO3hv5i0e08F089nC3aR7ShOreg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FTj99fPZ8VfH5fMcLMiuG8CVNHWCPcddi2rLLiMuSVQKQpewNkhSECYfdBYv?=
 =?us-ascii?Q?xmErc68YcYda736mSc8xJipaFeSYNHxBf5rTY1FQgsRerqV4g+sA+nb/eAhH?=
 =?us-ascii?Q?X9fl1H2qzJWpJB4Fkr86d85nJpdeyAIvpVifME0EFN/F/yiwlfu/tSaYNx38?=
 =?us-ascii?Q?PtDDeiw+qO5A703jnBJ7Rn/5PDJjpTBkkQ66I/w51etDDQguzPRbHCNC/jKm?=
 =?us-ascii?Q?mDgenKLvgrMq3ibZxR7O5oFY7zEUJmKm5ox/lhIna1brPPGLLMtvpYfIWOSQ?=
 =?us-ascii?Q?psqdoMLMa10BiyXKmL3TbhpjW774J0IgdJTUuYEuzTHRgUTcAN1seZrKRujF?=
 =?us-ascii?Q?rRc5w57VSe8VmR3PdIlUMF/6Bm7eUH6PYjRaMKN5II6nYGSo+ObTkgzRS8c4?=
 =?us-ascii?Q?VmUJOWW72T91NqOtkJ8DTsdsGVogNlZtKKKIIdUu/M00hc3Y0oupATuEg9bL?=
 =?us-ascii?Q?IRjYREc4DAbe67zjRfqwYsgEYqEWLeogrfqoxHzeg/BVw2kayoIwpOF3YC6r?=
 =?us-ascii?Q?8I9VV4jaqp0Pk30QiKj4C2yvq1wIcy8U0z7RzRASNUTUp3USmfGNPzZIzhm1?=
 =?us-ascii?Q?ESmaVWCB9rW2eeJ5mBmvyI+8Hv8f3Pm1KvRK8i3c1QAMafCDCuj8ALYfm9z8?=
 =?us-ascii?Q?+xGHSTzeR7eSJyOKvOv6B5yFcRRp7zxtyDnFDJbuCYqpG6wtweVOZ9xiIKmb?=
 =?us-ascii?Q?0vAwVCV9RIzTJfdCWNlbMzk0xe9xcN6nqlbByW3KDyO0qVfgLC1MZ8AvNGoE?=
 =?us-ascii?Q?4XJaEq/aQPao2RhH2uw83vi+ghhELjkAzmMTXTGBxIZeRw7C7P6fMghywddB?=
 =?us-ascii?Q?85hRPU8+KN67bMGYw0YdE7Vq3zTIFU3jPYVo/suUEVE/wpgKmjmXN5Smndzy?=
 =?us-ascii?Q?TLIYws5TUZd7tVqYGnZ72+snQg/3Mt9TdOwp4Glo85qC25BMNVXB2rhkQslc?=
 =?us-ascii?Q?UYdIBP6XCgFQYsZGRRtuMHC5FsBS6CWz3vcVMsv8g7jMHsEx6jcd7LbgWcnW?=
 =?us-ascii?Q?F17c+IaQObu+VI9NxU2cYGAYb/WpGMGEheSv/ldRYJTmC0IP92ECBD1ytM1Z?=
 =?us-ascii?Q?wuhTNh44DMiW8T0rsN3yj61lM+Lu/zCBcLcydtr/ClOObjBkb7pM1gMov5NT?=
 =?us-ascii?Q?NhM+wrQtBveZwqPUiP7iSocDiGq/FZ273cKGq5XfKyz7d9FQDfamhPX6kS4C?=
 =?us-ascii?Q?OzwhD4uPrA/cL05SMkpt5kWG/7Xku0gsiCMlipdE9A9J4pYsobXtB3aiOJ9n?=
 =?us-ascii?Q?mgC+w0LxhY3ZDSBGY9hvkH7WoZdWi7E1nFtAOXz0lL9uYaTXHoDHuuCirmG1?=
 =?us-ascii?Q?qZpKPTPzh0dp7N5Kr9GKwZtclxxhCuH0CZMEl6sPIHS+WV31qwaWJufih/Up?=
 =?us-ascii?Q?WtPlqATUdPPw7Z9/0g1sCU0h9DtKaySxh1xjRpZMGgDoGUUBXIGD6dxOz3LJ?=
 =?us-ascii?Q?dNmkh8eaY3X6MagwetuZm/+/R2woEbZrHieRYEotVp13wWxWs3NnDea5S1WT?=
 =?us-ascii?Q?htdQxGeigGmWqL3LQ48eqw0Gg4x37qEfm1hAcr30vRkjSgWi77JL63ryxpMU?=
 =?us-ascii?Q?DzVxWy7tAk09mwjPgxqfbFvAPHnWCfHOoIvmBUCyIBQuO3c4wdb8haVckoOo?=
 =?us-ascii?Q?kH+pc2HHdDhNhipccDG1Lr8HGsKA6+8PgQ9/GkGnZALE83+JrbwlO8ER/GcT?=
 =?us-ascii?Q?OH+XLA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ivorAhIiU7j2/vaBpcFKSJl7mVDdDDox2qJUuA4TdqE1x1QPktLFzIUsU50xf/NqeyRIMXkC1G/ccs/XZUGXZ7OHmFTKhEqeaacISxgREKBYmIW96/UglyPFsVAXdWU2bzNTKXE3xVwSgff6YZx6K4rU/7EuJTCT/JNxKbxfJEy28EiD+y82ga4dKG7zaYAL4TQde0HnHeHCwHlOjbdT6U8EJW0UBXluAqOZWXxbDbues3sayqgNg4RDGETMT475CNtW05QAOZm9IXQIRU72+l/AGtu3pNvrl7uh4qn45avpZvhdnZTX8gcd3J7uPTqVjFBqgI2r0br0jUjC4CrVEPur5Mc4cqa1C9wCrChLJQwzCEsAZn2jogbNJskT3fXeBegAd+eLHfowOXI36v9lglZDs04ZsHuYMKCrG+xGA3q8U5tTn0ZiOdqhUyNvpQLV0pWtYLLbGhgBJlH8PPMkyzw/jvDMfLTMsmhAWnnYkatRSH6jcgWo+vb2ygab8b+pJMd4zrB+oD7OAoJ3eHkaJUjKhvnQeqU+5HlG372otDX4ivqBxe4brLXGmODv2425h0D9oyvcnF6ZeoxYfzEsdak921JIpwLW+nKNLAtK6pE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c221a2d9-754d-4ceb-81f9-08dcb5483006
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:14:42.8476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cB9dycVgP8DTlhygumERxy7NKsPBmUHa8m3edpESh/KEzQBGbGHeCHsneyuseX+ZglWYtkatXQRKDyQDGj3zNB9SXJH/jh17+3hbSUisXhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_01,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408050088
X-Proofpoint-ORIG-GUID: xbUoRhxTiWarJC2wMwT7u_TxEG3X9wtv
X-Proofpoint-GUID: xbUoRhxTiWarJC2wMwT7u_TxEG3X9wtv

Pull this operation into its own function and have vma_expand() call
commit_merge() instead.

This lays the groundwork for a subsequent patch which replaces vma_merge()
with a simpler function which can share the same code.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 57 ++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 12 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index a404cf718f9e..b7e3c64d5d68 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -564,6 +564,49 @@ void validate_mm(struct mm_struct *mm)
 }
 #endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
 
+/* Actually perform the VMA merge operation. */
+static int commit_merge(struct vma_merge_struct *vmg,
+			struct vm_area_struct *adjust,
+			struct vm_area_struct *remove,
+			struct vm_area_struct *remove2,
+			long adj_start,
+			bool expanded)
+{
+	struct vma_prepare vp;
+
+	init_multi_vma_prep(&vp, vmg->vma, adjust, remove, remove2);
+
+	if (expanded) {
+		vma_iter_config(vmg->vmi, vmg->start, vmg->end);
+	} else {
+		vma_iter_config(vmg->vmi, adjust->vm_start + adj_start,
+				adjust->vm_end);
+	}
+
+	if (vma_iter_prealloc(vmg->vmi, vmg->vma))
+		return -ENOMEM;
+
+	vma_prepare(&vp);
+	vma_adjust_trans_huge(vmg->vma, vmg->start, vmg->end, adj_start);
+	vma_set_range(vmg->vma, vmg->start, vmg->end, vmg->pgoff);
+
+	if (expanded)
+		vma_iter_store(vmg->vmi, vmg->vma);
+
+	if (adj_start) {
+		adjust->vm_start += adj_start;
+		adjust->vm_pgoff += PHYS_PFN(adj_start);
+		if (adj_start < 0) {
+			WARN_ON(expanded);
+			vma_iter_store(vmg->vmi, adjust);
+		}
+	}
+
+	vma_complete(&vp, vmg->vmi, vmg->vma->vm_mm);
+
+	return 0;
+}
+
 /*
  * vma_merge_new_vma - Attempt to merge a new VMA into address space
  *
@@ -700,7 +743,6 @@ int vma_expand(struct vma_merge_struct *vmg)
 	bool remove_next = false;
 	struct vm_area_struct *vma = vmg->vma;
 	struct vm_area_struct *next = vmg->next;
-	struct vma_prepare vp;
 
 	vma_start_write(vma);
 	if (next && (vma != next) && (vmg->end == next->vm_end)) {
@@ -713,24 +755,15 @@ int vma_expand(struct vma_merge_struct *vmg)
 			return ret;
 	}
 
-	init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NULL);
 	/* Not merging but overwriting any part of next is not handled. */
-	VM_WARN_ON(next && !vp.remove &&
+	VM_WARN_ON(next && !remove_next &&
 		  next != vma && vmg->end > next->vm_start);
 	/* Only handles expanding */
 	VM_WARN_ON(vma->vm_start < vmg->start || vma->vm_end > vmg->end);
 
-	/* Note: vma iterator must be pointing to 'start' */
-	vma_iter_config(vmg->vmi, vmg->start, vmg->end);
-	if (vma_iter_prealloc(vmg->vmi, vma))
+	if (commit_merge(vmg, NULL, remove_next ? next : NULL, NULL, 0, true))
 		goto nomem;
 
-	vma_prepare(&vp);
-	vma_adjust_trans_huge(vma, vmg->start, vmg->end, 0);
-	vma_set_range(vma, vmg->start, vmg->end, vmg->pgoff);
-	vma_iter_store(vmg->vmi, vma);
-
-	vma_complete(&vp, vmg->vmi, vma->vm_mm);
 	return 0;
 
 nomem:
-- 
2.45.2


