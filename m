Return-Path: <linux-kernel+bounces-548670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70E7A547DA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0E13AD24F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFC32046BD;
	Thu,  6 Mar 2025 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q3gioSBF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WKwHkTcU"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFF320102E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257270; cv=fail; b=tuUNBmXC817DK1corWV4f59dCNLhMFxKrIcS7JbeZmNXCp+QlMn1O6wZ9MbWRPpo8FN71QfcsN7BFDeTiC5tcd5mf2cr/MLAsgpF2q3G4ubpuI8Q8onFyduM3BcEib9mZP1fdI3NvwDKLC0lktp+lw/sa2Fq1hY2m4pJLhOwXag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257270; c=relaxed/simple;
	bh=VtmLzUix0omPdLIEI7mZ5EtFkC584DeBKqFCqdibWKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yx6uw7F/RprrJW50a1Dsrhq4UZB6Fb3tN4hBQO8MXUfE35M4TXUjy4s8jaVc45uJRxP96Ux/s45f9aOfwcx1HqshWrAyjfgKlQJw76VDDpUpj2ZGXaY7eLbAGjrPr8xkMO6OrgxmG6OhSB4QDqMFIIu8lMe1wklTejxJjl8Xmrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q3gioSBF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WKwHkTcU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526ABflb003723;
	Thu, 6 Mar 2025 10:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=j98RvGp9i8dPsGlpfoEaNFCEMACsgE+Sk7Yql+1C7n8=; b=
	Q3gioSBF34FlXIsgmUjS3+B0PAToBfA69z+Ue8DeYcTyz+n0rcP3JJEUOZy8/EFZ
	s4mOR240Byo73XUyGLbvJJnEqM68pVKaXHAtbUiVILCToyw7leSKfLFz1hvwAtDb
	ELJsxp4b9ctBG+T/GQz21wVDKqY/xx743R7zqaLXdW0RGmxNe9qRU3yzeYSYF2wU
	9PVx9OF4vfB4OIT1nGAITX1z8H1FFdFCppBqSyZ+6HiWfjWnUGLIg+PGEH2EAK0e
	WrV+uouTNRJhWNMGjXS13tk9yUDP4yKPwkcTLUwLHfzYCQ5i97jaRsGN74ukn4sL
	copudIJqSTbSMow2457W+Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8wspbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 10:34:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5268XesT010933;
	Thu, 6 Mar 2025 10:34:17 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpdh6rw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 10:34:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2vWNLytX8iY3MsrST/sJnS+5aDholziyTOfbTGc8hMB7AiChg0GiSAofjuO+ZUFywttgAoqscZb44Eayh5zg64UXfpHBvIrAYeSLsgjoh4i6u/lsE9iNdy2Im93f4F/jTTw51zEq12AqdZh1ewqTPjxmFsPLpJi1X1aLq8Kxl0ACrn9353FKBzS2hlIxsPs5BfLr6l08pjKJkIVXIegg1nRMArMV3OhPz/Rmv6reY2tkm676ypJFxLw/oHvFQmzmbsurDKIaHmXJ381skpJjcS56CvTjJLHB00jN6Xd0qz6zcXEEwqe4Xw28QB/A+nJ5pCvIz34rkagaoSHclkvvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j98RvGp9i8dPsGlpfoEaNFCEMACsgE+Sk7Yql+1C7n8=;
 b=AlhqQlFpYEdpzvCmRVZbjCwxHofUcE7hdK4T3FYNGN1c9xi1Qjp/Vew2jog3MO79znvMRbmuV+/62kCENAG28xtVNqoN88jrBg2U1IvpusP1MdiGAnzJwqzY6cJV3olE7aD9nvWZzh7AuOkGkgYxksej9d+opTgv7OTFHQGIgCdRf5CQFmOb6p3z+i1Ml7KBCfLvb+4yLef6guIFSgbllcWVSZ2sDzpzJr79xAn8JoExZVe9BkJYdbmGZ1e0kfnFxGlvBTPbL0PiC4KJZXVzNIc6mWhcUbdFiWa63PV+tXaeDnAh6tSnIRYA61w6CpQnl+rcuhpQPhnxaDahpyuAMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j98RvGp9i8dPsGlpfoEaNFCEMACsgE+Sk7Yql+1C7n8=;
 b=WKwHkTcUH2dDggkD9ZOb4TDzIggVkRQHSw5eL3HFcX/ZLMYevxv+VJGjiH57Z/Pm5uFs/Dh3uJ6LIv0LFMYaqkzwalSOpo67Rg9GTknL37p6m7EAfiFjRn7/QzBWsL6XTH8VUKADcpii0G+QmXIyPw7e9Jde0KuY0RJDRuD6Wzo=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH0PR10MB4647.namprd10.prod.outlook.com (2603:10b6:510:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Thu, 6 Mar
 2025 10:34:16 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 10:34:16 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH v2 4/7] mm/mremap: initial refactor of move_vma()
