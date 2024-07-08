Return-Path: <linux-kernel+bounces-244924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA85792AB8B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 23:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7831C218ED
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E8E14F138;
	Mon,  8 Jul 2024 21:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NjkJg/jx"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D4B14F11C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 21:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720475902; cv=fail; b=F7OjRzGDDzK93jcnEfsUcpXsXkVv0I5VyicoS+zXD4DnUxgUHvN/n8IXI+K1dt/nSf7IVzds0mY6LipieGWei4QiEFfIqI2SbSVIypPyMg/kMYrtDbj+wHdr2Fe5lhcVTB1WBlcenU+cTw/hqPmkYuxZa46oG1imz/OOTfDtgC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720475902; c=relaxed/simple;
	bh=bDY1yuwNCGPuoZ7Gxw3Da4Jg1p71OzBjCer0+Thg6d4=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=UlzxIRwtzdvSRkefurOlpWaRGhwN1OWChHaoLV5WhMWrN/a1AlZjhQWpi4BbjJp1xtQD0yw5uWC32z3hgcuLBy9vY9gvEt3BgMx8rIlSIqGDLJZPPFM5yrlta5we7nQOkkpbrD9gVxNSya8lcHN3Fe0P7NrVLeckszxTcdCrorg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NjkJg/jx; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlHbCfKtis36b6S+gTkkM45MtziXBzABbJ/SoArYY93QeHkp8QcjrDCJf3z21QzqTiPSP3uWVkfZ7i452siVGBpaiaA+kBsHAnu4dKd1AKmkJXB/ZLragVchM2Q6mwsvmq0D3GADIFmSpF8/xbsF779r5Tgbbq9gm8TqLHccRt610DCv3c+LSFMmK4T7kKZ56Jle5iqcGHdiv/LoiPDXY56m841y0ghVmpCVNWSk74d7HnxYLsnTm2qcgpEV8GmChExjcQaMXYLo30YjjB2x2O308lGtmMXSMnHq2oHAxir1qS6xSJw6i4Rn7Xj8CKGUthn6ujizX2YruoKnCuYeMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ev3soCYbqs5+lIdXe8x6EfgQY+zuL8WDAIxyoBbsR8=;
 b=Tq9sDcnCq8/BmcXj3LUy1OnZv+9LlHa+FwbU1NzUqatG7OOgXWtoQwxdKAgjWUB2ulnPInktdkqSJr6ZjGbswRZBnyk8Uxi2d16xGV+eDTcbyczB3zqgp/smeKg3PoltdTZrUTw6g/Mbb9zgSMxD757BFLzzPuRZNirIfL56srOPn3b3cUOIGKsVkTZFRWzQonCc+iPVTqZOK6ONqDxFBXzEVpHuaofiT8wlLsGTCSlD+IAM2RFZkUDdEnkUjSFjJlELPAQ954z8DJ4EYsG4mikjef29dt/SRd7g1f8hgQXHNhkpJrey9h2l4dfZA106bYUPkECGJc5l/VVbb0qouw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ev3soCYbqs5+lIdXe8x6EfgQY+zuL8WDAIxyoBbsR8=;
 b=NjkJg/jxbB9+ZFb/gl6Q2m/mDbLdC8KDjTy0cmgVAI+31O3h9kPr0JAW6RMdsuMY1ki67EdKSvTz6o9tnNJi+ESF8eOgtKQD/3n9YiE4zwXy3VtdJV9VVHOU7FAYLRX6kXv14QUCGhot3/EkrRx0BszcyzkQlKNYe3zkKtMgiDdFMQUrlT8+Txh8iLwLkgKDpPIgin+BhaMRItgWmwyZQ1BczGvjMvNEGDCk1Q6Dug5Rrwn75+kQbFBXetiCkHrx1WvutXUaa8NnrS05qwHzG50V4EOmV1BP0FAncUMLkWik1WJ3I9PFkz4hdZ05oyFdBpGOagPtmo0FwSHtqr1gSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 by SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 21:58:15 +0000
