Return-Path: <linux-kernel+bounces-398916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3569BF7E5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F691C218A8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA3220CCE3;
	Wed,  6 Nov 2024 20:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a7NMLIgF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vzydf2rI"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E6E20C49D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 20:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730924350; cv=fail; b=Ev5GrVhu/cr65YOUaAvvtu7izKiKai1pbHC/V6FzXgeKPey7qh3El91vpG9aEFfpdvIqhrOCAhr2rgVQcuoPSmSo0rJcq1zo1zgBMBDLoU0qd4OWClnTu1akHz+paKf3lpeBmQ97jAWFE8GplEgv2z/URT8xDOLU0l5cMgNBYco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730924350; c=relaxed/simple;
	bh=InBqwZjLM17O2oAAjdNp6FJKNjF7kU/R0UsQaK1RnjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q6uLQNmOITPR7S21U0EvxQi6pztdYg122PDdJM9P4K2RSHJxtX+u1wibu2oiaGajqheFwZ6Grc3U8W1lUEKEbmWHVFG0SlNQCPCWL1OibY2DMFKvR5UhV2slAN/+imb/eM0BXxLT5KAYM0RUrvugssdWg8tYxRzsBfPud+GyGMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a7NMLIgF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vzydf2rI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6JXXJw005483;
	Wed, 6 Nov 2024 20:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=v08h8woyqrHWMEVfB1u5oCC6UWzQHRDiRI3lZ5dKGtM=; b=
	a7NMLIgFbDJgVzy1NvzRur4cd6M430k+XL9s2p6lLiaq/NtK01Q+r/Jc/g2Pma/0
	hSXZv2n84LLZl0NpFngAT8rcQhXYF0TK/7P436f7JVNWdBEvR2nSFLu/uXiOY7lJ
	TqmqxIrXPBJE4/KuerJjubJDrfKEgkr4CHfpXgzGnhgBWTYXq0SGEaXWz0npE+Nn
	LamUswL9q046LeLAdMfUq6UForc3/JpZuOXqtfTPxrEcE8r6uma3NDvXLk1atL4I
	z20SzD6qf+0iZyhXg8klLp/ua9xO2EfG/czaWYD7jM7vl3atAV3AqNF8+tYJ47WB
	nopkCH5E2s9eTRPZWWfy8w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nagc91cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 20:18:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6JYkik009712;
	Wed, 6 Nov 2024 20:18:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahfc0pq-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 20:18:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mB4WS2xCnBIBuzSUWSE3mKcqMo2QMkvkSfaUCWEvrP6rxF6WPKeF1VUO7r+SZ9r0I8OwrRauZtA4X1FQRgy/7c9Y3U44cMb1QQGex6csoA97bA0gx++gbeUdznjSfQJFYiWSu/AVx4btLKDvl/zWcuNaAL8UbgpZWqCNICswGAEKskeir3ixyEuywdCbc05tCLjTc2DHLSDuA/mN+K+eUSwsR3q+oNHxWASc31T3Ta95jWWTSDLZCsbmERXnvtlEhmQLLOI/OBgCA+awG1G0c4n7r48TtrNLzi+OpP/Y/YeXpVpB0GUjmjNMC6vZKmGfDu4OfVRXc7puYFPJ5IxNxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v08h8woyqrHWMEVfB1u5oCC6UWzQHRDiRI3lZ5dKGtM=;
 b=QUYHbG7NiLGs+29GKyegA3AYIbyK8xZHky85OAtSt3iMSaQdp+gMOCkpRkaXLYw+0W3pthi69L7d/UVGXWIuVLnxqz9cnuyjNmQh2nGA9WNOQ/QNH4pP0yRXfKLztZ8qTTbS2Xn/Dsoaollq8roRiKspHoRxwNxOWU6OQijEt2oV8Godv0QWVIwG3OM51TkI4RERxyOBRxbriDUMjSsGzr6gwjWDuPRaJVjs+ONSehRZRBDbU6tXDyBPOScwHssOQNTwInRMWAhpgR90w1aaBTZBEHo4jMclJ/o18ZEVRUmYsNBeWhO+EDRxH4+CG5AzX5Y+JQ9tjjCHCbssWIqWow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v08h8woyqrHWMEVfB1u5oCC6UWzQHRDiRI3lZ5dKGtM=;
 b=vzydf2rIOx4yXxdyJvbZ/oqQOr3EmWqh/Es6HddpVZW/Fu3Y59za5MjqSNvId3F+vhbV3IF40s2wNJIrmfXcZk8kJHLEBmL2yP0OTy1AAbSx7IzFoKhRo2/oh2+NrOFJwzdrJMmkU65oQAannvllGGdtdfGLlD2wtaB653SWcUQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by LV3PR10MB8107.namprd10.prod.outlook.com (2603:10b6:408:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 20:18:18 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 20:18:17 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, ankur.a.arora@oracle.com,
        efault@gmx.de, sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [PATCH v2 5/6] osnoise: handle quiescent states for PREEMPT_RCU=n, PREEMPTION=y
Date: Wed,  6 Nov 2024 12:17:57 -0800
Message-Id: <20241106201758.428310-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241106201758.428310-1-ankur.a.arora@oracle.com>
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:303:8c::23) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|LV3PR10MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 188f712e-ea01-431f-81ec-08dcfea026b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XvheWkQ1488jcrBoNHiNnZnD+HffcH+uNfnD75dJnh7/EoyiBz1PLltVKbxN?=
 =?us-ascii?Q?XELIqBi5fC7vWU1kut4YQGhJiWUEcmX/uTGi1FyNBgFoZ+fu29GWFYbduqJF?=
 =?us-ascii?Q?u/VOQtdMgYhgNQ+2W1x0RXGErEWTwqN4UiO86mqQbl3opSgWcX+nndpt8TFJ?=
 =?us-ascii?Q?kzwFjtlY1ffCN/1sA1kDBVKqjg9J50FoAA6pj5RYwDK3ug2q5EunMiSeD/Kv?=
 =?us-ascii?Q?k2pY15fvYNj+tAsDB6fcM+LJhVqJ7cUgqyWpfocgnM+U/qqaqu78413ax3qJ?=
 =?us-ascii?Q?RXgZmqd6DQH83kFOAX5dEturhkHF1VC2cZ85fYgx8Ecm7j3qgW/phU7T6F9i?=
 =?us-ascii?Q?3Ih+YNVnHtAQ7gDyCazpabD/5KKDGmyS5wpHyEsgyPdgfCe3FNIKLNo1kKW0?=
 =?us-ascii?Q?C4dg6cPjfpAFc+/2xCE6cEq0fJrYWkRFkVnMz1KcgY3a5XWbUZYhwT1f/w8K?=
 =?us-ascii?Q?dCbyDzO2COlVyHoJ83TejjoqVSwCXcPFHnUMhhSth/5DWkFxk9G91u6N4yYn?=
 =?us-ascii?Q?KtJ9WXovVh44F1rXVB7cOWx2cKNcEyjmzNIR/OaBAWluPWMOX555dJ17dxlK?=
 =?us-ascii?Q?Ui+DCAC40mthVeE4bxh3ZHqjBFvhH4MdDsgBjz+pIo0ebrAH0866LUnbJx+H?=
 =?us-ascii?Q?ASp95suQksFYr5DrU4YodVxKoHQQt3LBYkW7c7vkQfGrYu4q4FuBPZvAtAJr?=
 =?us-ascii?Q?Dpqx0Xmdj9nluuPkk+ouLpf0tHfLkU9ZX/bMgSuqcUfYzqLkKHkeA/ubXVGz?=
 =?us-ascii?Q?dTyBHEucFjAdB68HP9kkVM1DyriX12uMdUwGm0mdmqYNjXinGwEm4MtS38XB?=
 =?us-ascii?Q?pC4RBbPLsw34rFjcqww0Lg859i7Q2mKTLCx+SewmZqnbt1x5/oCJVbYJZ30t?=
 =?us-ascii?Q?5BtHgL1Uh+5NhcuSf5e8NgrmeOm4aKQPztZty6MSY3HBTap5hd8DMEBs24wG?=
 =?us-ascii?Q?seRl1eRGh30MflxF7r4Z6ziZsQKGWXsPv+no6nVSyNa9gwvKN4wpa1Z+oOdU?=
 =?us-ascii?Q?+Pp0/Ft3CJEBHZXrXRbgT0k9I5UT5cvdlljxVthbmPbR7gziR+JHGmS+d9WM?=
 =?us-ascii?Q?5t2wLsNanCZSanZP5ULVK3MI0dHlHiHosHHbiswjwZYmZLn6YsbC0JriyEMV?=
 =?us-ascii?Q?74VRgzhrTcJQeb0wHwAzuYo1sAK1NGsdKIeaAaSPgvnv17RVZxCSkDVL5O+I?=
 =?us-ascii?Q?Nve3+/+PcMxOqueOr48V16N7dquHrn8iTK3rqgMT9a6XddRCyQe2QyZBWMMb?=
 =?us-ascii?Q?ivFjxos0o+3/Ev/80csIKe3s52mwW/xDnkuyGCiARI/0jvhJVvFluQh/xqWZ?=
 =?us-ascii?Q?DeLaBd4VccQFlQfBYnEu/9rF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K9NXJOcasO72mfbNOlXf+QGkHBVToWObPdFviWbdW7ARS1hViHrNEISpJgQ8?=
 =?us-ascii?Q?5uZV7SaQA1T/O+iyMELeyxZ5u8q9kDWI3Gzzu7EaF+hiWtJ6oRL9VbLLdbU0?=
 =?us-ascii?Q?M/P24RGc8UFrHJCwFi6q3PKlHOdttPQ41wEPac53Vh9I1REvlskaaoa5IeYv?=
 =?us-ascii?Q?3xvEtUtxu5g7+mNBPTv6diy/KH1qOaXTktQgg87rTkxVjxCXAN6xJfTr8Ksn?=
 =?us-ascii?Q?+h639J6ZQ6/NfyTzldZADr2RfZ1zMHhC9d9rDYMBBodroX/5F74nsC1gBfKL?=
 =?us-ascii?Q?MF+WuHUNzUXrSS33zYiELfWA/ldsc9JbmUTzcUDCmY+b7IYF6cTscrnwTjbS?=
 =?us-ascii?Q?J3wE+qMbArZ7UnljEOzrkYH4gcufi1yWTNyK9cP6kaDyfR2PNzkaUWfqfq41?=
 =?us-ascii?Q?RbMSpuZ9JGdKXTeoxeVP9KDfZgbdfqsb4j9Vl8c5NqvjOIy7OvmhYq5q65bX?=
 =?us-ascii?Q?FboSs+UUbHKrZFNKsrONwzu9WAPpaOSsqyajQHLyN/6/3v/sr2psMCSFvMTH?=
 =?us-ascii?Q?+CFaoPjqGysubjFtanUXSVkxnuzrnCzf7hl+lYwlFyolDmJMjezIuCiFscp4?=
 =?us-ascii?Q?Wboud5WKssuDd+GgyRTfvt9M9uxbEfpj2WZ/Ao5OBuXGSE4iAHsGcsvi1ZVM?=
 =?us-ascii?Q?NzJt9zJM/qcme5ZhNGlVsY56L+f1JbonpQvcpO3+sfb8XoStiY6V/debVHWJ?=
 =?us-ascii?Q?0rKXHtDBqSth++d9GWhAeYq50e4eveHGoMRCN1PZjrWF07Jh0Ef27C/3HYaI?=
 =?us-ascii?Q?38bTdqbMZHQTFLzZwsiYtAXlJT53T8rTbZCHBbsOG8b5I0gq7EeqobRaS9hn?=
 =?us-ascii?Q?DB3DFTNql7cfLho5Leydz6GxDqpaG0NDCjt1bMkmhH4xL4H4HpUs9gQZvjQy?=
 =?us-ascii?Q?lanvKc7JHN9coFUGIWt7BmMAA3kHYF7sR1vlf0csfAFv0yFefbg3hgXh6+F5?=
 =?us-ascii?Q?zx6dZQ9KbFQlCqnqXO8hWm4U45nrKLbilcUbpPwjMQpag2K0bgFZXlamZNXV?=
 =?us-ascii?Q?lBJP5uz6Pvp5RriPbKgs0nZKb57NW5O01ty0lsF8ZosmhXmhTbnAOiJB/4up?=
 =?us-ascii?Q?iG7rmnmve5RG7umESTDrRv8UI8BKI2o338DZmk8cb881HMBLCjeytqqTDYAt?=
 =?us-ascii?Q?t3uZrNWur8ToQ3XJJ1KyaEgPCaOT3ymulb+dDdhxvZG1NySk4PXw7pYRV9Gs?=
 =?us-ascii?Q?7NPdERu1jRnKE6G+H+fMJJr2V2984uWu/jgC62RhqbIxKJSCH1kuk5rTMLOq?=
 =?us-ascii?Q?HuR2ZmUy+jEufH0Jdr3mxexota8LETaGsjJHhj21F7lqXbicNPACSCp2BvsN?=
 =?us-ascii?Q?dD2wLAbdjEdciggwgWtNYkqX08vsnIy2ioOZhiSgqb2vobJSTY8jIr62/uIq?=
 =?us-ascii?Q?QpimwwghKRfMOzhvJ8Rc2DAGhyWjZzbTFexVhH7LBmqF7KBXRWhsdPFegPAW?=
 =?us-ascii?Q?R8oRKkSo6lrel40UUZoree/5/Hz0WO35MKNeooTplehwygYi0Ul7vfD7tnzS?=
 =?us-ascii?Q?BXvz5nu81irB/sZQIB8kNutcjRWt3h7sCClqlPpnoJotQh+D1TTRsoU4a3TL?=
 =?us-ascii?Q?p9Ob4LQu8OR2I4jsvNwjryUUs0tU00TyEwSnUhpDwHfQ7OturPIRPWCjCh+/?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2tHC6g91l6/HPq1tOoxgi6B4UlYLx9qnyB/NCm6Jytv3+lDcJm8spy9MT8sp9dAgee7uNYaE2m4e9q65p9KvGmYr/FRyab6UbA8YaGkl+Nhrd/n/sefucSq1k1IwxZhl0Q2ChkO/gCWoMHMXDuOHZAOvyICFKqEwZFxp9wFqRFJHJfp/WXyxHq/DH5PNyh3qwV3SV77C5rlF3jjLtH4U0WMtD9slpZ5v84/XRr084Ttp4RmH72WVU2S6RtSt6wuk7Pul8cb5grtYqUCIZvFExCO+Q0qTgu78jpB7gwv4UJ4CO42OoSw6Suqm0qTujqnsoT2yp9ScJmSvv0jslqI1j6DMDehojLdXnXKUB8cZ5Om31B7vGsKW5C7A5JkkwKIqq9DYehtgmhl/0TmCAB7ydQLO/4t98wIi3fxVlZOocHS7BmaMhrsvNXxNsaZAMbDYNTlVzK9dOLqI9J4xSB4223yg5fbFbZutbzwZmoLOictBueyVTjbaSUftEdA/+yDOSsr25RGD8bytkYpZs4Pyo90t9K33DhaV8p7h6Bu02j5AVBL6GbYbCpi7v9Ch00hKvdTEjT6ZfxPQvUgZZDFIYGh4fBhm8k+MqNT6BwqtaKE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 188f712e-ea01-431f-81ec-08dcfea026b0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 20:18:17.8871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9AvGGD1o9k9cgib305QRwtA6Qizu+LXjLgfqJ19UUmtorMOW7KGQf6Ugrw4oNBMoDmVBL9gstSEUPS6QkWyYSHqpXgV+eY9jvRHOBtydVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8107
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_13,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411060155
X-Proofpoint-ORIG-GUID: j8pmL7CcjWGxwIn4-R3n_jUF7nY6600s
X-Proofpoint-GUID: j8pmL7CcjWGxwIn4-R3n_jUF7nY6600s

