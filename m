Return-Path: <linux-kernel+bounces-544663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23022A4E3DC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C25217DF1A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ABE25D551;
	Tue,  4 Mar 2025 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aY9R6rOB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XIjAgqWi"
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700B9277803
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101724; cv=fail; b=Q2dOPhTlgOEpQ6YysWmj86U4H/FCNJc5Vd5aojOu9wH2YHuuwCtlD06E+/QG/i4qAlBaTF3zdjuTwTTV0FnzzHM6WdutOgUU+5MKpdRrQX/szOmYPfzlpMiO9z2hyAoA1NWZnbRWOyWrTNWJxLq5lTVAQmWCUQiCkid/kCVLrc0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101724; c=relaxed/simple;
	bh=PoBu+cmfXZmStjlEWLet0D5UL7OO/7NgflPZ0ow8m+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GX09Tb6IsejjEwBV7XwFQzvNsIrJPwK4iPG16ZAA9kqZNBO8+RvD/L9hyySF+PRdvlsFZrDhFCbj8eXnVp6J3ZYcs3NXaQeE0YtieeHUj/kvR6GrOO78zvu92zL6xo+lVw/PVDIFMDhXhgIVz1krz8ED/Q6XCUiu0EQXaTsNalw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=oracle.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aY9R6rOB reason="signature verification failed"; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XIjAgqWi reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id AE2D340D0BA4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:21:59 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=aY9R6rOB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=XIjAgqWi
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fWX2C9fzG01p
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:20:24 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 121A342724; Tue,  4 Mar 2025 18:20:16 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aY9R6rOB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XIjAgqWi
X-Envelope-From: <linux-kernel+bounces-541518-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aY9R6rOB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XIjAgqWi
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 67DAF428A2
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:15:21 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 2E8002DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:15:21 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFA318956C2
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722A61FBC89;
	Mon,  3 Mar 2025 11:09:21 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A791F5608
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000150; cv=fail; b=FZcpMVPvsWfd7ozw1/tKH9SGl8QIFTrRjGABIxW97SsiA0KWV0NxeiWZ5v+o2Fe6gMwKbGUOK/Nj4beznUr+w4G7vQ5m9mOqV55PLEDWtsQy8ff71ixuIqNhkyYLinLFaQAVrDgRSbsDR32S8La+9M2jXjQm9rL8e3szvkyME+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000150; c=relaxed/simple;
	bh=OqsI320UR+PGHFzqhvBkWwaXtqaRTdjsguN1dPZhk1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L2MOeaHRu/zWUXTkj5qKiIFTaW+jUpoHFqmnU2axL0Y/M19kyUua59qNPkRPt70lAb7MZuEzUuHdz/gcvO6R2fC/ITuw5arGuppuJDU+JAcJYbXabk932yyToXR+VVGrMrSUsgzZPclIc286WKs4K8evLdO+aEaGx73gxDtDcCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aY9R6rOB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XIjAgqWi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237tgcd026452;
	Mon, 3 Mar 2025 11:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1Has/MXKXTVWDN5Di9puibXAvmMuHkHfSmiQDjztFlg=; b=
	aY9R6rOB+ELNacEIzf9EUDgWsdYbvlTcinnQwKkpqdNI8dYAiwfEgOZvEECrG6bk
	gT/c/mjHtTQ1Bfo65zWBRi18YcG0vaF6miMtKa5+KUV3xHD37bN9adB9eoquVjm9
	kGHrMTmnSTtDfBD8u8fb9BHvutI+RdLKtnKtQyepqxBvwIrqHDIft1Ae2ngl0/kC
	3Ky7g4IF2/XEpNScg6Kyk8iCxq4N8BWw5jQnwJwydXJRgr1RnOCsJ4tjwyfLDDG7
	us2UeyHGJ+x/DucM+32MdsWzP/4e0r75fH0bVN++z+ca80Any9u1xsE0nPf1oi9h
	GAGVL5rL6oT6yeLEMY5l6Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u9qae0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:08:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5239GbMC039698;
	Mon, 3 Mar 2025 11:08:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rp82hkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:08:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWDuQ522006VatPhrsa3NxAhefK8OZ6+Em8WESEKpNH78CRRDr9Q4F/mDkhJtpVuiDPP5IL43MJYnt7IYOOLOjCJMLQL2nxN3QaT8AeecHWlLj92c7XswcGKPAU4YyQ+VtTW8BcfHxEVUCIQf1bwsDZHPxmtbJi0/m8AD89GQD+O/yNFXMeBdjMRE5MCRQJnMzgu0Ua6DOVJj67iIDF60wn15S6M5BS3EmxcsWGDxKrWzJ92IGQ+K/822PMzW6vlbQGiEpmYtWdOXkWcwHiBRiTZEhtH0VsZfp/znJuxdXCU4Mk3QfmT3R1gGUj/1LVv9LFsjfIYWnpcOrDSau2eXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Has/MXKXTVWDN5Di9puibXAvmMuHkHfSmiQDjztFlg=;
 b=BHaKUYJRYjEf7imSvEr1uSgE66sSHSUljePnSBwHRVT73ysidV1yqUzVXHoa2AfBTER1ZXGbdBq1uwyNz3yCgaWWyVzZ9zWPeElRhxMP3mi8Zp04PVgAFQRcsS8u5xfP+3trxa/+wxC6zXK7q1ZdMJG6tmQm55eOJq7R/0y7yXm/i425hekfRAKvh6skSGG7ddSNV+KC20gfIre69Y+5O01rERADH2LXiAJI6lQT6M2mugXqMyNx+1SNsI41imboTsanO3qkWswg5YaJkCEYAc8t3p9Sqf2ASR1GMkRV0QU/2KEGPBg0lu0JHVLM53tF9daufJulQGJKrL3oUZ0uhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Has/MXKXTVWDN5Di9puibXAvmMuHkHfSmiQDjztFlg=;
 b=XIjAgqWiFsE+aD3ailuYb6H48aM0t3tuso6lL+j9np9nDzj9MjkkJAMazunvweHnNqa7K99IejjSSBxiqXr6wpomYADhPreEeZRo0rAmob5NE3tM0/RTOMoggLoZuLQaRn4ZHi8yRVRvsnnJboUf6l4TR8DHPfSMNTlgh95dPvM=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DM4PR10MB7427.namprd10.prod.outlook.com (2603:10b6:8:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 11:08:53 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 11:08:53 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] mm/mremap: introduce and use vma_remap_struct threaded state
