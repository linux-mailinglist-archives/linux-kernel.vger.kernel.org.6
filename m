Return-Path: <linux-kernel+bounces-541520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9097A4BDD1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA31F16060A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7183D1F9EC0;
	Mon,  3 Mar 2025 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KDsAbmIB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m1r0WASy"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000F21F5839
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000151; cv=fail; b=T6sVGBbWJdn4wumXgOZkEErufIiF9aujQgkMkc81F2nNzzsm39JstsnjFvmy34K6sg00eq33BJxKuennJXgskB4483AMkuNGE6ynA1IPerlu1ihlAj5v9KZbLmf7ofMFeGvB/M5Sqxu0Ib8yJPFATTU5WDQZu3A+X/q1kQExJco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000151; c=relaxed/simple;
	bh=0y6upwm9pfzpuKHLGHGb6d8A4+6Y5+hjtoaOqbPVIQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b6dDimNe4tksRo9w2SlZUp/MrnwmYvPu3JiOwUlyoLhPkacyh4VVY800IGNIyB1AplAaEPGp7v0zcXf3aE9DSKY8R6TvOQgovRu4ns5yCENRN7HrP6uUQgn/JAcwpP7U6AqgP17I6JyBRacmQ2pLDN4gSZKwsLOBV5Y2CKIieCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KDsAbmIB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m1r0WASy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237tkGK015585;
	Mon, 3 Mar 2025 11:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HXsGRQzNKMXt42MCoue5RtWOd2wLzstBfkrX8aat4C8=; b=
	KDsAbmIBLuTL+6tjZl/+Edt3Zg9Zd96KSfnmmdp4y0PLTvwYF4uU86uJViRpKcrp
	x1/pTWGUSEQtXTFvDQy5NjqKVf61N9HU3uqDhUrPSAMaPB+By02Yn63b3W49Fe0z
	qK8VM15mzNG3kEeceb96i7HOq7aWiCTGTAHuPHq59KutYTZ3F+wVa5menh2Dr+Vm
	uoBr1sCiu4p0ceyl9FYapKa0q1S803pUydFL72JYWywWTceWUOxA/r+t4ko9VkFZ
	nJvMbLhWw/K9lOnF9cEE6m1kQXjSuBBd2e4Wi8he+JixobTAIyyomiRnRpMgri5x
	UQVyi47OmCKlaiL1Ariu1Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453uavtcb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:08:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5239CfQL003167;
	Mon, 3 Mar 2025 11:08:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rp7bfvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:08:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkzCAzGFTd1YVGSUIK0LVRrPn67nR/zPkH+JY6mTI4XNNeSEnQiHl4grc/XqtKKDvvrfJ9/J0WRf6x/Sz0KCPeqnmoHZpiK36eMtYpR0GnSj/ctKCpG4aHqORW0soc5gwCWjy0G0kblfpbZSW/bhN4z5Immv83eO1JwauKbYFJepoE3vyVOKZOkMCdr8dji9mUbAhFtLhXxxtrgfQ7N7mhzFZFzlQQajL5eyjcBn33ukBxEFcJhrVSoxycf2o//YzNoM3xw49dNhxWy7y3gdd8Z+CSPZ2V3C7KeIhKDIrAlUr8rdjAvwxeLq8Em8QecBbBmwdOvQWLsNYxoVvsmPnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXsGRQzNKMXt42MCoue5RtWOd2wLzstBfkrX8aat4C8=;
 b=GT/7g8GgmN/eIQatlej1y61LaQo/Cd/qGn+5L5xkLk7sC64R6ywDgnfl+A2hgGBTCV/fHiuCWHoh5YH63HXvp28z32JuAAKy6gl7A11FZkcOqKpyNw5JOEhMNvKfd9HBzbdrAD1CrJ/jlQxJM9PWuOKx90fjsa1jmzrHne5i1EXI6mTRK5q2IGZhiogPQe8DHcxXjoFdUCTtQT39Ogm6L3k9xV7d2SMJp3qSasGkZW67dfKS4ImYLC/pXI3sCKgDaAyeqoYgeuamyhiDp1bNlxx0/ygoPGA4qxSWhqYYiB9qetV6G9nBDNSJnEZjb0N7KcmZJUDxsZADklbdsjsEDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXsGRQzNKMXt42MCoue5RtWOd2wLzstBfkrX8aat4C8=;
 b=m1r0WASybgksnz3z7CO/xbFnoHPlLHWFAYqPhdmsqGuJjxQbYTaCih5B1Y8+g0XL1SPiM90bC0uY1FZWT8L5Ofo5XXdNs8y8XpcdlvOS/2q8aKWoOP202cKnu77bo/jDWGutcvrXrRhPPOfsnIx58ciWvt+P627eRk6xQq3myLE=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DM4PR10MB7427.namprd10.prod.outlook.com (2603:10b6:8:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 11:08:56 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 11:08:55 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] mm/mremap: initial refactor of move_vma()
