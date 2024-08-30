Return-Path: <linux-kernel+bounces-309307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D36BC9668BA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A4B1F240A3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3B61BE24F;
	Fri, 30 Aug 2024 18:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TKkvRVV9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qu2zPO2y"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8251BC9F6
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 18:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725041471; cv=fail; b=hp4E+87rI43nS4qthHrH8nuGq+2HOGr1oK9A5rqzm63ujsZkjr6eaSZbMD1wUkwUS5rSTd4RaYiOxAOVAiptYmh9U1BVFgQGC1KVj6x+naz5mojIPr6wAEqlFBxhNZrg+cl455j+otPCDmZ+z02APkhf9h5eMt8IpzwItCgQLIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725041471; c=relaxed/simple;
	bh=xIHbEu940IgtCujzFKccKU2I9LuYBJc2zE2hrav80JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F1nwZ5nukH0JaRDBDDQXItEP/BvMmT9lnpg4a/v1zRgXptp5ONBmWl21WXw0oxbJ0HA4dy5tg90UAG2RRBV8Xg0rzf1nBjo554Mo0olF9a0xiHxAZ1+7mSKg2WrMJMWwlTvdtIUb6RbaLb4i0DKcveQS9F65m5NH3uHDFQN4hwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TKkvRVV9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qu2zPO2y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UI0UxJ009289;
	Fri, 30 Aug 2024 18:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=fazFJsHyHkXUn6atixEtgs51xdHzmo2Rb8GkbkVPQ5E=; b=
	TKkvRVV9PjPGqK7hXalDrNgf94vcmp4KxjzlMxgsOqreJjQN0MnO4xurqKXVPhJd
	N7GpnKOvSjWYoIouJINLp50WGyHxcwoEO5F38kAHj+/11O3CIisuN/9PAutrsYHD
	TLIJc+9+++kG3cUeyJ6pM/6YbZqqnfz1gpiVmubnaSQoP0sr5GuPcvZ2THA/vSkT
	5goGXT9iwcXcTfeoT1EFEdvqp5l+yfXYG/y80WgcOjlVrxL04aNXwGClmCpOTbtF
	KJtFnI8J/Vod8eo6Jh8bxj0rmtq3IOpHGE/kx1AhjgOghmsAbGr1sdHWYrbiNVtJ
	j95d5FBvex0lK7UYhzi+ug==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41bfgj8gwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 18:10:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UH7202016697;
	Fri, 30 Aug 2024 18:10:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 418a5wruc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 18:10:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2ejLURu5U7+TM/G3jLbOGXyf02VT2lWmmdSp88N2VKhao4cXFcQ2I4Iy2U2g+Ne/H80P6z8RALhMvj986rP6pwVePeQES+123ttTY1IAfylrqN3+33ExVUYoPP4HRJ29rRMinKQUguR3NQJa0ACqHmqE6+Gz676XsECJvDWXvAu6bQg3XxaocqgQhE5aR90B64gddm7EKoBJaRcBBsFmDXVti555ivqvaGT3T7+IX9oNznI9YG3fEBdUS9nYcuINyOlWZPi1rlHmf9VpWZmBLjGsrHGksl8xnhBaHJNo4sU5EyODtoQ6bU+fO3s6Vl+bp7Zr4EP7ZUXiCix4Hwgcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fazFJsHyHkXUn6atixEtgs51xdHzmo2Rb8GkbkVPQ5E=;
 b=yaR672JmD9RvGWDlRrHk56PvELFYkPquJRfc9ad3II9lJwK4KmzwxzeIWFQsERQiA6KyLIMj/XKOL5NDjv9sIBJ/p/ANQ8qGcopkrd72q3emsx6k3rWSjO9cbvUkiZf8hNgWaHlllZl5mOAUWVBGuvnOFgYZL6P2asjMeBKzDbftxAno+9d1un59TlUwfA63EYGLeu6ac3RJNIPVJw6UivwG5C7lfu6iCkRhC+iCFU0bs9ZIMt0Yib7C5VsEjXfXE5Ungv7uJI4MKGIesGfkkltmDdWObDp00d+anli2PcmIQ7kx6GuRUTHZth4tzMV0+7lgTTmNdZsPm/Lhezn3zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fazFJsHyHkXUn6atixEtgs51xdHzmo2Rb8GkbkVPQ5E=;
 b=Qu2zPO2y0qW+r8iIGN06cbjtGwigNzTfPCZOhO+nX7Yik13h3zLC8tKFC6J+6XGDwFRPUgHkbDzBYe+zSJXk2KOcxf6UA2LDhV19js6hSANNRvsUs5ZRRsneqam13CVfRt6xyQDbcKn5ieMLnyMRCJxrkXeZtEQjiB/6PTv0j94=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA0PR10MB7276.namprd10.prod.outlook.com (2603:10b6:208:3dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Fri, 30 Aug
 2024 18:10:54 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 18:10:54 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 09/10] mm: refactor vma_merge() into modify-only vma_merge_existing_range()
