Return-Path: <linux-kernel+bounces-398910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 131509BF7DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AB8BB220C2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235B820C010;
	Wed,  6 Nov 2024 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z09zVmcc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hZ0+aIDX"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DC020969B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730924334; cv=fail; b=em35by6xIakEthSBCq0W6kLU6Doibmnogk70Z7XbPYxCEhmlJWGdbAyK+jH8uikYcL/woRhdEWYOweZxGOB2p/HmGwYASiIzhelryBsWbdkF5pVKjo+DSUZw81aJwCeVRapgtJzKfBtXo8sT+Dd1pAGaRnuIdBYyrloB9DYkvD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730924334; c=relaxed/simple;
	bh=kAUrxgMI94ff+FiTLK2B9inQv8CaaHs3HrhOI3IAdKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O293Tj4mYv4+J6MCq+F0DzCuO3PACLvGqh19jAoGDwnuHZ/TlBedPAdZGl1BqxcH4WpmvaePfAxnf2felTcDengD3bMiSsCG5NWm5TlONWVc515JMYesNkWmWekriOtvwa/6D0V9a74pmMKovKb0u4iR0ckQEUg2ln3wXPWz0ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z09zVmcc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hZ0+aIDX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6JXYOX017347;
	Wed, 6 Nov 2024 20:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mEUT5widYnsM8jGiVBHDB6HffutMnzzql0eQU6JxxIE=; b=
	Z09zVmcceBCvOeH3Fj95k0GIAwqB72WUzQJl3foTWxUGXh7puP2XZzmr4HEKG+tw
	Rk6i78acZ3s/pkxfZJ7JhBuBDR/eezWel5Dl6YaifmSy7T4sRb6VqblB9+Dq570d
	aBGlnJ09x6tpjNhQUpjZLoaRTL6nBXYWU1v8sXDICtV+Sr1aw179VzVZyX88iN42
	hmhvO6yFP56Db2WuN2NY1x7K33B9ucVjdzlJ8P1Ha1TEs/oj7KDQ7bpVaT4LAtNX
	ylFA0qYvRuJpXcXVguWRDHyLd6jED6lyprCvpVlF17QbUxo/n079x3cq44cV4+OI
	IynNpDFxNA2YfMEKx9dbrg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nap012jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 20:18:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6ItHS4008469;
	Wed, 6 Nov 2024 20:18:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nah91n0d-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 20:18:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpb1e6n2yb7VW7ntYpt9GztEfpkO8DDSMQmzjFp8RqJzY1WZRjfe74dFhxwhRm9hcoqX77et9GOR6ozZ0qQrce4eA5KyW0ESWfg2m4DXg+DBJLMbNA5SiCWOTF//djsL1wz4Ht3M9DWF9AS0I+5MYuWQ2iX32QurpX7iN7GRJy9ocAHytlyXjWanlToFYB8VOo3MDnpYVTTcDZGZXxfs2ZquQmEXbZNfLlvNHYTstqGk2x71CLp1nfa5uZLgTHACyve1RHFI2BNsACXOUK/uFhBDncgp/Qpvnkq0Loug1zFAPkOLPyqNuxhkI6tfBeYQxRUQzx8T8gFcvGF6HuGoFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEUT5widYnsM8jGiVBHDB6HffutMnzzql0eQU6JxxIE=;
 b=aMvX4ZD9TSZa0FYBzyvKaCm2Pxgl1ant2jj7WRQy4oQkGilCkRu1o7Jp6cadPupYpqRO4PNVjYyMWC2dd+HtUNIVmywt034PlXmcc7ABbfv5IGz4fnCIAYU/NTs8fX9qM4GWwT64M1SBHuc6fwWnE0jRH7bmBbXIrptH+4hDr8EMfNW8Buqh+gHgYHRhIu1u6MYiP+IgPl2mTl4INdvYk/wCgRhas17dfOwIf5V3ogrTfzmijhOdZr0JV+U2EC600rE3xv7pXpD8C9CLoMoSIvyjFbuvovXhAL4rCYqlvm2wIdZYFLYYRljIdOR4kuzff/HXYTsdIZy3ZkBs4Qfang==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEUT5widYnsM8jGiVBHDB6HffutMnzzql0eQU6JxxIE=;
 b=hZ0+aIDXoVZVJgNSWwjiY0CsrjE2MV3yk29Z3n/4jcNUmoYgP8PQrxQxxjIzr6Qhy0f5xCqB6XpFVu5sFcYv2h2eurFuYSGwuyiayrRlnwGIeKNzlpmt2SdNI9pkoiw9vtFILzDgFg7QKLAYersrrQRpC2gh/Ct5ieKd2zTeteI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by LV3PR10MB8107.namprd10.prod.outlook.com (2603:10b6:408:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 20:18:13 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 20:18:13 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, ankur.a.arora@oracle.com,
        efault@gmx.de, sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: [PATCH v2 3/6] rcu: limit PREEMPT_RCU configurations
Date: Wed,  6 Nov 2024 12:17:55 -0800
Message-Id: <20241106201758.428310-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241106201758.428310-1-ankur.a.arora@oracle.com>
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:303:8c::7) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|LV3PR10MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 91dcb46c-6022-41af-2343-08dcfea023e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iJja5Aw/TMp9RMmG75jIxFaGoYOr72FqEqyQKwpMMiMeJPFdb18ITLqOzicj?=
 =?us-ascii?Q?iHiu8vHcM248CIbRgcVUhKtghGyghzMW0EAdhAXyp0tXbT9ES2jg/LgJrKE7?=
 =?us-ascii?Q?zrsuukB8XW93KTYfNih4fpm2y6C1ACz0z0Kl/SsnH2s3Z7Xjp6PiwzLFQvZF?=
 =?us-ascii?Q?g9dhHsGtmGTrhCEjLHGKUP3ucOvJ4SYbr4mkGYrGAuntfLHCXRGvIqsGY+6j?=
 =?us-ascii?Q?F9Tf2yZeHnPUjbx7FHbhgh1aUiYZSK4N/jDaBdwEcuNk1z14FW995GOkvlw6?=
 =?us-ascii?Q?Gh//mLJ8YHWD5HYGyIRYrKPIo+dsWzp+BvRjcaY5EwbjldVSRcYAnTQCFcaU?=
 =?us-ascii?Q?SLIOyI2bA2tWsVNmiT8fj7ctaaj85OxCgXjjrC1qunSrPmr5kMNePMvciV8a?=
 =?us-ascii?Q?WE2S3TYlctMwJCoo9qb+5mK03RIFR2mPlgKjJJdgLyTdYtyhCupUPKAg+l8f?=
 =?us-ascii?Q?9Sdft4S919ALx65hvIUuVChhPBZYu2HmRA8T2wjwiUXHIq5ZwukbwbkxENDJ?=
 =?us-ascii?Q?DQXPnJSkV7JZS6bjeQ8CMVR+fTBo41k9GDNCYuIP45EzB7ukEKBCXrKOQS7a?=
 =?us-ascii?Q?zzyhCYc5ozZSB+OVRzyMtuUF4AlaFMXKdP6oyUPnw9r6NNTttelemIHgXkZl?=
 =?us-ascii?Q?uCvr9H9VjxKL+xvacsCP1/Qvd1aTcwTe78cLWogg0dOfgW8zNuAqa+GqJr//?=
 =?us-ascii?Q?U5ULNnCf7yHx2tvWglx/VZgOcPp2pmrTEqFGWzvwXs+Ga0d9yOFFdN15dvMp?=
 =?us-ascii?Q?t8bKXyZIDrU/bV42riFHywxUEBH/sRFvRVml4nYw49LYJuwGCSb5ZcdiNnmq?=
 =?us-ascii?Q?XI4XszRCBsdQ9ny0N0zlf0kwBv2iuwvMJkgWIwb33y7kqi8tTjQI5Dr1F7K5?=
 =?us-ascii?Q?TkfxCh4cr0AjTYTWzMZ+OPCfHkluSBnU7TXicKNNm5QLbelejfJxmb+2BPJi?=
 =?us-ascii?Q?LVgxpaL+wpYUlaUJihUUGxfdY/VHlI+4idFCd8PmY6ThqtwaIvXopN9Vj3lz?=
 =?us-ascii?Q?GO+1ZBP8inmR5DfV4lTkZzMX2733b3i1wNNOLImC09DK3s0crfqlRb3eka90?=
 =?us-ascii?Q?PNs1zjziu34eincmJvZZXUJ67yLprpaqkVodVIJYVFweiZBEYi0Z6VolYRX+?=
 =?us-ascii?Q?AEV39U34lBY8R1pLYbq/Fn4gVL2TqQtbDhNvQaywj55C1hI9oiYfvTKHSHSw?=
 =?us-ascii?Q?O+t4rcT3tOxoWK9pOvhcHu4YWVJ6ELkXo/uWZPC1kBjrFZyyB5NzzpB7bloY?=
 =?us-ascii?Q?x5ue+ofihaFwbIhHj+hQ6OWD4A+v3rkKbwueyD/UxBXCf/HB2Qkyv5mY7wr1?=
 =?us-ascii?Q?DfSRpuBTQWeezp8TW6GJOyxs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I5KdKJctrobuzAqhrPSQOESVJxH7mBfjo9xUir++I9NlqWG+G3+usQwDHT+Z?=
 =?us-ascii?Q?NPDIRmZ6pIgRi5XsZKPSRzzrjtV9YVz2vdPjOJcbRrEw3AnHv3Zp9PzIz3hW?=
 =?us-ascii?Q?DgSEqxGpe/e051x/BcDDE1XYATJSAyG15S5uj7ARK1mlEygoekY6Uq36Se0j?=
 =?us-ascii?Q?9wGOloonBN3DjALV1WmJ0lYjuBgrk2S/SBVCy7KvBHk3n5muDpliSy065Rwj?=
 =?us-ascii?Q?ItvaPzrnh/vWTwi6kjmxhxoau4lKTju+6+s8TD1Gqs17lhoOuLXpcn3xJ39z?=
 =?us-ascii?Q?ZKmiHdc/VQ8vO1o2fIZx3D3G7s5mLqFMnTfF/G7bND6zjqGUU1J2/afBUUXm?=
 =?us-ascii?Q?4yquZnqYS0jSCwQbxO3rHJTXrMYnS5uH4sBsnwolsfUTVVox87lgQLOmfsMT?=
 =?us-ascii?Q?fdkdnYfVY0uqbs1UiIVv1t2i7crzCI8qCbUUaNGI6JS1hTDNpHuZlHwqQFmu?=
 =?us-ascii?Q?9CXt+85oYG/gsNMTwVkrtFFZaJbWc6uAv3x2q/FOKmJDAL6DYBAhrAF7GYem?=
 =?us-ascii?Q?KAWWvareBs4d3hj/qFWqzj8JO3cZrZpcrOuJT+1Fh/6EDdWfve0LxkbxsKHQ?=
 =?us-ascii?Q?+OAcSKy01bcpHZubehb984nZcX4IDoD87f8URJKBY1jxjIyYWla/cLwJusax?=
 =?us-ascii?Q?1D4PSDEc6ljAxikU94T9aNxF9fTHqdW8TnjtK/xDLCjiP/s8rlal2F6zuMK4?=
 =?us-ascii?Q?xc/+j7rLLegCR8dTwii8jS3OQ7ja+CjOpV7l7mnPLifrmtNzYPnX2RCFVy7w?=
 =?us-ascii?Q?keymkufyQ/W2P2YfYJwa6xsbyw/y/0rzwfd329wQTiIBdQi+eWZoJ/7N512K?=
 =?us-ascii?Q?cHTpm2Ci8a66yS4cGOCSlkAhFFWKkdKFozJRKehutINYSXYj3XT+EX4Kia58?=
 =?us-ascii?Q?F27qtFccWPj3107DH5/6P70/EMZp0zJWJBIaXJ+3AFsnRsBDdjbKxg4LckEu?=
 =?us-ascii?Q?cyDlYD09z5FGKA9yhB/tXcAXqI1kF9iYqH2pDbd0X3WQlqBYteI+AOOUTbHo?=
 =?us-ascii?Q?/bZNdjjW2bAqnSXmC33zgX+3oiuiT99bdx3lg3a/5QWbh6haiizEM/AQD3uz?=
 =?us-ascii?Q?BBo+r1A1FnbkUvgLEJWbPEjQ41u8lb5NktzUm+f1feDOdT/AiK6p6ItIs04U?=
 =?us-ascii?Q?X1akWYlfJ6Gau1Q6u1FTWfrsNEgDl6O4Ve0vKqzs4dCSTrU1LYUO3vBcTDHB?=
 =?us-ascii?Q?g8Cobisli7MQJtIi/z4WYpn/m86anuNOqeKDC/80cz5eIK1VbhlpxrzoR35m?=
 =?us-ascii?Q?gCzj6j1KUCDBq/T1Sx0iUsI26KqJ1L1/ZDCxwTnCZMMqtiofPOVUDFQwbyBZ?=
 =?us-ascii?Q?rgpydhzx1n1Gna4di679ZUnAfSogJPbECOgQ3RXnU8teSs0U0XX/ZSxloA4E?=
 =?us-ascii?Q?Ph/mSfk01wXxStENY77bRjzjugeBl0WtnM7IlTcpivns+arFiJX4lS18kz95?=
 =?us-ascii?Q?H46lCxodDasfvqHpQNAUWaPDSy00Py3C1v80QeJv9kZMd45iapvyKPTfulqJ?=
 =?us-ascii?Q?RZ+JFOjjRAzut12Jp1RGBDMLaM2SP084lHRviK6B0NiZ5sP/rFkEoxgh9POV?=
 =?us-ascii?Q?fW6vt8fl3xBxmZG0GdJBVHqb8yapOzEUUpll5J3howoesbJ5/bhdevcRE1v4?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uA71qDZMmrD6aGPpV8Q+9TCuuGQ3KK6YPu4cBxUb/UNkvFUVG1MJTnwfeG07e1Ba0SV2mjyX+Ft+bCh7swzI64UX41/eQkeVJRXUsMaRKV1CDmUJleSajmcOcHg6OFjoY1YfMk+sTLOI7gHk2dDGoCSB1mrEKsAPaJbHvLvDR22qOLHMXE51DWnBfu9BFB6wK3naLbJF4FhN1N7Xfe7ZpqdXQtRGXuyKA5oYScS4yjE9z7fIWYWrG+eVnvJl4cSsbCTrWPwkz1IuRSv8P2dVcDGe7UOkJWt9pGy5+IzlDmpEQxdKMTklz+z3LmFWp6oxuKtiDGKBArQkAJQAZSUdGNBt2dpXpELmdYfy35QmOEsTSa7ReSd2CqpUMtpxi+OV6y77bzZdWC9caGDo8lUrNagrsopGvgz0OdGo1lTwSnQEwu5ijvsRgIPFOg4+z5neBOimwFNe7or67i791aKE17M2ubej+Vvd0tohL87d5OzhkObGDn6Z0rgwxaKaaWPqQaNYDXjwAqXyHXM5kY30FB224lmXM98E2e3SnlKpH4YCdhXcXYmN9XmP5fVM8ezV90dyW2QSb5SrcBJjnlljuryuIS/V8h6mBwvDe/0HmFU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91dcb46c-6022-41af-2343-08dcfea023e8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 20:18:13.2438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXR2TBg5wvxZwMMicfFwMg5yFNGtfd8SoJSw0BAGudVvL+oolhBlYwjk58CA5Ytpecx4bEaIqa/3o/Ik3Ipima1QrEROvqHxCm9wILaZn6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8107
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_13,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411060155
X-Proofpoint-ORIG-GUID: T0GZR1mg6HtKfAe0n6KnkfO5y37C2IRI
X-Proofpoint-GUID: T0GZR1mg6HtKfAe0n6KnkfO5y37C2IRI

PREEMPT_LAZY can be enabled stand-alone or alongside PREEMPT_DYNAMIC
which allows for dynamic switching of preemption models.

The choice of PREEMPT_RCU or not, however, is fixed at compile time.

Given that PREEMPT_RCU makes some trade-offs to optimize for latency
as opposed to throughput, configurations with limited preemption
might prefer the stronger forward-progress guarantees of PREEMPT_RCU=n.

Accordingly, explicitly limit PREEMPT_RCU=y to the latency oriented
preemption models: PREEMPT, PREEMPT_RT, and the runtime configurable
model PREEMPT_DYNAMIC.

This means the throughput oriented models, PREEMPT_NONE,
PREEMPT_VOLUNTARY and PREEMPT_LAZY will run with PREEMPT_RCU=n.

Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/rcu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 5a7ff5e1cdcb..9d52f87fac27 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -18,7 +18,7 @@ config TREE_RCU
 
 config PREEMPT_RCU
 	bool
-	default y if PREEMPTION
+	default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
 	select TREE_RCU
 	help
 	  This option selects the RCU implementation that is
-- 
2.43.5