Date: Mon,  3 Mar 2025 11:08:34 +0000
Message-ID: <b4e64684d6ac753d5a66c0da0da5f4b94d033859.1740911247.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
References: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0417.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::8) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DM4PR10MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: d3297e34-240c-486e-0299-08dd5a43ca25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7be0SF1DzoNvkDjcWMrrR3BFZ+KX04cfXS/Rvug52alFfw7hm8LGbF70c6im?=
 =?us-ascii?Q?9MTyvMzEpROQgRwJ3aBInw+pN2NhZNbGCWm/pMOFY+6L4PVHffFjmIeLAcxK?=
 =?us-ascii?Q?fk1+UsDzqiSw4aSRuFY6OJ8Ikgtt4QoMhcf3QaGRb3LDMradjHc2CD3lbl/k?=
 =?us-ascii?Q?2iXJmih1ovUDleV51UPyCPj0GF9tKEGwUda0H1OdNfeO7o0gSo7gXj6/eu09?=
 =?us-ascii?Q?RO/2m1UKIVNNZtiOoy6sQvajogACdW6m2/wsQzlmxgOOW+Glac+Ho5Gcx2tp?=
 =?us-ascii?Q?VB9FogOg8BWR5e0U4QWmkPj6CHe9z74BFHa3EzhmxnCHXElTXl2EuVH2Chm6?=
 =?us-ascii?Q?AxeWLrNs6zBMdWwFXNWQQ50B0Mj8fel5GIryJUyJK7jiF4briH6l0ZtcBgXE?=
 =?us-ascii?Q?qQAN7JFDVr2t0IMSVD/rcRvNRby3Vvm5Ry2mv2oRJRnFbPQeBueP+MnAZQzu?=
 =?us-ascii?Q?rOzqoiWzPg7OgUGWGeH6cmuqwYbIjkunlVLEKBtuHou7nkwA32ELgG+vycGa?=
 =?us-ascii?Q?nItjZ5a4OmZsMEuD0vIRx4ReyHSQ1jtnqHkmgnfEJTk8hA2FQ41d6JvzT0xl?=
 =?us-ascii?Q?mWgRWr/h7ctoIzw9gH4yRoKP6CUq1dOM3cbDYiCz79RPQj6fzpiRjwHm/uOg?=
 =?us-ascii?Q?OpoSs2e3hXMiGENZ+x+THpmpkSTdUZJrj43EpBnUC4Ruo0Gqvz03CVFJPP2X?=
 =?us-ascii?Q?XFbIB+qLXYJ9tL8EQy9FVwt6wFefIVYSofL037FR0wGMhnIERFiSRtvt4/Ix?=
 =?us-ascii?Q?ucSD1Anfrqd+3JHsOriuostVtUAKRkigZiNgZ4bBUbmtzQcYkAe4w9V81ind?=
 =?us-ascii?Q?Nn5veLbcofxfNrkc7/dBrgIWU2lNgW0AdsEHgkqaYTvmUuOqYrsKYL680oVv?=
 =?us-ascii?Q?N+WGbqoGqUZk5wTfH9zfU61HMveNIz/FH5G2IhSltoyy+0MTifFdi7+3e8q3?=
 =?us-ascii?Q?+CMCDhYCciZdUVZjIkrqzVhiXY1wZ1038EFBe4N5jBxGQUpbFGSray/QLpqR?=
 =?us-ascii?Q?ZxrZ3PSY+XI0SZmCKh9u1uxVr6NsjsuUbS9GyxptjZE7WwuUQiItbP2PKw+h?=
 =?us-ascii?Q?KhphXAS943h2g3Yz8AiCSy0GuXtEY5LIqzyIfd8TIHRu2V0AmM7WQvuXd3NQ?=
 =?us-ascii?Q?0DlAE3ENtKaVqBQVNK9Xo4VSeyQYbNtl+mtRQV+wFt6w0Do8NRLn8gFfB8y8?=
 =?us-ascii?Q?v3gf/9OJUXwruYN3q+CE9oG/wUUVPGSRFZT0UMqWfaY9R0QzdNpkSyHXAXQM?=
 =?us-ascii?Q?bamYNwf9INQZeSFJv0r/0zI9WS6WYP4BPqUzP44qpcVFLsHzob2CuqtV0UOw?=
 =?us-ascii?Q?2g6xA7mJLXSYW/4NwCDZThDpWICxl6fhwLvMJOPzYOYFFZGlouf3smMhWq7M?=
 =?us-ascii?Q?wLrltq9vciobS8TFzHFhcKrGB8kB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KYkPer9g0dG5ga4/TNQlj7RrWmSQZu7YQEwY9/VWYtjkB0ggOquJAPH96iCK?=
 =?us-ascii?Q?DQRys+EXfg9itO3q2BKqQw0UujM3qcuEz0PmQhtDd/de9ddvnfH2TVIgNPvh?=
 =?us-ascii?Q?lEs6scqJYXv6a+dbjI4gG8OlJgrze6z2DvWkZOUKFugQ4xlKzeJWwVD3JEdr?=
 =?us-ascii?Q?sWd+UgAaBYTtDRyKosJaIKdJA+RdKev1UsyVHhHPyE15E7F5hA/BL9JH6PU+?=
 =?us-ascii?Q?S+lwuWSIkYq8wVKP+c0NN+JOjju4zd16wr1v0BnbHDCJiaEnXoUrvQi7yrwL?=
 =?us-ascii?Q?3tS/4hDfgmjSizgDALB+G5UbAROC2f/tKQrUpYy322aUn7JLgqPxzsyBr6+w?=
 =?us-ascii?Q?y2Pu2GQxr6R+zbyNLl1ir6/ksCRSIz9zKd+3ZicKpE7Fssj9a1rLqPMKkbQ8?=
 =?us-ascii?Q?moizZHBgyjDJYSaS9x92M4UcGb0MiyKSCQ+lJeR1bcMz+Yrlm/7i5y8iERsO?=
 =?us-ascii?Q?9rqFA6MCzuDbRscaDQlqpfk+w7cxhOohi+DUGoXhpvyA9AG09/2349h9jn51?=
 =?us-ascii?Q?snAfju8OnP+M5VzDUxSmOgDpWyB+Zjv4NkSrnEtbOWd+EICJwlzPmRC8BBYH?=
 =?us-ascii?Q?8jdBVcocB0fTR082/guF67sjWQt3xaBj8zlpJO1YL4aqKIwl/9JNk9EbQJ9B?=
 =?us-ascii?Q?V0abPXB492BDByQv5UTX8m4xKmVTfqYiu/83PTCNDkiX0CFb6ZpGhqeAZZY8?=
 =?us-ascii?Q?wXOg7+6jsFPRQ9ZvVJzL/DYNTstVqnlp0FAUfCMB8feOrjTDKumVf0dC1g5q?=
 =?us-ascii?Q?rXtsRsaU4hMOn4XOPb8rXCgO3vZyfFmWSFk26CbE6+Tz6mThHV1OvQO9ULjF?=
 =?us-ascii?Q?Rzu75dzdrBUdD8/C5vjMNVutfbsK7cMaD9x+7tdi6sgW9jPAsmG5q336HYFU?=
 =?us-ascii?Q?/rB/b8x/2+YWD7eErXzBT9Qx5kKYyAEx3l+TY2eBYGnjJ0ryvcwzF9DynZFb?=
 =?us-ascii?Q?0zd8KqY7BpE9BHSQj0iwJ64oXjNR2FD+PoBWKhmw7KGPRN8KiuW3VD4coe+v?=
 =?us-ascii?Q?FvxuKsiTr4YXLAyp5EAf9s5GrQFemTgowvkFfEsPChlGEwGhZb+6b/AZQEu8?=
 =?us-ascii?Q?3T8VMYDSc13ceRfDdADTaqsvYsm63oz0JaBD+BkWnWwgzzyGuFxVKkSYu+bc?=
 =?us-ascii?Q?7ASEGU/yUxGzz83l9OrJT25T++tBG50lh5RSVs5X3yir86frHkeNC+J7WBX2?=
 =?us-ascii?Q?Gk5dAv/OqoPjUh6Y1nFbNYYl6GbXHQpQzHhnjuY3WVPkgU1Vxo0jDYMG8j73?=
 =?us-ascii?Q?tC79uwD5rXWIW7uEBHsS33VBCWGAwpBM0oR74sLpQxYfrd1vn8LofLXqMPSL?=
 =?us-ascii?Q?mak5bneSixmdlKWnuRffbMJ1RElIh1qKv2v0krvLhUxMQpI28KajfTTDo5Go?=
 =?us-ascii?Q?r9Dxrv8P74Z33LghhPOw7bb39Ry1gT/ojwe125NI7GCwR1C121tioQYJLz2x?=
 =?us-ascii?Q?YdCgJbG3AsSrlVUqsVMLGOFyhFBZm6Z63CzdEYbHKnwNXF+k5sZG2er7yizk?=
 =?us-ascii?Q?uDj9+PuaDKGJG4jBOz+Fe3UiPbdSr6PgVXpkF2Q3TDL6zcCxVbo7N93Uj+Gw?=
 =?us-ascii?Q?RURRfuTYbDECJiNgVmiHh5x/advKZELW/6MJXPxxiRrn3AmANHKWkNq44xRP?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	auDhGvokIL8YR8lndWgQUQazZAo50OBsUBvka3ATVoF0xMLg9F4e6r4wb2OP5+qQ4B7yCCGvRJKFqffd0kd4bLroX4kRe0m4svZvzqWmDH+WLzWzoP98QiaQoxDetIUPK0iBWm7c6gZbkU+MPAAQP1SwCTaTVBwWORj9OCMVBTHT7rGa09sFAaXsrU53snthIDC/hUsg5J1Z9LQfSwkub3zPBiWzZ6wboZH2b1OZ/PoKTkaQ8mD7JqmujYEgRsH5xYJ2Ch8gwrhOBWkHY1lk8Ux30Lmph38pzrGnUkeIAYCmPGbZcH4S+uTipLa5ycJbA2IX98h370Oq4gl9O6f5SnL1AqQCZP48mbV2OXDD+bTtyPMBDrEKPVJCDHNd6/IJvL3CsncGaNlQEILR/ri98xyWVClofURi+edUGAkzl6+G3ar1zLxMOb7c6Bb7m7ByEB9lqKtRLzaLz5AT5deCuT91ycS9Wih4hu/4b90LsxA0a94cjY8sZOThgckf2B7dEzjlo8xPRRUS0k5OhGOVNMO9CIhlWo1bCmQEjQBJsT6PwwfT/uhxFekml9CWNiaz88N/31DadrBifYaCtSXCFr8XwHJVEhRZSLE4MxsRqMQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3297e34-240c-486e-0299-08dd5a43ca25
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 11:08:55.8913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0+HU+S50LHvhwolnyqNkPnWASIeb3l+jmblPnSAHma3k/EFtWj1qiLd/0wwVhiUgUEAxrCFLyTSUInQUSMvIwnGdU5Z/FlWxALREYNiyvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_04,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030086
X-Proofpoint-GUID: MclRlKW6RDqbynPUlnLKvZVBOr-cfzf9
X-Proofpoint-ORIG-GUID: MclRlKW6RDqbynPUlnLKvZVBOr-cfzf9

