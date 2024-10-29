Return-Path: <linux-kernel+bounces-386673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B42B9B46B8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E3F71C2225C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83B6204006;
	Tue, 29 Oct 2024 10:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OwcjCxvi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DJTCNBgR"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBBB20495B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730197435; cv=fail; b=tRM8oQMjvT6p0HjfkjjdwvLaOp497gSLqB0WvAIKzN2NHy6bt+/yYz2vur1+Xlq3smPNnq/ldsbDyzHyy5kFWDkJvM4dnacjcw+WhIA1hP58TsGKjEEUj5w70f/drLlIKx5xKToXQfUC6FB/4mw8Wxpmr+mQav0ytommD6IbofE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730197435; c=relaxed/simple;
	bh=FFWt2MQimWQAdz19hoYkSiupzPdODKwVVWiD5DUIoj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fN8PJryqRZ1ZiUtNXuxkIbyxwqiVP/d0zOJhfW2NRNz5LpgQ+My4OZgqy0Ln+WzO86qwjmVjeSELzTXumd7bcs4oSBuJY+LUZFcpmrB4GkmNUIKYKU/2XStH3HZHGeXtlU0gLXdIlU8ETxTZaRzblLgyYXalw5Y6bc9gC4LTVKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OwcjCxvi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DJTCNBgR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T7tcxO014858;
	Tue, 29 Oct 2024 10:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=FFWt2MQimWQAdz19ho
	YkSiupzPdODKwVVWiD5DUIoj0=; b=OwcjCxvixP7mEW/979GYTRTEHTmzuM27Zj
	Lh3suZjgiyPxox53yiVCyMTd20Da9tOXosPGx4Jgw5/iPk+/ajwTLxetWiUrMCEZ
	TNUXenSESSveQPZZW4ENJn/VSfW/AV0Eq8DcB+eeAs6C8TDyiEmKd8TWQQLtIm6B
	Gg0xYqKzDErvHSprO7iNeGD6AY37EAY9VY6Shr94oQvillnmPJzCwqazBwD2lGcX
	BhviwEr+Lf177W2/sq68tDu+ghiKC/cezi8ciWs0RA5L2gu4XCZKLeJqwGPef3cZ
	5p8W3k8juui1NTquE1lfQqAvOTeDnZYgJ3+IIgoyKTDLeJtSUj0Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdqcy5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 10:23:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49T8UXDl011807;
	Tue, 29 Oct 2024 10:23:35 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnaca80x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 10:23:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNswRS9q4aqedgHRQJJ5D2F5W3xyye6EFR4PoEjirbJNEg87CGNBr1hkAumHMtVrMJPszuj5SGdN5EO10m3kMND/nc5spXdWVki127YgBygZY6WZJXpak7EneL9QoWqv+6y1NifMUy835/4kpNGCtobneZ3m9VL9GR+TgTDeSgrSMtxMZ1FymIv29fNd4wofIqxFWS2UQVTpPHYwmurStJAevwOyqtdqkhJJqq6fexu/YxMnQZW+Pu1+Wj1pKKVcMPMIHckk5murJtLOJSUVWuOKniwPJzd6ctO+ZICoPLmwjqR7oa+YjHKtwPmS/irsIoee6Lorv08G/qPHKK0MPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFWt2MQimWQAdz19hoYkSiupzPdODKwVVWiD5DUIoj0=;
 b=zMrs3HFgAqAcTSXC2eEgKX+3wy5fb1tg6XenB+ee4lL9oF68aOorDALtk62FnlQuFiIaZaF+my/U515xtpdvApOHaINSEB+V5MXaHE4tcG7XFdN60F5dyjMPElgJ6+AHLsscgIaGz7HG8vmjMpgsP2/+3skAaid1ZYSPWGKYpv3T0ic7wlD9BOTR9vTLLzj1pnUnL8bmj/5BCWXloljn+0mu58bMONDBdgphBm/y9ar3B8rBGc/pg2oTLgWbNzs8wOi8APgXQc+gOJKvRZBfSEVX1ZEw0ez3CIni5YdcK0PCYpt/clsQbFbP04KfsJzfJfhYS4tiXZ6HMQ+EKjaGxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFWt2MQimWQAdz19hoYkSiupzPdODKwVVWiD5DUIoj0=;
 b=DJTCNBgRjxEYClExNROeMGiUtDEEVBGP0lxHkXCG0tRSkqi1Wq4NkdW9k2pOpNeZl7fnlwRgYJ0mO9JTYUnSPEghjhDlwlsa4c3e9DZUQtEGPPHNAIdFHoRhI4vCTZmde6I7e40GeK6CSbXuZkz8lshHgmY3nYwUV2wlJjK+AbM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 10:23:15 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 10:23:15 +0000
