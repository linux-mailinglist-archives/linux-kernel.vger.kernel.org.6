Return-Path: <linux-kernel+bounces-220165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B648290DDB9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E323281467
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C199615EFAF;
	Tue, 18 Jun 2024 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q9dULSPy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oaHEhFF+"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BA7176FBE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743725; cv=fail; b=N/p172ARY+B2pQeyiPKiHcRp+2cHvjMKcPvAcAzg4/zuZgM6dYEDw8RX0Cj3DzIt+IMK9vl9Xr1jDOkp7iMMqxdy0Nyi6MYgBQ1+zDpEskA9mz/0xj2F+97w5Og/5a3+OgmzAMQc8iSl3egfMNa63IN9ToQal2QIgvdLrwg0NWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743725; c=relaxed/simple;
	bh=OSpY1Yj6DpzyDLPUgfkJBOLS5OkEEvnc8KhI0wqSPGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XNZldP8kew2O27XTug7meN9fWyr2NFHCYCS56fjhEyKFGTHZg+ecMjUGzx/ppcbjpD3SrOxGN8Joy2jYvcyl88aonuFp3slDm0Mh1PzyAcooYqTCaUE9+miVezcXT88bUq+neN/YNGrsFTKhlKfUhvkeDkUT9AEk5CcXvQXD6ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q9dULSPy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oaHEhFF+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IIUuo7029804;
	Tue, 18 Jun 2024 20:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=TtkocouQTFTPgXp+1BjOXz5ILXZUoo9Pc8T1JgZ0Wmg=; b=
	Q9dULSPyjHAbH2EuB2O3txrwJy/Qq+in7gxCpsKfORLDZ1UrTlsrx4hIl/RWnEWg
	EovbaM8OpxvmBvwEacoMXEcF1Hc9F2DaMfsstkXv/YaxSpFyFGyMgzDOKVccR91x
	xtJi39PZflVE25l9TMLpOQyksjdxHDHs77FemtcewK3C1/tnQhi6qr0xdmyxTJNK
	C5U/rlLtApRPqTGoIL5AYGF84qSk5pQB74dBskNVdCq4iMeNgP5Fp3ifeDEuaBps
	Nki06ucLQ1zQgYnYCfFo7m/uHcWjjF+0fmKAix/kDggMBvWuNxOypsu5n3clxY6J
	7BgDpl1QHJq/mPtDIGwXAA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys2js5tp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IJlTIU034656;
	Tue, 18 Jun 2024 20:48:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dey4ud-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SN2mSWXCvnpFjtivEU1sMb1sorJRDsKZj1Z/eA84lvtes9o2sSpzSdVkYZYV07/q13xxvvZpSkbilskLdGXqXTcbmmPym8h8GaCm7XgbQvNIFdsD4ZinXrWTIuXukhDtILDrPf5F7xUWdWQBmmDfGb0GeuyLOwXn89V8va9SKFpr2ev+5R+mRbzrpFv4kW41NtyGBj7lT4FEPnL9/WsmACBw9PsoDSsiOxn4Bg75aAdSqFOyxuXyNiJmiFNCBvKKcX82pAuTIz+k/LoOKnDYLpOy2FttRkHAPnzAmBGsBXCrCiPZUermm5b8vsm2UxAH6cqtqAxmbuZVkoE9c6w+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtkocouQTFTPgXp+1BjOXz5ILXZUoo9Pc8T1JgZ0Wmg=;
 b=Qbwrq28+9bifv4Wvao7GtBp1qQLXDjkAbHCLIUDpxQ6yFYDi3aOrmKkQM3CKSOn/HzOBPPFi9CWUfvyWbqkUnYRdtZ8WRlIvP1A6KM1E6K9s6lRORLj3Mac40lYmK3G0vSic9BWmXvqwtPp7uKADP0jw9ntyU6vMYK2Yh2D5e2z2WwhcWixXWj8L4qYAKaFD/xU8yAOXDpOlKAshcvQzpaouYtE1PhZqj8/b8qqJ/XiI7Wa0vPEwlvuccwpa8YNshSAJ45gF7aHUMLuVnAlpIQbftgFaWIigwXu/5EujvIn7kC8nLmOr/RlJYILyUfpCkrAcGBzB5wBp6s6x3GXzdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtkocouQTFTPgXp+1BjOXz5ILXZUoo9Pc8T1JgZ0Wmg=;
 b=oaHEhFF+wOOJNgdGw38X/2C5xSHUAUHXqHprQ61RhaaFLJaOfnpqtsszg3RLz+RzNOYLe+ONUIsjvQjAdJDYKSDI5sga6quePEoi6nogCiU8PIaNqw4HISvoU+ouLYBdNJBE6ieaFxtKc/p+d6t7CXF30VzdX59uFLOOBJBO7lM=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CY8PR10MB6465.namprd10.prod.outlook.com (2603:10b6:930:63::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 20:48:29 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 20:48:29 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 14/16] maple_tree: remove node allocations from various write helper functions
