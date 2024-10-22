Return-Path: <linux-kernel+bounces-376934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C599AB7CC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06ADD2837E0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38211CCB47;
	Tue, 22 Oct 2024 20:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C2O1lyzb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hOOGVyeL"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A621CCB39
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 20:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729629687; cv=fail; b=UOZQx7lbed+u8Apko5vjJDMMSXRi3tHZWEyvMPvi2X7lxVT7BTHwVsNKCfCr4NqymOzIgTQI6d8PaTAmTWcP7iGb6EhzFyCaO32VwJSnLd9s4/Rv/RERR6TTpvZiN+JULpXZEwyqUtevDQgJd39Eg4usmHbbfc+GHswcWRjv8Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729629687; c=relaxed/simple;
	bh=VTD7CScjNazMZD8e7ZMV2L9WeEPyRy54qj+PeCZ8v/U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lrLEe2uRlCUtCTmPK3rw4qkS4widqWTdVI8V+ia6BoYiyhRzOQiEK0jZSvA1fWjtY3U7o9eYP8DUPLqnKU+TpT+jYLcbXMt2wdb53/uf7nvbrnJFvm6HADUTPPrr6VXMJXnYOFUjYr0ZPSv9E9UWhxGeu4de1lNZU/YnASRO8wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C2O1lyzb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hOOGVyeL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MK3YJS020540;
	Tue, 22 Oct 2024 20:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=jpITDfRM7U2Jze6E
	Ss4lS36slS67iQuUDSMEzftcL+0=; b=C2O1lyzbZv1uyqr2SiiEpvYZJ+G8PQ3A
	sFzFjTHY/ibgDsyPFaPbNzUpi5yFBZIDEB+rxIqOqI6XvU9+AAwH76xs8t6u//VL
	NzYrRY3u8ykgAt23a49/W8QdK24HALdqGMcRySS4+8H9GuP7hw0TX2/btLabzP7x
	91zAFZaqe99t2QrZRrtSHm3XD2pRb1/GHPJr2WcWNmY2KwU5ZOlp66ACLqNjahMG
	Dvj0GsNP6DbQgkLz0qMVEyfkmjf1J0XoAhLBvjwBcB3GSwljkkH/+AlEH+i9hbEl
	CaPyvzMB44YFiA5UgUfJ5cbyU3E/aovUkT++f47acGiXVNsAozJAEg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5asencx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 20:41:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MKLAUF026976;
	Tue, 22 Oct 2024 20:41:06 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c3786xpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 20:41:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWPkaRU/2HXkTXyIy6JC3b8MhgCO+wFUFgt+NkO5VGpNkaSB2ecozNJUu4q2fmndtzoOL8kVbWW7Tc/yU31XV+XhASrz5wHQTMF+Onj7wKZ2D5My4G09C58kmIERa3Tb6g/OHEGNip18UeLKMotmNyNjUAV1mjmMmcGzoF1hbV9DEde+3XHJLyggik2FRH2vzVQOG3xncXrPJW3e+SH2h5+1h/TnYYFaGFMG1xC7lRlzY02yOtUZjrOmV6vDBsmL6UPbW3THMzPftR9YaHtV6LovYHi4qoyqfoZKSjTOr83LfNfLwLv67uKhBKJ6BxT5yjBa0oCZTVuk8rnpHthskg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpITDfRM7U2Jze6ESs4lS36slS67iQuUDSMEzftcL+0=;
 b=LAsFYmwcEBONOpURcgpYZCQsoEEKI3R5wn9BeiGHYRQxi5fKqjo/6SgTeSy11mqBA/3UgKjjdloVj+7Hc1Bhzls4RaGp1OqTzUD5Wi+36XvYpZD5lhRmgv1qPe1r5vTcejBh/3NF31nZv3QgbZl/XjMdO4aQ3YXaBYhPiAIjNS7lqyb+VtgPYR6GSnb+JuOo+PaWf3IHRSybi/0mLCVCaI8gyFXJ9TRcsKh6fuxIsFdSUF/LWl78f80R1i5XhBd00xHEczVMmHCKpS+zFjPDHhHwFfnSOtmOHLRJEpY8yessXWsDB4N6lBSoMeftz0qviSYofKtuwdPEYdCOiJwWSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpITDfRM7U2Jze6ESs4lS36slS67iQuUDSMEzftcL+0=;
 b=hOOGVyeLMpMDqLWX9osD4w7ImH+owFzoCwNgb/Jeo8IBok4QP4R+mS2txIaDiTdDSvwg7EDBsY+vcJe0a3qoTm/7Lw0bw4l9cyY9+xsXxLyy1J2UaWeJNLsFm0e9Hot0wkmdgc0xAgaxIEK0or3uovpJKJ0uVWHxrgvVqstWuzk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB5879.namprd10.prod.outlook.com (2603:10b6:510:130::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 20:41:03 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 20:41:03 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH hotfix 6.12 0/8] fix error handling in mmap_region() and refactor