Date: Thu,  6 Mar 2025 10:34:00 +0000
Message-ID: <93193b2b45f6e95da6e8c7a2776e2d8c43a346e7.1741256580.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741256580.git.lorenzo.stoakes@oracle.com>
References: <cover.1741256580.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0580.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::16) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH0PR10MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6e25a1-1a35-4a0e-05e1-08dd5c9a71be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fwck/pNZxpeBbBW5Zmky0xMSiFb9wc3/kmO66QrWLsfSN3egNvmh/mfiGUx5?=
 =?us-ascii?Q?U/HPjrRibIkg86b4H+tetqyK1xBXhvxb2WenXsihPAuwWXfFPMalhT6pBnjW?=
 =?us-ascii?Q?lWYB9nyhsjIApBWj1Uh+fxsceqbbwzb3Xsugh/GWJtmAmO7tXAATwV2wKIPm?=
 =?us-ascii?Q?ByoHfF87NsZp5kMc+bMaINmYeRAWTk5WJkuL3r+R+Wc7OjI2FuaBUYo7y1uY?=
 =?us-ascii?Q?P/7x4s8WYtmOJJe41vqEq7nJqarI7354gpPlG3H3NiNY7/eWgGctAvFEnE0C?=
 =?us-ascii?Q?9ebQb0sYe8Nm5I3R4ugQLqrpY/jR06RsGGHQ7LI5gOuBFxS5+iHeNTa+PW4O?=
 =?us-ascii?Q?x2z3aQcLoev/YFqK/ecorTCNeOV/3oONRKX7hNsmPDNLOUOplSIVA552pr1v?=
 =?us-ascii?Q?dFNeujUJQCz/qAChokIhcL1i8Igv+4Xk79of+jETdJZjoIly0KkDKM5aVESe?=
 =?us-ascii?Q?bzeKHWwObJG+jazny79a0eUT4x7NmHZSNF+IwblMJMeF6abry8IP9e5KOuMg?=
 =?us-ascii?Q?A/8RvZaj54CMTWMuwe2dREoB6os8yMm1hG3pOFUvy0cyBA1KiunQ2Jy2yvMX?=
 =?us-ascii?Q?1atvrmTt/HqUp8dakfv6P/vWJDqPIRtsgebBqMQCAwk5L1y6YBVhFAN3W5Aa?=
 =?us-ascii?Q?+G6kviFsOFsCxouM9xUhX9JTLvnWlkFsVxk8EuRZXN8q5M+xzVzbieI6Wvrr?=
 =?us-ascii?Q?M/yIFZHY/VNmrbooWkS2hoU52aDoqIJBPOF2Bp8O5EhP7dfwYbDoMbQgnTx1?=
 =?us-ascii?Q?VbJcxxTFXl23DmPPnHPYAkMxR4+qt/pXQB5T8KAu2CH1UqxLTfeixLWJHrYz?=
 =?us-ascii?Q?3l14b86ynVyv9VwINLIers1gx7p7qRSvl1NmyEYGl0IFsL6pPfZqtbQYWnmw?=
 =?us-ascii?Q?E5Jz8hDcY1LlvHTxybkNoz0jgztF5uESvVRCEGJlY5UUkKpCimznPMFgAX+k?=
 =?us-ascii?Q?3K5xEFLb/a/5shtUhZnqsr329C+jg/geFxhuok+rP06VutbYMGd0hAvSX42V?=
 =?us-ascii?Q?gFgxTCUfClaYTy6osyJz1zNksal/r3T/1H1sZtg2Y79sKY0Ov2Ik4ux3Ba+6?=
 =?us-ascii?Q?T33Rstk1lofBEc6QFuts5GEqqdbiTHEf6hIHfYw7LaUdrX4RSLw2fYQ3X/4C?=
 =?us-ascii?Q?1hkhbHb47dHekxxx7uao+vXsWVGQj8jHYlLDA+3tslAp18oFgyKXkPpLcgp3?=
 =?us-ascii?Q?g37ANJ42QuP/2tDIP+y98MMTcLS7mGhaV6pqghDOfu58qQ0IodKLqNbAFl6j?=
 =?us-ascii?Q?TE5GALikLsU70Q4DZfH3IfvIFKrKBI/r2C++o08FEGGiRqedfa9t0ifdFAnM?=
 =?us-ascii?Q?vjYbYRdwyqdsdxq1CGVXZG4Ks/Br/SIox8l3x5LWN7I2DCPBylz77aAg9b4t?=
 =?us-ascii?Q?FwEYCvXGiZ5EHz9pRRyRdP8NkYnc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WyUD5NUNm6LTbkZe3Fqnz+Ijifx7R5oJwFfgfXgrEjy104h8/wo3gcpDfqC/?=
 =?us-ascii?Q?8yJTigfkwQsLGeO7U1mAGy7ElNuxKqakUZN6xxKn/joFEBGbrxYSJTLlSHk5?=
 =?us-ascii?Q?Woc6weJR5CmM+W9Vhl599Rc9eoaELj+BVeGU7aT5r6aFfXzjN20DhcnyLumn?=
 =?us-ascii?Q?oN2dFKZ6r/ygWVpyOpaG2EnWqYGeEOyAVgWF3LWye51SigTBoX7j1okSDtu4?=
 =?us-ascii?Q?o5dx3scLp4IhC/+GsU0Wcy4vIOC1bK/bEyE1shcYfOcZ/3gsCLWwaoYJMo+C?=
 =?us-ascii?Q?32gFxU8UhN9WvYK435buNQxqcaVjqgMqWgt3eKqyrixgKT/xvmsSWGP8nsky?=
 =?us-ascii?Q?V52XZMPL+r8+4sZ51XSk+5CBxxof1npV2lFhqYZ0gfpX0pzkH+e0uWngv9ox?=
 =?us-ascii?Q?92UE+OlYpAr1zVBmXJEVttyfCHZM/dxs8yILiI+QWuyYoXvHKz9ahWy5fxdf?=
 =?us-ascii?Q?hHHJg+fpFwn3mXMqglnDNwWlfZxreJQ4vIeGL7PeBwD60QBWpaQY/e6xIj/u?=
 =?us-ascii?Q?JxQ1xajPGUbO30iWeyJMJJxTFslSknV4s+Kgp2Ff6CRVygOQSMsSDzD7Se2l?=
 =?us-ascii?Q?IFNE+YgOxBOpsc5h9i20m+I17wJvuxloLeNgLDcf/o9GyWS5lYacxvIPzAt3?=
 =?us-ascii?Q?mgGSuSQWNV13SQoVNOOVI7wSY0tulYbfsVaOR3cd2xXhzWAYmgNveBrUT/Yl?=
 =?us-ascii?Q?4bTiRsNOBNl4dvHKoZmYIZstFjqBAJWgsWYTyR9AlrdSlFOXQhbnSKVJ8P2P?=
 =?us-ascii?Q?4uvtxemlF6aM6QQ9dU6MsH3/pvI4Ch6MDjqfV/Mz3mC30R3a4KuumXALaWA9?=
 =?us-ascii?Q?HlzKFwFPLN4KDeh8WwKwjxvvFOoupFuc1VpRG/bxt1V3SIsAz7xIqbWxFx9B?=
 =?us-ascii?Q?L9a31YEFaoko5exFLKqJf6O4G8qGq7nz011HZxYXEaq5rJIToTkpuhFlf6gt?=
 =?us-ascii?Q?4+a0K0g9t2IVrAJ2GzM6MbvP/b2Sq+PgiUBcRow1f6B62CUzmJyw3ntMnNfa?=
 =?us-ascii?Q?VWY4jRjQNgcKz0Jdwaw9Tk8tCHY+/8BFol4kQkpM4WvQIQc1iHeE7EgWVeuY?=
 =?us-ascii?Q?j6BIAcF3RWKJFy2PcDDLNe/wOVHhfKVi1okK6DNVfB6BukyV0QdMnrpPnK2F?=
 =?us-ascii?Q?9GKrCgiiu0FUV/twoh+NeFBblLpwdBubfp/lf9FrKGmSXB7OF0qkm7B/NfYQ?=
 =?us-ascii?Q?JwGFAfVM1fCR8ngUp5nqFIS65m45w27MMjm3XtYOn5UiO4zvqnkytfIDLrEl?=
 =?us-ascii?Q?dN/HdYBLjep+3bkqfeIpOrdNtIgvlgNgaHyeTmhts2btGLv5uIL5qNufwyGh?=
 =?us-ascii?Q?Oga7pzU4AxRvEWLUBucZZCY9Qv7ZBqMF6eXov4U3MMfPYifRaOI0DAOQHVst?=
 =?us-ascii?Q?ffXaB/5l3PTjlLRX3blGPUpxWnqIs3JXaTdCl0FQ989C0DAaHtvmkOxq0pGx?=
 =?us-ascii?Q?dwcWgLLeNzaD1rP57bjKT/jHF1PthNe99JsjRbzcQVcrKlzgKnVUNfvCkfUH?=
 =?us-ascii?Q?oneevBgC2TOlcS7j0qdeB2FOHOtKaE9pXr/q7M4xDaPk3n7HHev1gUaQRo7H?=
 =?us-ascii?Q?LMItUSLmPNO6R0tlQSKN1RTg+e9qz3oIz0D4mwqmf0t7ihUttSGNsy9ARpa0?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/BnprgpQhObabA1msWztPZYPGkerEwXrklU15tvhOVfA1lsyJ7+NZ//l04xGke6iAhjNpf0/mFGVhaHd3JFO7LUceuioPv4/YCtSYWBvfTkuX8C2NsLS639TXct+ocd8Q0qgGQ68v9jLKVq3ux9cqucUlLAnoIodFN7Gv2fIGjkE2ZnNRzp2mP6VfFWcQAEaBkdottdLphxlajeTYFYqCi/6iQjS1Ju1nMcgQYB3UvOhSGAMpNJPCpfh4zfqPuDv7L1B7JID+7yUy6AqXGIlExX+JN5CS4p43j3JNiJTVXyS06ETcif1MM37h90puU9YguiKbjC8vvbSoCZqA4vZ7VWJpkjAEyWMNCa5ZaL9MNJTelir/Z1TrltsT6BIS0OERkzqWTomOS4w4r0wYSOtET9IRltv7fOHvk1cG5F6I2Zouf7bfdtcv5Sgs1ln0SmpVC5CgIHf6x23ht4pLlUKADftn6WmBumvDjiqqTBjJEKw/H516uz78PQknSEDWvHd5BiKNndjCnBA6R7Y5t4IV/m3cjMr9V6l5JfmpibMfyK+X3p+Og8y7CiY3ANdt9l3cFAKlRBBQk1I+nbMylfLijuy7k4U60obilSy/zp+nDk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6e25a1-1a35-4a0e-05e1-08dd5c9a71be
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 10:34:16.1270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THWMb7JInBC+wIb8LevpBXzoeQc4O/Cn70F4pMq/dkwS8TeI3tTH3zWUUQ8qR+7VkiLS2ju0BFOTIlZ98giljLQDMMcCTV3qOLVMjV8HjDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503060079
X-Proofpoint-ORIG-GUID: ONm3nyZkUuZLhLNB7Jkdx_J8NlNYfuqo
X-Proofpoint-GUID: ONm3nyZkUuZLhLNB7Jkdx_J8NlNYfuqo