Update move_vma() to use the threaded VRM object, de-duplicate code and
separate into smaller functions to aid readability and debug-ability.

This in turn allows further simplification of expand_vma() as we can simply
thread VRM through the function.

We also take the opportunity to abstract the account charging page count
into the VRM in order that we can correctly thread this through the
operation.

We additionally do the same for tracking mm statistics - exec_vm, stack_vm,
data_vm, and locked_vm.

As part of this change, we slightly modify when locked pages statistics are
counted for in mm_struct statistics. However this should cause no issues,
as there is no chance of underflow, nor will any rlimit failures occur as a
result.

This is an intermediate step before a further refactoring of move_vma() in
order to aid review.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mremap.c | 186 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 122 insertions(+), 64 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 7f0c71aa9bb9..fdbf5515fc44 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -67,6 +67,7 @@ struct vma_remap_struct {
 	bool locked; /* Was the VMA mlock()'d (has the VM_LOCKED flag set). */
 	enum mremap_operation remap_type; /* expand, shrink, etc. */
 	bool mmap_locked; /* Is current->mm currently write-locked? */
+	unsigned long charged; /* If VM_ACCOUNT, # pages to account. */
 };
 
 static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
@@ -821,35 +822,88 @@ static unsigned long vrm_set_new_addr(struct vma_remap_struct *vrm)
 	return 0;
 }
 
