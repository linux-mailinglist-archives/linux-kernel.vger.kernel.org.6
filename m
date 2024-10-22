Return-Path: <linux-kernel+bounces-376936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D071A9AB7CF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF47283790
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B763C1CCEF0;
	Tue, 22 Oct 2024 20:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aB9G1H7O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u7QE0iUf"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1929D1CCEC4
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 20:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729629690; cv=fail; b=GJgH9/+Wpg1a/9tH2957BlmXtqVwyu8iLwaW3n/a3sjW/SQbi0OE32Mo2enN2BXpXvvavk6J6zGU1kpA75MrKOuSCxGtcPEFaXjAd5tuTviRBJYX6R7pYO4Fzvs8Z+D/CA+SjPaksVpRfMuDt18HfyWKcL4KK5AsdBqX7OmDJwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729629690; c=relaxed/simple;
	bh=cUmctGVR8b1UxHfrytqUMJGeG8de3oe8uKtrX8NZdBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EP4EspQkD4NbLXXJ20RvurfZkoM+RxqOAV8pZxwfCdEfSmlMJ4slYGDIOF2vpkF5f14mvKV4aDy92cqC/+zhI/tacQAtrST1ZBcy0kDxfDyY9TvSAjj1OQNiOVYBiPScfqXDBuWOfIZ7w/6MHD6d0K4Y22bDYmJLhJr9//RTqQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aB9G1H7O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u7QE0iUf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MK3XG7025798;
	Tue, 22 Oct 2024 20:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=e34AEHAMhHEQASKV1R/2I3fLJ9/l6ehQMuhQiU5tCX8=; b=
	aB9G1H7OBEbDW8H01Vv8nphGJm1lsMifIVg9ELbFFvjeJ81a8wA4FEdx5jsnwgk1
	PN2B1zSr5WUt4MBaMfHBvyfMbZEESNEbWofgra2aiVmBkFVMWbQOXZjygrewXmKf
	hK7pG53idv6m4aXl9lr+5mlgeUb1NU5FdzLLBCk+RGumJkbC4A3fvHpyAGMpMvrV
	aW/ZW5ZYtPA9Q2upEntenUirFdss7DxGSOiKgNw1pym+24fxkf4cHdfmshw6KEAu
	cEJxLmWT8ttIV0Asj/23H9VUV/vOn+18Ftps5cH/VdknCkmYJuTtgtKWc0tFn7z+
	A01Yc8jPgutIWOAZlZFRYw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qendq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 20:41:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MIoKGl022660;
	Tue, 22 Oct 2024 20:41:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c8ew34a2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 20:41:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4WPXWYz03hWe3vlZnQ65HCuHk9NWxQ8CTaH+pO9j3n1C0HKu++MpXV9qshcDWvaWwvimB+lq5Xim/0ZQ7LtSZlNbNdheF9b80yBEeQ+TtDxHU+Lq4/RSMf0a3gceMslcbXdlnJ9YHp5DiB12ZamrLNzHrc7ogfnshRaijwSYllb/Wp8gt5fY/fio1L9CCRjkT/bHYqL6nz+lAEuVH3DzwICZESWKq0ku3H+ajDou7cTlPBgni6aZut3kx+1RHzud9cvKG5bTDMRQt6ChGvauRMgCcmt7t9B10aAHcGhmboslE5WiQV+U8LJOcVkJ48KSg8QFQG2VP010F3g2JZS+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e34AEHAMhHEQASKV1R/2I3fLJ9/l6ehQMuhQiU5tCX8=;
 b=nutyY0oz+Qqec4+zZcn1sOz/G7tJyONM4fRgPGw2ye34LMIKHFFn+5ok5m4C2392hZ9Q0hj1F09QHxZYqv8c7r1sqVaMGAliWGRpf1IRp+TtQua0pKl0OjvQuWJJKTlx1xpMfwRIjxk6oHVCMCOyzwSR8GrXbnJ28YfCYJGKqpkUT4cM4UT1I4c6O9+bqPdMD7q1GHq84tZj02AcyhrrWwLXhlVw+LGzjbo/OG2dpT0AoZlma03hoGfqKn2belfefywVmcmrgWW7NGhx2040tUL9+TpIbkqISgg5g5rM0Z6GP1imZjuXTWPTEoZJrRL5Pz+peLdbCrjaS/N7R3feig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e34AEHAMhHEQASKV1R/2I3fLJ9/l6ehQMuhQiU5tCX8=;
 b=u7QE0iUf4/7EINHeCJQSJvz+rMV4tPGFkFZa8coisXNVjEV2iiCyf6Mt9wY3e3nmCKc9ypXOaNtd8GQBACrOjr+UFHZnMGSkA5CfKVXuoSk0ZF0pY0bx4dz72TCxc/9fNk6A+jxkj+TfZoCVBmp1DuY2uQ2QcRDH/m93+dPACrk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH0PR10MB7437.namprd10.prod.outlook.com (2603:10b6:610:193::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 20:41:16 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 20:41:16 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH hotfix 6.12 3/8] mm: refactor map_deny_write_exec()
