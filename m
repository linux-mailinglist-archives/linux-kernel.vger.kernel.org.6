Return-Path: <linux-kernel+bounces-541517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC55A4BDCE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89A1172B2C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2C71F91F6;
	Mon,  3 Mar 2025 11:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DvGvN8n4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hd3tqxVF"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE3A1F543F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000149; cv=fail; b=BQFCBNQeHuGzhVNYLGzV9oSPFULycUGL86Sn3gCWniNld9mMqKVy50N60N+PzswUHRobq+RxjbrTChtaQCyi+J5oNPgBH9AIQGpomPeshSo/xrhz9I3oci53BYtS5UYsuOgXG1PhGNIZlh3LiEWNXSYp8HNXsXGg9H/8GO/3Mhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000149; c=relaxed/simple;
	bh=CBO8MQGTl9agws0GIppyiMJeJ+4ye4UtAEuyeAvNi20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rLDIR2/y+zgWYgFsoaNukzP7UAwOP1GYJje85ORgsbgjpsXDzQMpP5X/iLVy34bUj11JP4Bz/TK0ma/jvfFEVfZpUaHoBb2APqcpCl78lnr5Xsp2S9tDxqYyKs41EQoxiRgjfJEW6iWvZAXlR1pAMk3yhGxyjd09Z8RoRjPJkkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DvGvN8n4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hd3tqxVF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237tiQZ031358;
	Mon, 3 Mar 2025 11:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=EG6ccytL3mfjzNgokq+UADo2jHVfKtGFrTk6AYgEH9g=; b=
	DvGvN8n4zMZWGpXGL03W3VOYXjZttywaiyJlAvkqBQO3h+JDqzK9ef+A4Af6ieqU
	bC+HIE27YvgIr/hrrkk/ZFJqWoW7+39u5HazBYUdc4Rshz2jzXvNEH3j6UcD0qjB
	VOqtkxVI8ROqGxznfhElPhclp3XVmJO47R5V+IEWr95qY3DG0+aTPyY/+kboXy0d
	GOcpu7y+cZAL8kntTGYBastmCXi2CRZAbx0AWcJjTQMxv+Kq+tiAogM7HorXBFzw
	kSs/yBnnn4GHRCr3BC3n8k8ZXmYDx7ciS6CoorHB/3qnPsoN24oFZOZouwUc9etQ
	7sYMobvHjbdmqLm74zjsOQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u81td6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:08:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5239BtXF003191;
	Mon, 3 Mar 2025 11:08:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rp7bfu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:08:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8/TDWLAUpXObuJbIomwZTr8M/QlOEsdFiN2KOzcUU5EMru5aeKSRqJgzzDNCdM4fb5NWfKjVJEqM9jzxNbznO5vxUrM9SyZPqgUNg841353ETYiyHx9SQYbC3wRnPPdL0v7HjSVEqz5Lzcx5btjSOeHGeWvOSle6R2DpJ5Im01/O1o2Gp38vgAuuRrXaHkwC+9F0A7F8TwPDbHk40xzZq7Q/u3nqc06c8VL3qiY2rEKqY4IkOzU9tClkm/B21rf4KR6UsWG5td73vcMoTmmh+MlYHR1oIBBWvTIzfK+vJULkEj79Rn5NW+nTteZNQzjnLdsbaaBxCPVf/5MNdiAiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EG6ccytL3mfjzNgokq+UADo2jHVfKtGFrTk6AYgEH9g=;
 b=NdIUgNIM5pVE5M4sKFn7FiSaRv+PXkvQRbNdJNOXwuCVJKOAWhk/wFHoLka2EVUzV69wTk/PYh/rwJ1Cs/H+a84IfUeNQgE151Bqmuvj2x47KHWC349m47TKDjBy2+OLIGPI5J7/TkUoDmQHGRlfS46JktGpdGrzctRayiTBZelljy5ucMEyDKHS2f/5EsFXck7gVJGtpXoVJLZE63kxW0peEQWE5hCtmdkzxn/hI85U7yM3Qn1Ml3ZYEGAr8gJ7qSllso9aGP7syWRpzHCwqV1IF3PAyNNvDZ7Q8WY7ICWRfmtlJKk/9OCVt9fFosP95Reels+U23V4z39POxwMiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EG6ccytL3mfjzNgokq+UADo2jHVfKtGFrTk6AYgEH9g=;
 b=hd3tqxVFFEASBNbd4Wja16vxpvLq9DbGhZwq8l+1emVcj+bEp9UQalmpkMi1bSnzrh6YIIr8u/nkP0NFwjSdzG09Hxfu7vzgzgYurOjNFoRGJi8NZpWAnJIE97R90Ii9zt7oOxTOKxAROyq2e4faf0j3+3QSLpPxkf8akBCIvMU=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DM4PR10MB7427.namprd10.prod.outlook.com (2603:10b6:8:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 11:08:51 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 11:08:51 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] mm/mremap: refactor mremap() system call implementation