Update move_vma() to use the threaded VRM object, de-duplicate code and
separate into smaller functions to aid readability and debug-ability.

This in turn allows further simplification of expand_vma() as we can
simply thread VRM through the function.

We also take the opportunity to abstract the account charging page count
into the VRM in order that we can correctly thread this through the
operation.

We additionally do the same for tracking mm statistics - exec_vm,
stack_vm, data_vm, and locked_vm.

As part of this change, we slightly modify when locked pages statistics
are counted for in mm_struct statistics.  However this should cause no
issues, as there is no chance of underflow, nor will any rlimit failures
occur as a result.

This is an intermediate step before a further refactoring of move_vma() in
order to aid review.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mremap.c | 186 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 122 insertions(+), 64 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 0ab0c88072a0..9f21b468d0dc 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -68,6 +68,7 @@ struct vma_remap_struct {
 	bool mlocked;			/* Was the VMA mlock()'d? */
 	enum mremap_type remap_type;	/* expand, shrink, etc. */
 	bool mmap_locked;		/* Is mm currently write-locked? */
+	unsigned long charged;		/* If VM_ACCOUNT, # pages to account. */
 };

 static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
@@ -816,35 +817,88 @@ static unsigned long vrm_set_new_addr(struct vma_remap_struct *vrm)
 	return 0;
 }

