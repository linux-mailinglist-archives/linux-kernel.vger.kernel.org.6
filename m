Return-Path: <linux-kernel+bounces-556088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B29AA5C0C8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10D2176E1E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CB1221F03;
	Tue, 11 Mar 2025 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cdfk5AOc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ed5c+Aed"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F19221F24
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695485; cv=fail; b=VpD8kv7ppa7MDOB2ab3fzK76LZJTjOgvFUgCRxVgASOMaitMljlqfb6GkWf+lL8hTz+o2+Ky4fJkmniw4/hT7cNjhpOP+6sqe+n3eRwLWhBuxfCL2cUSy7rg1tpIhgQa0xWNUGNh2StOjzOkP8Uyhn34ddvqo8sFnSp5Nt59kFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695485; c=relaxed/simple;
	bh=lANkWR53OVk1R0qpRd+xs7ckSMHp+21Yxk6jh6Ruz0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XwtIwQ+COrLZg4fFOfTSz42JIXeujgdOZRu31yUzvZN6nUdoUpTsUdFCnb2z2PeMP9/p893286ToD2B0V6WOWqqxN3qTaZ2Qa7mR+9v3f6/HsF0/SwnwfEpY9XaHwWuHThL1HPF+eWPoie5R2Qu2frPioRMlE5um+ia5N0VAz7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cdfk5AOc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ed5c+Aed; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B1fp7f005577;
	Tue, 11 Mar 2025 12:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=HClfJapLw7ldkKt8/b
	cjeJzKe4Uf0FB5b+GRfNRkIJk=; b=Cdfk5AOc4M6m3AhBh+SfuOPifNA0q0Zhxq
	AUMwLyiWDzSYN8+NYPKCcwTrWPrJwRk5im0ZG2cP842/zeE2y1iG04/ocrU911+r
	wnwf9pBamxL1Z8usALd9uBovHpwBO9C4MFQdv7ekxHdHPgmoNRMvVTuBMvBGAEJ9
	yvFYkZrJY38Y8kAFh398f99MpO9iA7/9QhSWapV2g7gfiXSpQZisZXhzBt3/lkBz
	SHJlRvhQ6rjUghng6wlP9Y7oZXB2JmIs6vijRkOh2oamHuiLYtsjIQ7ILi/Zs0dd
	7ovRrIIvYoq7LKpv9smdXwiLn5E8TTIGTojUPAlyZkSQyvs/mxCQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458dxcmpgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 12:17:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52BAepsK015122;
	Tue, 11 Mar 2025 12:17:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458cbf7mrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 12:17:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szPtxIw90NQUbZhsr/A0mwu/NDRXwDe7IE+RGEJrD+zje2i/uA0KLU94kN8oeBXao2rKEaZOKo9ty9jhP3MNIUIDxMrUwlz+CV0Sijpi0Asx/xq0hmz+0/jU/KhMAZ+hx7w4vBK3z26JhHcBJ0tbM9WVnXabIVogeePXwhedjWEEA2Lj6TO1ULhOwbjVfb3/3uF47VL5dIOS31pZcbrPZzgmy/An3ClJPSNYjKjraLwj2y3qOKa/pkvHbO/V3Fopg5L/DCm4eFme080vNPji6jQjOsVjJXQMsARnqLuQCZfBh4Tzo0muxQCmWNfi+F+QKxDgcv7S76ofLTw8l0G1zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HClfJapLw7ldkKt8/bcjeJzKe4Uf0FB5b+GRfNRkIJk=;
 b=hn5h5wUownzfc8Inu+J1vQ5rwAm4GAEfzUowFtPAulmzrk6XQ/CgOtOkritrkfRTg/KeFTFfnXrCszEeXGzR2PQkIpqAoOkq+YNdwX7diy07pHIfxELjpYSm0dePPxbGcS9kP9YJLoXLT3hdmhORy5kO6dtnKsHiVZjFyOsTbXMUvuHSwNUfVqJT2V9aQt18valnC++gPCfyj470FBT4U8KQTIXcsTx0c2blOTgl9CRX0y8eO92zJKj94dJ9IdxrYSviaG0uJYgxNhZ8hQ8HQDFQLsVLFubKK87XinsrznYiJu/y60iMhh6/fzkDHvsHrAlhQ6gTj55s+95yt+uI9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HClfJapLw7ldkKt8/bcjeJzKe4Uf0FB5b+GRfNRkIJk=;
 b=ed5c+Aed/+YsoWEsHaIHWILusDBKXmFwMVyuz2YY8C4504KjJYUJZgWY092oAnWiSrvnvAmJzg0E4ijAjPZZbHLUQWbvJbAj+Bt/EoJeld6O4B4T/0vyR3mWeAuJ8Fu7CiXnhKRc1U81FDRa4GYLL7EvcktB8i+mX/HQyNhb37c=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by SA6PR10MB8064.namprd10.prod.outlook.com (2603:10b6:806:43c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 12:17:42 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Tue, 11 Mar 2025
 12:17:42 +0000
Date: Tue, 11 Mar 2025 12:17:40 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <howlett@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 5/9] mm/madvise: define and use madvise_behavior struct
 for madvise_do_behavior()