Date: Fri, 30 Aug 2024 19:10:21 +0100
Message-ID: <2cf6016b7bfcc4965fc3cde10827560c42e4f12c.1725040657.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725040657.git.lorenzo.stoakes@oracle.com>
References: <cover.1725040657.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0016.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::7) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA0PR10MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae8b363-e916-4b4d-9134-08dcc91f1685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A7ZpZIz9PLgWQK6aAf11ecMNyXLg/8+AnfqIcNQslXJ3VrsrNaU0opXn2tQv?=
 =?us-ascii?Q?fjILH4g1anEPb/NAcGHudCrAmWv/e300VdRPRDxUDzPdFApMii5V88AkDU40?=
 =?us-ascii?Q?PVhY+TBtgMZFqzwWdaZi1jtzBPgfChmOSyzKX0NNdh8KrEUt3jvWvQbB1UwL?=
 =?us-ascii?Q?Fl94Uv9cPR7ihNvHz7MfDLRpgsKcTgLqNfkkA4YFm6/Gen7OhDj2+gN+F9xR?=
 =?us-ascii?Q?4qfBaKeVf+EJvTSFrtkL2gUIhwDVaKMRf1pZLLjsInIQn5H9QEYhzxWZXJBD?=
 =?us-ascii?Q?hkhDc8DIQNzk9wIuMZoWJWAeKTY/wH6gw6B1X93JUqGfnagG27BuAOuJjP9L?=
 =?us-ascii?Q?2o+pn70ZhmIixHIAU7nwL/+12VkyynFVwXOIub3Kx8p7atSvjDNzP2cOQv0U?=
 =?us-ascii?Q?I9Nxzm1qxSbEXuf57glQsLWI5qK6b4o4bvvUWYzOJLW1Ag4tdHS/+6It6QWO?=
 =?us-ascii?Q?BQjYlEws9rlE3dA2KC8VkYnhYVzRhehlOfk5kq7mL1dPa/U9yVfx3tuUhXQr?=
 =?us-ascii?Q?zoQZjuNCd4aAMwERs8a4tmNhofmoCb+v3CgmyoOrzkAzVq4KkgBlYK4Ls9Yd?=
 =?us-ascii?Q?a0wU56ayEDxusOD10rnc9c2fHxAWRS0aUydvwNnDW6DQjYCxzsD6A9qBB24E?=
 =?us-ascii?Q?nzdx6ZHF1WHpnDke9Ddx7ln2lvYQrOfuk+eIInRkTKFaNN6oRXYhgj7teQjA?=
 =?us-ascii?Q?3JgdBuuS/so5y3cuSDY92ehqSilIk2IhH0Om2qD+TuE5d6QT+yqRmO6uWMb3?=
 =?us-ascii?Q?qtkDlHcbSJ7vGhTlO8INyU4MVC58zyXFho/2xXMRsEAE5VdZolseuizzywn7?=
 =?us-ascii?Q?Cx+GLDxpBnOJyq81kC6INA0LfZk52/e2QDBxqUjvvUMO3LRMrqAJ06omLGx6?=
 =?us-ascii?Q?CUQaDwYaJTNzqB/dWLINF3uB3cnYC/GaoKYfDfaqFMO4tIrCX9Msg0U7j57G?=
 =?us-ascii?Q?F6BYkMraqobENXF42K9fjGH59D9hK9t33UMQWahsO3rmXxXvaMgbwLjjp3tV?=
 =?us-ascii?Q?Uta+cUTq816fhis7I1i6vIG2tSyy7DGKMVbPjAVA9edh6xdmhLrDuWEv0Hdu?=
 =?us-ascii?Q?33fOdsocg2QLwzSF6apNnuFRzj05Z+mRYCXqvNc5+Akd6H61knHnFL4F8fdG?=
 =?us-ascii?Q?XMo0G4INLukFYjmZgzD4zy0UzN5mRSFqK6tqF1uDJrfUtG9WnhUEZEOHEWjO?=
 =?us-ascii?Q?irCfqUCiKpMPNO7QbTMCtT35ww8Bu8B493WWhmsl2qnkra5i964IBCywZA3z?=
 =?us-ascii?Q?ii6aa7sVnO8do+QonUncZYFsb3f2AbVQuud05L9pR3ngapkWtDL0V698wI6p?=
 =?us-ascii?Q?HO7qOZ33IOkWDgLhPeqPyF5b+Ia78ubzQsprNkrlOSdw6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jM5YkDiux3eiBcHDPxEEXNzKG6+JttBGgWwebKMMDZ9yLcB3m/qgZCLxeII4?=
 =?us-ascii?Q?Osj8WAscf8qFanGbSZSzNBcayvHJ3d7d9M5+OPRBjTN0a1Wqf8uVPsO/hlzi?=
 =?us-ascii?Q?lfFkTLKjYEo91Zd/ZhhAStNqaULMBK5dgj50O39swkb/XZ2re6dVG+UamnPy?=
 =?us-ascii?Q?NeSw6rMhZg3CJeeriuQV8avSL6FqEQKQK4ks0kZCG8mNJmkp6QYXCtWpd5Xa?=
 =?us-ascii?Q?vsVoV+MqJYOX/t3r61Zp6pSZKEM4EZYUxujDP/V74+LWXn8jZARIf//l5ST9?=
 =?us-ascii?Q?BoNfWlNIB/8VbsJftir+okaDE6vs7SN++DYDTOfiEot7vJ0N0cwiqthA9+KW?=
 =?us-ascii?Q?wQYQRGGqzKvBLp9WScvw6U6MCliU5FbXMrS8+zYWMu5ATbb84YFj5ORheT/9?=
 =?us-ascii?Q?xvYWNnEyZLk1Mn3KCqNSsjJHiWmQus33zqvQU9gJvob8r7Ct+pT7lYt9aBLQ?=
 =?us-ascii?Q?FlG1hOSD877eCDB13iO32UP6OuSZyrYGnwhTpXwFSqDUvQYRoFNk1iKKyMbB?=
 =?us-ascii?Q?AgjpQJ3PHmo4aumLIz9QSTEfhbDI7bH1CsVDjABGpV8GRbvI5sut9bPtfhHS?=
 =?us-ascii?Q?EBcPHtXFB/QeYMzSV0vh8aJerP672Fys7ZRpus2YYdPnA1tG49O1ROPqijAJ?=
 =?us-ascii?Q?DhJ6TnmkZIgu/1u+4ucwtsDyBdJBKXy5gbS+k93w9i+moXYE/4h3HrTLwxj8?=
 =?us-ascii?Q?I5A8v40BZi2DCOWrBbBzbIXKFooNrUHaOY4rGvg6zISqMuZbIXL8JsXRILTN?=
 =?us-ascii?Q?UM7hTBmm5hW+J8/SdRPTUDlN2eJeQCFNllSkVpxfpIvNKEGr1JxIf/hYjfak?=
 =?us-ascii?Q?bC9wu7rw4dfbBSVxi4lIo3vGqUTH7dXxgAw5z0c70TXvWeHhlgP6SVaCMWEI?=
 =?us-ascii?Q?H6+wURG7KkfE4bpj8E0otByTVkR7scmg1FAFzqeUxiQeyOOHTDipZ6Mf2Dce?=
 =?us-ascii?Q?8UUZv3dZ016eGbewkVVOGJjpO6Py50avTLO94i7CguSiFOP4fY01+KtDRGyc?=
 =?us-ascii?Q?IGhmB0EF2s/j5kxCZfeXO6eQRlq4h0gDvuPA9lTu/+fSxwh7gHkcHwmJ+lAo?=
 =?us-ascii?Q?EwCORqyUc4yEfFXVrrJzjHnJPkv3ZqqKvUYHSqzQz4zeezp2DE5HeR4BlYqR?=
 =?us-ascii?Q?srl1Asf9zl1JcOOMMRvjHpBXsGDYG/n5wKom4lTr2K4ZbDdnVKMqPUewPSG0?=
 =?us-ascii?Q?SRj2Jgvf/82sdtt+k7UvLPHUDMYwIP8KYmC8hmFtOp6pWcWF+Tijl50QTcyt?=
 =?us-ascii?Q?7o1ipncV6Dq2/9+sX0hH/VqZN9GphjO5VOYziRt4HBwPZ5+9Px0YpvXnH4r+?=
 =?us-ascii?Q?OgWiR3Ek8OVfnLrGRIGK8kxD2qX5P6e/HtGFRGxlV6NSoNSTX/+5esg+nTON?=
 =?us-ascii?Q?KweJzCyUygVR05NqgC1+gyTsllxtqQFI4r/6XOjjaf+eAM0JHWvDQ92dpQMD?=
 =?us-ascii?Q?qBPalPHPcC40HxurFia8rTl31/bgh5WCl4uSHud9i8QnVN9hDVw4AmqnsHSc?=
 =?us-ascii?Q?k2UsgKNVDFQiRYeM7DA4YcQst6l3WgwDJy6h1bxdItLSbK+qxAL2AgBVfLbd?=
 =?us-ascii?Q?v5h8mI1WlD1RrFCN6SnCT6mwc2Y5VCqEvVqcDLrSMpcv2+NK5wkc4z0+bhnv?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mzVXgZd9T98gGIoSSn+G0RXyOGe0ZlaFu9KASeprhm97P0j9B8XVpU4LtwCQ9yxhhYsh4g63ajlHqbPj62kRkyky0Mimem0EEXxzpU88Hy/a+2W7FTGfLuXmDVtTlVZSzo7HSbkM7rvto/Qb1Sot9U2HBAuVRRwAMd9ZJA0bKiKWend05WrWzvmjV8JWFftT4In6CSyOyGgfyWchiAS8fG11+geDKXTswSDSDCACaPUmu53o9m5xRsTxbyf9akBTBPAR3atUXr2qqQeopE+UCTGTXDVsyHWmkeDnBQE4nXXsmoXzMTO7lHjvMlGahIgzlih7LzQOgIdQu1zOYo1joeJS7oSHc9VJEMtQELE5xeKxc0M94WeV0NMK0o7A85eAiWp1lRHL7FAC0X3pAKfdV07BRSVJhfU9HVBOPjJWU+qVBpwzGtnmLXLyAJ7S71H6C5xDZw2MYCTAf/fc2CBLIfEwewUzYeXNDlthZA+e+IZqVzuUPZD/RLkWK4J0/5aS1/mlUklsnoUajIoWx4bmAZLr/AcRBXI1uij58IL5JOnn5WB4TQUpthWn8Fnj3uWKTItRJrZCfacD3S0+VL2GpN828hz9zbYRZXM5K96g920=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae8b363-e916-4b4d-9134-08dcc91f1685
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 18:10:54.1060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2Wb7S+qNSSbcUYNU1tzMID2U4tJeq1TTbB7p7Vyz/hXtkB+H8vqJ2SMeLnxe5hAzMGrJmaULfKdNj9idF/WZCUR0JzalVcL9Wpq+s1Frk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7276
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300138
X-Proofpoint-ORIG-GUID: gXbHQI5WwrIcY9G3Rmoid2i5UQz-Glb-
X-Proofpoint-GUID: gXbHQI5WwrIcY9G3Rmoid2i5UQz-Glb-