Date: Mon,  3 Mar 2025 11:08:33 +0000
Message-ID: <665d51a5bf1002e84d76733ab313fe304ff73f65.1740911247.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
References: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0062.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::13) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DM4PR10MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b2258a-8777-432e-f6b0-08dd5a43c8da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bdqeHpkT+qc739uDejIFsmobAqaNJAYIr56R+cwjuU8FxmXHVlWOhr91rvrN?=
 =?us-ascii?Q?SbhZ2XqSjXTS1cUauXoUePnmlUxgJmuP66FBMSbmZQE1TZqmqXJ4dQHMTIx1?=
 =?us-ascii?Q?5ih/XEUhunRYKqC+WCDv9gDRjOdTRyD02G/O0No9IpRzZJYdRxlZ6pPWsNLL?=
 =?us-ascii?Q?kH8P1o3uKSLcm0yANnEDuXH8DHlZchhwu7PIaJsTyRkKpKKeEtlHbkac4/zX?=
 =?us-ascii?Q?S8yBVbt1+Wf2tttdsBkLTP6OEEu0MBGfPcUw5tIQ0XdbWdXPmrN+TtQtwGRI?=
 =?us-ascii?Q?t7CnJ3YFq9dO9wKpraHSb02GrEdSSHrAwQzrouLxBlPi6ggtR0xaFNqupe70?=
 =?us-ascii?Q?LiBNbogceIwU/GhFSvNB+wfctVX79GdnXRAZBflzQktihXmyObQ1k3r2c6CL?=
 =?us-ascii?Q?bePsYonO+fR+Y7tR3ZoM+auiSl9w+TWa6Dgyq5nEmFxUq3xY5ckCq9a4h9Ch?=
 =?us-ascii?Q?P5B+o4FwfOzPorhPoxLZF8Djpph14hkZm6AQJQTqwsUizvNiCITTqwFuQ3An?=
 =?us-ascii?Q?NCAZ+2esUXuSPwBkHP1JsaPj1ZpWK82g6xv5d+mJcXOczgARvduUfUbd6qmX?=
 =?us-ascii?Q?wJV4H2kOWyaOSqm1QtSW0XtuLAY08Yn/87ppO4/PzXu1f5JgDkz1BqU7Rags?=
 =?us-ascii?Q?X/Mw1toN7p/gDKOzhOMM53GuuzCidJZsRaOh2WDXusxVA0JDcVrFkXAWXPQN?=
 =?us-ascii?Q?jlKHE8LJ4BPzW9qaKxyHmVLBatm46Nf42CVtlGsg/xmWvz46Gikek64ePjRg?=
 =?us-ascii?Q?Gok5AXSI72+au6rogxlll8Mwrf14/8SUdWcGkE2y69YCuBkyfpb2Lst3Oo4D?=
 =?us-ascii?Q?MX69irzWzJmSmBnqKsn/ndBD6xQM20TetSJMd1IjYCkLGFgwMQdgOQxRXvNp?=
 =?us-ascii?Q?4BtQGiXOZeVFx75+0c8z6FE8F8MN2TNXt0SL1e+BdOUFLeqsdF1LvknqYF+P?=
 =?us-ascii?Q?IO9IJEoSoBOflrFl8TFJfIANKvqWF+Wxkv6rS2FnHxicZNr8MOory8aYq5JX?=
 =?us-ascii?Q?rWPSH70JjS8BJOxfO0P18rEL9Evp7CWayfRaL2y+5Vo75muSbNa1fM5vI+rl?=
 =?us-ascii?Q?Af8ngvfLbhqViuTsqGqc7K5g/cSNtZxj1HdZIJpbbHgG8rp9IdioiU9ASwsw?=
 =?us-ascii?Q?tQLkHHxithSBFcAJLTpGpDpyXpHTZw4Rz4QpOKRwPqR9DQw9ed00m3eF9Yob?=
 =?us-ascii?Q?m+J3fCTW1e6lmyPXOQU+NIOAUyUsOqXHiX5krf5OyjLyAGiKe7crpYLUVdiV?=
 =?us-ascii?Q?LDMZIbFJ5PM/S66WeeR01dl2FyOvukks0AC6j8VkpZKvgjJU/zT+hufQQggY?=
 =?us-ascii?Q?W+p1lEDtkA80rAXsTngZ0T1z+qvKnAJbxMjneSRAMJ7igx18chOGTp4uZcKm?=
 =?us-ascii?Q?oiQ2zLi6mNFkTZUgRPPDSmYdn9/g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b0yz8FiDBplCXUxaT0AhZfqKPTTPPd7oTiTjL9W+Q7F0wky6ofmhQGrJDHS1?=
 =?us-ascii?Q?TO5HMtnKQEYyGhDH8qhQ6pJ/hYRHj3+qre/k8sApCYA5nupylD0PwkoikddN?=
 =?us-ascii?Q?uT730f4cqL0kKXlFVN0RPSJrqkfwruf4vigtRk9ceiJ2Io6iw/hi4ijOk6nT?=
 =?us-ascii?Q?1E6bZncOoBXOO0bEorYXNHa2+SRBlc3a37RlNRkX/5zJPghvNdX7CtGcH9kV?=
 =?us-ascii?Q?u+crufw+2iUkhrbOmGZ+L4BxNBEJAvrWG8BtwGZsWJE4mmIukrDGFkXO6eZS?=
 =?us-ascii?Q?M/9uquP5bTonbVzKeu2DKPb6FXh51bRdwM7qz4IR+VO6mXSb33NKa6hsjIaW?=
 =?us-ascii?Q?W+7tiCt3RD1k5Zhg1FerOmjGgRShyNs5bPKDjC1f9tB/k1kaQE552AxDIZh3?=
 =?us-ascii?Q?dBWOFYRthbrORo6LKMJUqehkonHEnfrRbJv5BD08Zzlt3hWsNxMjCKAQyDAa?=
 =?us-ascii?Q?K7CiB5vo2t0nzvO4WIAs0/RQEuGL9vNk2A/rem4cGxZ9D+KlA3qlAsrGvCU2?=
 =?us-ascii?Q?ApklTeSvZkZGmGwn3DsRbY9A54IP28ZFoYbAqvdmX2rfmq32NgwLiaohTVZP?=
 =?us-ascii?Q?qIbYZGtRUry9MBAcCFM7EHVfMASBAXaXzIvhAVSOAzkUJGnTMCS+LB9JmiH1?=
 =?us-ascii?Q?1H2Xz9XHwyQd6xPu3xW2+U0BueegwwGxGWCj8+Lu0H9bxdiEJy2YPXQhmF6K?=
 =?us-ascii?Q?hQ6BUtOZPM+xanIO54q8cwEdrRD29Q99uLrla6plj6cn2u10B+7tAxNN0+CN?=
 =?us-ascii?Q?vmqsUttjey3uh+fu7yGmtD2L4o5q5S0nqgAVJLx0tOnbQArx6OI1+foiCl0w?=
 =?us-ascii?Q?FYTBdeKKKnrVG9vycXO0U4wBDV9gX432MaikIO5y7JczHjEJxrPo2+E0rju1?=
 =?us-ascii?Q?pY4TSibBmcl5FsAd73NRWYrHWYHcsJhCiiE37FSeLnV8VP3FST5Sx5Sgx7Qx?=
 =?us-ascii?Q?BgKNGd1rx15tXm0f0lHlvLMJwTDdE5keYULm5JZZpHhl/ZjQAKGWgVYlBtaZ?=
 =?us-ascii?Q?b9powuxeQfGK08+KLikJUmJD7hJ+wfM6tmaQ9wLc4KPhJ6o/ngSawTXQPNax?=
 =?us-ascii?Q?8kkd7Nir/wB63+g3Jmb+0AaOutLrKe0XHM5JeM758aipHmkI9kKooBeznLaw?=
 =?us-ascii?Q?CSOaH8QrFmCYNX9OYQ45CenrX3+bqqLa4uBPSzI1eJdF45jkZLNN6kBBt0wV?=
 =?us-ascii?Q?+AUe34qLs08LfmIhuIvvaUHMm/rRFXrG0TcD9MAzLckvmIuTrnL7AEUIPTz3?=
 =?us-ascii?Q?VeLC765RePbtSOYrFRwGzg4x/GFrAl+9MB7V6a7PsAZbSVwvOyNbvSTyY1PE?=
 =?us-ascii?Q?BifnCyo22i1L2H+I09RtzkPaM5Gj82283P09vVvJhLJlfS76/g6XIFZ3As8V?=
 =?us-ascii?Q?4hVb4TprA5DlcBEsCJ1jX/g8bO6Wfb41GMyAkit+DdBhfPtSBfZYZFxOSk0F?=
 =?us-ascii?Q?Z2aQ/cH5x5jhYWKmW4a3V3M06azMoE2zkN9O8aFZbKnO2jjfbfYR4w2kpGgc?=
 =?us-ascii?Q?RtKhHyIrAiSTCgrsUpgiCsLgU1KzQxPR/3PPTDsg+ly6jcerWkypXafxWHeF?=
 =?us-ascii?Q?WpswmaNbmYFXnR3GoR2ZNfq8ZEVI0eMIbSlGEWh6t6CPXqNuUEGhafDyCbgW?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9mehW179qW0Dg9NF8zDbt8uszYf/vw7lut2iFRv/syw/p53qiDJOLkUe+i/QZGuj/VubWGDPG2aEiOiwaf7skC+DQ+cWqq5Qf49vRdG8FoxIfEXZ2iW3d8vEiubiL/KxCpwmslemUohWKDJu90naDigj+/nylFiv2l62OXXxoQeXVlJQwZkjH5KhlxLEWZHASCbks63ccqczR8NlkZrGaRxzJZLG1XpWX4/bhdirSzuEL8VIqLr6hkxH4Ty9572LXICMVmUYaWm1ikshQT4FlMD/vMBoLfGIxEh/R85kmPZQgbnlCFsmLgJgDaZo6N5yHXP/HdyvpGBbPPQer2HME4ZKMiwt8Us0sXzpfpPNfYciwyIwxih9j/nkAJZv6vebXu7BBf9w9RMw+E+gabw+fSvY7KrZEmi2ZnpuLiZYaExPsJi52bGbXmrMeCAMtJZ1nNfnyle9Wxs0D3z9p0D6sgpxX3EwLSZhzuaVCi2Sr9/UQQW1voB9Ref48Lg7DCLN1FXfcOubMIkURXT3Ig7Y8/UbdS1gD0z24h/lYwzbbIDkkLYGCCJKWm888tm6ccZbV31YoAcAzkY9zsyJ5CdxgC1oGTPVFQtly8oDRBy78so=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b2258a-8777-432e-f6b0-08dd5a43c8da
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 11:08:53.7362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBwIlExuzKgUjj/ulVRrElcxNn9CSWa95pIxCC63qoNdeAiiwRXM3/9FBtUwyUV98fsp+YGZduu9H+/F2BNneUCW+orvbU1KrGPfqI9UhAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_04,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030086
X-Proofpoint-ORIG-GUID: SL03SwDfY57TCXb3D7tvgINXD3jjbe0A
X-Proofpoint-GUID: SL03SwDfY57TCXb3D7tvgINXD3jjbe0A
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fWX2C9fzG01p
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741706435.22655@1I0eD3KgG1BFjKaUq5a4hw
X-ITU-MailScanner-SpamCheck: not spam