Message-ID: <cb48d187-6fa5-41f5-9fc9-3f424f105785@lucifer.local>
References: <20250310172318.653630-1-sj@kernel.org>
 <20250310172318.653630-6-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310172318.653630-6-sj@kernel.org>
X-ClientProxiedBy: LO4P123CA0397.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::6) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|SA6PR10MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f59da44-347a-4802-e4e8-08dd6096b8ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q3vHY5ww3AfOeL1UgH8j/9/pgCYJx5RDv+YRd69w5I8d1MHhe4yfLhF55SZj?=
 =?us-ascii?Q?P808LXzixJnqO1ybBPWtuOXSkRIfkEhNZ8v0uAq00piIUmN9BuBlmwVFThfJ?=
 =?us-ascii?Q?8D9NFwvrTsqIpUe+IXIVKIvHejG6kHc8uK/zqg/li2pZChh6XT2Y+DiiSRVv?=
 =?us-ascii?Q?hbmHCvh97HrCB/ZxOB2rhfwg4ndS67BplKRop+zCIAa596aPYtwqMsH2uxSu?=
 =?us-ascii?Q?eYuUimlGT3Yak3+qXeTkYClxm680We8rtoM5esxDNad88aVP1bfeITtOkpCf?=
 =?us-ascii?Q?gLLP4hV34TsF294JA/jWOSLLfPH5wR+UsCTZ9HVCTBP9enbt+BIdV99rRgbG?=
 =?us-ascii?Q?r0DU/Pl0qYLXsCkoHj3TEoQblI3ep2C7FZjFVFmmO1gNYupl4JkUuyHxCTEs?=
 =?us-ascii?Q?jM5jq3pQAyKbR8pORlnmVmexdoHxBDVpiFAY/NUm0seCMa6KMKFjT1KsLj6q?=
 =?us-ascii?Q?2gL5EkqpJq/lYSrjVyRykJolhURXZcxNBWQV5RIdNVDOX8Pmr2wPJaITGhhT?=
 =?us-ascii?Q?ypo9D9vQre2xOJQrQ61rE/t6HWiePGjBrn8Y5zgGAALPsCJ5WvvO8bEUa6T6?=
 =?us-ascii?Q?yhtn9JkFFKW5kWtN7viumCi9xpsyzbveYuJERWaJswWPjVYNmWWK4rGadpOr?=
 =?us-ascii?Q?M78MR1MbuJ1AfGjpdNvg5UCDfPkM9bvdaNA37Yh9jWbUaKcjobjYhJy0mhMX?=
 =?us-ascii?Q?RBqgYjorLBG+Cs3tJIpSxfdm5GzLk9UWUqiyQyzkeCG3/3MKXzC7/6wtfln4?=
 =?us-ascii?Q?isFVSODJoCU4nQ20RV7TjLKTLkGiuLpw673WqzpFUbexj8VlF6XHXAVi0N/C?=
 =?us-ascii?Q?XV7jNrWtlYmI0z/wEvP6VUvJMMqSfAYDklPpZPj6FxIgpsUNCiIyEc0E8k4I?=
 =?us-ascii?Q?sg39FvVgingz1PSqxTo0/YnyqctsEW15sIaTglbGpUmLHQrMCcVXVxjzX3Rg?=
 =?us-ascii?Q?SX2zED9w96zAYLPicXUMXiQp3EP+lFlaMNaHuRoTGiIj5H4A/BypE3Th9V7D?=
 =?us-ascii?Q?A/9thdWUrF5EJzkSPKvTbgwJTD8PPAgODuQwaXUpx7r+N6uTGxw2VCXyKIDy?=
 =?us-ascii?Q?JxOW9yf79RAzqR2GdzRyRJvZ02mwBgfGvdi3qgGQ9z1uj823FFGNj6k/VlJm?=
 =?us-ascii?Q?fwaP6A9CmHwo/5DvPykeRGYYUI9g9vjo2ZQxaa470chn8Gr4v37Cz8kaE0S7?=
 =?us-ascii?Q?kkw4l+k5O2kxzSyrHg5YJ5jJms9XyGJYOB76HTfg2VZqtbf/Mkqqur046cir?=
 =?us-ascii?Q?2fGtaxy7YkQvQUQy87bEtgR249L6xBaYlVYUYzpo+kM7SKoHxeawpVEEgFd6?=
 =?us-ascii?Q?60+IayW9Pqb0WcSAhMlvLlaUbPP2FWbfCPF6NqPH0CVqMABJuTqQ9XnbJ4VI?=
 =?us-ascii?Q?/hCtXNEZPcolV+K1lKwD3DMXR2h1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yxsZeHI3LdrAvCJgsipqGH4q4qf7vdgR7Z9xIN+WMb7fSHgXVXaGti5/ubOd?=
 =?us-ascii?Q?dxIJEOtCoaYJH1ZoCz1udpqy8V+5EFiE/bfNgyuSwYbcanBT+g0GPUwhZxtC?=
 =?us-ascii?Q?/YbVHT1SpmOx/XR3GTnVCCgFdsxuId1n17UOhdEBcKGYGvaBCgwVTeVaTCKf?=
 =?us-ascii?Q?Fmth87ZdxebrwNd0T7J4Ks0mV1P4YBRa7EX2k+nIuU13nf//s08X7cCDtvjh?=
 =?us-ascii?Q?gDmoFY7iRgXu5NPIhzKHfx6skAaiOEZwV/iMzx3f5GtUIEHaJ9R4InKcj64Q?=
 =?us-ascii?Q?HsCxnTSCz3ncCK8Tfnrzn7JAbFsdza0YoU9Zi0WAxvH1kYRl8ojG0OLAooFT?=
 =?us-ascii?Q?x1E28u9/nOp64bFiJusrSTwY+qjK1bpkne9v0Ozk49f4fISkH0EAZ69eXM7y?=
 =?us-ascii?Q?vGblg8bBnj8pyQm0R8sNuX9G76cmuOB6bFVRqLtQT8vheOjfqkQuX0mzVoc/?=
 =?us-ascii?Q?N4KLIJ72gF6TjqfBimvWKnTUs4ukq+5X0YX/KXPwVZFCZiW9DCUrHsyeCiQW?=
 =?us-ascii?Q?Du0NO8OJHLTEWAiJ0DIcd8VetCTa1Q+qFq0BpYV6JLksBYQrv6dlCJc+Wss9?=
 =?us-ascii?Q?4oYQ+mMzivsTYfyDslA+mbOe6lpbv5bQ583ex4b/xU38yWaOktTiNdDWwgze?=
 =?us-ascii?Q?HAIWXs8D5muLgJRBSZPlBCJyZlMKIwRvQpXlmG6jV+96zGhJfDltm29J29t4?=
 =?us-ascii?Q?lqVwcXkN5CG5x+jI0aDWaRqrA03MK2pIDrNhQC76uXq+ZGhsc22pkUtjzZVT?=
 =?us-ascii?Q?W59PS2QuFsmsOet20Oq2c2M0OxC8mxphyyneH/yjF/kvmZJSJj0xonBahivC?=
 =?us-ascii?Q?SjFOgCM1nFiisotMxZaNQEMjsn9eIfblqYvOcQUDuYcO7PhgG+6id58CPthI?=
 =?us-ascii?Q?pdmv667ApSqw14sSKlqK//QRg5w52YmcECNGdsbSYRoAij7VlKNVMPW4EMaO?=
 =?us-ascii?Q?31e1G0yoqBpfUjhWza8kJyvwfBkOwbn+hPjuVNTC2uVed6ahPQxKeTr+NWSE?=
 =?us-ascii?Q?pSHp3gMQ++FSjMTt3Vz3Lm+UATHby2K2ijVWeW3OhnWL3SGdyXeL/g0Wb33J?=
 =?us-ascii?Q?hMWu1JYwDU8OrbvqZBOnieaGlH/v9OxcQhUlSGhgqSHFRGDMqn6rijgICOoO?=
 =?us-ascii?Q?5Za9V7DZk80fI27lMIRne4hNt/5HJFxafe5pAcjOBySZCOfxKNHEhwLg3Ox/?=
 =?us-ascii?Q?7oHnPlUOcpUyzqVefpsNXcctpsrCzNAQnG/Sp2qtR5No4/fQEuhX//r1qOKs?=
 =?us-ascii?Q?1xXed8l5l6umclvjAer7JJ8VdhcInk98+8RS0O3a+WOsEdtkHyhYoW9GrD9Q?=
 =?us-ascii?Q?KTsL/mTH6NVW5Ac+yIUfIqnd6RuyDEL4mhxjhUQJ7KXKmpknfRLKN95cDED6?=
 =?us-ascii?Q?0Owu77gTsim+MpCtI39vZwDaGnJshLGq8rXvA1AFvWKkdpt7OUWLtktvCTiz?=
 =?us-ascii?Q?BzpPbf90v4+5MXs7JDD06MI9/9vL8swFuWAb35QQik0RXh23kzBZ/RC5qtAX?=
 =?us-ascii?Q?O5jYB1hsaaQedBIQZGi6ChjibJstdMUsBJdzXZvf/T9lSONAhvAoCmBAUedD?=
 =?us-ascii?Q?fWXLDExVamdVURyPWF3NRs7xJ/i/BF7T+vBjtmbh/M32vEKwrR/XfH8jI2vX?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BF6tMOVv5VyoWHNvH0txkJU74bIlT+aSnQaCLt+7QIyBy9waAjdVLeirQD4YXF+mT5eErQUmRaICPI9Kd1wIatmVStZlWzPG2YrmVocp9B5Saf7EMI7HFtsT/P/9Ho2uEV6sWS9rEsOQMJ74kzRzmSo6j/Lt1f2m8GrbuYoaq/5uso24aeUtxBQA5Id2/vew3KHWeeK3eIhx0u3Yyb9LW23NNdknZUJXleKQw4gy4ZfvRbHzZUz0uFeEXbxvUr1/sXzJQRLPAZsnH4JPfKFDdZZmPJ42Qa/0YE/SZOv8tWwe0VRsJLHGDxZZTUwJDWia5v7F8Ut1dX1LPR0pT7jPy+oRuKItUi5dQAi77CJhbopxKXWgVR0drTNN3RrjdzEyvv2gMLMbNs4G3eQCvLch/bEHfv9gfmk678vvLb/0na1Coa8sgYcJGGZxHQKl95h2nTzVcfdCND/w0Ov/s3A/4DKo9sfpdV5PPLGELefKOgc/cNWn9EVlrCEP7NUISdpbSoelOzPGycn6kCyR3lw/qh4jKq/WFZ3Er2xgHhuD1MBVmboO/GWpITpVUTaeGu2X9sdVOFMAY6RLZ4pLawEStAO4MFaLMrOyr3wgQTF5Yks=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f59da44-347a-4802-e4e8-08dd6096b8ee
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 12:17:42.2244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfWsq/WBmCxzFc3qLecenTKbYsBpB4f96q1O7p2lQ3NwW1SFctONs4aAusp9QCU65mydIJLxl7ERGbx30gs4cEhimxsXCuauGfOOyIuySwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8064
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_02,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110079
X-Proofpoint-ORIG-GUID: fY_LqduFOfjcRY6Upcd2-xydwZV8oIJV
X-Proofpoint-GUID: fY_LqduFOfjcRY6Upcd2-xydwZV8oIJV