Date: Mon,  3 Mar 2025 11:08:32 +0000
Message-ID: <e6b80d8f58dd2c6a30643d70405dec3e9a385f7f.1740911247.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
References: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0551.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::19) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DM4PR10MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: ff282744-f419-43c6-891b-08dd5a43c7aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WIXO6e3X2He+/4AkPN9tSjEQl0ijdbaHgCgp7xj8VZIAqcXCUaivJaXFaDYu?=
 =?us-ascii?Q?IrqLIkGm5ffERS//kxzcilUCfqRisEF0o9+QpxSOgUm9K3aOrzKXearGRu8F?=
 =?us-ascii?Q?L8A7xt8CQiqr/yKJIgHXRHosjmg/QRb2wl7Io6viG99SCiGzM4OP1eUQM8Tv?=
 =?us-ascii?Q?EL5MRdHNYWd9YEGtsosmQZ9sAmVlerZm+9TlBhufRoY0H4uuxiSauc6qU7MD?=
 =?us-ascii?Q?e9wH5p8OMf5BEBmxO8yFj2Rvd0N4e8gPxYg5qTkrdieFjrwAKEuvhxztLREw?=
 =?us-ascii?Q?OdHt4CNz2j/nEWiFtzgiavPdf17g51Zh6/cIFi15TiXRhZJ0Nu4KpbQwCWVh?=
 =?us-ascii?Q?dsgRLi7T8jaBH3uycocQxniWPbInorNLMokfqE3OcolklbPG9UIoe2er5FOn?=
 =?us-ascii?Q?6mnTcG5vYOrlrV7zutKYo21YncBp2hPqbQhKgMz9NaP6KSig1HUkn3ULc8Y7?=
 =?us-ascii?Q?qaNDzW9dF+XeNCExp+QF9uoLQynXeuLnEXv9XbX943OO+spz2q3vVjGZyIga?=
 =?us-ascii?Q?q5pn5Nz2yFRpM2nHFpIbahbBfk4gnamLbSQ7S+I3kGbfHOfGXXr97fE3VBh3?=
 =?us-ascii?Q?MLmFxqXSm39317/ggzjA1jdm64a5DwYJF2FOko03fha5RG6jpSdsmZlRAM0h?=
 =?us-ascii?Q?sUVPlaKSVXxh9ceahwTj/CiyYY3s44kXD6BadGEOPemSih9+mC7+wedarVSt?=
 =?us-ascii?Q?d1CG6un3g/u742JbqPE6MV7U/fr0WwK7ugoL5QBTDTjALVdEidcAqwEKAODn?=
 =?us-ascii?Q?cqUYIvk8A6Gif3Te1Fbd2DuZzZDZjysq5957ZHaNipVXMBVg4/i3JGdlzngW?=
 =?us-ascii?Q?TulCDU1Rvmt68AtiF0Etj9UAgkR3jjY2OytmXDNW0UjGGAECcuIc+ocpOB+7?=
 =?us-ascii?Q?hReOMDu9lT4P8tC2bsbbAWUyVfeSuJE4SusfMCd+XVzBUSsxwL3Y+OdWjXM8?=
 =?us-ascii?Q?hdrpqJRHPO58Waq7UtQ7q+Nno6k95nj59ADtkfhIdtXxMsW6EWn6+qlJ6SYa?=
 =?us-ascii?Q?p/9nK0+b2+UIj900HRhhRmWaioIzd78PG/0BNW/3EJbIQzPG45mAtG15SbLg?=
 =?us-ascii?Q?agL2QK3cOatcDYb0fwI17EtMAJv6/+YnPkXr+LM9YQzv/byGugzEeUAqtu/D?=
 =?us-ascii?Q?+KfIZTnbgBcmfNdtjTlx0OQNWcoiQC2h3Mqrjw9BATexBh0JI7AXA/wALuj+?=
 =?us-ascii?Q?oKftFiCRur/mMCVQf/LOwIONg+lbVpJINDWkfwBnVwFNMpM1jd40C7vWRMX8?=
 =?us-ascii?Q?jFsKhusLLMAUo3JN/BrUqV+4/UZIg022jXLQBxygl/yIko3vccROmUwdurwx?=
 =?us-ascii?Q?B08PX4YalJ8adS4+9qgNds3Ll4ujjUSlkWQxIJs2AtGMW5mqLTKLPH/qSTHA?=
 =?us-ascii?Q?6I1e0YQtu55sNVqWG25Y4/dfRpRU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gx03TW6POIE2JbRh+15cySVlHhqcTtOamVXPyNwFBEzCcC2BEoeYKGx7QGAZ?=
 =?us-ascii?Q?idnatlc4xEbxVoHnXy12u5MpYPPmfMJeykd+CrPj0qk8YR9zjo1woj65586V?=
 =?us-ascii?Q?hRMUUeRLGHWNfyf/oOn6aVaHvuYg+4QpF8pYJj6bL2Yb7UnlXWRdRK9wpCdV?=
 =?us-ascii?Q?iaax8iSVAj/0I+BITNJwIReKBz9kj87tILpOwD9hhXOpm0v8+yDLJSSk1qJu?=
 =?us-ascii?Q?u7kMD63RcFbzm63BblPBTBcs39rp/LFv0gEwKFAxefoS7R6MYjz95ItuBYmH?=
 =?us-ascii?Q?siInUigXxS3UQO1BS/Vf3XjvKqTLyPblSyCsqhBXcr8gMsre5pdrjcH1PTFb?=
 =?us-ascii?Q?ipem9NyKt2p+RJ4LZ1Ydrya4gQRZhJ44zzsEYPzGZnqNAihqKxOAEEnR/AQh?=
 =?us-ascii?Q?O4GPzSVuTTy9HQyt9xhO43875gmDlbscykDddtQ7JCkcF8usdPX/8g+Er/Xr?=
 =?us-ascii?Q?C+IPKQUpxNiJPdmXw4MMc8Pcs+6MElDx8T0H9uYgqiGFZTdiljUUBdJ864OJ?=
 =?us-ascii?Q?3wnFBfDFy+8hDp29ZkvNi3Luq1synhdiKkfRKMh66ys9k3qZyTLoHfXa7rMN?=
 =?us-ascii?Q?db69CT/Zh+Q87PXsvf5i8yv/Nx5guCiXGBh7Rb34DJW6zzeX9J525wQ86zrR?=
 =?us-ascii?Q?N1CrguaVWb5nP3GoIAdnPoJCQgZl0IqWTaDPiGwH0tptrKzqvkUvD/7VALzQ?=
 =?us-ascii?Q?1yNiqkzjKZaKi4Tjm4RiD+a3wSUy3OzY4komBC3WOKv/aHqTvMlJ1Ybmkqcg?=
 =?us-ascii?Q?Ts7SUk2c/k5B7kbSZicUF2GzdsTU3dCMljp2tXEF0mH2tP85QCpVz0ZbksT7?=
 =?us-ascii?Q?niR7GZrtz5UEgY3UQDZ0/oMeHIl56r+fp4dJ8AtvsN3A2zlZrI2re3HZFBfB?=
 =?us-ascii?Q?/684a9FnX6H7LKwEZ1z2f0Hpzmwq3XewMPwWVuy3WdBOQ56lxf+dy6A4LLxC?=
 =?us-ascii?Q?Ej+U3eLRdcSF6NdigzEClY2cmTqfQKvZMD8+fKJZR6TKhoAzyNX09tL+yTfR?=
 =?us-ascii?Q?jbNrX8WBtbGvFHpgg4+cmCPj1uWbxO+SRW5mITzakjf8JVwwaBvqErupJNkr?=
 =?us-ascii?Q?FES9+I6BSJwYGovDPlUWyCc1/XFFGCV9YOxt91iBppLUbRvEoJWxFgdvebtX?=
 =?us-ascii?Q?tWGAaFj0IP2/Skti619kroDiOqEA3qdrfqOZq/fwcpsl6CxLOzBDhqbIWG1b?=
 =?us-ascii?Q?b+bKD0ybLtNPoZoel1qqYXmB2Sl+iLN3TgsSInnjOLmeEp87+bttGEcdztfs?=
 =?us-ascii?Q?568XbOulTXeqO7eeGqw5drnbzK8MHhkHd1ziEvh3ugHDTYhle00n4UDVfk2Q?=
 =?us-ascii?Q?n41Rh4bnvNl4C9UqL6L1rd02/ApXHkWLDNOpmdTTSSoTTtlW06YTMcUfUOAQ?=
 =?us-ascii?Q?eXhnrdrumiGcexMfIAw9nysd+LL2ji/SksP9yoq70XBN9wKHev1ob/ytVlV2?=
 =?us-ascii?Q?rHGUWUDH4H6bEJ3+KDy7MvpGlHyzEI7rzoatwJocL68dgqOXcWdHsA0DJmUM?=
 =?us-ascii?Q?pwrcYsXkwvo9ZlcC/LgGUWhW8O8wEmQ6aftRCGXBDiW0DjJbNFaVgZP546NI?=
 =?us-ascii?Q?BRnRge0RRe0fnow8PyTceRt0/WVMMqwMxE5G6ALOUggjULtaB8kB9WTvywA3?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Hd0rlIFj19XkcNMskQTuM4YU4MjSn1N77tIL1OjhAfzNnVMq+m07WAW74u9R/R29RZiOmRQWRMIR/60MP5NnFzdJwHj1Gvw+x7gvCIA8fhZhhtfRDgD/J6x2kffl2ygUhncYDfkBrN0jcJSHbObEYc5ag6/0gD7RM6yI3kkBQqNYe/0tlo2JjqgokXO0vMC2hw2Ghe8j5uaGxGzM8u8oeW7e4u1wBigK/5x3XcdYc5WPaowZbyeL36qiyp83XIOupxiRT5+vs1YekxAHWrn7N2VUjzJD5epa4KG3zPH3vmR3JGVlAADdkBH2W08e+cl7rrPQLclzps8W2QCmbJAnlaqz4P8pBlkW/eFJtswMFf1TjnYT1+r0FIOApnI4E7rGcZSw4FytThcIYDk+v+xXUlzDajOxlt6RnoD+awazqeB/HxOkwmQE1bMXOM8KFCY2y+wiuKQgiHc0KJCWdVGx2+ntF24mAynQfY2fIXjJwXYIDImI0dyxSBOCmxI8oPzRXYu1VLpPfZ8NyeaGoUVdyzBxJY/usPtjniWYIeSQmxMgxKDPkIAQrju3UNp7tmDlZYtOba5ggi4/TuKNm18LICWJdIstuTluh/StKatSedY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff282744-f419-43c6-891b-08dd5a43c7aa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 11:08:51.7221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZQlKPkWVUAHeiSzkWj5hyA9n70WKdfNzvD1kSU7/6/xORsGxGeCYdpyNczoCswLB3O365MptcuArM5a011knGeMYcqm4W9r2phpn5gjgXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_04,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030086