A number of mremap() calls both pass around and modify a large number of
parameters, making the code less readable and often repeatedly having to
determine things such as VMA, size delta, and more.

Avoid this by using the common pattern of passing a state object through
the operation, updating it as we go. We introduce the vma_remap_struct or
'VRM' for this purpose.

This also gives us the ability to accumulate further state through the
operation that would otherwise require awkward and error-prone pointer
passing.

We can also now trivially define helper functions that operate on a VRM
object.

This pattern has proven itself to be very powerful when implemented for V=
MA
merge, VMA unmapping and memory mapping operations, so it is battle-teste=
d
and functional.

We both introduce the data structure and use it, introducing helper
functions as needed to make things readable, we move some state such as
mmap lock and mlock() status to the VRM, we introduce a means of
classifying the type of mremap() operation and de-duplicate the
get_unmapped_area() lookup.

We also neatly thread userfaultfd state throughout the operation.

Note that there is further refactoring to be done, chiefly adjust
move_vma() to accept a VRM parameter. We defer this as there is
pre-requisite work required to be able to do so which we will do in a
subsequent patch.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mremap.c | 559 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 354 insertions(+), 205 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index c4abda8dfc57..7f0c71aa9bb9 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -32,6 +32,43 @@
=20
 #include "internal.h"