Date: Tue, 18 Jun 2024 13:47:48 -0700
Message-ID: <20240618204750.79512-15-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
References: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::26) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CY8PR10MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 020b6d64-cf06-4bca-0568-08dc8fd80254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2pwymMc4WzK9ZCdcv2hOo2xs7uDQOhhLfboWyFh+GygZuBXGc6JK7xRd7aoD?=
 =?us-ascii?Q?YwFXGpfNyMxjKV1h3IQ1+BJXtdlrsPkHW7hYQeKEr3lmx72vtJ4ck4gx12ju?=
 =?us-ascii?Q?S/Lj4rKdvsxAWGxF0en+agyJ5YqsQ/YAJRiRW4JT9XF9/oZm9gF4Px4Q3+6o?=
 =?us-ascii?Q?CHEPWTmi/2KCgsNr1aN2niwO7YkOkCp3HyPSxXMNHKb21B79geHW8bj6frZ/?=
 =?us-ascii?Q?Zq0p8MP7x2oYfQBtZN6jfKF9chIvG3fLtMkVQnRXZJfURmwuML+5pSEaZg9h?=
 =?us-ascii?Q?a9Lc2+xdG7bXzVZuB7S35Wv6DXV0Je/ftlRkPE2QS1xEpKQQpnzreCC50t3/?=
 =?us-ascii?Q?dT/PwF94S4A+FXanMhuv4LpnZsRffIcDzUrzASZOMoICdgf3tlllhxFb8Ftq?=
 =?us-ascii?Q?7D1l8tRRexxLw8O+v/f+JYOfA7PamkCH355HOHbsGZroPd86o0rTRoOV+r+t?=
 =?us-ascii?Q?X19kAFB7AK86LyhUXv4CoDDyNTguchXoGLOFjKmeqd3PbHPtn3uOUZnhN5Cp?=
 =?us-ascii?Q?PqejlFcKdxV7McQnO505bUl9eiRbNyvv+sF2F7dK1YkAb/CvU9vpkRl0VKkQ?=
 =?us-ascii?Q?6D+dzmsNv0i8v+FP3d7zUMRKByUOmZz05s4WxQBq5iMDa6CPUCZvr0Y2KU0z?=
 =?us-ascii?Q?qPM8H0WCJDB32grFY4wuCVHOW1/HwhcMYTJkeE2rJDGzIP4zAg+HoMPYyEw/?=
 =?us-ascii?Q?6+legzI3gijMXoR2DXw04VdlAMhKBoWQmhiFeIJp1vXsdZhkxOxsJvvxjOSX?=
 =?us-ascii?Q?cmyrC6Am9ygw5ZznM2ZwJvtiEMHOgvLAYFKBjPv2pIaCi1aox/JaSZv7i92q?=
 =?us-ascii?Q?oKe75lK1TADlQCU7XWdhcBcM1cPiDxp2ieB9bpHvIOBRDTgGZudBzBXA284a?=
 =?us-ascii?Q?uu/dfSOZus+T9Nb5PkIbwb4T5mcXTaW2/I67DKK4YLH6aPJvw8gCod/zNywJ?=
 =?us-ascii?Q?kuQxbxjp0U402w6cehWPWJo2XYzwihbriPeRzY2fr84Ev10TQ0Sp7l7aOVBQ?=
 =?us-ascii?Q?kDXNVzASHWKZUbNjUa4vg3Qj5yHTWrP8NCASDIOHLvxUhlNXR09xGwEB2lWy?=
 =?us-ascii?Q?FCgZVD7geFgD3+n4h2zJFGPBduqPB5HO5Ticx7q9akfM6yUDqnK/pqmvT7Sp?=
 =?us-ascii?Q?2BZ0n81rb1X4c7c0VwdP3YIAtq9E9xVRFn/+kbZFrQM6DJp4VTPh5xIDQYyJ?=
 =?us-ascii?Q?vdrK/wOckxM5gTltixLwx6yZbUOap62NCmvP9QS0/g3F3TNeew0IhGZAr0hG?=
 =?us-ascii?Q?Ydbj0euE3gEswH0ekiS3SiP5l5Xjox9C5tdVifceqoej8ofvzmf+NjD591Th?=
 =?us-ascii?Q?YsGgRqrIHlX8QGRo7/cv1NiS?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?AIEA9x7eHs/OCSJ9M13LEaTsfqil1ugIYHVWOLCdQ7DWGcq7cBPa90YkqrrQ?=
 =?us-ascii?Q?FD3Pstm9O9W8rkhUW/Vc3vljx95WXs2dfWKpGWl/ayDhIbwZnZ+f/RaNs0XK?=
 =?us-ascii?Q?Q8y8NOB/cgoxny6DFH9CV0OuopYjJUQyt8itidCRXnetHzwQdk3fMdpDDDG8?=
 =?us-ascii?Q?YRA8y+g6eKXUpu9Roxc4eSv46TO+flJ4zRikGxm5MGKk62PVTTOslxAnZ34Z?=
 =?us-ascii?Q?8KYdfL+FN4ackab1SBFBlcrKdKpiJYWnuBMXp1qZxHZMwc0cbFT5sqhgbVtS?=
 =?us-ascii?Q?hfDX4899SnY4sVsUNWRBTUuXekNLZ1fs30E4E+ERkJjM/AeTQX2TQBoFxMrd?=
 =?us-ascii?Q?/U7JExB1Zl0vw+dmBRWw3AjPdCtgNj3FeOWYLPU8ufDDlzsMBUTgeQAU7XyF?=
 =?us-ascii?Q?yW+e44Md6nRRNA53Pm4zzAq/BQchxsBkiVZdQp2QU6vNSy/cKv3VunehzKc5?=
 =?us-ascii?Q?8Mz4tWsYA4lOljRIQvGTGVzvifqrKLbhxhD+Ta7qY0eVGgESqcUuOxxKwSQu?=
 =?us-ascii?Q?0GcYrE0Zc5GgZ1Vqe4G3MsXZyLdz4wOodxkRZCUHp/mi4Ev55nz228QId3lu?=
 =?us-ascii?Q?UAXlSGjq2naLH17J4Aj9ioe2ETuBmKp2Leb6f4mZJD6sfsp8+sZH73ZaYRVJ?=
 =?us-ascii?Q?wPVJqYMpWix37SuYfTXR8U7QQckJKNvymBpxTsvM62+pkySr782B5GRI3og8?=
 =?us-ascii?Q?Wn7MO4temXGFY98doLq8J/IR2FKs+yoxHZqz+q6fBCEdzDpPzkNo5WWTWYga?=
 =?us-ascii?Q?LZCTDjZue7uVSkIIbjByxBXgSfC+0lA5ZQ4L+vR+THLP3h6Lyy2tWaEMp1mF?=
 =?us-ascii?Q?OWmmgzWTQByzVayFUzWrFvehhnl5ggUPd4/nVZlYJNwP6LL/nzugnd0PgGw3?=
 =?us-ascii?Q?fmbaBahb0KN3+zq3JPcE6Bw1uryV7wuf7tInxSYo6kXe/enjRwnqtvF4PLKe?=
 =?us-ascii?Q?MXhVwJT6Rtmxo0vG43SmnKM/t8DLJTjokaN+JLboYEPcCr3qe1/u24Ep0tIo?=
 =?us-ascii?Q?dgr3lVjHjst6t6/xzXcZyqDALXVFTCFZ9F2G1yCuL5yrF19vCixnDnTNbx1z?=
 =?us-ascii?Q?P893udNvMCUfMj4YnbMdKkvg0avJeXOVYIRDyPxVUx1Wes8vApqCnTGvP7aN?=
 =?us-ascii?Q?7pCBulyhSbDNrIqvfip5kifgzgfVhBuwCbqP7GioL5Zoo503PYUy9oj+oJnZ?=
 =?us-ascii?Q?WR5xyL36v0CtmclXm63E6R0MC59Ek1J6yDWx/6xenyeevDNeIGO5CApFwRaZ?=
 =?us-ascii?Q?Mbvt8C0oMLEx8H69N5fcxBEYvnYKmfLy8vrUFoyl5uEewBF0RxAWuuBYA++n?=
 =?us-ascii?Q?4r7kCBqtLuSbJYwY9WOyJT/RkSigROykK5Wa6nfX4u5b3oDuQKxV/ffpuAPC?=
 =?us-ascii?Q?Tcy7EWuO5oK8+dqKYq2QUYD46fcbPRS4dsO81DSvzzq26U5CZxX5zpIn4LxL?=
 =?us-ascii?Q?U9b6+lSJ75aYrOdVFNXNw3sbblsYAXrNW/O7AbszJZqU506HGNA9cAMtBApg?=
 =?us-ascii?Q?k1mfy4SEVMkRyv5k/ZCr2pWgYuie01jaD5F3EqW2zyqCkFMaZV6qAm7MuwJU?=
 =?us-ascii?Q?iHiERaOBZPFIONwT6aEkchVTLkvtxDegFa7outoywe5xL7O7h6m1+dsh8iVP?=
 =?us-ascii?Q?WF+qu/FNn/9hoBV7Y1roXwg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fNYGez856hRm71gqYtD9pUQ2TatF4TwkqVJ59MNXY46glmgKTnXdbCYFQ583IggXIsysRjZYD5QZ489imaYdBW2UDyY6YBsL/MwD6A9mMYvObabFaM/AX7T/3sn5Qyg2JubYmfLQpP/uQT0ZJidN1PaPrkIYt363ybKqpA6YVO/c7OaV9PsIB6lE7jvD2HSiTg0gMATfN35ft8CSm6bDm8449hMv1foWKO/3KGupNFFMhQjmfvaQAXo/Ok43lMUpBU9xy8d8RtRtfW96VfVJLgP8z8IDVP1c1HL1BkvJHXqUFODoHABaRp9U9t53nsxgVfWDpdajT66ECQ6xmcz3vB0J1ctvUnGVby7Ht5AOxesxzyZR1iGB35K8X42faZ0hvMj7Em2o+DIFVF7RPV1t5M/93o+KtYieU8yXDIz5C5P5OENJJs6NH38429flDkEqC7IHw/4a5zdqRgwgbcLP+YNeh91U7HN4OcQEG8MeEVODUofLtIpvw3x8a2n0AoSYSxXqn2Kcdhx31liy3wZMhJ+fo7G9bwh5crv5DL177v/JBoRBO+5mjRR8UnMRid6xP+3qYy8dqscr19p0EUpcAw8KQEyh8p5h2vEwKZLAs0c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020b6d64-cf06-4bca-0568-08dc8fd80254
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 20:48:29.6083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NmpESqylId/Pti9x+Wd0LvJesS/XwDkNSLW3gxo9bYD3A7gMSPN0F6LXcVjol61/D3aousE8b9/zNmqfxqvbrmphG/32wUCSZVTykdwHAPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_04,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180153
X-Proofpoint-ORIG-GUID: LG-n3IqnHaeHNZ2HbgU6l5uJ_F73b5Ve
X-Proofpoint-GUID: LG-n3IqnHaeHNZ2HbgU6l5uJ_F73b5Ve