Date: Tue, 22 Oct 2024 21:40:54 +0100
Message-ID: <e67b7f6c682bddbea2fe8b2d87b8441e4d2ea6e6.1729628198.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0042.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH0PR10MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: 1694ec98-4a0b-46b6-4121-08dcf2d9dff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iNB1fbNOqFArCB/MHYwHXYvPo4K6+0FIBNdHXU3Odw2cSMfiSPp/jvIyW4Jk?=
 =?us-ascii?Q?Uj+fp2OvXcubLIlxUctbDUlq/uAc0VA06WKBUGavp5HsjZlUSXGDyq5BCj2u?=
 =?us-ascii?Q?wEJyAEbQX2xMK3GN5+bNk9inYjajPzsLJETpP12TjWNBeOGT+pC84NxZkEC0?=
 =?us-ascii?Q?/0U0nUy34nik46GYb3AY1t5hERIx4e1k7nT+xQJrl+fyqwUj079K9lUM+Wze?=
 =?us-ascii?Q?euM/OYwyvRM0mstvSlNAEn9v+ScVKmO/QQrl7EQLt5+Vem+RopA6D8HX2Nw4?=
 =?us-ascii?Q?3FK9cvZ2JHkQlapM2Nn6egZxE4PDZTjf6NiRfq3CD44DNFEd5RP24bPjR5tU?=
 =?us-ascii?Q?1xN46BrHYniaBHXuA7viWG8JDzj0r/RYxBQmdmX1tJnS3CQmbMp6S/Ide3CP?=
 =?us-ascii?Q?JggyiZfTeNL9Gm5K5fTGnEjtPUv8Tu17gRxRUntN0op52pFMd/Y8LUbtGNBF?=
 =?us-ascii?Q?FikR7a/04DsVrUKeUSUEWXH0s4wkZarHY5E5RXOeJTO6rMVFHMCWk1K+vNTx?=
 =?us-ascii?Q?BABoz9tae6ZQ/+JSEdCP6m/0GOqDV3bluRPp4NulidqBL/PxunXdJaJyKVtR?=
 =?us-ascii?Q?n9Kpm7DCDJo7qQX6g3xcFZWZ/nw6gmIseuhWPyakj6A+I36afIWyfJ0Umt09?=
 =?us-ascii?Q?kljwoWJ2MLwfjHGBcDParrx3fLWBraSfODGGu9osnQ0wSZtldoShTmn5io3w?=
 =?us-ascii?Q?HR0qooAaa6DkRPAtdrWkYVDiLPTFfYQg5J/X5uysZLf7P5aHGDTHeRuUqmX7?=
 =?us-ascii?Q?DGyKZwbsSdHdvIBu2AK6gHnnFaqkBK6HGZ9XVuEIzivZIcOHUwS+sOf6Z9x1?=
 =?us-ascii?Q?IzQj1D327SmPbsBPe8yWhRXEjJ+s7sqisKRzUXFtZDKJU8KqmeibDwPt60JJ?=
 =?us-ascii?Q?00Lbi7woIENpJZFmXv9KdyY46TXIoSXVu6QRa8PbTFw4QUZZVO53wHFMn7mP?=
 =?us-ascii?Q?FYGh/xpb8QVtBiJbJWUxZUGwgsKJiF18SZVqvLBSIxJud/tRZfdG/zA6DIOL?=
 =?us-ascii?Q?0UMD/fwACaVbYFlbtiUvE+MhDxbpOVi5dH600cwe1/Adre4Wl/wgrn44lUPs?=
 =?us-ascii?Q?F/7SlDD2DR2PuL81qDR2jlIA3N/Uqu8N4PN9LGGb6ssbaxShSobryQKcGzzV?=
 =?us-ascii?Q?9bUNJ0ucaSVCtDWxi4pfMq7uHSImQJXHGBShCcPTwdk3apkFBHxXQ6uVdUlm?=
 =?us-ascii?Q?Qr+S6BXIC3Qw1Ze+vqQ4t/FckGroq0bpAFrdC2+thVeuXnxgQinHy1syQrj4?=
 =?us-ascii?Q?wbvz88/S0WF+bVa6xwMW/XNbSh90K6nxjSuwDUmizYOpIZwJrpjwICgrKXDu?=
 =?us-ascii?Q?hXHdZAD8w545shYPiaotec8n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GAEs2oRJ9cb6A6wsNcJ/1ftn6B28ju7DBUXqGo6hzRMDIitM/5IM5SVQDTPN?=
 =?us-ascii?Q?RqdzrBXebKXfytU1QIlwRgUiVHbreCIYitwWm+YFatCe01Tj1baCwrnUWkLr?=
 =?us-ascii?Q?rQgESUOiCxmF3thGHk3/W1v/zgiXi7VInOX/vjYCo68WNnmIp97zoiuxsT+6?=
 =?us-ascii?Q?h7Sx9YjmhMz7UvQyE0C7JoiY0FmYIODK9CBeY4dnExFn+M+T20S4XlEGoa1c?=
 =?us-ascii?Q?LrQMYtms4Wn+Qvzx+AegOb3uvtqL0mGRZYVS3JMkQNGKM/Kk79/Uk7CWoghS?=
 =?us-ascii?Q?QME3N7Fpk5hdyXCp9D3AW3XKVZbztmco7E770cwiZsl1fbSv/9C2icK4MJe/?=
 =?us-ascii?Q?o/Qm2X4NmS7oJrhCjtiTpwVTKLh0GcYDwZN8aewlIM6w3BzUVsHeaDRVuXAa?=
 =?us-ascii?Q?E+q1MnSbKrCUtuA9ekUBeZW7aiqNId09FgxhAZHgrLJReDJfp0sWqzi1c9Kf?=
 =?us-ascii?Q?R9kHhewCG3y5w1ZLroZAMptaE+w66+x9PDVq/WE0G/X5DELToGArQXHvChSC?=
 =?us-ascii?Q?Ztm5ZGQQbr0DH8TvYpX4qFKshErrFiIiKnyxZspp15N3FcepEf1OrrWTN0Cm?=
 =?us-ascii?Q?qzV/H7GcZ0esfvD3zGmURu/jx9jISQRYzOkNlZlMFNs+ticNN8w6kXqwJYnp?=
 =?us-ascii?Q?yI2QS08VXNRPyTsKmTUqY5LPCGxTstvPgeGbnBkb+kv+V/huv0P1od++Nje+?=
 =?us-ascii?Q?p2QKKaLb2lxqOPBgJ06KggVTAh1JwG+l1ueoGj2PSt7afNd6fCAyn3ok/DH4?=
 =?us-ascii?Q?Rw2Y0cQVy4cq6Yw4Sq1dF8o7OiPRG645OpdMWhnWVRULiMWgCIH+v/Nx0fPe?=
 =?us-ascii?Q?gV2Zoky34jcT3e+3JAsxojJIdxIrrbvIaiot1PiVFqPXd4dOQ24e1XpuHDku?=
 =?us-ascii?Q?7FcwDka/sUVEd3lZvqxMhz1XnAIW0tYu6mgi+iCwJZJA4aXN7u4ngEFQGtXb?=
 =?us-ascii?Q?BYgNIYScg4HlsoDuisTSUahgSS9tAyK9RZrky93AapXGLQW+VWLhhqkwR3Cp?=
 =?us-ascii?Q?W0laAfRnOAlJdlue9jHhO5e5qQm9Wy+jnDvp1kBpCpXtPql5MrB6EmvESIcb?=
 =?us-ascii?Q?zSCszHftIzb83jIfO7inwSdysEvf+PUADO6eaed8WqwRUuYHTqULLYKad8jj?=
 =?us-ascii?Q?yQMa5GBAmq3xMs/3ssgS7bZnwWxywvotzQ3e1nugErVPEYcImHDdd2FtVIox?=
 =?us-ascii?Q?Sh8JCPJbvw0onf48fitxoZQ3jSKWqCHJGoD0Vol3PZLLWnHq2FvIqeygJg1v?=
 =?us-ascii?Q?napETtd5m9YRJc14VNSGgaby1pPfOtvUJXxjhO3ugjKdo3Z8Odlnclu7oA2x?=
 =?us-ascii?Q?YEiXFkL/zpzv5vyO0pG6+8pIttPfz5qSkx3Ma9m9mxGKlTfy8eX8XPBRyKEz?=
 =?us-ascii?Q?GtBndXg0Q4YMysuDI7qZV81dok1uymSb6h+cj6hu13RBQem2KU8h9j7fRZdo?=
 =?us-ascii?Q?fxilf3n2THlX/T9dENrfI1h/IG8nZj7dXyAIEPWqURtnb/N9sAuzbbFxh2K2?=
 =?us-ascii?Q?K/X4QNk1vzbVcA8g0nRfpZvdoTUj7nLZAILi9nEdDjrRqkPiRO2zvd1s/JHJ?=
 =?us-ascii?Q?mZodbrpCL4TdJkiiDAuNo1Aksly3ghcfSjdjwXUdX7uQvD0KQDxvZtY7t0I6?=
 =?us-ascii?Q?IY+VEil4pKwSxTNpH1uxv0Krrs4cB+zYOikNZHWixSwN7F+A/BIvy2/e5pG9?=
 =?us-ascii?Q?Gz/uPQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	53v0TyjhEQo5d7mfSguNh+Ln2v8xmOyuc034sCvZWD0xbfzMJaaB5zl1dlCfKHKFsWgUFdR+70MWzhv1GYcsL8Yh6Fin37tJu2fq+8f9Sij93DrA7oi54t1SBMAfnO0YHiR2uPW5A3mz8lia9Z0iUNS7JsC1hQalFcEn8PUaQBU+yVnVoqTmZ//ZymIzlubicf1wxwVbhpiagEbMJ0MR7lqJPXtnZ4Om++E58IE14+EZxAlfQIEvzFZ5CpAAYyhLtcj8exJUFCsUm2N4GVYEV2PapTCcFcls9cJ0M9sIeQWJ7MTtjlH4gL3Nl8dL9dQgnyq22B3JcSBSNPR/fR5DBtpuX2c2Mx+QIT82Ql+LXnA2Slo6WYHefmV8LWxCqmTpCz31gXq305YLLgyHu7JzO3nRfeLMSLMpunljgSPr2t7L5GmIZOwU2AW2/amLyQDpa7BNUWgnvu39FUV5i8RGM6ZfMD/nHlwpWoMCqq2gcrMdI3MyiDNj6M365PrBKecJJ9orjksMY4eOav4y2eznM/eQ+lSQI6E9Lz5oW+BH0Pn4gsGyYY1bAKiCmHuzsVlfKZ8KX06aDDDeSInuItOitKkfuqrSPOEY6gza/+/46Oc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1694ec98-4a0b-46b6-4121-08dcf2d9dff8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 20:41:16.2030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dIBKnR+sLk9fNlRTmE+b4te/3o03spUBU8Rd+p1qxmtdDhiLciTVDdIPAq1fXg97GrZrA/7FIfDM24n1gw0TmFb/1nTmoF1Jo50He/+SoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7437
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_21,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=979 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410220134
X-Proofpoint-ORIG-GUID: rZgmdcJBQiJr_qbbFFJtO5VJevnX5oaw
X-Proofpoint-GUID: rZgmdcJBQiJr_qbbFFJtO5VJevnX5oaw