=20
+/* Classify the kind of remap operation being performed. */
+enum mremap_operation {
+	MREMAP_NO_RESIZE, /* old_len =3D=3D new_len, if not moved, do nothing. =
*/
+	MREMAP_SHRINK, /* old_len > new_len. */
+	MREMAP_EXPAND, /* old_len < new_len. */
+};
+
+/*
+ * Describes a VMA mremap() operation and is threaded throughout it.
+ *
+ * Any of the fields may be mutated by the operation, however these valu=
es will
+ * always accurately reflect the remap (for instance, we may adjust leng=
ths and
+ * delta to account for hugetlb alignment).
+ */
+struct vma_remap_struct {
+	/* User-provided state. */
+	unsigned long addr; /* User-specified address from which we remap. */
+	unsigned long old_len; /* Length of range being remapped. */
+	unsigned long new_len; /* Desired new length of mapping. */
+	unsigned long flags; /* user-specified MREMAP_* flags. */
+	unsigned long new_addr; /* Optionally, desired new address. */
+
+	/* uffd state. */
+	struct vm_userfaultfd_ctx *uf;
+	struct list_head *uf_unmap_early;
+	struct list_head *uf_unmap;
+
+	/* VMA state, determined in do_mremap(). */
+	struct vm_area_struct *vma;
+
+	/* Internal state, determined in do_mremap(). */
+	unsigned long delta; /* Absolute delta of old_len, new_len. */
+	bool locked; /* Was the VMA mlock()'d (has the VM_LOCKED flag set). */
+	enum mremap_operation remap_type; /* expand, shrink, etc. */
+	bool mmap_locked; /* Is current->mm currently write-locked? */
+};
+
 static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
@@ -693,6 +730,97 @@ unsigned long move_page_tables(struct vm_area_struct=
 *vma,
 	return len + old_addr - old_end;	/* how much done */
 }
=20
+/* Set vrm->delta to the difference in VMA size specified by user. */
+static void vrm_set_delta(struct vma_remap_struct *vrm)
+{
+	vrm->delta =3D abs_diff(vrm->old_len, vrm->new_len);
+}
+
+/* Determine what kind of remap this is - shrink, expand or no resize at=
 all. */
+static enum mremap_operation vrm_remap_type(struct vma_remap_struct *vrm=
)
+{
+	if (vrm->delta =3D=3D 0)
+		return MREMAP_NO_RESIZE;
+
+	if (vrm->old_len > vrm->new_len)
+		return MREMAP_SHRINK;
+
+	return MREMAP_EXPAND;
+}
+
+/* Set the vrm->remap_type, assumes state is sufficient set up for this.=
 */