The existing vma_merge() function is no longer required to handle what were
previously referred to as cases 1-3 (i.e. the merging of a new VMA), as
this is now handled by vma_merge_new_vma().

Additionally, simplify the convoluted control flow of the original,
maintaining identical logic only expressed more clearly and doing away with
a complicated set of cases, rather logically examining each possible
outcome - merging of both the previous and subsequent VMA, merging of the
previous VMA and merging of the subsequent VMA alone.

We now utilise the previously implemented commit_merge() function to share
logic with vma_expand() de-duplicating code and providing less surface area
for bugs and confusion. In order to do so, we adjust this function to
accept parameters specific to merging existing ranges.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c                | 508 ++++++++++++++++++++--------------------
 tools/testing/vma/vma.c |   9 +-
 2 files changed, 264 insertions(+), 253 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 566cad2338dd..393bef832604 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -587,29 +587,278 @@ void validate_mm(struct mm_struct *mm)
 
 /* Actually perform the VMA merge operation. */
 static int commit_merge(struct vma_merge_struct *vmg,
-			struct vm_area_struct *remove)
+			struct vm_area_struct *adjust,
+			struct vm_area_struct *remove,
+			struct vm_area_struct *remove2,
+			long adj_start,
+			bool expanded)
 {
 	struct vma_prepare vp;
 
-	init_multi_vma_prep(&vp, vmg->vma, NULL, remove, NULL);
+	init_multi_vma_prep(&vp, vmg->vma, adjust, remove, remove2);
 
-	/* Note: vma iterator must be pointing to 'start'. */
-	vma_iter_config(vmg->vmi, vmg->start, vmg->end);
+	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
+		   vp.anon_vma != adjust->anon_vma);
+
+	if (expanded) {
+		/* Note: vma iterator must be pointing to 'start'. */
+		vma_iter_config(vmg->vmi, vmg->start, vmg->end);
+	} else {
+		vma_iter_config(vmg->vmi, adjust->vm_start + adj_start,
+				adjust->vm_end);
+	}
 
 	if (vma_iter_prealloc(vmg->vmi, vmg->vma))
 		return -ENOMEM;
 
 	vma_prepare(&vp);