Received: from BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::afc:1e4b:7af6:115c]) by BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::afc:1e4b:7af6:115c%5]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 21:58:15 +0000
Content-Type: multipart/signed;
 boundary=a4e0b808739889c0ad3421c8338e2d1b4189d9e85860bf7aefa565ddb90d;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 08 Jul 2024 17:58:14 -0400
Message-Id: <D2KHSYKMJEYO.2EY10FZM8H2YM@nvidia.com>
Subject: Re: [PATCH] mm/migrate: Putback split folios when numa hint
 migration fails
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Yang Shi"
 <shy828301@gmail.com>, "Hugh Dickins" <hughd@google.com>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, "Huang Ying" <ying.huang@intel.com>,
 "David Hildenbrand" <david@redhat.com>
To: "Peter Xu" <peterx@redhat.com>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.17.0
References: <20240708215537.2630610-1-peterx@redhat.com>
In-Reply-To: <20240708215537.2630610-1-peterx@redhat.com>
X-ClientProxiedBy: MN2PR08CA0021.namprd08.prod.outlook.com
 (2603:10b6:208:239::26) To BL1PR12MB5730.namprd12.prod.outlook.com
 (2603:10b6:208:385::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5730:EE_|SN7PR12MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: 08f051bf-c7a1-4e60-3b41-08dc9f991199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azB3WlBVckptR0lkZlhOcjFOVnpoS216eldTK2dRLzU1VS9GNDZlN2RTWWhH?=
 =?utf-8?B?OVIwRlpLeXZ2SWVSaTNXWk1lU2NOaDY0YTRnbXJCZWFEVlFHQTFBQkxtb3BD?=
 =?utf-8?B?ZTBpNnFUQWE5UTNLL1VjTm9lTXZEQlJtOVVTUU5NeXcxZEtjRVM4QU5TQjR2?=
 =?utf-8?B?K2FmZkdBaUxYdzJLaE1oV21waHFBdDFZcU4wUU5LRTVNYXNDa3VpSHAzQklC?=
 =?utf-8?B?amM0LzBJNWFnMC93UE9SNHB3MlZHeGYwaVJudlFjMlhsUm5NMVBUb05yNnBy?=
 =?utf-8?B?L1N4b09GNkZUakdYWHZnOEtGU0diR1daRjlmYmVjc3lJVXo4QVBvT3NKRjFs?=
 =?utf-8?B?d216ejU5bHFJdUVYN2d2ZWlORVZvY2o4QmZ3SEwwdnR6YWMxZzA0T0lGaWFs?=
 =?utf-8?B?ZGZYOEZJaFJ0eWJGY1I2VkFmQmYwckQ3a3ZTM290cndnRm5uVktOdlFZT2hk?=
 =?utf-8?B?QWF1dUlkVzNKL0xNZVlNQ2FRNnFQWDhXa3NKNzRQTWUwL1pWQWs2TU1kNlVs?=
 =?utf-8?B?NFVxZ0NnRy83anJPbElDVEpMcXA2ZHZsUXZJM25QYW5WQ2k3dW10cnlJOS80?=
 =?utf-8?B?T2puL25ycUUwb1VUOVljRWdFT1NZMkRteFFHdDNGeEVVNHdTN0JuZjBpR3BQ?=
 =?utf-8?B?eXJja1cyUENycHgwcGZTNzJpUG1yRzJjSUNwT3BWTXdmY21DS2JodG1GZHRW?=
 =?utf-8?B?TFBXRmFYNlZnaDIraGNrUUgrYVhoZUx2TTcvbVVTZ2dMMGRIbHJoUzZTc2Uw?=
 =?utf-8?B?K3Vrc1FCVWNPU3dybUJSejFQVkpWZ3J1Ry8wVTM1TG1Qdml0RE16ZTk2UWtm?=
 =?utf-8?B?TW1HdFJzamZ0MFhmeXV3Y2ZsSzlmKzNhRnBuSURmS0N3dEM5SElzNy9ZZHBi?=
 =?utf-8?B?dUJhOXdkUlJmZFZycEJlWnVRMTdrN01ubStJbll5N1E0amgzUVBFLzF4bXpY?=
 =?utf-8?B?QUs3ZW43NEhPU01KUEx2d29yTjNVMVQwd0R1alR5cFg5VlY2ejUrbjlaa3lY?=
 =?utf-8?B?UndYa0hwRHlqa0NxOXZxKzdVRGhNUUVPQ3lES1FPN3FkU01Wd09ma2VzK2Nn?=
 =?utf-8?B?Z1RuWVBjVlYxSEdLNCtDeWlGc2c4cnh1elYxTWpvMm5teTJqeUJZMUxyNWJv?=
 =?utf-8?B?b0ExdklwZ2dLaFdFUENCU1p5STJnM0R4TDhMZm5OTi8rMElhaEtFbVVaellz?=
 =?utf-8?B?bmhzRlQwKy9Gb29Jd29sMVRCd0dOTUdOcUZyQk9yS1VDNk9Jc09INXlINVhn?=
 =?utf-8?B?VXJrV1E3dTF2Mlc0NWJRMDIwQ0NMd2Zja0xzUDI2NnArSjR5NmV5RzZZVWlu?=
 =?utf-8?B?SHBDdWZKb2NLaHJhbXoyN0d6Q21KaXJBRndvaFZRa3pVeERVWjVpV29CcGlO?=
 =?utf-8?B?M3BsNUYzdVFBV3dzMVNmRlBJOVBvNjF4ZGdRMWQwQW8wYnZwUkllTTErL3Z6?=
 =?utf-8?B?Z2NQMmxiNXliV1BzRGxYeUFyT0srclAyWnZkR3RXTWJmWWtTN25TQ2drNXFt?=
 =?utf-8?B?dTMwckNXZVNaYlEwbGxHQmFIQ0dxb245OHY1ZW1jSFgwajF5OWpHdW5vMVNT?=
 =?utf-8?B?dkhMelE5TVV4VkRMdjdmR1lSQkJoemRFNi8rQTFKWEtndzNzRGpmd2xjckUw?=
 =?utf-8?B?aGNsaklwRmMxdTh3aHE0R1pXcnBLWGUvU0RRYXM2UG1rQXpKa2kvcjREbmRm?=
 =?utf-8?B?UXd2WnQ0K2xvUGZiUmFrZVladjN6cXFmK0JVQVJORG1leE4yckgxUDN2VUtz?=
 =?utf-8?B?Uk04b1FpendYVDYwNjVpckJ4Qmtyemcxc2xMS0tYQkkzbzA4L1FJVUJMY3V4?=
 =?utf-8?Q?vOkUiy2sHVlxmA+rBETGhIT+1fOwsQioagmvc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUIrR1VQSGZ3Q0t4OThmOGR6VUVYdUpTYjZsdk9QakQ3ekRCOW10Tm1reDNr?=
 =?utf-8?B?ajlDbzh0NnVhdlhqc3NEMjZkaCtzRXQyNEEzSnhNYnZST0s2dXp3VmxOMEhG?=
 =?utf-8?B?UGFMTDBTbko4VzlDME5FZFNFY0VYdDc4dnlVYm9XaFZhM0ovbXhmcUxscUxI?=
 =?utf-8?B?SWJib2grYWJabTJYTFhseFJYTHg3OHZnL2tIWUZSWmxUTVF2cGFDYjc2U2dh?=
 =?utf-8?B?UEpVNHhXV3h2Y0I0N0J1QVRwdUlickNjRldFMXlJUWZ3SEV2VDFCSTlXbEFF?=
 =?utf-8?B?eEFxOFNwaDUycTFaVWViUWVRWm4wOWVSUW53YU04bjBNaS84YnQwK25QWVBE?=
 =?utf-8?B?VnBSbWNtZVJjSGNzdjkzcEhrTFQvUnE2a1g3VHh6TXFUeXhFUUJmZnlBTkxI?=
 =?utf-8?B?SG0yNElib0lZTHBrQWZDdmJoajBYQy9HU2p6dW5USFJaemZVNDlGQ2Zyb1B0?=
 =?utf-8?B?Y0ZkWElTSFFoQmxrVzJreWJVd1F2VzBuOTFjYzYxREFNeEV3V0tsck5mREdq?=
 =?utf-8?B?Z2owWGF6N2xzTEJ6dWxENWFxZ3Q1RVYxVkpPeW5zWWIzNHNqamZVME16SU5B?=
 =?utf-8?B?akR2OFYwQW1CMVZITzZ4d0lRN1AxOXIwQ1MxaERLekxaQ2xkc2lnSW9oeGpB?=
 =?utf-8?B?V2VoZzBUaGhmNytyaTVieGZvYU1DcE5DVmlMSEhoNmxYaTYxWkxKbnhlN3hE?=
 =?utf-8?B?VVpnNm9nWG9iV0dqUjFOMXRQdTlhOXNCZlBlTmZXUVFRbHkvWVRSdkRXcVY0?=
 =?utf-8?B?UnhXcklGYUl0a0FVeXl4RXA5QStyZXo3emVrdWRnYnBLRjA5SlZVMlBrVFNG?=
 =?utf-8?B?ZlQ0OHpYOCsxZTR3WXhONnd0OVQxTkJZYnBpVzJQcENtaUhkQzhkdWxzN1hC?=
 =?utf-8?B?VGVNa1pqb090VlloTFFvYjBlL2ZxYU5LUnBTUWFvbVVJQnFWSElLL3IwdU4w?=
 =?utf-8?B?WGRLZXBlK3VyRlQyV25IeGwrSVZ5Wi85ZXJSaFluNnVnd2QweWlNOWZCdGVP?=
 =?utf-8?B?QmtRejZuaENncXAvVmtmaTdFeHg1TzdSb29ZcTVMeW0wVHFoUVRWdCtEMmFT?=
 =?utf-8?B?TE5zMjdvNXBVbnk5MjZFNlkvWit1RTR0emNIbFlWMUhvMUt3RzhNcWs2K3Nt?=
 =?utf-8?B?NFdYM25pVW9tTURaMWJ4OVVUckNhcVV2TEV3NERiZ1FsaXZ3dFdWRFhQQS9I?=
 =?utf-8?B?SGwrbFF6M2x1OWhONmtFQnZJTWxwSUwwYkV3RDR1Z29KQUdpRE5UNUpDb25L?=
 =?utf-8?B?YklxNHU0QmZtTXZ6ODVlREgvVGZmRG1DR1pPeFlHMkpPdHVkeFBtdEtNNTl2?=
 =?utf-8?B?QXIzblprZ1VtN0xXN1hhZUFQLzV2bldrcW0rdjJjdzNFWWlFVm9UaGgyeVUx?=
 =?utf-8?B?K1N1QnliaDdablUvRGQrTFhvb0RNNzdRa3NjTFVUMEVJODkrODZZZEZnQWN2?=
 =?utf-8?B?TnhNWUYvTW5jU3docEt4Tk0rZEJOVUlSaHNhaG5KV3lHaU9xVVRKSmNYdExy?=
 =?utf-8?B?SGFSZUNtbzdCQjZSR3JMVzZVNkZNUVZHanlFOUdIZFUzK29CZHJVZGsreDlW?=
 =?utf-8?B?OGpPR0oyQ1pKQ00xN05HYkhkR3BzdWR1Q0hHVjVNWjBkMDZwKzBBZkxzN3F3?=
 =?utf-8?B?V3lHVWdzak9paWhGV2VwWVE2WUtUbEVjUzh6RnVKMS9mb1Jac3BmbHZFcFFk?=
 =?utf-8?B?WGg0NU85NkZWK2xTS0tkNGpWRnB1b21vUnhFSmdDUW5TZGtQNCt6V0ZJemo1?=
 =?utf-8?B?NCszN1JpUWRHWXkyajF4TlpQUTRQS1pTWnNlbDhtT2c1S0FyTklFQUJtSGh5?=
 =?utf-8?B?emJLM1NWN2h4K1hPUDZDVytmMU9MWUlZcVlVQUJrMTZXMDBHWFduek1VUDdQ?=
 =?utf-8?B?VUphZlVQa0JSZ0JIbXQwOG1Objl1L2dKNk9HOVRJeFA4d3FOeE9QWGgwQzJh?=
 =?utf-8?B?TUEra2paRTFoQm84Y2pmSzEyNWVYYzdnamdlUjh6TGlYd21QVm94QmM3NjhZ?=
 =?utf-8?B?eldZRC8zd0puWEhpbWZSSmxQeGdXRFU3aWVEVlRSMGdJWVIzK2pvb3hpZ05j?=
 =?utf-8?B?NXFxVERNMzA1bTB6aW52M0pPdXlXZlJ2dS9pK3NtUVVDRG1VY00vMTRGQkJl?=
 =?utf-8?Q?ALZY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f051bf-c7a1-4e60-3b41-08dc9f991199
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 21:58:15.5299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9y6O1jM6SyzfoeRziT/W1LY46tdyv9Uz/Mkp9JufWw/NavwVo6PhHwZNWPtJjnG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8770

--a4e0b808739889c0ad3421c8338e2d1b4189d9e85860bf7aefa565ddb90d
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Jul 8, 2024 at 5:55 PM EDT, Peter Xu wrote:
> This issue is not from any report yet, but by code observation only.
>
> This is yet another fix besides Hugh's patch [1] but on relevant code pat=
h,
> where eager split of folio can happen if the folio is already on deferred
> list during a folio migration.
>
> Here the issue is NUMA path (migrate_misplaced_folio()) may start to
> encounter such folio split now even with MR_NUMA_MISPLACED hint applied.
> Then when migrate_pages() didn't migrate all the folios, it's possible th=
e
> split small folios be put onto the list instead of the original folio.
> Then putting back only the head page won't be enough.
>
> Fix it by putting back all the folios on the list.
>
> [1] https://lore.kernel.org/all/46c948b4-4dd8-6e03-4c7b-ce4e81cfa536@goog=
le.com/
>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Fixes: 7262f208ca68 ("mm/migrate: split source folio if it is on deferred=
 split list")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>
> Don't need to copy stable if this can still hit 6.10..  Only smoke tested=
.
> ---
>  mm/migrate.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>


--=20
Best Regards,
Yan, Zi


--a4e0b808739889c0ad3421c8338e2d1b4189d9e85860bf7aefa565ddb90d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAABCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmaMYPcPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUakMQAJ1+5cYgJ2loUEvqzHNLQ8iSh/wGsaR+oQa8
myYIkFSwOmc5vSSfShqa2ka/4HpcQzgzeaoxEsEFqycUS+5vOCZBGuG9YWZ+uIMz
2G1KSCkv5XEWILBPZ6cGYAQRaA617R0rOfjCoZwI7PyEpDKj+D2qPNtpGgBidUlf
Fcm8/wKFZ2EjBStAcid+iNaRdusx1KRV3zfiR4dRMFG8BOPRH8Z02hTVyA5rd+1X
P+bGsAAc7D1g5KsIvv0RPJjdsN0yiVGVpZmvMT3HyoB4WS1NDvAM3vtcKy0QVSWB
uVGXq2gGgZfRmSlv90aB/3LslLfrEJtcJOtedC3pCEjtO20xJzoE4JFsp9uPh+t8
ooxxLSiuujIGrsIHgyjXFWQ9a3CLc8EOIwpCBtJM/8ulO24Zyz/iPgSCJ/4QlBgm
gvIDM0p5cnlRjHY33BBFQ88bbrvednTPoOIPOw4ibSIsv3iwiUidNf/KaueOsJLI
nJFPZLuLBrY9WWglbUXUDFrJfaoYvM39mD6NNNwAL/PHu02a4dyjLYaz3Z3RHnth
72TJSI2TjQ2W4+1KD/rGMwZL+GU+a4/A1yetBqg+oNVibtCa91ygOGKJWvOVD7Nu
GtGSVQq+2RQVfAWkSkilD2hqcL5VpjFmpk51DFWNMlud/Azh6WDAFwhd/53bqve6
+9VeAXqj
=/wtm
-----END PGP SIGNATURE-----

--a4e0b808739889c0ad3421c8338e2d1b4189d9e85860bf7aefa565ddb90d--