+static void vrm_set_remap_type(struct vma_remap_struct *vrm)
+{
+	vrm->remap_type =3D vrm_remap_type(vrm);
+}
+
+/*
+ * When moving a VMA to vrm->new_adr, does this result in the new and ol=
d VMAs
+ * overlapping?
+ */
+static bool vrm_overlaps(struct vma_remap_struct *vrm)
+{
+	unsigned long start_old =3D vrm->addr;
+	unsigned long start_new =3D vrm->new_addr;
+	unsigned long end_old =3D vrm->addr + vrm->old_len;
+	unsigned long end_new =3D vrm->new_addr + vrm->new_len;
+
+	/*
+	 * start_old    end_old
+	 *     |-----------|
+	 *     |           |
+	 *     |-----------|
+	 *             |-------------|
+	 *             |             |
+	 *             |-------------|
+	 *         start_new      end_new
+	 */
+	if (end_old > start_new && end_new > start_old)
+		return true;
+
+	return false;
+}
+
+/* Do the mremap() flags require that the new_addr parameter be specifie=
d? */
+static bool vrm_implies_new_addr(struct vma_remap_struct *vrm)
+{
+	return vrm->flags & (MREMAP_FIXED | MREMAP_DONTUNMAP);
+}
+
+/*
+ * Find an unmapped area for the requested vrm->new_addr.
+ *
+ * If MREMAP_FIXED then this is equivalent to a MAP_FIXED mmap() call. I=
f only
+ * MREMAP_DONTUNMAP is set, then this is equivalent to providing a hint =
to
+ * mmap(), otherwise this is equivalent to mmap() specifying a NULL addr=
ess.
+ *
+ * Returns 0 on success (with vrm->new_addr updated), or an error code u=
pon
+ * failure.
+ */
+static unsigned long vrm_set_new_addr(struct vma_remap_struct *vrm)
+{
+	struct vm_area_struct *vma =3D vrm->vma;
+	unsigned long map_flags =3D 0;
+	/* Page Offset _into_ the VMA. */
+	pgoff_t internal_pgoff =3D (vrm->addr - vma->vm_start) >> PAGE_SHIFT;
+	pgoff_t pgoff =3D vma->vm_pgoff + internal_pgoff;
+	unsigned long new_addr =3D vrm_implies_new_addr(vrm) ? vrm->new_addr : =
0;
+	unsigned long res;
+
+	if (vrm->flags & MREMAP_FIXED)
+		map_flags |=3D MAP_FIXED;
+	if (vma->vm_flags & VM_MAYSHARE)
+		map_flags |=3D MAP_SHARED;
+
+	res =3D get_unmapped_area(vma->vm_file, new_addr, vrm->new_len, pgoff,
+				map_flags);
+	if (IS_ERR_VALUE(res))
+		return res;
+
+	vrm->new_addr =3D res;
+	return 0;
+}
+
 static unsigned long move_vma(struct vm_area_struct *vma,
 		unsigned long old_addr, unsigned long old_len,
 		unsigned long new_len, unsigned long new_addr,
@@ -860,18 +988,15 @@ static unsigned long move_vma(struct vm_area_struct=
 *vma,
  * resize_is_valid() - Ensure the vma can be resized to the new length a=
t the give
  * address.
  *
- * @vma: The vma to resize
- * @addr: The old address
- * @old_len: The current size
- * @new_len: The desired size
- * @flags: The vma flags
- *
  * Return 0 on success, error otherwise.
  */
-static int resize_is_valid(struct vm_area_struct *vma, unsigned long add=
r,
-	unsigned long old_len, unsigned long new_len, unsigned long flags)
+static int resize_is_valid(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *vma =3D vrm->vma;
+	unsigned long addr =3D vrm->addr;
+	unsigned long old_len =3D vrm->old_len;
+	unsigned long new_len =3D vrm->new_len;
 	unsigned long pgoff;
=20
 	/*
@@ -883,11 +1008,12 @@ static int resize_is_valid(struct vm_area_struct *=
vma, unsigned long addr,
 	 * behavior.  As a result, fail such attempts.
 	 */
 	if (!old_len && !(vma->vm_flags & (VM_SHARED | VM_MAYSHARE))) {
-		pr_warn_once("%s (%d): attempted to duplicate a private mapping with m=
remap.  This is not supported.\n", current->comm, current->pid);
+		pr_warn_once("%s (%d): attempted to duplicate a private mapping with m=
remap.  This is not supported.\n",
+			     current->comm, current->pid);
 		return -EINVAL;
 	}
=20
-	if ((flags & MREMAP_DONTUNMAP) &&
+	if ((vrm->flags & MREMAP_DONTUNMAP) &&
 			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
 		return -EINVAL;
=20
@@ -907,99 +1033,114 @@ static int resize_is_valid(struct vm_area_struct =
*vma, unsigned long addr,
 	if (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
 		return -EFAULT;
=20
-	if (!mlock_future_ok(mm, vma->vm_flags, new_len - old_len))
+	if (!mlock_future_ok(mm, vma->vm_flags, vrm->delta))
 		return -EAGAIN;
=20
-	if (!may_expand_vm(mm, vma->vm_flags,
-				(new_len - old_len) >> PAGE_SHIFT))
+	if (!may_expand_vm(mm, vma->vm_flags, vrm->delta >> PAGE_SHIFT))
 		return -ENOMEM;
=20
 	return 0;
 }
=20
 /*
- * mremap_to() - remap a vma to a new location
- * @addr: The old address
- * @old_len: The old size
- * @new_addr: The target address
- * @new_len: The new size
- * @locked: If the returned vma is locked (VM_LOCKED)
- * @flags: the mremap flags
- * @uf: The mremap userfaultfd context
- * @uf_unmap_early: The userfaultfd unmap early context
- * @uf_unmap: The userfaultfd unmap context
+ * The user has requested that the VMA be shrunk (i.e., old_len > new_le=
n), so
+ * execute this, optionally dropping the mmap lock when we do so.
  *
+ * In both cases this invalidates the VMA, however if we don't drop the =
lock,
+ * then load the correct VMA into vrm->vma afterwards.
+ */
+static unsigned long shrink_vma(struct vma_remap_struct *vrm,
+				bool drop_lock)
+{
+	struct mm_struct *mm =3D current->mm;
+	unsigned long unmap_start =3D vrm->addr + vrm->new_len;
+	unsigned long unmap_bytes =3D vrm->delta;
+	unsigned long res;
+	VMA_ITERATOR(vmi, mm, unmap_start);
+
+	VM_BUG_ON(vrm->remap_type !=3D MREMAP_SHRINK);
+
+	res =3D do_vmi_munmap(&vmi, mm, unmap_start, unmap_bytes,
+			    vrm->uf_unmap, drop_lock);
+	vrm->vma =3D NULL; /* Invalidated. */
+	if (res)
+		return res;
+
+	/*
+	 * If we've not dropped the lock, then we should reload the VMA to
+	 * replace the invalidated VMA with the one that may have now been
+	 * split.
+	 */
+	if (drop_lock)
+		vrm->mmap_locked =3D false;
+	else
+		vrm->vma =3D vma_lookup(mm, vrm->addr);
+
+	return 0;
+}
+
+/*
+ * mremap_to() - remap a vma to a new location.
  * Returns: The new address of the vma or an error.
  */
-static unsigned long mremap_to(unsigned long addr, unsigned long old_len=
,
-		unsigned long new_addr, unsigned long new_len, bool *locked,
-		unsigned long flags, struct vm_userfaultfd_ctx *uf,
-		struct list_head *uf_unmap_early,
-		struct list_head *uf_unmap)
+static unsigned long mremap_to(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma;
-	unsigned long ret;
-	unsigned long map_flags =3D 0;
+	unsigned long err;
=20
 	/* Is the new length or address silly? */
-	if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
+	if (vrm->new_len > TASK_SIZE ||
+	    vrm->new_addr > TASK_SIZE - vrm->new_len)
 		return -EINVAL;
=20
-	/* Ensure the old/new locations do not overlap. */
-	if (addr + old_len > new_addr && new_addr + new_len > addr)
+	if (vrm_overlaps(vrm))
 		return -EINVAL;
=20
-	if (flags & MREMAP_FIXED) {
+	if (vrm->flags & MREMAP_FIXED) {
 		/*
 		 * In mremap_to().
 		 * VMA is moved to dst address, and munmap dst first.
 		 * do_munmap will check if dst is sealed.
 		 */
-		ret =3D do_munmap(mm, new_addr, new_len, uf_unmap_early);
-		if (ret)
-			return ret;
-	}
+		err =3D do_munmap(mm, vrm->new_addr, vrm->new_len,
+				vrm->uf_unmap_early);
+		vrm->vma =3D NULL; /* Invalidated. */
+		if (err)
+			return err;
=20
-	if (old_len > new_len) {
-		ret =3D do_munmap(mm, addr+new_len, old_len - new_len, uf_unmap);
-		if (ret)
-			return ret;
-		old_len =3D new_len;
+		/*
+		 * If we remap a portion of a VMA elsewhere in the same VMA,
+		 * this can invalidate the old VMA and iterator. Reset.
+		 */
+		vrm->vma =3D vma_lookup(mm, vrm->addr);
 	}
=20
-	vma =3D vma_lookup(mm, addr);
-	if (!vma)
-		return -EFAULT;
+	if (vrm->remap_type =3D=3D MREMAP_SHRINK) {
+		err =3D shrink_vma(vrm, /* drop_lock=3D */false);
+		if (err)
+			return err;
=20
-	ret =3D resize_is_valid(vma, addr, old_len, new_len, flags);
-	if (ret)
-		return ret;
+		/* Set up for the move now shrink has been executed. */
+		vrm->old_len =3D vrm->new_len;
+	}
+
+	err =3D resize_is_valid(vrm);
+	if (err)
+		return err;
=20
 	/* MREMAP_DONTUNMAP expands by old_len since old_len =3D=3D new_len */
-	if (flags & MREMAP_DONTUNMAP &&
-		!may_expand_vm(mm, vma->vm_flags, old_len >> PAGE_SHIFT)) {
+	if (vrm->flags & MREMAP_DONTUNMAP &&
+		!may_expand_vm(mm, vrm->vma->vm_flags, vrm->old_len >> PAGE_SHIFT)) {
 		return -ENOMEM;
 	}
=20
-	if (flags & MREMAP_FIXED)
-		map_flags |=3D MAP_FIXED;
-
-	if (vma->vm_flags & VM_MAYSHARE)
-		map_flags |=3D MAP_SHARED;
-
-	ret =3D get_unmapped_area(vma->vm_file, new_addr, new_len, vma->vm_pgof=
f +
-				((addr - vma->vm_start) >> PAGE_SHIFT),
-				map_flags);
-	if (IS_ERR_VALUE(ret))
-		return ret;
-
-	/* We got a new mapping */
-	if (!(flags & MREMAP_FIXED))
-		new_addr =3D ret;
+	err =3D vrm_set_new_addr(vrm);
+	if (err)
+		return err;
=20
-	return move_vma(vma, addr, old_len, new_len, new_addr, locked, flags,
-			uf, uf_unmap);
+	return move_vma(vrm->vma, vrm->addr, vrm->old_len, vrm->new_len,
+			vrm->new_addr, &vrm->locked, vrm->flags,
+			vrm->uf, vrm->uf_unmap);
 }
=20
 static int vma_expandable(struct vm_area_struct *vma, unsigned long delt=
a)
@@ -1016,22 +1157,33 @@ static int vma_expandable(struct vm_area_struct *=
vma, unsigned long delta)
 	return 1;
 }
=20
-/* Do the mremap() flags require that the new_addr parameter be specifie=
d? */
-static bool implies_new_addr(unsigned long flags)
+/* Determine whether we are actually able to execute an in-place expansi=
on. */
+static bool vrm_can_expand_in_place(struct vma_remap_struct *vrm)
 {
-	return flags & (MREMAP_FIXED | MREMAP_DONTUNMAP);
+	/* Number of bytes from vrm->addr to end of VMA. */
+	unsigned long suffix_bytes =3D vrm->vma->vm_end - vrm->addr;
+
+	/* If end of range aligns to end of VMA, we can just expand in-place. *=
/
+	if (suffix_bytes !=3D vrm->old_len)
+		return false;
+
+	/* Check whether this is feasible. */
+	if (!vma_expandable(vrm->vma, vrm->delta))
+		return false;
+
+	return true;
 }
=20
 /*
  * Are the parameters passed to mremap() valid? If so return 0, otherwis=
e return
  * error.
  */
-static unsigned long check_mremap_params(unsigned long addr,
-					 unsigned long flags,
-					 unsigned long old_len,
-					 unsigned long new_len,
-					 unsigned long new_addr)
+static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
+
 {
+	unsigned long addr =3D vrm->addr;
+	unsigned long flags =3D vrm->flags;
+
 	/* Ensure no unexpected flag values. */
 	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
 		return -EINVAL;
@@ -1045,15 +1197,15 @@ static unsigned long check_mremap_params(unsigned=
 long addr,
 	 * for DOS-emu "duplicate shm area" thing. But
 	 * a zero new-len is nonsensical.
 	 */
-	if (!PAGE_ALIGN(new_len))
+	if (!PAGE_ALIGN(vrm->new_len))
 		return -EINVAL;
=20
 	/* Remainder of checks are for cases with specific new_addr. */
-	if (!implies_new_addr(flags))
+	if (!vrm_implies_new_addr(vrm))
 		return 0;
=20
 	/* The new address must be page-aligned. */
-	if (offset_in_page(new_addr))
+	if (offset_in_page(vrm->new_addr))
 		return -EINVAL;
=20
 	/* A fixed address implies a move. */
@@ -1061,7 +1213,7 @@ static unsigned long check_mremap_params(unsigned l=
ong addr,
 		return -EINVAL;
=20
 	/* MREMAP_DONTUNMAP does not allow resizing in the process. */
-	if (flags & MREMAP_DONTUNMAP && old_len !=3D new_len)
+	if (flags & MREMAP_DONTUNMAP && vrm->old_len !=3D vrm->new_len)
 		return -EINVAL;
=20
 	/*
@@ -1090,11 +1242,11 @@ static unsigned long check_mremap_params(unsigned=
 long addr,
  * If we discover the VMA is locked, update mm_struct statistics accordi=
ngly and
  * indicate so to the caller.
  */
-static unsigned long expand_vma_inplace(struct vm_area_struct *vma,
-					unsigned long delta, bool *locked)
+static unsigned long expand_vma_in_place(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm =3D current->mm;
-	long pages =3D delta >> PAGE_SHIFT;
+	long pages =3D vrm->delta >> PAGE_SHIFT;
+	struct vm_area_struct *vma =3D vrm->vma;
 	VMA_ITERATOR(vmi, mm, vma->vm_end);
 	long charged =3D 0;
=20
@@ -1114,7 +1266,7 @@ static unsigned long expand_vma_inplace(struct vm_a=
rea_struct *vma,
 	 * adjacent to the expanded vma and otherwise
 	 * compatible.
 	 */
-	vma =3D vma_merge_extend(&vmi, vma, delta);
+	vma =3D vrm->vma =3D vma_merge_extend(&vmi, vma, vrm->delta);
 	if (!vma) {
 		vm_unacct_memory(charged);
 		return -ENOMEM;
@@ -1123,42 +1275,34 @@ static unsigned long expand_vma_inplace(struct vm=
_area_struct *vma,
 	vm_stat_account(mm, vma->vm_flags, pages);
 	if (vma->vm_flags & VM_LOCKED) {
 		mm->locked_vm +=3D pages;
-		*locked =3D true;
+		vrm->locked =3D true;
 	}
=20
 	return 0;
 }
=20
-static bool align_hugetlb(struct vm_area_struct *vma,
-			  unsigned long addr,
-			  unsigned long new_addr,
-			  unsigned long *old_len_ptr,
-			  unsigned long *new_len_ptr,
-			  unsigned long *delta_ptr)
+static bool align_hugetlb(struct vma_remap_struct *vrm)
 {
-	unsigned long old_len =3D *old_len_ptr;
-	unsigned long new_len =3D *new_len_ptr;
-	struct hstate *h __maybe_unused =3D hstate_vma(vma);
+	struct hstate *h __maybe_unused =3D hstate_vma(vrm->vma);
=20
-	old_len =3D ALIGN(old_len, huge_page_size(h));
-	new_len =3D ALIGN(new_len, huge_page_size(h));
+	vrm->old_len =3D ALIGN(vrm->old_len, huge_page_size(h));
+	vrm->new_len =3D ALIGN(vrm->new_len, huge_page_size(h));
=20
 	/* addrs must be huge page aligned */
-	if (addr & ~huge_page_mask(h))
+	if (vrm->addr & ~huge_page_mask(h))
 		return false;
-	if (new_addr & ~huge_page_mask(h))
+	if (vrm->new_addr & ~huge_page_mask(h))
 		return false;
=20
 	/*
 	 * Don't allow remap expansion, because the underlying hugetlb
 	 * reservation is not yet capable to handle split reservation.
 	 */
-	if (new_len > old_len)
+	if (vrm->new_len > vrm->old_len)
 		return false;
=20
-	*old_len_ptr =3D old_len;
-	*new_len_ptr =3D new_len;
-	*delta_ptr =3D abs_diff(old_len, new_len);
+	vrm_set_delta(vrm);
+
 	return true;
 }
=20
@@ -1169,19 +1313,16 @@ static bool align_hugetlb(struct vm_area_struct *=
vma,
  * Try to do so in-place, if this fails, then move the VMA to a new loca=
tion to
  * action the change.
  */
-static unsigned long expand_vma(struct vm_area_struct *vma,
-				unsigned long addr, unsigned long old_len,
-				unsigned long new_len, unsigned long flags,
-				bool *locked_ptr, unsigned long *new_addr_ptr,
-				struct vm_userfaultfd_ctx *uf_ptr,
-				struct list_head *uf_unmap_ptr)
+static unsigned long expand_vma(struct vma_remap_struct *vrm)
 {
 	unsigned long err;
-	unsigned long map_flags;
-	unsigned long new_addr; /* We ignore any user-supplied one. */
-	pgoff_t pgoff;
+	struct vm_area_struct *vma =3D vrm->vma;
+	unsigned long addr =3D vrm->addr;
+	unsigned long old_len =3D vrm->old_len;
+	unsigned long new_len =3D vrm->new_len;
+	unsigned long flags =3D vrm->flags;
=20
-	err =3D resize_is_valid(vma, addr, old_len, new_len, flags);
+	err =3D resize_is_valid(vrm);
 	if (err)
 		return err;
=20
@@ -1189,10 +1330,9 @@ static unsigned long expand_vma(struct vm_area_str=
uct *vma,
 	 * [addr, old_len) spans precisely to the end of the VMA, so try to
 	 * expand it in-place.
 	 */
-	if (old_len =3D=3D vma->vm_end - addr &&
-	    vma_expandable(vma, new_len - old_len)) {
-		err =3D expand_vma_inplace(vma, new_len - old_len, locked_ptr);
-		if (IS_ERR_VALUE(err))
+	if (vrm_can_expand_in_place(vrm)) {
+		err =3D expand_vma_in_place(vrm);
+		if (err)
 			return err;
=20
 		/*
@@ -1200,8 +1340,8 @@ static unsigned long expand_vma(struct vm_area_stru=
ct *vma,
 		 * satisfy the expectation that mlock()'ing a VMA maintains all
 		 * of its pages in memory.
 		 */
-		if (*locked_ptr)
-			*new_addr_ptr =3D addr;
+		if (vrm->locked)
+			vrm->new_addr =3D addr;
=20
 		/* OK we're done! */
 		return addr;
@@ -1217,62 +1357,65 @@ static unsigned long expand_vma(struct vm_area_st=
ruct *vma,
 		return -ENOMEM;
=20
 	/* Find a new location to move the VMA to. */
-	map_flags =3D (vma->vm_flags & VM_MAYSHARE) ? MAP_SHARED : 0;
-	pgoff =3D vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
-	new_addr =3D get_unmapped_area(vma->vm_file, 0, new_len, pgoff, map_fla=
gs);
-	if (IS_ERR_VALUE(new_addr))
-		return new_addr;
-	*new_addr_ptr =3D new_addr;
+	err =3D vrm_set_new_addr(vrm);
+	if (err)
+		return err;
=20
-	return move_vma(vma, addr, old_len, new_len, new_addr,
-			locked_ptr, flags, uf_ptr, uf_unmap_ptr);
+	return move_vma(vma, addr, old_len, new_len, vrm->new_addr,
+			&vrm->locked, flags, vrm->uf, vrm->uf_unmap);
 }
=20
 /*
- * Expand (or shrink) an existing mapping, potentially moving it at the
- * same time (controlled by the MREMAP_MAYMOVE flag and available VM spa=
ce)
- *
- * MREMAP_FIXED option added 5-Dec-1999 by Benjamin LaHaise
- * This option implies MREMAP_MAYMOVE.
+ * Attempt to resize the VMA in-place, if we cannot, then move the VMA t=
o the
+ * first available address to perform the operation.
  */
-SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
-		unsigned long, new_len, unsigned long, flags,
-		unsigned long, new_addr)
+static unsigned long mremap_at(struct vma_remap_struct *vrm)
+{
+	unsigned long res;
+
+	switch (vrm->remap_type) {
+	case MREMAP_NO_RESIZE:
+		/* NO-OP CASE - resizing to the same size. */
+		return vrm->addr;
+	case MREMAP_SHRINK:
+		/*
+		 * SHRINK CASE. Can always be done in-place.
+		 *
+		 * Simply unmap the shrunken portion of the VMA. This does all
+		 * the needed commit accounting, and we indicate that the mmap
+		 * lock should be dropped.
+		 */
+		res =3D shrink_vma(vrm, /* drop_lock=3D */true);
+		if (res)
+			return res;
+
+		return vrm->addr;
+	case MREMAP_EXPAND:
+		return expand_vma(vrm);
+	}
+
+	BUG();
+}
+
+static unsigned long do_mremap(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
 	unsigned long ret;
-	unsigned long delta;
-	bool locked =3D false;
-	struct vm_userfaultfd_ctx uf =3D NULL_VM_UFFD_CTX;
-	LIST_HEAD(uf_unmap_early);
-	LIST_HEAD(uf_unmap);
=20
-	/*
-	 * There is a deliberate asymmetry here: we strip the pointer tag
-	 * from the old address but leave the new address alone. This is
-	 * for consistency with mmap(), where we prevent the creation of
-	 * aliasing mappings in userspace by leaving the tag bits of the
-	 * mapping address intact. A non-zero tag will cause the subsequent
-	 * range checks to reject the address as invalid.
-	 *
-	 * See Documentation/arch/arm64/tagged-address-abi.rst for more
-	 * information.
-	 */
-	addr =3D untagged_addr(addr);
-
-	ret =3D check_mremap_params(addr, flags, old_len, new_len, new_addr);
+	ret =3D check_mremap_params(vrm);
 	if (ret)
 		return ret;
=20
-	old_len =3D PAGE_ALIGN(old_len);
-	new_len =3D PAGE_ALIGN(new_len);
-	delta =3D abs_diff(old_len, new_len);
+	vrm->old_len =3D PAGE_ALIGN(vrm->old_len);
+	vrm->new_len =3D PAGE_ALIGN(vrm->new_len);
+	vrm_set_delta(vrm);
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
+	vrm->mmap_locked =3D true;
=20
-	vma =3D vma_lookup(mm, addr);
+	vma =3D vrm->vma =3D vma_lookup(mm, vrm->addr);
 	if (!vma) {
 		ret =3D -EFAULT;
 		goto out;
@@ -1285,62 +1428,68 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsi=
gned long, old_len,
 	}
=20
 	/* Align to hugetlb page size, if required. */
-	if (is_vm_hugetlb_page(vma) &&
-	    !align_hugetlb(vma, addr, new_addr, &old_len, &new_len, &delta)) {
+	if (is_vm_hugetlb_page(vma) && !align_hugetlb(vrm)) {
 		ret =3D -EINVAL;
 		goto out;
 	}
=20
-	/* Are we RELOCATING the VMA to a SPECIFIC address? */
-	if (implies_new_addr(flags)) {
-		ret =3D mremap_to(addr, old_len, new_addr, new_len,
-				&locked, flags, &uf, &uf_unmap_early,
-				&uf_unmap);
-		goto out;
-	}
+	vrm_set_remap_type(vrm);
=20
-	/*
-	 * From here on in we are only RESIZING the VMA, attempting to do so
-	 * in-place, moving the VMA if we cannot.
-	 */
+	/* Actually execute mremap. */
+	ret =3D vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
=20
-	/* NO-OP CASE - resizing to the same size. */
-	if (new_len =3D=3D old_len) {
-		ret =3D addr;
-		goto out;
-	}
-
-	/* SHRINK CASE. Can always be done in-place. */
-	if (new_len < old_len) {
-		VMA_ITERATOR(vmi, mm, addr + new_len);
+out:
+	if (vrm->mmap_locked) {
+		mmap_write_unlock(mm);
+		vrm->mmap_locked =3D false;
=20
-		/*
-		 * Simply unmap the shrunken portion of the VMA. This does all
-		 * the needed commit accounting, unlocking the mmap lock.
-		 */
-		ret =3D do_vmi_munmap(&vmi, mm, addr + new_len, delta,
-				    &uf_unmap, true);
-		if (ret)
-			goto out;
-
-		/* We succeeded, mmap lock released for us. */
-		ret =3D addr;
-		goto out_unlocked;
+		if (!offset_in_page(ret) && vrm->locked && vrm->new_len > vrm->old_len=
)
+			mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
 	}
=20
-	/* EXPAND case. We try to do in-place, if we can't, then we move it. */
-	ret =3D expand_vma(vma, addr, old_len, new_len, flags, &locked, &new_ad=
dr,
-			 &uf, &uf_unmap);
+	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
+	mremap_userfaultfd_complete(vrm->uf, vrm->addr, ret, vrm->old_len);
+	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
=20
-out:
-	if (offset_in_page(ret))
-		locked =3D false;
-	mmap_write_unlock(mm);
-	if (locked && new_len > old_len)
-		mm_populate(new_addr + old_len, delta);
-out_unlocked:
-	userfaultfd_unmap_complete(mm, &uf_unmap_early);
-	mremap_userfaultfd_complete(&uf, addr, ret, old_len);
-	userfaultfd_unmap_complete(mm, &uf_unmap);
 	return ret;
 }
+
+/*
+ * Expand (or shrink) an existing mapping, potentially moving it at the
+ * same time (controlled by the MREMAP_MAYMOVE flag and available VM spa=
ce)
+ *
+ * MREMAP_FIXED option added 5-Dec-1999 by Benjamin LaHaise
+ * This option implies MREMAP_MAYMOVE.
+ */
+SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
+		unsigned long, new_len, unsigned long, flags,
+		unsigned long, new_addr)
+{
+	struct vm_userfaultfd_ctx uf =3D NULL_VM_UFFD_CTX;
+	LIST_HEAD(uf_unmap_early);
+	LIST_HEAD(uf_unmap);
+	/*
+	 * There is a deliberate asymmetry here: we strip the pointer tag
+	 * from the old address but leave the new address alone. This is
+	 * for consistency with mmap(), where we prevent the creation of
+	 * aliasing mappings in userspace by leaving the tag bits of the
+	 * mapping address intact. A non-zero tag will cause the subsequent
+	 * range checks to reject the address as invalid.
+	 *
+	 * See Documentation/arch/arm64/tagged-address-abi.rst for more
+	 * information.
+	 */
+	struct vma_remap_struct vrm =3D {
+		.addr =3D untagged_addr(addr),
+		.old_len =3D old_len,
+		.new_len =3D new_len,
+		.flags =3D flags,
+		.new_addr =3D new_addr,
+
+		.uf =3D &uf,
+		.uf_unmap_early =3D &uf_unmap_early,
+		.uf_unmap =3D &uf_unmap,
+	};
+
+	return do_mremap(&vrm);
+}
--=20
2.48.1