Date: Tue, 29 Oct 2024 10:23:11 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: [PATCH hotfix 6.12 v2 4/8] mm: resolve faulty mmap_region()
 error path behaviour
Message-ID: <2de95424-ad80-49a8-bbb4-e01d2b82f0dc@lucifer.local>
References: <438f50c5-8b8c-444f-ae85-10e5151f3f24@lucifer.local>
 <57mgmdx7wgfwci3yo3ggkmcnm3ujamgkwcccm77ypvmer5tegn@opiq3ceh2uvy>
 <ykzmur56ms7fm4midi6tbncjvcvf7ue4lp7e4orblrmwnefw3e@oa3enlpdrcrr>
 <bea02efe-a695-49e0-b15c-2270a82cadbf@lucifer.local>
 <CAHk-=whpXVBNvd0NJpw9=FGcuTuThwtfcKeM3Ug=Uk6kpChCPA@mail.gmail.com>
 <0b64edb9-491e-4dcd-8dc1-d3c8a336a49b@suse.cz>
 <CAHk-=wgE8410gu3EabjNEHhOYh1dyYwt23J62S4a9SYcwZUFhw@mail.gmail.com>
 <1608957a-d138-4401-98ef-7fbe5fb7c387@suse.cz>
 <cf1deb9b-c5c4-4e85-891d-62ecf9a04e0f@lucifer.local>
 <ab636f4d-a140-460e-9ee4-fcd1e859ea67@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab636f4d-a140-460e-9ee4-fcd1e859ea67@suse.cz>