-static unsigned long move_vma(struct vm_area_struct *vma,
-		unsigned long old_addr, unsigned long old_len,
-		unsigned long new_len, unsigned long new_addr,
-		bool *mlocked, unsigned long flags,
-		struct vm_userfaultfd_ctx *uf, struct list_head *uf_unmap)
+/*
+ * Keep track of pages which have been added to the memory mapping. If the VMA
+ * is accounted, also check to see if there is sufficient memory.
+ *
+ * Returns true on success, false if insufficient memory to charge.
+ */
+static bool vrm_charge(struct vma_remap_struct *vrm)
 {
-	long to_account = new_len - old_len;
-	struct mm_struct *mm = vma->vm_mm;
-	struct vm_area_struct *new_vma;
-	unsigned long vm_flags = vma->vm_flags;
-	unsigned long new_pgoff;
-	unsigned long moved_len;
-	bool account_start = false;
-	bool account_end = false;
-	unsigned long hiwater_vm;
-	int err = 0;
-	bool need_rmap_locks;
-	struct vma_iterator vmi;
+	unsigned long charged;
+
+	if (!(vrm->vma->vm_flags & VM_ACCOUNT))
+		return true;
+
+	/*
+	 * If we don't unmap the old mapping, then we account the entirety of
+	 * the length of the new one. Otherwise it's just the delta in size.
+	 */
+	if (vrm->flags & MREMAP_DONTUNMAP)
+		charged = vrm->new_len >> PAGE_SHIFT;
+	else
+		charged = vrm->delta >> PAGE_SHIFT;
+
+
+	/* This accounts 'charged' pages of memory. */
+	if (security_vm_enough_memory_mm(current->mm, charged))
+		return false;
+
+	vrm->charged = charged;
+	return true;
+}
+
+/*
+ * an error has occurred so we will not be using vrm->charged memory. Unaccount
+ * this memory if the VMA is accounted.
+ */
+static void vrm_uncharge(struct vma_remap_struct *vrm)
+{
+	if (!(vrm->vma->vm_flags & VM_ACCOUNT))
+		return;
+
+	vm_unacct_memory(vrm->charged);
+	vrm->charged = 0;
+}
+
+/*
+ * Update mm exec_vm, stack_vm, data_vm, and locked_vm fields as needed to
+ * account for 'bytes' memory used, and if locked, indicate this in the VRM so
+ * we can handle this correctly later.
+ */
+static void vrm_stat_account(struct vma_remap_struct *vrm,
+			     unsigned long bytes)
+{
+	unsigned long pages = bytes >> PAGE_SHIFT;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma = vrm->vma;
+
+	vm_stat_account(mm, vma->vm_flags, pages);
+	if (vma->vm_flags & VM_LOCKED) {
+		mm->locked_vm += pages;
+		vrm->mlocked = true;
+	}
+}
+
+/*
+ * Perform checks before attempting to write a VMA prior to it being
+ * moved.
+ */
+static unsigned long prep_move_vma(struct vma_remap_struct *vrm,
+				   unsigned long *vm_flags_ptr)
+{
+	unsigned long err = 0;
+	struct vm_area_struct *vma = vrm->vma;
+	unsigned long old_addr = vrm->addr;
+	unsigned long old_len = vrm->old_len;

 	/*
 	 * We'd prefer to avoid failure later on in do_munmap:
 	 * which may split one vma into three before unmapping.
 	 */
-	if (mm->map_count >= sysctl_max_map_count - 3)
+	if (current->mm->map_count >= sysctl_max_map_count - 3)
 		return -ENOMEM;

-	if (unlikely(flags & MREMAP_DONTUNMAP))
-		to_account = new_len;
-
 	if (vma->vm_ops && vma->vm_ops->may_split) {
 		if (vma->vm_start != old_addr)
 			err = vma->vm_ops->may_split(vma, old_addr);
@@ -862,22 +916,46 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	 * so KSM can come around to merge on vma and new_vma afterwards.
 	 */
 	err = ksm_madvise(vma, old_addr, old_addr + old_len,
-						MADV_UNMERGEABLE, &vm_flags);
+			  MADV_UNMERGEABLE, vm_flags_ptr);
 	if (err)
 		return err;

-	if (vm_flags & VM_ACCOUNT) {
-		if (security_vm_enough_memory_mm(mm, to_account >> PAGE_SHIFT))
-			return -ENOMEM;
-	}
+	return 0;
+}
+
+static unsigned long move_vma(struct vma_remap_struct *vrm)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma = vrm->vma;
+	struct vm_area_struct *new_vma;
+	unsigned long vm_flags = vma->vm_flags;
+	unsigned long old_addr = vrm->addr, new_addr = vrm->new_addr;
+	unsigned long old_len = vrm->old_len, new_len = vrm->new_len;
+	unsigned long new_pgoff;
+	unsigned long moved_len;
+	unsigned long account_start = false;
+	unsigned long account_end = false;
+	unsigned long hiwater_vm;
+	int err;
+	bool need_rmap_locks;
+	struct vma_iterator vmi;
+
+	err = prep_move_vma(vrm, &vm_flags);
+	if (err)
+		return err;
+
+	/* If accounted, charge the number of bytes the operation will use. */
+	if (!vrm_charge(vrm))
+		return -ENOMEM;

 	vma_start_write(vma);
 	new_pgoff = vma->vm_pgoff + ((old_addr - vma->vm_start) >> PAGE_SHIFT);
