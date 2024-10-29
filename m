Return-Path: <linux-kernel+bounces-387462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA4C9B519A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3691F24116
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C2D1DD9A8;
	Tue, 29 Oct 2024 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kuxh+4lT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OOOwplpX"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845D418130D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 18:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730225544; cv=fail; b=hCxMsoe7cZ2DUUOaxERI5P0wPzn1hIdWGcpbXOplRqTBNsRtfn2CugsJdqMHFSc7pUYIzsAZxufBV0WOv1bRMRWpOL0XX/Z2DOWlZ1iEPpr3W2n3AYIGurzLUwBbhDD1v8nJRcLDrA/FgtLusNl87Wq6u3DblR/U8UOW8nPSjAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730225544; c=relaxed/simple;
	bh=h2P3JkMiubQxggNXYSNaT5fwzXIL7kAmG0PVGRl/PGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cg2oUfPqpVt8s2cJX0N+jwG4wv/X5SygIBFYyGZi+zZVoGziAFPqo5RFWavXtpNlCYkb4ZJ3gzCUgS7z+UBQoP0zm43rAEsNRZHgQ5bHThcoqSZSzQST5cAAAjYQuDRrrl4p6cEE+X4jgsCIU0L8bQG2dPkrsCXIrICiFuaMtUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Kuxh+4lT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OOOwplpX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TGfZMp028589;
	Tue, 29 Oct 2024 18:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=+QDEXsl2pFJid9vG
	F0AX0Oh1jFYKn/rHyMJJW7fRLbc=; b=Kuxh+4lTD1TIj03LLAThepiPnXV3nvTb
	777ajbolNL+IcpVLV30ISpO82tiagxOli12nReSUHSz6XvagPw4JwmuQmgER24CO
	mKOAZQj2WvS4xxxN8A3Ig+NCnDriJ9QEFfqPda1f1/5E4a333PwtL1Tza16iYXkL
	PGTwx/zKdmWDnxw3AqGuRoUJjh0K4AhjYTQGEAX+RD3ScwdaSJJlsEU8Za11ajz8
	wSOFsx8fr3BzAXEmAza7c5ERGojqLF9pB/huKUjnjpunAuqGxplDMZxELpwd7IQV
	5VukzhZIIpVYuZYEJtWYMlne5xHsD2/XViUMB1lMV5rRmYtVmZZGBQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdqe5wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 18:12:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TGwU0x008427;
	Tue, 29 Oct 2024 18:12:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnea1u2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 18:12:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvJSrVDmSTOE2GEqeZxW/DRAIDcRN5b839rx+JLHKrurJfSl2303o+AWSMlJrBpIG/e5hWQIILXhQxtZhazdxdznJtpFhqTnkTqRwKC/IxK/dV3lFii4TuuCD90dGe4oIqq7/cXQSHtgZCQsRvaKrggf/eqDRCxgu2uSCfZjViF2PCAnU1Aqnz5uOe7F9Wmvpe4xNdvGDhvxOunecHmbA8na4Jp6OLeyxNPAVphc6XjM8+AU2Bb96tlKB96poABtR8ZimDM5CanE9PfFfoUxp1H48pjCp5hIkm7yeG74/GGOCxMf4C2Siz69B/BMvifW4Fyr0Zgtq/hw9VRrby0zKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QDEXsl2pFJid9vGF0AX0Oh1jFYKn/rHyMJJW7fRLbc=;
 b=qZvUFDs7miSyJoyoCjoTgO3oVV2OMbsXgXQA9j2fJHC8Nbe2VOQOuknlr4trdbKx/ubIgbcIl5AMIZPXJFlRolKACtffK0dHNXdDSG5ljay1beZAaSokwrfXBVNwZ2EyLwqyAItK2j8usCoAtHpYht1ctp0j+BeijHEFoIWtIhXpeeopssG6b/NhIOtccM5B1vz5Q9/P80YNrNhWWJKy8WYRqdAqecixHGdXMUCMls9uhUX72RpxbUxhUTJoJEzh7MAl1BhYARGWhqcCIbL7fB6lUeNLrC8Ac3dgqNbcq7GSvMuvpGSt3u5e9+48Wv2b7L8fb6hGI1GE4KxUzF60tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QDEXsl2pFJid9vGF0AX0Oh1jFYKn/rHyMJJW7fRLbc=;
 b=OOOwplpX5/F750gyUHjXkM/G6rlIfw1r7ZYg/vEhS5hytIeQJe1vjXT4avT1BcdzSjfAdVSiR0Wjzz43Wr1WraVD5OIHPluON7hTtwnmp26tTVhAL9wu93EO2ulb7T7Q7mEKDc2GfuuvN6CY/V6+s55M8yO7Sqr8W9up+MfUAkQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB6966.namprd10.prod.outlook.com (2603:10b6:510:277::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 29 Oct
 2024 18:11:56 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 18:11:56 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH hotfix 6.12 v4 0/5] fix error handling in mmap_region() and refactor (hotfixes)