Date: Tue, 22 Oct 2024 21:40:51 +0100
Message-ID: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0072.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::21) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: b9295443-7a62-459a-5475-08dcf2d9d862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m61Qhx2Jco9s4LTO3eRc8FDoAihAl773rKQR/xKo4phg+fV7wGWagLOQ3Tg/?=
 =?us-ascii?Q?MdvgDr1tOqLwQa9qD8C4l6SmAgKDw1TkMDDEZfzLskgzojkZdR6lmU3R0w0V?=
 =?us-ascii?Q?2w4HPZ/+6R1waEb5zXUU3Mm2sn6fIxOSEly1XzRo9l/0nUoOG6Sb0/npcvNv?=
 =?us-ascii?Q?vd7HKLZ9oFLZcuf0KIV4woFgGOYwC/lNQFZgxuh2nLCldiU/bNNw6zU/PN0m?=
 =?us-ascii?Q?20NAX52yzwlT+D/04EsSHV+90oLwQ9Zc1m5is3zeSrwYtxjo+n2CbRWUyXdE?=
 =?us-ascii?Q?mTx3xtgxWmQzuKl2DF4mcOz2TfIFzUcVgwqDveF+ipaVV21CXZ7+nQ/xSQbW?=
 =?us-ascii?Q?8QrwPpxpIaN5434NKpoyvuOj3Fl11mQp82jenXB/DT4kkEGFoJkoMzCaSvVk?=
 =?us-ascii?Q?dMoT4jg6OE2bC/Vo37EKmK2PEBrgdZJnywKUuWi8u1xBkFp+LQd7e+4QEf9q?=
 =?us-ascii?Q?e9ET/80DRH+pPPxZog87btxf5fv4N0TxIx9xDdcFgTBH1NL90ZgFVD67l5Yx?=
 =?us-ascii?Q?sSZJGtvdF4CWPfICqxgHsDWXyKTyskxx2puSD3BFtJkt3TEled6XOokVjblk?=
 =?us-ascii?Q?ZcxedNIDR4yT9XRPEw+K1asHc5j9LhxaKGDWe4LMG6NAW12BlyxMR2E+GeqV?=
 =?us-ascii?Q?BB3iaxjYrSRcMCjsgh/SL/Gm2vJuBOg6GI2FWE0rcJQgFp4fP3YQwusYz4jq?=
 =?us-ascii?Q?szqteRC94mBI+hqf4noFoY8n/WiKDfT1FZmPA7BkzcsM3PBuWqPanvUaZLqW?=
 =?us-ascii?Q?bdxn+m3cRnubkFZq8liVdj3cjn4mBw9W10POrNZpINfqH8j8BssWmi77H0RL?=
 =?us-ascii?Q?8MprJgSyoqCTO5We3ErBx3cdGzgBxKpEVlXSri+0zP/Rsqv1AoJ+VuqmGuki?=
 =?us-ascii?Q?ERNA3KEx0/sqWhpXWzVfzaJQpXZ54Uk53EaGSTsFKPCsrRC3nx9pQ2PPDke0?=
 =?us-ascii?Q?J6OEMyEhR3jdQrHBlDV2HAYuaT+GBr6DOjvU51mjxs6uJ/kpaKrX3fpyvNAU?=
 =?us-ascii?Q?IPwrGNjWIbwOU3qKIjPrpGc1EswRTJzWpaw6vSb55NxTHvnlZlmQQZWPWUd9?=
 =?us-ascii?Q?X1Ko/2XmFOGkyUTtCRk8mOiFQUiIRv5ooAUzKeshWJuvcF64e8MiOc2AELWP?=
 =?us-ascii?Q?OhDwTC8KyISD/GdNU9pCEWtEmDzRzWDJ7GzIChk16eLID9yHW+OzZagIv0yr?=
 =?us-ascii?Q?29gKEmuO3Wjvzbuij9KjyJYLNktv+i8OrdVxlA/EG5b4rLZgd1jDfoqIpb9R?=
 =?us-ascii?Q?5Wdc0SFNNpQQBF1PRKDdkMO/XoVFklmlebq4xucYTIx6//lV5zPn1gOMexen?=
 =?us-ascii?Q?UYdPVuIaiwPYSLBiyAplVs6h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xd8JniwwgdaJfUN1/jMRUaff8ReHVZl1giY+lWpKch65AdeVEMBtQlyOl4fJ?=
 =?us-ascii?Q?Y0jHedck8NPaAyO33e4JvBUUAUSlRbNByGryLbgleqyP9xbj7P3e5ISejYrh?=
 =?us-ascii?Q?qR367n/HAldK7X2lga7K5qLsje+PHUO6Qnq67sQzf/bAFkr0N2mgzLRog2dR?=
 =?us-ascii?Q?gTYRsqfpvphvWqH4jBRD+gy11dR7WWX4tb21D0uvLyDV8CL7FxqtKvNLRfGM?=
 =?us-ascii?Q?RzxUNuKAjMQISWD0rhgRuIdUt81H5OX48qr2vzNZXrfc/aVNiRiGz0cRBMao?=
 =?us-ascii?Q?+1JmlU00KJxIIasx9mvcoTLl2snf7K7895yC2i49BTBS9VHMMpYOPKY1QURx?=
 =?us-ascii?Q?9GxPp7omZ2IDDR/ITCq6AClPVpo/ZI+IFhJm9Hg4ZHtNawupbqxDloVoLXA0?=
 =?us-ascii?Q?luhOae4zHZD1YIAqalZNU/usx4RafTCz9+9ZbhaiobxjrVxDeqhf29MPpSCC?=
 =?us-ascii?Q?ibgqpex8tU3BZaKaJvL5whIs65mnYPKZ+VVckACF9hOpXHchYfDiEZKHH6tT?=
 =?us-ascii?Q?5KD3JrKp0D6Tx5Ks91kuitU5LaZl/lvOnPt1T93axOBQyVc4XdS6BiWKsEBx?=
 =?us-ascii?Q?fB4CHV1e8kKwJ0yP9JM8VV/hC3uli1dLjuPl0Y1qu3sot1+zkR8XoUQ+U/n8?=
 =?us-ascii?Q?Jn2sWBwdra0/kQqztBoNgPb+wUHvMxymohMpeCvPa+OzRfjCv/2+ViyiPPDK?=
 =?us-ascii?Q?w0AERZQoJVZiZTCMzzl1gPXykTAJKC1ZdTRTjrFSwb0+nklZu9jwNjZBtbwo?=
 =?us-ascii?Q?2Cpd3ifglxAvPB4BBvctIb79R9s7AaLoVTwPyiMrbcb+5yWTgEqr8wWN3Zzt?=
 =?us-ascii?Q?KTZi8kTtj5pjuXw+GnOnrZyh1dN9h1YaXvMwBGgRkLwTX5h2r8LmtPu3wQ4a?=
 =?us-ascii?Q?d5F1Tcpr4v1fK6D2wkRVO+zGUGUTPofCsuPC88hm+z589sQLGTsiMkqj3wjJ?=
 =?us-ascii?Q?6YgT+ihTVpU61bjUP/xdn0kxk60G2sHy+gjB471cCoXXByV8nTNLCTOOPCbg?=
 =?us-ascii?Q?6WOyxyk9mK0rNyzqAytP5SJRCEnmP5Cdof61QBHG93ojOW73XegSPHbOcD3m?=
 =?us-ascii?Q?LimbN5iL1jpjb9mcyolKJkBQ3t4rz7KjIYAGnigfI/V3i/HN6tp0XQ9kjgzr?=
 =?us-ascii?Q?HYDAXxl8bTm/U4iKiTom8vch0XUvOShPEtNLIhCHrozJhXVb46doa8B7HD1u?=
 =?us-ascii?Q?5p4M0rk8UUtXjfdHvOFrzW0X03IINoRHeEi91hEOVL1iEnLYPDBql1PWHzxp?=
 =?us-ascii?Q?KqzGDLjcUwYzy/EGQHE4O8xEzAfTfLCnYoJ7YQJoDthQhflfZG+eamSQzj4b?=
 =?us-ascii?Q?BU+r2H6HSRE6iW+HpPKXvXMsq66SYM7j5dRGdyYgmlraddxPhjXt6NKxfmrL?=
 =?us-ascii?Q?3tqOOKNFZQlbsv45xH/9OHBsoOid03u+93AMrYq7KG4VvmrLox3S+jNXFt8j?=
 =?us-ascii?Q?+GX858PGo4RCWxU4H3kyZoQQRVGpnICx43SQXfsFUmrb/ptZh/w8JI55JdDH?=
 =?us-ascii?Q?oAmAmeBw+yZ2mAmhuwrQ2tNFuOZ/G91Bhmg09IKad8UuPFzBG1e6LeAyLHgD?=
 =?us-ascii?Q?AY8ANJBOAXC3BU5Hps97E6xEckuIRvRMau/wWNbPL2wDLg4SMRxNJfEK78Mq?=
 =?us-ascii?Q?XOCp6zSGww9tyy3b3Mzd0q94jjI1r3UODsiuqm7Ldnix7Qkk1f5PT/sivzri?=
 =?us-ascii?Q?X1bGGw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1rcUn/Uctsg+C7lYLUUi6C/9emE1UJ4vEyU8QwUtkAI1FgsH9QWkknkMXbq4vKis2YMEmqkR9TiZEkfX55mofW27tVkJCgQdTIZHNO8HhYXIk6K/G3/YqNbHab3eX09Qrnx0Er1DHjOHfAC4J7kDptPUw5qvcgDiH1Ft/sGIqCXDHWhKRmlT16Oaszb26PIxNPPU0EYYdO8dKu+ZyfkxN0hTIqe9OvH1vFXeULeXfXZrnyFFkN40yjyfprAcSjxA7Wr7XQFJtU76A4AGzNQI9czR8O2+HOSwekeIl9LxrzjeBok/FLWGDj4GrrnTeLyUZinlg8dLq++GWOivufmcv1TKlNODV0uvNmsV4w+KD6DymqTL6+rSoeeBwQkwccuT91ZVL2sTal9A1zcjyjK+0I0Ims5v5+q9zM3yE0mmjP6HJPt+Tv2kxxf/6CKKg5wrSjwGfmG4KSIFWLBjwGnit0iHlGpXYLYqTdVsANMfYG4LRWbzh2liMHBBaAo+kn5P67i1WOvyAcL0u0jYzanvEB6tKgZOId28w+FSPjvInJQf3onBc+4CfUiQPvWmmtWDRnGv/VQXvcKtR2IniV9E38s9NKy84VGdCvZO/QxCiIo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9295443-7a62-459a-5475-08dcf2d9d862
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 20:41:03.2809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1knojpsHqgp32A9p1EIa4funUrSggGkAQCTVo3C7ra3xEK2RcA7sq1tIcmhAibUO9QiHGzJcrE8wHRtbHln4f3VF7Ig7/JcGfTaTT5mN/WU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5879
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_21,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=967 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410220134
X-Proofpoint-GUID: Qgr1MidGYbvtQUveCIpGH215mYdrO_ZH
X-Proofpoint-ORIG-GUID: Qgr1MidGYbvtQUveCIpGH215mYdrO_ZH