On Mon, Mar 10, 2025 at 10:23:14AM -0700, SeongJae Park wrote:
> To implement batched tlb flushes for MADV_DONTNEED[_LOCKED] and
> MADV_FREE, an mmu_gather object in addition to the behavior integer need
> to be passed to the internal logics.  Using a struct can make it easy
> without increasing the number of parameters of all code paths towards
> the internal logic.  Define a struct for the purpose and use it on the
> code path that starts from madvise_do_behavior() and ends on
> madvise_dontneed_free().

Oh a helper struct! I like these!

Nitty but...

I wonder if we should just add the the mmu_gather field immediately even if
it isn't used yet?

Also I feel like this patch and 6 should be swapped around, as you are
laying the groundwork here for patch 7 but then doing something unrelated
in 6, unless I'm missing something.

Also maybe add a bit in commit msg about changing the madvise_walk_vmas()
visitor type signature (I wonder if that'd be better as a typedef tbh?)

However, this change looks fine aside from nits (and you know, helper
struct and I'm sold obviously ;) so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/madvise.c | 36 ++++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 12 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 469c25690a0e..ba2a78795207 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -890,11 +890,16 @@ static bool madvise_dontneed_free_valid_vma(struct vm_area_struct *vma,
>  	return true;
>  }
>
> +struct madvise_behavior {
> +	int behavior;
> +};
> +
>  static long madvise_dontneed_free(struct vm_area_struct *vma,
>  				  struct vm_area_struct **prev,
>  				  unsigned long start, unsigned long end,
> -				  int behavior)
> +				  struct madvise_behavior *madv_behavior)