Date: Tue, 29 Oct 2024 18:11:43 +0000
Message-ID: <cover.1730224667.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0152.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::20) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: ea8d1005-96c4-4238-ecd5-08dcf8452c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hvBoKTp5iPFpXDM5XV74qhkA1n5qMl+KKGcXJdu7y8CubGxMMZRNk9bFG1K4?=
 =?us-ascii?Q?K5DMhoyhLGe3ywMRcL18sjN+kruoZVfoLCimZadHOkVYmtzjKaMsmWOMbWPB?=
 =?us-ascii?Q?/u+Ei/rsAS+Qx0U+5Vvd1plQ63mY9NB50BP+34nCh3HHFJwYPNrLkncvrtwe?=
 =?us-ascii?Q?eO40qnfzMdh0AqahN+dHsE7Zs2lMGgJWoVcIHtWSGMXjuUzYUbv2nMbamYFU?=
 =?us-ascii?Q?PqsKB6guoH2mwayTFz8n3w8r3i8UqfJVUvCylvb0XgNHdLuQLkBU4hb0eKGm?=
 =?us-ascii?Q?oFivJZCx2settWHELEZqJiWqwjodzpJmJyZHyMOk769UEunMKk0xsC1Xe8oW?=
 =?us-ascii?Q?zACMZ1AjENOK3AGXBtElljMz1RQvWViorFbhz7psh3JZVF6z4RcGHrGn6CIK?=
 =?us-ascii?Q?9OQhLpypIuskIsef1VZ6/diBoZie9PWADME+4ELPPGIpGAPoT/Kju7YkvYsb?=
 =?us-ascii?Q?yThjriXVWKSy7iilhi95WEnqYfXe8nQk+w2OpQRB3WeeozRDHy1wRbisx81H?=
 =?us-ascii?Q?OCUFg77s7cx0vos71J0m1FM+IU0HGReybCzHcpRD3tJdNxYpoeSM2gLIOzM9?=
 =?us-ascii?Q?9BEAWtlcQkidVLI0a7eN4EWmSvW1iqwZFxBpHBbs6vy/vNCvrZgr8+4WW42R?=
 =?us-ascii?Q?5/MmmN/rAP0fYTpJHcx8JD4I05ZCTrreF2YWnMBsU1G5fjIVv6vaLIVnRw6W?=
 =?us-ascii?Q?JQmdNqhSIS55jxWi0lBhzaeuMT91wQY8/WwPL1uvzzpOUI7gyVyxqpxe5/gd?=
 =?us-ascii?Q?H8EmRwJqPQxH7UcX0EwHWxz1Zi8tvkjokTL/nYx0MUVTs7gC0fsP15jJ6wiH?=
 =?us-ascii?Q?3ffDwXtBcOkLtxXb8k5Lqy9bBWNlem+vZ3Gw6hZnpzDnBC0qA1itnIX1JiTM?=
 =?us-ascii?Q?gM98ZY56V0pueYVPuKCzOf34vLvp2V9xmSeim1s1FCwb5HDS2exLJvn0Xley?=
 =?us-ascii?Q?0/BBpSr0Zq6FyDiwDyOdBN1Qt8/HFyhp396q3UIN8JepAFyC6C0BKKe2vKhO?=
 =?us-ascii?Q?J83pwirpoJQDRQ5+GfSknRTEXNGVs3R2TxiX/jokMj3zVpMJFqv1VDCrMWti?=
 =?us-ascii?Q?nFOQlQF4LRhCBSz5CRQhhwb5HAi1U+FQTjxHjlCTrkYqjeNJz2OVZo08zJ+h?=
 =?us-ascii?Q?Zew+fnZ0ZPAIhovhY3OhFF/zpbzO9Smu555T1r9ZAG+oSpr4n5LdQXgiCxMm?=
 =?us-ascii?Q?FYVSjGXjGgONyJ+0MIL3BZ+/hnQURiHlYua3ceosBQwYbrMgSSbaaohW7w+2?=
 =?us-ascii?Q?h9dBqcaVTje1Xah+LBa28bhZ3k78fJIcyohumQHbePgQud+GgqABPnBdrW8a?=
 =?us-ascii?Q?EyGyHnfzUTDim1SiTw95CPB6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qKlpM6KCKgscW27Baf5FcuXg7kG1AaGZ5iuvekuDMbs5YcJGbN+uHU5OAnY4?=
 =?us-ascii?Q?412cGSsxwcKmH9EnYOwgaAiyvPMetJ7h1+7YjsLhUuw16+y82Wl92KyQ4q2J?=
 =?us-ascii?Q?k0R/kvkMXFRug5nrJK1d6yLbzGvtlJbynve3CUEjUyQmWJ5oBCFRzMy7gWWT?=
 =?us-ascii?Q?a/y0iveICImx9hBxLuFfpPUh98qiTia5l+i61npV6L6KoFDhK/LE2MGXRRMo?=
 =?us-ascii?Q?bwAGdNHd87bbrQEPTL2YgHH7tEGmqePM8La+Ctl3BXK/coidrHkDJprQLD4H?=
 =?us-ascii?Q?LyTAs1dHOwNA/+cmsu+iSUDf1FKKFlYFgKajNtnhUO95kxJGBedpyaAHaAut?=
 =?us-ascii?Q?IJZ0mFVJxnOCPBMthyslQI2AgPSjIUKPQMEp920SdGcqkV8mvSdhJv05D+kQ?=
 =?us-ascii?Q?wrHbmErOxf/HZYH19LwZQxyfkkBp0R1R/+b/fxC7M0HGJ/415zSacqLLHgMp?=
 =?us-ascii?Q?1ABTwJJKe3b0E6TOK9snNwW7mCGGl4Q9JvXJPT9ewwUN2S9eoOTpIL1BVzBx?=
 =?us-ascii?Q?thBRCEHhHvwEKJcpgEHOCxWzh/aYJ0/e87/uln9tt8om9NCThvPL+jf5nN56?=
 =?us-ascii?Q?GM58DXIFInZm1XLrI/0CZfCxhSD3n2q9Z5ARRpUFG5iW1gIP3HWy/3dlr9bL?=
 =?us-ascii?Q?y9VlGHn0iXfBosg6hofZlgYtExiTTty5Qxhl8ICRYj6CDcq+VPYVshpY6B97?=
 =?us-ascii?Q?/z3Hd6yXVxtYsD+4RYIOzVtch6kQf9zTmxHyt56uJnrOYAMS9Yns7FqLI/id?=
 =?us-ascii?Q?PQvyiID6XDvZCDP74VtLwErYJHmYDQbhJCI23T7oM5CxeUnhmZswezxMinCM?=
 =?us-ascii?Q?RDnbJLhchZIKFCypD5rjksjaJW2fDLuRH8Gpa7egPVhwznmdBXzfYXjQiPoF?=
 =?us-ascii?Q?TfmsJJk4Rq3inK5e4tYNcZIQxNQto1dAs5R7L09VTuAWOfxCbrgg0iwp/qW8?=
 =?us-ascii?Q?DdxbJUmnKYUSHHc3BydH3u8E2gf2XRSJLMkW4EEiFiR3RQw16J2i/nWBuplz?=
 =?us-ascii?Q?6lW23f5pwNwdPUfm9ZSPSnA2T19G1FcoybVNDcis/ptRGXdbKr1uUfPa8MyN?=
 =?us-ascii?Q?c0l2jO2FdzNPaGebEiHhUNeUz67hPEUD+3HNSVcxMkAcjaJ3YKm88ge4nRC9?=
 =?us-ascii?Q?4NFsUHdncR87dwQrtT58F8jJ+24bC9ReR/de6NPtsVqyedrZQjM2U44W4XH0?=
 =?us-ascii?Q?8UCXRcdmlejKVcWcZtaDy2yyTJaF4zgLpPx6Wjr+0yt8erYqXTfXvOeKlpGm?=
 =?us-ascii?Q?ILtqZSjTXS+0qM4lHfJHdmUx7ezxLWtAxOI57Illwg4arLpU+R5dNu+N9Vdn?=
 =?us-ascii?Q?tvKUCkuRvmmv+ZSU12YgyDlIepTOqsi/ZGRXqVHocvGG33UA4Fxc5JW6heVz?=
 =?us-ascii?Q?ssuV5FZQwbZNYNvIOIXo+rkjRfAQwMV6hpe/I6FcWQyMD7vC1E2WJxuuqgSu?=
 =?us-ascii?Q?iTzzmdaHXqT5pBRPaE2/O++T5XaG9d1k/fZ/ptgm4h5KA8uk8kbqN3GElT+a?=
 =?us-ascii?Q?7d48Ix3wIS20lryVby91NXsDIVTzKye9i84lcTbKD8LHhvSndX0v8mtqoSfp?=
 =?us-ascii?Q?39bkhmgC2bp+qB90zPT916Jf2metDKnNdHNlrQASYFnxlePQe/2eLUToUNa3?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	36djGcIJC10gZDQQwaxvcvIdyJuFqD0DBHWUvnb3RgrHs/zWImpr3c8sw1sxiXnuDHj3OoRoc4YHrB64ABZB7/eBeeD9DKmNBfl4A6rIy5vDeGSXy3mgmXYheqOvwpweQiKX+94O62Ta2uDhWNjg+XJnO6YVWY7kZDpsDbaUNCZ58xIZcCHab8E0GhNhcqpsYrZWnPcGhbET17kAV3nW6gKDJzUaoSoLopVxxXy9WAwZGvEygjwwSxwweFWSm066XgeGZkVDU3P77fU/DxgRuxdoV4bjbG3UNnqq2DkSFoyZXaZlYpDdukRfAddl8GPxIO3HFp8z2VyDfFZ423vcy5jUE7SQDJHubGcVPF7iLUYrGSXlguL4vAfyRYxNHllEOIQIzgVInq2o4436IcuBiv+Dl9bkGtvuWSsVgpYXAUKBRWCZNxqYiRbY+VD/YKArbd3OWIF1Ka6nOSO5SKgJ7B5RXmg3Tc0X/yg3fvA/kbOMszC0B8cmIbEN+zlsJ0WjJSnI1BBicdLsHAOUpBDDQ+iEJ4gNro47bJeDBTpsoCiN6vlo5XzKi/z53w06seTJ48rxbwUTt6xnI1INJbrpw0xucrmJReOaHjIJvVEAtJY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8d1005-96c4-4238-ecd5-08dcf8452c53
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 18:11:56.3087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlqRaBFUS8CUiCg1TiP63v0IpeepRzNjgVjibbYBmuSRjF/98rVWJP12nUOEyM3vEQ1DcEcJeCT+r5gswwKfMo6q2DbDnVppKex9xZ0P28g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_13,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290136
X-Proofpoint-GUID: s8_tk-zgM3uss7jfvM5FqStNOfCcNzfL
X-Proofpoint-ORIG-GUID: s8_tk-zgM3uss7jfvM5FqStNOfCcNzfL