-	new_vma = copy_vma(&vma, new_addr, new_len, new_pgoff,
+	new_vma = copy_vma(&vrm->vma, new_addr, new_len, new_pgoff,
 			   &need_rmap_locks);
+	/* This may have been updated. */
+	vma = vrm->vma;
 	if (!new_vma) {
-		if (vm_flags & VM_ACCOUNT)
-			vm_unacct_memory(to_account >> PAGE_SHIFT);
+		vrm_uncharge(vrm);
 		return -ENOMEM;
 	}

@@ -902,7 +980,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		old_addr = new_addr;
 		new_addr = err;
 	} else {
-		mremap_userfaultfd_prep(new_vma, uf);
+		mremap_userfaultfd_prep(new_vma, vrm->uf);
 	}

 	if (is_vm_hugetlb_page(vma)) {
@@ -910,7 +988,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	}

 	/* Conceal VM_ACCOUNT so old reservation is not undone */
-	if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP)) {
+	if (vm_flags & VM_ACCOUNT && !(vrm->flags & MREMAP_DONTUNMAP)) {
 		vm_flags_clear(vma, VM_ACCOUNT);
 		if (vma->vm_start < old_addr)
 			account_start = true;
@@ -928,13 +1006,12 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	 * If this were a serious issue, we'd add a flag to do_munmap().
 	 */
 	hiwater_vm = mm->hiwater_vm;
-	vm_stat_account(mm, vma->vm_flags, new_len >> PAGE_SHIFT);

 	/* Tell pfnmap has moved from this vma */
 	if (unlikely(vma->vm_flags & VM_PFNMAP))
 		untrack_pfn_clear(vma);

-	if (unlikely(!err && (flags & MREMAP_DONTUNMAP))) {
+	if (unlikely(!err && (vrm->flags & MREMAP_DONTUNMAP))) {
 		/* We always clear VM_LOCKED[ONFAULT] on the old vma */
 		vm_flags_clear(vma, VM_LOCKED_MASK);

@@ -947,22 +1024,20 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 			unlink_anon_vmas(vma);

 		/* Because we won't unmap we don't need to touch locked_vm */
+		vrm_stat_account(vrm, new_len);
 		return new_addr;
 	}

+	vrm_stat_account(vrm, new_len);
+
 	vma_iter_init(&vmi, mm, old_addr);
-	if (do_vmi_munmap(&vmi, mm, old_addr, old_len, uf_unmap, false) < 0) {
+	if (do_vmi_munmap(&vmi, mm, old_addr, old_len, vrm->uf_unmap, false) < 0) {
 		/* OOM: unable to split vma, just get accounts right */
-		if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
+		if (vm_flags & VM_ACCOUNT && !(vrm->flags & MREMAP_DONTUNMAP))
 			vm_acct_memory(old_len >> PAGE_SHIFT);
 		account_start = account_end = false;
 	}

-	if (vm_flags & VM_LOCKED) {
-		mm->locked_vm += new_len >> PAGE_SHIFT;
-		*mlocked = true;
-	}
-
 	mm->hiwater_vm = hiwater_vm;

 	/* Restore VM_ACCOUNT if one or two pieces of vma left */
@@ -1136,9 +1211,7 @@ static unsigned long mremap_to(struct vma_remap_struct *vrm)
 	if (err)
 		return err;

-	return move_vma(vrm->vma, vrm->addr, vrm->old_len, vrm->new_len,
-			vrm->new_addr, &vrm->mlocked, vrm->flags,
-			vrm->uf, vrm->uf_unmap);
+	return move_vma(vrm);
 }

 static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
@@ -1243,17 +1316,11 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 static unsigned long expand_vma_in_place(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
-	long pages = vrm->delta >> PAGE_SHIFT;
 	struct vm_area_struct *vma = vrm->vma;
 	VMA_ITERATOR(vmi, mm, vma->vm_end);
-	long charged = 0;

-	if (vma->vm_flags & VM_ACCOUNT) {
-		if (security_vm_enough_memory_mm(mm, pages))
-			return -ENOMEM;
-
-		charged = pages;
-	}
+	if (!vrm_charge(vrm))
+		return -ENOMEM;

 	/*
 	 * Function vma_merge_extend() is called on the
@@ -1266,15 +1333,11 @@ static unsigned long expand_vma_in_place(struct vma_remap_struct *vrm)
 	 */
 	vma = vrm->vma = vma_merge_extend(&vmi, vma, vrm->delta);
 	if (!vma) {
-		vm_unacct_memory(charged);
+		vrm_uncharge(vrm);
 		return -ENOMEM;
 	}

-	vm_stat_account(mm, vma->vm_flags, pages);
-	if (vma->vm_flags & VM_LOCKED) {
-		mm->locked_vm += pages;
-		vrm->mlocked = true;
-	}
+	vrm_stat_account(vrm, vrm->delta);

 	return 0;
 }
@@ -1314,11 +1377,7 @@ static bool align_hugetlb(struct vma_remap_struct *vrm)
 static unsigned long expand_vma(struct vma_remap_struct *vrm)
 {
 	unsigned long err;
-	struct vm_area_struct *vma = vrm->vma;
 	unsigned long addr = vrm->addr;
-	unsigned long old_len = vrm->old_len;
-	unsigned long new_len = vrm->new_len;
-	unsigned long flags = vrm->flags;

 	err = resize_is_valid(vrm);
 	if (err)
@@ -1351,7 +1410,7 @@ static unsigned long expand_vma(struct vma_remap_struct *vrm)
 	 */

 	/* We're not allowed to move the VMA, so error out. */
-	if (!(flags & MREMAP_MAYMOVE))
+	if (!(vrm->flags & MREMAP_MAYMOVE))
 		return -ENOMEM;

 	/* Find a new location to move the VMA to. */
@@ -1359,8 +1418,7 @@ static unsigned long expand_vma(struct vma_remap_struct *vrm)
 	if (err)
 		return err;

-	return move_vma(vma, addr, old_len, new_len, vrm->new_addr,
-			&vrm->mlocked, flags, vrm->uf, vrm->uf_unmap);
+	return move_vma(vrm);
 }

 /*
--
2.48.1