-	vma_adjust_trans_huge(vmg->vma, vmg->start, vmg->end, 0);
+	vma_adjust_trans_huge(vmg->vma, vmg->start, vmg->end, adj_start);
 	vma_set_range(vmg->vma, vmg->start, vmg->end, vmg->pgoff);
 
-	vma_iter_store(vmg->vmi, vmg->vma);
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
 
 	vma_complete(&vp, vmg->vmi, vmg->vma->vm_mm);
 
 	return 0;
 }
 
+/*
+ * vma_merge_existing_range - Attempt to merge VMAs based on a VMA having its
+ * attributes modified.
+ *
+ * @vmg: Describes the modifications being made to a VMA and associated
+ *       metadata.
+ *
+ * When the attributes of a range within a VMA change, then it might be possible
+ * for immediately adjacent VMAs to be merged into that VMA due to having
+ * identical properties.
+ *
+ * This function checks for the existence of any such mergeable VMAs and updates
+ * the maple tree describing the @vmg->vma->vm_mm address space to account for
+ * this, as well as any VMAs shrunk/expanded/deleted as a result of this merge.
+ *
+ * As part of this operation, if a merge occurs, the @vmg object will have its
+ * vma, start, end, and pgoff fields modified to execute the merge. Subsequent
+ * calls to this function should reset these fields.
+ *
+ * Returns: The merged VMA if merge succeeds, or NULL otherwise.
+ *
+ * ASSUMPTIONS:
+ * - The caller must assign the VMA to be modifed to @vmg->vma.
+ * - The caller must have set @vmg->prev to the previous VMA, if there is one.
+ * - The caller must not set @vmg->next, as we determine this.
+ * - The caller must hold a WRITE lock on the mm_struct->mmap_lock.
+ * - vmi must be positioned within [@vmg->vma->vm_start, @vmg->vma->vm_end).
+ */
+static struct vm_area_struct *vma_merge_existing_range(struct vma_merge_struct *vmg)
+{
+	struct vm_area_struct *vma = vmg->vma;
+	struct vm_area_struct *prev = vmg->prev;
+	struct vm_area_struct *next, *res;
+	struct vm_area_struct *anon_dup = NULL;
+	struct vm_area_struct *adjust = NULL;
+	unsigned long start = vmg->start;
+	unsigned long end = vmg->end;
+	bool left_side = vma && start == vma->vm_start;
+	bool right_side = vma && end == vma->vm_end;
+	int err = 0;
+	long adj_start = 0;
+	bool merge_will_delete_vma, merge_will_delete_next;
+	bool merge_left, merge_right, merge_both;
+	bool expanded;
+
+	mmap_assert_write_locked(vmg->mm);
+	VM_WARN_ON(!vma); /* We are modifying a VMA, so caller must specify. */
+	VM_WARN_ON(vmg->next); /* We set this. */
+	VM_WARN_ON(prev && start <= prev->vm_start);
+	VM_WARN_ON(start >= end);
+	/*
+	 * If vma == prev, then we are offset into a VMA. Otherwise, if we are
+	 * not, we must span a portion of the VMA.
+	 */
+	VM_WARN_ON(vma && ((vma != prev && vmg->start != vma->vm_start) ||
+			   vmg->end > vma->vm_end));
+	/* The vmi must be positioned within vmg->vma. */
+	VM_WARN_ON(vma && !(vma_iter_addr(vmg->vmi) >= vma->vm_start &&
+			    vma_iter_addr(vmg->vmi) < vma->vm_end));
+
+	vmg->state = VMA_MERGE_NOMERGE;
+
+	/*
+	 * If a special mapping or if the range being modified is neither at the
+	 * furthermost left or right side of the VMA, then we have no chance of
+	 * merging and should abort.
+	 */
+	if (vmg->flags & VM_SPECIAL || (!left_side && !right_side))
+		return NULL;
+
+	if (left_side)
+		merge_left = can_vma_merge_left(vmg);
+	else
+		merge_left = false;
+
+	if (right_side) {
+		next = vmg->next = vma_iter_next_range(vmg->vmi);
+		vma_iter_prev_range(vmg->vmi);
+
+		merge_right = can_vma_merge_right(vmg, merge_left);
+	} else {
+		merge_right = false;
+		next = NULL;
+	}
+
+	if (merge_left)		/* If merging prev, position iterator there. */
+		vma_prev(vmg->vmi);
+	else if (!merge_right)	/* If we have nothing to merge, abort. */
+		return NULL;
+
+	merge_both = merge_left && merge_right;
+	/* If we span the entire VMA, a merge implies it will be deleted. */
+	merge_will_delete_vma = left_side && right_side;
+	/*
+	 * If we merge both VMAs, then next is also deleted. This implies
+	 * merge_will_delete_vma also.
+	 */
+	merge_will_delete_next = merge_both;
+
+	/* No matter what happens, we will be adjusting vma. */
+	vma_start_write(vma);
+
+	if (merge_left)
+		vma_start_write(prev);
+
+	if (merge_right)
+		vma_start_write(next);
+
+	if (merge_both) {
+		/*
+		 *         |<----->|
+		 * |-------*********-------|
+		 *   prev     vma     next
+		 *  extend   delete  delete
+		 */
+
+		vmg->vma = prev;
+		vmg->start = prev->vm_start;
+		vmg->end = next->vm_end;
+		vmg->pgoff = prev->vm_pgoff;
+
+		/*
+		 * We already ensured anon_vma compatibility above, so now it's
+		 * simply a case of, if prev has no anon_vma object, which of
+		 * next or vma contains the anon_vma we must duplicate.
+		 */
+		err = dup_anon_vma(prev, next->anon_vma ? next : vma, &anon_dup);
+	} else if (merge_left) {
+		/*
+		 *         |<----->| OR
+		 *         |<--------->|
+		 * |-------*************
+		 *   prev       vma
+		 *  extend shrink/delete
+		 */
+
+		vmg->vma = prev;
+		vmg->start = prev->vm_start;
+		vmg->pgoff = prev->vm_pgoff;
+
+		if (merge_will_delete_vma) {
+			/*
+			 * can_vma_merge_after() assumed we would not be
+			 * removing vma, so it skipped the check for
+			 * vm_ops->close, but we are removing vma.
+			 */
+			if (vma->vm_ops && vma->vm_ops->close)
+				err = -EINVAL;
+		} else {
+			adjust = vma;
+			adj_start = vmg->end - vma->vm_start;
+		}
+
+		if (!err)
+			err = dup_anon_vma(prev, vma, &anon_dup);
+	} else { /* merge_right */
+		/*
+		 *     |<----->| OR
+		 * |<--------->|
+		 * *************-------|
+		 *      vma       next
+		 * shrink/delete extend
+		 */
+
+		pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
+
+		VM_WARN_ON(!merge_right);
+		/* If we are offset into a VMA, then prev must be vma. */
+		VM_WARN_ON(vmg->start > vma->vm_start && prev && vma != prev);
+
+		if (merge_will_delete_vma) {
+			vmg->vma = next;
+			vmg->end = next->vm_end;
+			vmg->pgoff = next->vm_pgoff - pglen;
+		} else {
+			/*
+			 * We shrink vma and expand next.
+			 *
+			 * IMPORTANT: This is the ONLY case where the final
+			 * merged VMA is NOT vmg->vma, but rather vmg->next.
+			 */
+
+			vmg->start = vma->vm_start;
+			vmg->end = start;
+			vmg->pgoff = vma->vm_pgoff;
+
+			adjust = next;
+			adj_start = -(vma->vm_end - start);
+		}
+
+		err = dup_anon_vma(next, vma, &anon_dup);
+	}
+
+	if (err)
+		goto abort;
+
+	/*
+	 * In nearly all cases, we expand vmg->vma. There is one exception -
+	 * merge_right where we partially span the VMA. In this case we shrink
+	 * the end of vmg->vma and adjust the start of vmg->next accordingly.
+	 */
+	expanded = !merge_right || merge_will_delete_vma;
+
+	if (commit_merge(vmg, adjust,
+			 merge_will_delete_vma ? vma : NULL,
+			 merge_will_delete_next ? next : NULL,
+			 adj_start, expanded)) {
+		if (anon_dup)
+			unlink_anon_vmas(anon_dup);
+
+		vmg->state = VMA_MERGE_ERROR_NOMEM;
+		return NULL;
+	}
+
+	res = merge_left ? prev : next;
+	khugepaged_enter_vma(res, vmg->flags);
+
+	vmg->state = VMA_MERGE_SUCCESS;
+	return res;
+
+abort:
+	vma_iter_set(vmg->vmi, start);
+	vma_iter_load(vmg->vmi);
+	vmg->state = VMA_MERGE_ERROR_NOMEM;
+	return NULL;
+}
+
 /*
  * vma_merge_new_range - Attempt to merge a new VMA into address space
  *
@@ -757,7 +1006,7 @@ int vma_expand(struct vma_merge_struct *vmg)
 	/* Only handles expanding */
 	VM_WARN_ON(vma->vm_start < vmg->start || vma->vm_end > vmg->end);
 