The mmap_region() function is somewhat terrifying, with spaghetti-like
control flow and numerous means by which issues can arise and incomplete
state, memory leaks and other unpleasantness can occur.

A large amount of the complexity arises from trying to handle errors late
in the process of mapping a VMA, which forms the basis of recently observed
issues with resource leaks and observable inconsistent state.

This series goes to great lengths to simplify how mmap_region() works and
to avoid unwinding errors late on in the process of setting up the VMA for
the new mapping, and equally avoids such operations occurring while the VMA
is in an inconsistent state.

The first four patches are intended for backporting to correct the
possibility of people encountering corrupted state while invoking mmap()
which is otherwise at risk of happening.

After this we go further, refactoring the code, placing it in mm/vma.c in
order to make it eventually userland testable, and significantly
simplifying the logic to avoid this issue arising in future.

Lorenzo Stoakes (8):
  mm: avoid unsafe VMA hook invocation when error arises on mmap hook
  mm: unconditionally close VMAs on error
  mm: refactor map_deny_write_exec()
  mm: resolve faulty mmap_region() error path behaviour
  tools: testing: add additional vma_internal.h stubs
  mm: insolate mmap internal logic to mm/vma.c
  mm: refactor __mmap_region()
  mm: do not attempt second merge for file-backed VMAs

 include/linux/mman.h             |  21 +-
 mm/internal.h                    |  44 ++++
 mm/mmap.c                        | 262 ++------------------
 mm/mprotect.c                    |   2 +-
 mm/nommu.c                       |   7 +-
 mm/vma.c                         | 403 ++++++++++++++++++++++++++++++-
 mm/vma.h                         | 101 +-------
 mm/vma_internal.h                |   5 +
 tools/testing/vma/vma_internal.h | 106 +++++++-
 9 files changed, 591 insertions(+), 360 deletions(-)

--
2.47.0