Nitty, but not sure about the need for 'madv_' here. I think keeping this as
'behavior' is fine, as the type is very clear.

>  {
> +	int behavior = madv_behavior->behavior;
>  	struct mm_struct *mm = vma->vm_mm;
>
>  	*prev = vma;
> @@ -1249,8 +1254,10 @@ static long madvise_guard_remove(struct vm_area_struct *vma,
>  static int madvise_vma_behavior(struct vm_area_struct *vma,
>  				struct vm_area_struct **prev,
>  				unsigned long start, unsigned long end,
> -				unsigned long behavior)
> +				void *behavior_arg)
>  {
> +	struct madvise_behavior *arg = behavior_arg;
> +	int behavior = arg->behavior;
>  	int error;
>  	struct anon_vma_name *anon_name;
>  	unsigned long new_flags = vma->vm_flags;
> @@ -1270,7 +1277,7 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
>  	case MADV_FREE:
>  	case MADV_DONTNEED:
>  	case MADV_DONTNEED_LOCKED:
> -		return madvise_dontneed_free(vma, prev, start, end, behavior);
> +		return madvise_dontneed_free(vma, prev, start, end, arg);
>  	case MADV_NORMAL:
>  		new_flags = new_flags & ~VM_RAND_READ & ~VM_SEQ_READ;
>  		break;
> @@ -1487,10 +1494,10 @@ static bool process_madvise_remote_valid(int behavior)
>   */
>  static
>  int madvise_walk_vmas(struct mm_struct *mm, unsigned long start,
> -		      unsigned long end, unsigned long arg,
> +		      unsigned long end, void *arg,
>  		      int (*visit)(struct vm_area_struct *vma,
>  				   struct vm_area_struct **prev, unsigned long start,
> -				   unsigned long end, unsigned long arg))
> +				   unsigned long end, void *arg))
>  {
>  	struct vm_area_struct *vma;
>  	struct vm_area_struct *prev;
> @@ -1548,7 +1555,7 @@ int madvise_walk_vmas(struct mm_struct *mm, unsigned long start,
>  static int madvise_vma_anon_name(struct vm_area_struct *vma,
>  				 struct vm_area_struct **prev,
>  				 unsigned long start, unsigned long end,
> -				 unsigned long anon_name)
> +				 void *anon_name)
>  {
>  	int error;
>
> @@ -1557,7 +1564,7 @@ static int madvise_vma_anon_name(struct vm_area_struct *vma,
>  		return -EBADF;
>
>  	error = madvise_update_vma(vma, prev, start, end, vma->vm_flags,
> -				   (struct anon_vma_name *)anon_name);
> +				   anon_name);
>
>  	/*
>  	 * madvise() returns EAGAIN if kernel resources, such as
> @@ -1589,7 +1596,7 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
>  	if (end == start)
>  		return 0;
>
> -	return madvise_walk_vmas(mm, start, end, (unsigned long)anon_name,
> +	return madvise_walk_vmas(mm, start, end, anon_name,
>  				 madvise_vma_anon_name);
>  }
>  #endif /* CONFIG_ANON_VMA_NAME */
> @@ -1673,8 +1680,10 @@ static bool is_madvise_populate(int behavior)
>  }
>
>  static int madvise_do_behavior(struct mm_struct *mm,
> -		unsigned long start, size_t len_in, int behavior)
> +		unsigned long start, size_t len_in,
> +		struct madvise_behavior *madv_behavior)
>  {
> +	int behavior = madv_behavior->behavior;
>  	struct blk_plug plug;
>  	unsigned long end;
>  	int error;
> @@ -1688,7 +1697,7 @@ static int madvise_do_behavior(struct mm_struct *mm,
>  	if (is_madvise_populate(behavior))
>  		error = madvise_populate(mm, start, end, behavior);
>  	else
> -		error = madvise_walk_vmas(mm, start, end, behavior,
> +		error = madvise_walk_vmas(mm, start, end, madv_behavior,
>  					  madvise_vma_behavior);
>  	blk_finish_plug(&plug);
>  	return error;
> @@ -1769,13 +1778,14 @@ static int madvise_do_behavior(struct mm_struct *mm,
>  int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior)
>  {
>  	int error;
> +	struct madvise_behavior madv_behavior = {.behavior = behavior};
>
>  	if (madvise_should_skip(start, len_in, behavior, &error))
>  		return error;
>  	error = madvise_lock(mm, behavior);
>  	if (error)
>  		return error;
> -	error = madvise_do_behavior(mm, start, len_in, behavior);
> +	error = madvise_do_behavior(mm, start, len_in, &madv_behavior);
>  	madvise_unlock(mm, behavior);
>
>  	return error;
> @@ -1792,6 +1802,7 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
>  {
>  	ssize_t ret = 0;
>  	size_t total_len;
> +	struct madvise_behavior madv_behavior = {.behavior = behavior};
>
>  	total_len = iov_iter_count(iter);
>
> @@ -1807,7 +1818,8 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
>  		if (madvise_should_skip(start, len_in, behavior, &error))
>  			ret = error;
>  		else
> -			ret = madvise_do_behavior(mm, start, len_in, behavior);
> +			ret = madvise_do_behavior(mm, start, len_in,
> +					&madv_behavior);
>  		/*
>  		 * An madvise operation is attempting to restart the syscall,
>  		 * but we cannot proceed as it would not be correct to repeat
> --
> 2.39.5