These write helper functions are all called from store paths which
preallocate enough nodes that will be needed for the write. There is no
more need to allocate within the functions themselves.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 46bdc4ce6662..9ab8a6b6fb0d 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2976,9 +2976,6 @@ static inline int mas_rebalance(struct ma_state *mas,
 	 * tries to combine the data in the same way.  If one node contains the
 	 * entire range of the tree, then that node is used as a new root node.
 	 */
-	mas_node_count(mas, empty_count * 2 - 1);
-	if (mas_is_err(mas))
-		return 0;
 
 	mast.orig_l = &l_mas;
 	mast.orig_r = &r_mas;
@@ -3029,11 +3026,6 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
 
 	/* set up node. */
 	if (in_rcu) {
-		/* Allocate for both left and right as well as parent. */
-		mas_node_count(mas, 3);
-		if (mas_is_err(mas))
-			return;
-
 		newnode = mas_pop_node(mas);
 	} else {
 		newnode = &reuse;
@@ -3341,10 +3333,6 @@ static int mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 
 	trace_ma_op(__func__, mas);
 	mas->depth = mas_mt_height(mas);
-	/* Allocation failures will happen early. */
-	mas_node_count(mas, 1 + mas->depth * 2);
-	if (mas_is_err(mas))
-		return 0;
 
 	mast.l = &l_mas;
 	mast.r = &r_mas;
@@ -3444,10 +3432,6 @@ static noinline_for_kasan int mas_commit_b_node(struct ma_wr_state *wr_mas,
 	if (mas_reuse_node(wr_mas, b_node, end))
 		goto reuse_node;
 
-	mas_node_count(wr_mas->mas, 1);
-	if (mas_is_err(wr_mas->mas))
-		return 0;
-
 	b_end = b_node->b_end;
 	new_enode = mas_new_ma_node(wr_mas->mas, b_node);
 	mte_to_node(new_enode)->parent = mte_to_node(old_enode)->parent;
@@ -3474,10 +3458,6 @@ static inline int mas_root_expand(struct ma_state *mas, void *entry)
 	unsigned long *pivots;
 	int slot = 0;
 
-	mas_node_count(mas, 1);
-	if (unlikely(mas_is_err(mas)))
-		return 0;
-
 	node = mas_pop_node(mas);
 	pivots = ma_pivots(node, type);
 	slots = ma_slots(node, type);
@@ -3746,10 +3726,6 @@ static inline int mas_new_root(struct ma_state *mas, void *entry)
 		goto done;
 	}
 
-	mas_node_count(mas, 1);
-	if (mas_is_err(mas))
-		return 0;
-
 	node = mas_pop_node(mas);
 	pivots = ma_pivots(node, type);
 	slots = ma_slots(node, type);
@@ -3812,9 +3788,6 @@ static noinline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 	 * entries per level plus a new root.
 	 */
 	height = mas_mt_height(mas);
-	mas_node_count(mas, 1 + height * 3);
-	if (mas_is_err(mas))
-		return 0;
 
 	/*
 	 * Set up right side.  Need to get to the next offset after the spanning
@@ -3898,10 +3871,6 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas,
 
 	/* set up node. */
 	if (in_rcu) {
-		mas_node_count(mas, 1);
-		if (mas_is_err(mas))
-			return false;
-
 		newnode = mas_pop_node(mas);
 	} else {
 		memset(&reuse, 0, sizeof(struct maple_node));
-- 
2.45.2