-	if (commit_merge(vmg, remove_next ? next : NULL))
+	if (commit_merge(vmg, NULL, remove_next ? next : NULL, NULL, 0, true))
 		goto nomem;
 
 	return 0;
@@ -1127,249 +1376,6 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
 }
 
-/*
- * Given a mapping request (addr,end,vm_flags,file,pgoff,anon_name),
- * figure out whether that can be merged with its predecessor or its
- * successor.  Or both (it neatly fills a hole).
- *
- * In most cases - when called for mmap, brk or mremap - [addr,end) is
- * certain not to be mapped by the time vma_merge is called; but when
- * called for mprotect, it is certain to be already mapped (either at
- * an offset within prev, or at the start of next), and the flags of
- * this area are about to be changed to vm_flags - and the no-change
- * case has already been eliminated.
- *
- * The following mprotect cases have to be considered, where **** is
- * the area passed down from mprotect_fixup, never extending beyond one
- * vma, PPPP is the previous vma, CCCC is a concurrent vma that starts
- * at the same address as **** and is of the same or larger span, and
- * NNNN the next vma after ****:
- *
- *     ****             ****                   ****
- *    PPPPPPNNNNNN    PPPPPPNNNNNN       PPPPPPCCCCCC
- *    cannot merge    might become       might become
- *                    PPNNNNNNNNNN       PPPPPPPPPPCC
- *    mmap, brk or    case 4 below       case 5 below
- *    mremap move:
- *                        ****               ****
- *                    PPPP    NNNN       PPPPCCCCNNNN
- *                    might become       might become
- *                    PPPPPPPPPPPP 1 or  PPPPPPPPPPPP 6 or
- *                    PPPPPPPPNNNN 2 or  PPPPPPPPNNNN 7 or
- *                    PPPPNNNNNNNN 3     PPPPNNNNNNNN 8
- *
- * It is important for case 8 that the vma CCCC overlapping the
- * region **** is never going to extended over NNNN. Instead NNNN must
- * be extended in region **** and CCCC must be removed. This way in
- * all cases where vma_merge succeeds, the moment vma_merge drops the
- * rmap_locks, the properties of the merged vma will be already
- * correct for the whole merged range. Some of those properties like
- * vm_page_prot/vm_flags may be accessed by rmap_walks and they must
- * be correct for the whole merged range immediately after the
- * rmap_locks are released. Otherwise if NNNN would be removed and
- * CCCC would be extended over the NNNN range, remove_migration_ptes
- * or other rmap walkers (if working on addresses beyond the "end"
- * parameter) may establish ptes with the wrong permissions of CCCC
- * instead of the right permissions of NNNN.
- *
- * In the code below:
- * PPPP is represented by *prev
- * CCCC is represented by *curr or not represented at all (NULL)
- * NNNN is represented by *next or not represented at all (NULL)
- * **** is not represented - it will be merged and the vma containing the
- *      area is returned, or the function will return NULL
- */
-static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
-{
-	struct mm_struct *mm = vmg->mm;
-	struct vm_area_struct *prev = vmg->prev;
-	struct vm_area_struct *curr, *next, *res;
-	struct vm_area_struct *vma, *adjust, *remove, *remove2;
-	struct vm_area_struct *anon_dup = NULL;
-	struct vma_prepare vp;
-	pgoff_t vma_pgoff;
-	int err = 0;
-	bool merge_prev = false;
-	bool merge_next = false;
-	bool vma_expanded = false;
-	unsigned long addr = vmg->start;
-	unsigned long end = vmg->end;
-	unsigned long vma_start = addr;
-	unsigned long vma_end = end;
-	pgoff_t pglen = PHYS_PFN(end - addr);
-	long adj_start = 0;
-
-	vmg->state = VMA_MERGE_NOMERGE;
-
-	/*
-	 * We later require that vma->vm_flags == vm_flags,
-	 * so this tests vma->vm_flags & VM_SPECIAL, too.
-	 */
-	if (vmg->flags & VM_SPECIAL)
-		return NULL;
-
-	/* Does the input range span an existing VMA? (cases 5 - 8) */
-	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
-
-	if (!curr ||			/* cases 1 - 4 */
-	    end == curr->vm_end)	/* cases 6 - 8, adjacent VMA */
-		next = vmg->next = vma_lookup(mm, end);
-	else
-		next = vmg->next = NULL;	/* case 5 */
-
-	if (prev) {
-		vma_start = prev->vm_start;
-		vma_pgoff = prev->vm_pgoff;
-
-		/* Can we merge the predecessor? */
-		if (addr == prev->vm_end && can_vma_merge_after(vmg)) {
-			merge_prev = true;
-			vma_prev(vmg->vmi);
-		}
-	}
-
-	/* Can we merge the successor? */
-	if (next && can_vma_merge_before(vmg)) {
-		merge_next = true;
-	}
-
-	/* Verify some invariant that must be enforced by the caller. */
-	VM_WARN_ON(prev && addr <= prev->vm_start);
-	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
-	VM_WARN_ON(addr >= end);
-
-	if (!merge_prev && !merge_next)
-		return NULL; /* Not mergeable. */
-
-	if (merge_prev)
-		vma_start_write(prev);
-
-	res = vma = prev;
-	remove = remove2 = adjust = NULL;
-
-	/* Can we merge both the predecessor and the successor? */
-	if (merge_prev && merge_next &&
-	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {
-		vma_start_write(next);
-		remove = next;				/* case 1 */
-		vma_end = next->vm_end;
-		err = dup_anon_vma(prev, next, &anon_dup);
-		if (curr) {				/* case 6 */
-			vma_start_write(curr);
-			remove = curr;
-			remove2 = next;
-			/*
-			 * Note that the dup_anon_vma below cannot overwrite err
-			 * since the first caller would do nothing unless next
-			 * has an anon_vma.
-			 */
-			if (!next->anon_vma)
-				err = dup_anon_vma(prev, curr, &anon_dup);
-		}
-	} else if (merge_prev) {			/* case 2 */
-		if (curr) {
-			vma_start_write(curr);
-			if (end == curr->vm_end) {	/* case 7 */
-				/*
-				 * can_vma_merge_after() assumed we would not be
-				 * removing prev vma, so it skipped the check
-				 * for vm_ops->close, but we are removing curr
-				 */
-				if (curr->vm_ops && curr->vm_ops->close)
-					err = -EINVAL;
-				remove = curr;
-			} else {			/* case 5 */
-				adjust = curr;
-				adj_start = (end - curr->vm_start);
-			}
-			if (!err)
-				err = dup_anon_vma(prev, curr, &anon_dup);
-		}
-	} else { /* merge_next */
-		vma_start_write(next);
-		res = next;
-		if (prev && addr < prev->vm_end) {	/* case 4 */
-			vma_start_write(prev);
-			vma_end = addr;
-			adjust = next;
-			adj_start = -(prev->vm_end - addr);
-			err = dup_anon_vma(next, prev, &anon_dup);
-		} else {
-			/*
-			 * Note that cases 3 and 8 are the ONLY ones where prev
-			 * is permitted to be (but is not necessarily) NULL.
-			 */
-			vma = next;			/* case 3 */
-			vma_start = addr;
-			vma_end = next->vm_end;
-			vma_pgoff = next->vm_pgoff - pglen;
-			if (curr) {			/* case 8 */
-				vma_pgoff = curr->vm_pgoff;
-				vma_start_write(curr);
-				remove = curr;
-				err = dup_anon_vma(next, curr, &anon_dup);
-			}
-		}
-	}
-
-	/* Error in anon_vma clone. */
-	if (err)
-		goto anon_vma_fail;
-
-	if (vma_start < vma->vm_start || vma_end > vma->vm_end)
-		vma_expanded = true;
-
-	if (vma_expanded) {
-		vma_iter_config(vmg->vmi, vma_start, vma_end);
-	} else {
-		vma_iter_config(vmg->vmi, adjust->vm_start + adj_start,
-				adjust->vm_end);
-	}
-
-	if (vma_iter_prealloc(vmg->vmi, vma))
-		goto prealloc_fail;
-
-	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
-	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
-		   vp.anon_vma != adjust->anon_vma);
-
-	vma_prepare(&vp);
-	vma_adjust_trans_huge(vma, vma_start, vma_end, adj_start);
-	vma_set_range(vma, vma_start, vma_end, vma_pgoff);
-
-	if (vma_expanded)
-		vma_iter_store(vmg->vmi, vma);
-
-	if (adj_start) {
-		adjust->vm_start += adj_start;
-		adjust->vm_pgoff += adj_start >> PAGE_SHIFT;
-		if (adj_start < 0) {
-			WARN_ON(vma_expanded);
-			vma_iter_store(vmg->vmi, next);
-		}
-	}
-
-	vma_complete(&vp, vmg->vmi, mm);
-	validate_mm(mm);
-	khugepaged_enter_vma(res, vmg->flags);
-
-	vmg->state = VMA_MERGE_SUCCESS;
-	return res;
-
-prealloc_fail:
-	vmg->state = VMA_MERGE_ERROR_NOMEM;
-	if (anon_dup)
-		unlink_anon_vmas(anon_dup);
-
-anon_vma_fail:
-	if (err == -ENOMEM)
-		vmg->state = VMA_MERGE_ERROR_NOMEM;
-
-	vma_iter_set(vmg->vmi, addr);
-	vma_iter_load(vmg->vmi);
-	return NULL;
-}
-
 /*
  * We are about to modify one or multiple of a VMA's flags, policy, userfaultfd
  * context and anonymous VMA name within the range [start, end).
@@ -1389,7 +1395,7 @@ static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
 	struct vm_area_struct *merged;
 
 	/* First, try to merge. */
-	merged = vma_merge(vmg);
+	merged = vma_merge_existing_range(vmg);
 	if (merged)
 		return merged;
 
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index b7cdafec09af..25a95d9901ea 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -112,7 +112,7 @@ static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
  */
 static struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg)
 {
-	return vma_merge(vmg);
+	return vma_merge_existing_range(vmg);
 }
 
 /*
@@ -752,7 +752,12 @@ static bool test_vma_merge_with_close(void)
 	vmg.vma = vma;
 	/* Make sure merge does not occur. */
 	ASSERT_EQ(merge_existing(&vmg), NULL);
-	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
+	/*
+	 * Initially this is misapprehended as an out of memory report, as the
+	 * close() check is handled in the same way as anon_vma duplication
+	 * failures, however a subsequent patch resolves this.
+	 */
+	ASSERT_EQ(vmg.state, VMA_MERGE_ERROR_NOMEM);
 
 	cleanup_mm(&mm, &vmi);
 	return true;
-- 
2.46.0