Refactor the map_deny_write_exec() to not unnecessarily require a VMA
parameter but rather to accept VMA flags parameters, which allows us to use
this function early in mmap_region() in a subsequent commit.

While we're here, we refactor the function to be more readable and add some
additional documentation.

Reported-by: Jann Horn <jannh@google.com>
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Cc: stable <stable@kernel.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mman.h | 21 ++++++++++++++++++---
 mm/mmap.c            |  2 +-
 mm/mprotect.c        |  2 +-
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/linux/mman.h b/include/linux/mman.h
index bcb201ab7a41..d71f83b821ef 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -188,16 +188,31 @@ static inline bool arch_memory_deny_write_exec_supported(void)
  *
  *	d)	mmap(PROT_READ | PROT_EXEC)
  *		mmap(PROT_READ | PROT_EXEC | PROT_BTI)
+ *
+ * This is only applicable if the user has set the Memory-Deny-Write-Execute
+ * (MDWE) protection mask for the current process.
+ *
+ * @old specifies the VMA flags the VMA originally possessed, and @new the ones
+ * we propose to set.
+ *
+ * Return: false if proposed change is OK, true if not ok and should be denied.
  */
-static inline bool map_deny_write_exec(struct vm_area_struct *vma,  unsigned long vm_flags)
+static inline bool map_deny_write_exec(unsigned long old, unsigned long new)
 {
+	/* If MDWE is disabled, we have nothing to deny. */
 	if (!test_bit(MMF_HAS_MDWE, &current->mm->flags))
 		return false;

-	if ((vm_flags & VM_EXEC) && (vm_flags & VM_WRITE))
+	/* If the new VMA is not executable, we have nothing to deny. */
+	if (!(new & VM_EXEC))
+		return false;
+
+	/* Under MDWE we absolutely do not accept writably executable... */
+	if (new & VM_WRITE)
 		return true;

-	if (!(vma->vm_flags & VM_EXEC) && (vm_flags & VM_EXEC))
+	/* ...nor newly executable VMAs. */
+	if (!(old & VM_EXEC))
 		return true;

 	return false;
diff --git a/mm/mmap.c b/mm/mmap.c
index d55c58e99a54..66edf0ebba94 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1508,7 +1508,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vma_set_anonymous(vma);
 	}

-	if (map_deny_write_exec(vma, vma->vm_flags)) {
+	if (map_deny_write_exec(vma->vm_flags, vma->vm_flags)) {
 		error = -EACCES;
 		goto close_and_free_vma;
 	}
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 0c5d6d06107d..6f450af3252e 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -810,7 +810,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 			break;
 		}

-		if (map_deny_write_exec(vma, newflags)) {
+		if (map_deny_write_exec(vma->vm_flags, newflags)) {
 			error = -EACCES;
 			break;
 		}
--
2.47.0