NOTE: This should be applied on mm-hotfixes-unstable in Andrew's mm tree as
      it relies on other pending hotfixes.

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

The patches in this series comprise the minimal changes required to resolve
existing issues in mmap_region() error handling, in order that they can be
hotfixed and backported. There is additionally a follow up series which
goes further, separated out from the v1 series and sent and updated
separately.

v4:
* Reworked solution to use arch_calc_vm_flag_bits() as suggested by
  Catalin. This also ensures we do not break MTE in a KVM scenario.

v3:
* Added correct handling for arm64 MTE which was otherwise broken, as
  reported by Mark Brown.
https://lore.kernel.org/all/cover.1730206735.git.lorenzo.stoakes@oracle.com/

v2:
* Marked first 4 patches as hotfixes, the rest as not.
* Improved comment in vma_close() as per Vlastimil.
* Updated hole byte count as per Jann.
* Updated comment in map_deny_write_exec() as per Jann.
* Dropped unnecessary vma_iter_free() as per Vlastimil, Liam.
* Corrected vms_abort_munmap_vmas() mistaken assumption about nr_pages as
  per Vlastimil.
* Changed order of initial checks in mmap_region() to avoid user-visible
  side effects as per Vlastimil, Liam.
* Corrected silly incorrect use of vma field.
* Various style corrects as per Liam.
* Fix horrid mistake with merge VMA, reworked the logic to avoid that
  nonsense altogether.
* Add fields to map state rather than using vmg fields to avoid
  confusion/risk of vmg state changing breaking things.
* Replaced last commit removing merge retry with one that retries the
  merge, only sanely.
https://lore.kernel.org/all/cover.1729715266.git.lorenzo.stoakes@oracle.com/

v1:
https://lore.kernel.org/all/cover.1729628198.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (5):
  mm: avoid unsafe VMA hook invocation when error arises on mmap hook
  mm: unconditionally close VMAs on error
  mm: refactor map_deny_write_exec()
  mm: refactor arch_calc_vm_flag_bits() and arm64 MTE handling
  mm: resolve faulty mmap_region() error path behaviour

 arch/arm64/include/asm/mman.h  |  10 ++-
 arch/parisc/include/asm/mman.h |   5 +-
 include/linux/mman.h           |  28 +++++--
 mm/internal.h                  |  45 ++++++++++++
 mm/mmap.c                      | 130 ++++++++++++++++++---------------
 mm/mprotect.c                  |   2 +-
 mm/nommu.c                     |   9 +--
 mm/shmem.c                     |   3 -
 mm/vma.c                       |  14 ++--
 mm/vma.h                       |   6 +-
 10 files changed, 159 insertions(+), 93 deletions(-)

--
2.47.0