To reduce RCU noise for nohz_full configurations, osnoise depends
on cond_resched() providing quiescent states for PREEMPT_RCU=n
configurations. And, for PREEMPT_RCU=y configurations does this
by directly calling rcu_momentary_eqs().

With PREEMPT_LAZY=y, however, we can have configurations with
(PREEMPTION=y, PREEMPT_RCU=n), which means neither of the above
can help.

Handle that by fallback to the explicit quiescent states via
rcu_momentary_eqs().

Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/trace/trace_osnoise.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index a50ed23bee77..15e9600d231d 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1538,18 +1538,20 @@ static int run_osnoise(void)
 		/*
 		 * In some cases, notably when running on a nohz_full CPU with
 		 * a stopped tick PREEMPT_RCU has no way to account for QSs.
-		 * This will eventually cause unwarranted noise as PREEMPT_RCU
-		 * will force preemption as the means of ending the current
-		 * grace period. We avoid this problem by calling
-		 * rcu_momentary_eqs(), which performs a zero duration
-		 * EQS allowing PREEMPT_RCU to end the current grace period.
-		 * This call shouldn't be wrapped inside an RCU critical
-		 * section.
+		 * This will eventually cause unwarranted noise as RCU forces
+		 * preemption as the means of ending the current grace period.
+		 * We avoid this by calling rcu_momentary_eqs(), which performs
+		 * a zero duration EQS allowing RCU to end the current grace
+		 * period. This call shouldn't be wrapped inside an RCU
+		 * critical section.
 		 *
-		 * Note that in non PREEMPT_RCU kernels QSs are handled through
-		 * cond_resched()
+		 * For non-PREEMPT_RCU kernels with cond_resched() (non-
+		 * PREEMPT_LAZY configurations), QSs are handled through
+		 * cond_resched(). For PREEMPT_LAZY kernels, we fallback to
+		 * the zero duration QS via rcu_momentary_eqs().
 		 */
-		if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
+		if (IS_ENABLED(CONFIG_PREEMPT_RCU) ||
+		    (!IS_ENABLED(CONFIG_PREEMPT_RCU) && IS_ENABLED(CONFIG_PREEMPTION))) {
 			if (!disable_irq)
 				local_irq_disable();
 
-- 
2.43.5