X-Proofpoint-GUID: UagsyvwALR2wRk6j_MnYUKv5kI5MAWpa
X-Proofpoint-ORIG-GUID: UagsyvwALR2wRk6j_MnYUKv5kI5MAWpa

Place checks into a separate function so the mremap() system call is less
egregiously long, remove unnecessary mremap_to() offset_in_page() check and
just check that earlier so we keep all such basic checks together.

Separate out the VMA in-place expansion, hugetlb and expand/move logic into
separate, readable functions.

De-duplicate code where possible, add comments and ensure that all error
handling explicitly specifies the error at the point of it occurring rather
than setting a prefixed error value and implicitly setting (which is bug
prone).

This lays the groundwork for subsequent patches further simplifying and
extending the mremap() implementation.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mremap.c | 405 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 251 insertions(+), 154 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index c3e4c86d0b8d..c4abda8dfc57 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -942,33 +942,14 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 	unsigned long ret;
 	unsigned long map_flags = 0;
 
-	if (offset_in_page(new_addr))
-		return -EINVAL;
-
+	/* Is the new length or address silly? */
 	if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
 		return -EINVAL;
 
-	/* Ensure the old/new locations do not overlap */
+	/* Ensure the old/new locations do not overlap. */
 	if (addr + old_len > new_addr && new_addr + new_len > addr)
 		return -EINVAL;
 