X-ClientProxiedBy: LO4P123CA0616.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::16) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH0PR10MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a74418-9757-4376-dde2-08dcf803b33f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YcfFDtsH3CWIkyfG1syC1uhOrlZfZlqO16W9itxH3oykjMud85iZGt+UuiEV?=
 =?us-ascii?Q?qQ8xwFkTacctHYl//IUMDfYVdJqOdsSgqdQVU//BseqPsEQ98x5ezCw54gt2?=
 =?us-ascii?Q?ilaJi3wSp2qRzRBOrnrBZbh5p4V/QxsGB6Upoj3XFBtdWbW5hAUzXawpRdIF?=
 =?us-ascii?Q?Wsj8WUT2f3Rpq5Gc/G1+dNAV0tapRIPfGACdQXIRU5FviP56hj5S5eEnE9u+?=
 =?us-ascii?Q?UJYL1rgpiJ2/OJwCuKVyoIVaOMn+c6FsuxfpHBhTIEgcRu9TF/p/FAIbne23?=
 =?us-ascii?Q?vdanFYL2qIaegIUAn6uk8QG431s9fj2tvIqbLmuALVlkYcdJo/2sPY0mm1P1?=
 =?us-ascii?Q?O6YM0BKD5bu7zoHTYPRzhmXfxrbpKXVwXq3rc0lOdTLGz5uWMbqE6nQIGFlC?=
 =?us-ascii?Q?NHO/DBW+NaQZAAzPJ1fax2ZUZkmbEkV/K07jJoulkkrPCmzP/5Dc89UJF6tp?=
 =?us-ascii?Q?vzDeM5WEj5VABPllvA5pcPyTFNdIas/3ztTwDhoAMqB1eJwNiGo4djKRbQx4?=
 =?us-ascii?Q?aFdMfJl/fM3GXC/Ui1t1VuQ+Vxt47WoJIpZACjPxSfgdwKUn1IoxdlLduO1v?=
 =?us-ascii?Q?97xZ3MllSpq2/V7CMZV68tRCe9Sos0sXcaAjJxeZcC9m3KXP8Ds1qzOuEZMk?=
 =?us-ascii?Q?QxPaQdgy89jXlO+u32s7GuJ0m275MDiAncpaXBk6jM7jMVaqJn4Y1jdvZSR5?=
 =?us-ascii?Q?TcrFGhYLfhlP4Ep2fi2oaZuMXRCKIf33GHVAm73QqABdoiaNLgUWMF8bvoPR?=
 =?us-ascii?Q?P28pFfR5QlouAc2TsoZ4UA3Zdei1725zjlMU/bRK8UoKlHwy9PA0X0l7c9jJ?=
 =?us-ascii?Q?9aVuDp1ur1W2O2sa/axAHz9WOeC8nGNyT8VZTY+bhk/iXrtST9l3vtHMrL6B?=
 =?us-ascii?Q?5mUfghLbvkr0FO3k39tmUURmloiwn3IxlYvHcSCVFBJVTEnEaHI19NJyHaaj?=
 =?us-ascii?Q?vJQ4grnzQ2jzc1vmN+S9mbq29rWPb+VmnrXA24YXpvnd+RFSit//THY9Cm4f?=
 =?us-ascii?Q?MboUJBy/zXIFxs6Ucq2FI4Donmjt3SWKJxysAq4QkqpkqP5FkTtYHTr44HXs?=
 =?us-ascii?Q?LqigVYsla6isCVFNh+0uNUX1L6TQui+naEnITj2/ChNR92FwGsrzsBGYXhgA?=
 =?us-ascii?Q?QwzhaQ7XPB0JfBIM82EqkHKWlaiuX9vu/lj133W/tG4r8FvHstgJh0Z+EoLN?=
 =?us-ascii?Q?InbzrsvRd3G9kzl3ZFAstEzETsyHq/BvEt/i4V00Yr9h7dryuuUTDJ+q0z+Z?=
 =?us-ascii?Q?QqtDqziLCkaoSzVA9b29vKvqhuFNYJD0k19IHFQD1+lyiyk7SD87FkT+L48L?=
 =?us-ascii?Q?pmGq2ck+YCMqzPDbKd7TBOl9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w13fRTncV/AG80R/MtGMmB5VAU/VkPxZMMmox7xZ237AvK3aN9r+2cVEeMhY?=
 =?us-ascii?Q?yFIXO3zTa7hRVHQxI200iTDWHtgwgcsNXEt8daR3A9IWomTHIc3empUKtv04?=
 =?us-ascii?Q?TRz9O9CKPg/gokxeSElfttS0NoMGQiCQ8hZ12N7cW+vC7Rz1wmp9+iStrz8T?=
 =?us-ascii?Q?7PfKcAGy9Ykfb5xPi16YCxsv7hGzvYhxwTlzjlgIqLkuP4S8BEuPCpl41noY?=
 =?us-ascii?Q?jM3FCj7muLjdMtgvqaToxJFVvWExaAk3gr9Q60vbPt5xeZuorwEdfxl5U6r8?=
 =?us-ascii?Q?jG2qXM60glIk3GVvCBRmvtuDCKvO/5PxmtYHqLNB7hingICs3ZBX5KCiPsf7?=
 =?us-ascii?Q?Aj7nzYdVDpfDoLYae7JZuZRq7Oje+SOHBnDhDMXnn2JAiAfvp2flBV7Bkbny?=
 =?us-ascii?Q?41v8/tbyN/Ve0RRsbbasC88j288v/VYcCq8ElJrXDUFzLXdSbj8VOCoa6Xvs?=
 =?us-ascii?Q?jGcCq+YFyFpSV18J5ZgFhXFTVxFiZjd/PFAHAQfNSB/cZwQPTImm8OSnMrRx?=
 =?us-ascii?Q?duJPxDs8Syi9ZzqU2+y4/EcCbdNlk2MrC6hGL8uQc1NKQ5Y37z3c3BTQT9FX?=
 =?us-ascii?Q?MqwJhEDgxralFZIfGVBwcB+JbqHF/vp+ZcTmHuy6Uoi3D0DqOx5DeI6TVdfh?=
 =?us-ascii?Q?Rv2Tqo2O1cMzuTnJ+G1GYeobsj/nfwx7xWNg8ef0E1h/YinPuOogyRjpyPfa?=
 =?us-ascii?Q?SLWfO7SCbNvCDq5c0uuGMFSy6iwxOrs0VbA+y7dgOcO9YRWP4qYRcHIRQITz?=
 =?us-ascii?Q?tSJPFIMo9CdOnsQGcgf0jRZeNw4IdPoMIj5nc/9ggDHIWRX/JkCW8gg+puks?=
 =?us-ascii?Q?m9axyNwZZOoYUqHuPSd4RlIiwLuKpvgDDWN4oSGwEdYxZjC3FOoxKFJcs/NX?=
 =?us-ascii?Q?iPfjhregQU9uHXCdPt0wqR6cvHnJRkkIomrcLlFucwIxV8ge4Hf/2FB1zTqS?=
 =?us-ascii?Q?Y+PQoSC2E/zl9FWm4LMe0rFGqHpBLM7TCpeV5s1jNhNRvAarNMYJNbpSjWHF?=
 =?us-ascii?Q?4aINP+m0OkIfxiwTAOQtZ2Gv1OUt6EATaGzG/3WlB6eGv5WMQ9gB7u5XAuSw?=
 =?us-ascii?Q?zmiMbXAbeq9g70xWzDUi1qix5MI2UCTB2T4bNGuvTSdd7haKcQepCx97lPR4?=
 =?us-ascii?Q?OQJCPqjcbR+zQB89wZdpkiW0W0iZPWRo3+bAcWwLPaEQddPB3oiekLkxiO7H?=
 =?us-ascii?Q?//xD13g0BDl6oMhxRbYfN3DIEzAbehjmqWF+n87chvfbGEY1Wzx+3LdLeQMI?=
 =?us-ascii?Q?S3FxfOPu+pYTglfr7go31Q1CvQ8E9cBGQ+4JbT5zkFITpAbNmqWbLBZ1jbQo?=
 =?us-ascii?Q?x/ZwJ0YRg46/QmRnifRCbl9BelseNrwI0ddLec26tL1DSCKT9g2Vk5f+XjC8?=
 =?us-ascii?Q?9+wN9wlE99uiV21Lh+wVeJWeBM5DqIbKwLYZrb4lkleP0RhCkpLJbnf7RcAn?=
 =?us-ascii?Q?gJnM8fsK4MAUlFLjOGFJOXIBo1qThxhqZea6HKqIjAOObBUQKUMn2MaJobWK?=
 =?us-ascii?Q?O6leuW6nYuf7pO+wif4M2kI3me7w3yknIv1UnOUTBiUzdII8Z0ny0d728B47?=
 =?us-ascii?Q?aHRH4SAemswL/t9eE5GMUrJq57zG0HrX8plwiNGQINmHvNJyjbvqMUOLUi/1?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tn0BDtdJmWeHzKnjlMYRreWCj01ocgygYbiILe21CMhJYCgWeCjCq/4NX7eyZo/W+f2ZnvQjADVEFduBJNg6kTniE33JvWB5+ypa7+ZcRwDDMw6Cq8hBEVNvP2XMvFNjSbWS2KwVOZ6jSVF+KeU9QE078xsnKmmTSY/dsjaIDYKdeC0Ba2YcUj7UGEFa126rmOCEbfwO/VPQaZo4P+rEsCE8vgJcQhhv5BEPiJ+o68mQ4mf1pPDdkT0A3CA9hKj2dG7ENWJbSCnkPzxFD183vnbP/5N8PkW7G2hLwXbt8MJYXJsQgUb5xTxZUc5p/lzhNIwlvfMSws9mC9A9uKdZ3ogHAgkFJlVzcDbHZ4P56MsnlZeVkN3tX/sBkowxQtqQuBGheL8mwjCa5pYTjNXKn3w6hE2/5OuLiyO2eyUYAOyOwforGwtxgeySvNTBW1G5fv7zZXv+h0R8OHT+4X3JnZ9YSWLizVvSt3PI6s1yHxGuY8HAAmNMH9UMX2j/jw5PMM6K7ppXNpLCRAGWvl1nnkS+pwOgpL+iWc9ZGMxjbXzhKOmcAF4YrryfRgM8FliwbklB2DsbA7Fbft7MSKgbku8oGiaZqxw61Z7CKME6Wzo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a74418-9757-4376-dde2-08dcf803b33f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 10:23:15.7541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOKiIQygsnaP7bT7g0JkwANVSDAS9cmGTU+6Obq9qbTuku/+UIrtMcq9v++1XDfgTuJ+HxPyhgkEh8S0dHcz+j6kJB0VtGZ2UcMWfUkb/F4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_06,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290081
X-Proofpoint-GUID: gEZVwuC7fr7yamBPsr3IRhMW5bplvKdr
X-Proofpoint-ORIG-GUID: gEZVwuC7fr7yamBPsr3IRhMW5bplvKdr

On Tue, Oct 29, 2024 at 08:50:11AM +0100, Vlastimil Babka wrote:
> On 10/28/24 23:14, Lorenzo Stoakes wrote:

<snip>

> > Unfortunately we can't do this and have everything work entirely
> > consistently.
>
> Consistently with the current implementation, which seems inconsiscent wrt
> hugetlbfs.

Yeah 100% I think this is an oversight.

<snip>

> > This is likely an oversight but we want to try to keep behaviour identical
> > to before in this patch.
>
> If it's confirmed to be oversight and MAP_SHARED hugetlbfs should be
> allowed, we could add another is_file_hugepages() condition

Yeah I mean I think this _is_ an oversight but I think best to delay a fix for
that to a follow-up series and just do this for the hotfix. Might throw in a
comment.

Andrew requested a comment on the shmem_file() check anyway so can sling this in
there!

>
> > So continue to check VM_MTE_ALLOWED which arch_calc_vm_flag_bits() sets if
> > MAP_ANON.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

<snip>