-static unsigned long move_vma(struct vm_area_struct *vma,
-		unsigned long old_addr, unsigned long old_len,
-		unsigned long new_len, unsigned long new_addr,
-		bool *locked, unsigned long flags,
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
+		vrm->locked = true;
+	}
+}
+
+/*
+ * Perform checks  before attempting to write a VMA prior to it being
+ * moved.
+ */
+static unsigned long prep_move_vma(struct vma_remap_struct *vrm,
+				   unsigned long *vm_flags_ptr)
+{
+	unsigned long err;
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
@@ -867,22 +921,46 @@ static unsigned long move_vma(struct vm_area_struct *vma,
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
 
@@ -907,7 +985,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		old_addr = new_addr;
 		new_addr = err;
 	} else {
-		mremap_userfaultfd_prep(new_vma, uf);
+		mremap_userfaultfd_prep(new_vma, vrm->uf);
 	}
 
 	if (is_vm_hugetlb_page(vma)) {
@@ -915,7 +993,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	}
 
 	/* Conceal VM_ACCOUNT so old reservation is not undone */
-	if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP)) {
+	if (vm_flags & VM_ACCOUNT && !(vrm->flags & MREMAP_DONTUNMAP)) {
 		vm_flags_clear(vma, VM_ACCOUNT);
 		if (vma->vm_start < old_addr)
 			account_start = true;
@@ -933,13 +1011,12 @@ static unsigned long move_vma(struct vm_area_struct *vma,
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
 
@@ -952,22 +1029,20 @@ static unsigned long move_vma(struct vm_area_struct *vma,
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
-		*locked = true;
-	}
-
 	mm->hiwater_vm = hiwater_vm;
 
 	/* Restore VM_ACCOUNT if one or two pieces of vma left */
@@ -1138,9 +1213,7 @@ static unsigned long mremap_to(struct vma_remap_struct *vrm)
 	if (err)
 		return err;
 
-	return move_vma(vrm->vma, vrm->addr, vrm->old_len, vrm->new_len,
-			vrm->new_addr, &vrm->locked, vrm->flags,
-			vrm->uf, vrm->uf_unmap);
+	return move_vma(vrm);
 }
 
 static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
@@ -1245,17 +1318,11 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 static unsigned long expand_vma_in_place(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
-	long pages = vrm->delta >> PAGE_SHIFT;
 	struct vm_area_struct *vma = vrm->vma;
 	VMA_ITERATOR(vmi, mm, vma->vm_end);
-	long charged = 0;
-
-	if (vma->vm_flags & VM_ACCOUNT) {
-		if (security_vm_enough_memory_mm(mm, pages))
-			return -ENOMEM;
 
-		charged = pages;
-	}
+	if (!vrm_charge(vrm))
+		return -ENOMEM;
 
 	/*
 	 * Function vma_merge_extend() is called on the
@@ -1268,15 +1335,11 @@ static unsigned long expand_vma_in_place(struct vma_remap_struct *vrm)
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
-		vrm->locked = true;
-	}
+	vrm_stat_account(vrm, vrm->delta);
 
 	return 0;
 }
@@ -1316,11 +1379,7 @@ static bool align_hugetlb(struct vma_remap_struct *vrm)
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
@@ -1353,7 +1412,7 @@ static unsigned long expand_vma(struct vma_remap_struct *vrm)
 	 */
 
 	/* We're not allowed to move the VMA, so error out. */
-	if (!(flags & MREMAP_MAYMOVE))
+	if (!(vrm->flags & MREMAP_MAYMOVE))
 		return -ENOMEM;
 
 	/* Find a new location to move the VMA to. */
@@ -1361,8 +1420,7 @@ static unsigned long expand_vma(struct vma_remap_struct *vrm)
 	if (err)
 		return err;
 
-	return move_vma(vma, addr, old_len, new_len, vrm->new_addr,
-			&vrm->locked, flags, vrm->uf, vrm->uf_unmap);
+	return move_vma(vrm);
 }
 
 /*
-- 
2.48.1