-	/*
-	 * move_vma() need us to stay 4 maps below the threshold, otherwise
-	 * it will bail out at the very beginning.
-	 * That is a problem if we have already unmaped the regions here
-	 * (new_addr, and old_addr), because userspace will not know the
-	 * state of the vma's after it gets -ENOMEM.
-	 * So, to avoid such scenario we can pre-compute if the whole
-	 * operation has high chances to success map-wise.
-	 * Worst-scenario case is when both vma's (new_addr and old_addr) get
-	 * split in 3 before unmapping it.
-	 * That means 2 more maps (1 for each) to the ones we already hold.
-	 * Check whether current map count plus 2 still leads us to 4 maps below
-	 * the threshold, otherwise return -ENOMEM here to be more safe.
-	 */
-	if ((mm->map_count + 2) >= sysctl_max_map_count - 3)
-		return -ENOMEM;
-
 	if (flags & MREMAP_FIXED) {
 		/*
 		 * In mremap_to().
@@ -1035,6 +1016,218 @@ static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
 	return 1;
 }
 
+/* Do the mremap() flags require that the new_addr parameter be specified? */
+static bool implies_new_addr(unsigned long flags)
+{
+	return flags & (MREMAP_FIXED | MREMAP_DONTUNMAP);
+}
+
+/*
+ * Are the parameters passed to mremap() valid? If so return 0, otherwise return
+ * error.
+ */
+static unsigned long check_mremap_params(unsigned long addr,
+					 unsigned long flags,
+					 unsigned long old_len,
+					 unsigned long new_len,
+					 unsigned long new_addr)
+{
+	/* Ensure no unexpected flag values. */
+	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
+		return -EINVAL;
+
+	/* Start address must be page-aligned. */
+	if (offset_in_page(addr))
+		return -EINVAL;
+
+	/*
+	 * We allow a zero old-len as a special case
+	 * for DOS-emu "duplicate shm area" thing. But
+	 * a zero new-len is nonsensical.
+	 */
+	if (!PAGE_ALIGN(new_len))
+		return -EINVAL;
+
+	/* Remainder of checks are for cases with specific new_addr. */
+	if (!implies_new_addr(flags))
+		return 0;
+
+	/* The new address must be page-aligned. */
+	if (offset_in_page(new_addr))
+		return -EINVAL;
+
+	/* A fixed address implies a move. */
+	if (!(flags & MREMAP_MAYMOVE))
+		return -EINVAL;
+
+	/* MREMAP_DONTUNMAP does not allow resizing in the process. */
+	if (flags & MREMAP_DONTUNMAP && old_len != new_len)
+		return -EINVAL;
+
+	/*
+	 * move_vma() need us to stay 4 maps below the threshold, otherwise
+	 * it will bail out at the very beginning.
+	 * That is a problem if we have already unmaped the regions here
+	 * (new_addr, and old_addr), because userspace will not know the
+	 * state of the vma's after it gets -ENOMEM.
+	 * So, to avoid such scenario we can pre-compute if the whole
+	 * operation has high chances to success map-wise.
+	 * Worst-scenario case is when both vma's (new_addr and old_addr) get
+	 * split in 3 before unmapping it.
+	 * That means 2 more maps (1 for each) to the ones we already hold.
+	 * Check whether current map count plus 2 still leads us to 4 maps below
+	 * the threshold, otherwise return -ENOMEM here to be more safe.
+	 */
+	if ((current->mm->map_count + 2) >= sysctl_max_map_count - 3)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/*
+ * We know we can expand the VMA in-place by delta pages, so do so.
+ *
+ * If we discover the VMA is locked, update mm_struct statistics accordingly and
+ * indicate so to the caller.
+ */
+static unsigned long expand_vma_inplace(struct vm_area_struct *vma,
+					unsigned long delta, bool *locked)
+{
+	struct mm_struct *mm = current->mm;
+	long pages = delta >> PAGE_SHIFT;
+	VMA_ITERATOR(vmi, mm, vma->vm_end);
+	long charged = 0;
+
+	if (vma->vm_flags & VM_ACCOUNT) {
+		if (security_vm_enough_memory_mm(mm, pages))
+			return -ENOMEM;
+
+		charged = pages;
+	}
+
+	/*
+	 * Function vma_merge_extend() is called on the
+	 * extension we are adding to the already existing vma,
+	 * vma_merge_extend() will merge this extension with the
+	 * already existing vma (expand operation itself) and
+	 * possibly also with the next vma if it becomes
+	 * adjacent to the expanded vma and otherwise
+	 * compatible.
+	 */
+	vma = vma_merge_extend(&vmi, vma, delta);
+	if (!vma) {
+		vm_unacct_memory(charged);
+		return -ENOMEM;
+	}
+
+	vm_stat_account(mm, vma->vm_flags, pages);
+	if (vma->vm_flags & VM_LOCKED) {
+		mm->locked_vm += pages;
+		*locked = true;
+	}
+
+	return 0;
+}
+
+static bool align_hugetlb(struct vm_area_struct *vma,
+			  unsigned long addr,
+			  unsigned long new_addr,
+			  unsigned long *old_len_ptr,
+			  unsigned long *new_len_ptr,
+			  unsigned long *delta_ptr)
+{
+	unsigned long old_len = *old_len_ptr;
+	unsigned long new_len = *new_len_ptr;
+	struct hstate *h __maybe_unused = hstate_vma(vma);
+
+	old_len = ALIGN(old_len, huge_page_size(h));
+	new_len = ALIGN(new_len, huge_page_size(h));
+
+	/* addrs must be huge page aligned */
+	if (addr & ~huge_page_mask(h))
+		return false;
+	if (new_addr & ~huge_page_mask(h))
+		return false;
+
+	/*
+	 * Don't allow remap expansion, because the underlying hugetlb
+	 * reservation is not yet capable to handle split reservation.
+	 */
+	if (new_len > old_len)
+		return false;
+
+	*old_len_ptr = old_len;
+	*new_len_ptr = new_len;
+	*delta_ptr = abs_diff(old_len, new_len);
+	return true;
+}
+
+/*
+ * We are mremap()'ing without specifying a fixed address to move to, but are
+ * requesting that the VMA's size be increased.
+ *
+ * Try to do so in-place, if this fails, then move the VMA to a new location to
+ * action the change.
+ */
+static unsigned long expand_vma(struct vm_area_struct *vma,
+				unsigned long addr, unsigned long old_len,
+				unsigned long new_len, unsigned long flags,
+				bool *locked_ptr, unsigned long *new_addr_ptr,
+				struct vm_userfaultfd_ctx *uf_ptr,
+				struct list_head *uf_unmap_ptr)
+{
+	unsigned long err;
+	unsigned long map_flags;
+	unsigned long new_addr; /* We ignore any user-supplied one. */
+	pgoff_t pgoff;
+
+	err = resize_is_valid(vma, addr, old_len, new_len, flags);
+	if (err)
+		return err;
+
+	/*
+	 * [addr, old_len) spans precisely to the end of the VMA, so try to
+	 * expand it in-place.
+	 */
+	if (old_len == vma->vm_end - addr &&
+	    vma_expandable(vma, new_len - old_len)) {
+		err = expand_vma_inplace(vma, new_len - old_len, locked_ptr);
+		if (IS_ERR_VALUE(err))
+			return err;
+
+		/*
+		 * We want to populate the newly expanded portion of the VMA to
+		 * satisfy the expectation that mlock()'ing a VMA maintains all
+		 * of its pages in memory.
+		 */
+		if (*locked_ptr)
+			*new_addr_ptr = addr;
+
+		/* OK we're done! */
+		return addr;
+	}
+
+	/*
+	 * We weren't able to just expand or shrink the area,
+	 * we need to create a new one and move it.
+	 */
+
+	/* We're not allowed to move the VMA, so error out. */
+	if (!(flags & MREMAP_MAYMOVE))
+		return -ENOMEM;
+
+	/* Find a new location to move the VMA to. */
+	map_flags = (vma->vm_flags & VM_MAYSHARE) ? MAP_SHARED : 0;
+	pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
+	new_addr = get_unmapped_area(vma->vm_file, 0, new_len, pgoff, map_flags);
+	if (IS_ERR_VALUE(new_addr))
+		return new_addr;
+	*new_addr_ptr = new_addr;
+
+	return move_vma(vma, addr, old_len, new_len, new_addr,
+			locked_ptr, flags, uf_ptr, uf_unmap_ptr);
+}
+
 /*
  * Expand (or shrink) an existing mapping, potentially moving it at the
  * same time (controlled by the MREMAP_MAYMOVE flag and available VM space)
@@ -1048,7 +1241,8 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	unsigned long ret = -EINVAL;
+	unsigned long ret;
+	unsigned long delta;
 	bool locked = false;
 	struct vm_userfaultfd_ctx uf = NULL_VM_UFFD_CTX;
 	LIST_HEAD(uf_unmap_early);
@@ -1067,70 +1261,38 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	 */
 	addr = untagged_addr(addr);
 
-	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
-		return ret;
-
-	if (flags & MREMAP_FIXED && !(flags & MREMAP_MAYMOVE))
-		return ret;
-
-	/*
-	 * MREMAP_DONTUNMAP is always a move and it does not allow resizing
-	 * in the process.
-	 */
-	if (flags & MREMAP_DONTUNMAP &&
-			(!(flags & MREMAP_MAYMOVE) || old_len != new_len))
-		return ret;
-
-
-	if (offset_in_page(addr))
+	ret = check_mremap_params(addr, flags, old_len, new_len, new_addr);
+	if (ret)
 		return ret;
 
 	old_len = PAGE_ALIGN(old_len);
 	new_len = PAGE_ALIGN(new_len);
+	delta = abs_diff(old_len, new_len);
 
-	/*
-	 * We allow a zero old-len as a special case
-	 * for DOS-emu "duplicate shm area" thing. But
-	 * a zero new-len is nonsensical.
-	 */
-	if (!new_len)
-		return ret;
-
-	if (mmap_write_lock_killable(current->mm))
+	if (mmap_write_lock_killable(mm))
 		return -EINTR;
+
 	vma = vma_lookup(mm, addr);
 	if (!vma) {
 		ret = -EFAULT;
 		goto out;
 	}
 
-	/* Don't allow remapping vmas when they have already been sealed */
+	/* If mseal()'d, mremap() is prohibited. */
 	if (!can_modify_vma(vma)) {
 		ret = -EPERM;
 		goto out;
 	}
 
-	if (is_vm_hugetlb_page(vma)) {
-		struct hstate *h __maybe_unused = hstate_vma(vma);
-
-		old_len = ALIGN(old_len, huge_page_size(h));
-		new_len = ALIGN(new_len, huge_page_size(h));
-
-		/* addrs must be huge page aligned */
-		if (addr & ~huge_page_mask(h))
-			goto out;
-		if (new_addr & ~huge_page_mask(h))
-			goto out;
-
-		/*
-		 * Don't allow remap expansion, because the underlying hugetlb
-		 * reservation is not yet capable to handle split reservation.
-		 */
-		if (new_len > old_len)
-			goto out;
+	/* Align to hugetlb page size, if required. */
+	if (is_vm_hugetlb_page(vma) &&
+	    !align_hugetlb(vma, addr, new_addr, &old_len, &new_len, &delta)) {
+		ret = -EINVAL;
+		goto out;
 	}
 
-	if (flags & (MREMAP_FIXED | MREMAP_DONTUNMAP)) {
+	/* Are we RELOCATING the VMA to a SPECIFIC address? */
+	if (implies_new_addr(flags)) {
 		ret = mremap_to(addr, old_len, new_addr, new_len,
 				&locked, flags, &uf, &uf_unmap_early,
 				&uf_unmap);
@@ -1138,109 +1300,44 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	}
 
 	/*
-	 * Always allow a shrinking remap: that just unmaps
-	 * the unnecessary pages..
-	 * do_vmi_munmap does all the needed commit accounting, and
-	 * unlocks the mmap_lock if so directed.
+	 * From here on in we are only RESIZING the VMA, attempting to do so
+	 * in-place, moving the VMA if we cannot.
 	 */
-	if (old_len >= new_len) {
-		VMA_ITERATOR(vmi, mm, addr + new_len);
 
-		if (old_len == new_len) {
-			ret = addr;
-			goto out;
-		}
+	/* NO-OP CASE - resizing to the same size. */
+	if (new_len == old_len) {
+		ret = addr;
+		goto out;
+	}
+
+	/* SHRINK CASE. Can always be done in-place. */
+	if (new_len < old_len) {
+		VMA_ITERATOR(vmi, mm, addr + new_len);
 
-		ret = do_vmi_munmap(&vmi, mm, addr + new_len, old_len - new_len,
+		/*
+		 * Simply unmap the shrunken portion of the VMA. This does all
+		 * the needed commit accounting, unlocking the mmap lock.
+		 */
+		ret = do_vmi_munmap(&vmi, mm, addr + new_len, delta,
 				    &uf_unmap, true);
 		if (ret)
 			goto out;
 
+		/* We succeeded, mmap lock released for us. */
 		ret = addr;
 		goto out_unlocked;
 	}
 
-	/*
-	 * Ok, we need to grow..
-	 */
-	ret = resize_is_valid(vma, addr, old_len, new_len, flags);
-	if (ret)
-		goto out;
-
-	/* old_len exactly to the end of the area..
-	 */
-	if (old_len == vma->vm_end - addr) {
-		unsigned long delta = new_len - old_len;
-
-		/* can we just expand the current mapping? */
-		if (vma_expandable(vma, delta)) {
-			long pages = delta >> PAGE_SHIFT;
-			VMA_ITERATOR(vmi, mm, vma->vm_end);
-			long charged = 0;
-
-			if (vma->vm_flags & VM_ACCOUNT) {
-				if (security_vm_enough_memory_mm(mm, pages)) {
-					ret = -ENOMEM;
-					goto out;
-				}
-				charged = pages;
-			}
-
-			/*
-			 * Function vma_merge_extend() is called on the
-			 * extension we are adding to the already existing vma,
-			 * vma_merge_extend() will merge this extension with the
-			 * already existing vma (expand operation itself) and
-			 * possibly also with the next vma if it becomes
-			 * adjacent to the expanded vma and otherwise
-			 * compatible.
-			 */
-			vma = vma_merge_extend(&vmi, vma, delta);
-			if (!vma) {
-				vm_unacct_memory(charged);
-				ret = -ENOMEM;
-				goto out;
-			}
+	/* EXPAND case. We try to do in-place, if we can't, then we move it. */
+	ret = expand_vma(vma, addr, old_len, new_len, flags, &locked, &new_addr,
+			 &uf, &uf_unmap);
 
-			vm_stat_account(mm, vma->vm_flags, pages);
-			if (vma->vm_flags & VM_LOCKED) {
-				mm->locked_vm += pages;
-				locked = true;
-				new_addr = addr;
-			}
-			ret = addr;
-			goto out;
-		}
-	}
-
-	/*
-	 * We weren't able to just expand or shrink the area,
-	 * we need to create a new one and move it..
-	 */
-	ret = -ENOMEM;
-	if (flags & MREMAP_MAYMOVE) {
-		unsigned long map_flags = 0;
-		if (vma->vm_flags & VM_MAYSHARE)
-			map_flags |= MAP_SHARED;
-
-		new_addr = get_unmapped_area(vma->vm_file, 0, new_len,
-					vma->vm_pgoff +
-					((addr - vma->vm_start) >> PAGE_SHIFT),
-					map_flags);
-		if (IS_ERR_VALUE(new_addr)) {
-			ret = new_addr;
-			goto out;
-		}
-
-		ret = move_vma(vma, addr, old_len, new_len, new_addr,
-			       &locked, flags, &uf, &uf_unmap);
-	}
 out:
 	if (offset_in_page(ret))
 		locked = false;
-	mmap_write_unlock(current->mm);
+	mmap_write_unlock(mm);
 	if (locked && new_len > old_len)
-		mm_populate(new_addr + old_len, new_len - old_len);
+		mm_populate(new_addr + old_len, delta);
 out_unlocked:
 	userfaultfd_unmap_complete(mm, &uf_unmap_early);
 	mremap_userfaultfd_complete(&uf, addr, ret, old_len);
-- 
2.48.1


