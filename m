Return-Path: <linux-kernel+bounces-437893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4759E9A35
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834BA162443
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131291BEF8E;
	Mon,  9 Dec 2024 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NPBFasFO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tYk26/N4"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22661B423B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757437; cv=fail; b=qyd82qt1wT8C+6v3/GhYfrYchvSAsFg80cHTKTolCbW90/d4Zv4LJ8hqGEX5vj929rRIAiDmu/g9ClK0gfs9/sY4BhxwmOYQw5hd2Y6cflSFj2yZrU+O3O3VyOTGbDhEnvv3Xhf3Bxzmnt6HO8PJbPyO41AeEuzHEuuwHRS8eAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757437; c=relaxed/simple;
	bh=lZgWmzspByZJaxC5bk98FGByAjn5I5Mv6lpd+foTUg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i5SZg+N9+ifxWajNK0+ReiH1Q4n3QwOj/8mrr1Ojv5Lb0FVYHkBItLRv3X5dTPWgbpD4cUX1nUO5iskugU1GrWAkZRnH7um3ne3dlziM3i/7peOe2FztCm/GTpikMA9QjgjNY81QDaMJEAAFNk9irD1GJmqE44w5vmHB0Yk49zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NPBFasFO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tYk26/N4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B98fuo4000348;
	Mon, 9 Dec 2024 15:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=kGqu/KWdoZjdWk0FGj1q1R4GAEKO8i5pNNcnI77xebQ=; b=
	NPBFasFOq4LP7Y75wDMEYaHq5H20m9X28dqAbdHiibAhYyA8C9Bk6DLUNm87Q6kc
	s3tnBh4t5kccfg+hTXMNoGZ7AOEcH+edLrZMx6KKIoOozBEg+ZlFvUhBKaEvW7D3
	FQuSOV9utZ0RXDW3Pv7xAVSFZxlvQlsRW+bpumWL0RvrTt3A6DtvpKMLjyLoJ1MU
	FmZSx1RIX4qhk1bE50BQaqy1t4W7yoSGn7O3/1Vl91jDi2T1TOPBILMgdTqECEDA
	CX2Lao90NiU6ytg+t0pLiMjNTM6U2Mix4i13CwWA8HEpldNlYYI7LmcKPavC1Rhr
	BZiX6UwhhCrTbkzGf5r3Xw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cd9akgft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 15:17:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9DQvKO034911;
	Mon, 9 Dec 2024 15:17:03 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctefwm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 15:17:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7hqrvx+M/IDorZxqzATeu/JnXrb02w+qdHZfCIifGihB6DeSQXKtMoskH6CQnBoNIW5IZnJdCJqzYilQyQb8+cJpJfs/HTdwCVgCftckHvzymzMvpSktxCE2Jggq9n8XtNk37fpadz8A4zPzwvocRddpQMau6LhlqmKFBZn5lJSQgl535NxGmwlcz0sK+Jlgbe2a/ocVwS6SDS86bmnBTWJ6boytafi2CMA0OjyIu03ARJI+l6mlSCJkiF+8wHppz05HMnZ/bDay+qJFcW0vRs8Gsa9MbZ1IWQTdWCo1beC5qOVmqHNBhmXL1X2JpJucKmQJCpFOHSZZrOQ78I8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGqu/KWdoZjdWk0FGj1q1R4GAEKO8i5pNNcnI77xebQ=;
 b=VNLDoYKSUhxNHAAmnvHeaWiR9b9TdlREm5WoTZVzgnNR5WkMGNs5CKupsB5YkASj4U2VRg+rrHhWQv1ab+LL/xipSo60Tbz780R3cyldqOi1LGXo3a1JxvNZN0kPBVwEn3NekXGvNkSabOGsLQy8rS6zctR/4fL5drTR99nVwwi6aVAQ6EtEPF3rNq6sXsIsK7JBQEW1jjQAYhtXYMAZGWp/OuabqxrM9EUnFh9+1P8gmWgSi0GO1NTD2aUp2OgFHzFwILp7xom0HwTJoBhmdP3cDx6XiOHwnzvqLsJkDosrAdrbc4ElLsJw0jF1KgI0AsKyRWosvh+bHqV8x/ADEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGqu/KWdoZjdWk0FGj1q1R4GAEKO8i5pNNcnI77xebQ=;
 b=tYk26/N4YyIQhxr8UWtoRijE7vVFBGhF3v7Xd7Gp/biBdodnjtpq+rhw1VcIenDm4bZqyl6GYekSN7Mwe+u7Zvwqi4nENBR1p7ySu9m4SvJWs6cUWW/PKaHRROQ2mAAAeA/cIsCIDgQuF/l2o+MldPnTOat7NBhDMXPFdAy3pe0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH3PR10MB6883.namprd10.prod.outlook.com (2603:10b6:610:151::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 15:17:00 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 15:17:00 +0000
Date: Mon, 9 Dec 2024 15:16:57 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: group all VMA-related files into the VMA
 section
Message-ID: <67ae2a5f-0c86-446f-a122-f14decdb84d3@lucifer.local>
References: <20241206191600.45119-1-lorenzo.stoakes@oracle.com>
 <23d3d7f6-d6d1-430e-8ea0-ccae76b253fd@redhat.com>
 <41a14051-75ee-4de3-863c-d0532aa7e3aa@suse.cz>
 <1e4c3e31-ea9a-4af4-83f9-15a882732e69@redhat.com>
 <71beb3d1-21ac-4037-8363-6484c0c333b8@lucifer.local>
 <CAG48ez2s2mY83uce9mGUgc61_50nOp9VPJKLHMtyRYTTeKpo=A@mail.gmail.com>
 <81fc4cd1-55f4-4569-aef7-0b0da9684fdf@lucifer.local>
 <af887f35-0831-4c7d-9f1d-bc857b52975b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af887f35-0831-4c7d-9f1d-bc857b52975b@redhat.com>
X-ClientProxiedBy: LO6P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH3PR10MB6883:EE_
X-MS-Office365-Filtering-Correlation-Id: a78104d7-5ac5-40ea-8858-08dd18648747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjBybUlSNkcxbzdRc0dZak1iQWd4TnY1MHY1MHNUSzNScEkwajdZOTBlNVg1?=
 =?utf-8?B?Zy9lQjdJVDE0YW9CRjUxcE90cWc1d2R3VWFFdVZsbk11dUExTnpnMDNXS3Bi?=
 =?utf-8?B?UiszYVN2ZDFxRThldG5Ka1BmWUVCaHNVZnRmZ1hPRDkydU9ZWUZLNmZBenEv?=
 =?utf-8?B?TGwzazFpV1lhUVB0bExoRUtiUTUxYTBRTTM0MGllbTdJWVBSV3g5cW9EamlO?=
 =?utf-8?B?cUx0dG5ic2RMMmVKQmRIdGlaUloyMGpjZitiZktNeFpCZC82dHM3V3dQZHl4?=
 =?utf-8?B?VTB2bk9TNFhtdThQM0F5VzJmYzQ1RHRPanJrdnlleDBOTXRLRDRTNTRwTXZV?=
 =?utf-8?B?ZGozY1daYzRGVFJHVnpHQ3YwRzhYbWpjOVhDVTFHVEhYUTFHNVY5ZERtaWJY?=
 =?utf-8?B?dGkzMkNQUDlFaWpmRGVIeWRITmhtcEVEWEp2Wjhicis5Tk9KandUSm9zSFJX?=
 =?utf-8?B?azM2RlpjREFybXBGRm9USFgvOFlYVmZHTTA4bHVDY3dJU2lieWtnQ3NVbVZD?=
 =?utf-8?B?OG9VOGg0RTVLaTJjeGo1cnA0Q0JuZmxJRC9EOU9VQWUvakY0N0pQZHhEdWFn?=
 =?utf-8?B?ai81Z0pTTWo1UXQvS1pFZC91bzNzZ1gxNGVSWjZtK3ExNHhzNjJBN3JQak0v?=
 =?utf-8?B?b0U1UDY0VmswUk5IWGd5QWNtblRKTmJJVld2ckhrSHNLMm9FdGVmbzNSZ3dy?=
 =?utf-8?B?VWx1ODJjS0ZTcFM5alhsdkh1dmJzMDg3MWg0c0sveXg2dkNFaUdwSEFDa3Ni?=
 =?utf-8?B?THZRa3RiT2x2bUNPTFEyZlRObHBuOTJNTnFvMHNxeHlCa2RRL1hzTDMwWC9u?=
 =?utf-8?B?Uk9VME5UdzRLU0dxMkFqaWU3WWtVbi9iMEZ1aDVCaFBBM3VnV0ZxUUhUK1FE?=
 =?utf-8?B?bWdsN3Rrb2RPd3Z5QzgzMzFPTWNuMzVPRDJNNmVIVmhsN0F4eHhmazNGb1ZG?=
 =?utf-8?B?Mm9HWUFiemYyQXpYZlZUdUdMdzR3TGlqek1hV20xc0ZPdUtXYTBtRC9lUEIv?=
 =?utf-8?B?SlR1L0xuTW5YajFoNkNBOUV4ZC9jaWttNmJEZUUvbjNFc3IzN1ZhNjl2RGdv?=
 =?utf-8?B?WGZjZGlmM0pTMjdEVlNkenNSQmkyb2tDZ1VmR3h0MnY2Vk03MzE3VWZmek53?=
 =?utf-8?B?MjhWZDNYNU1CZzV6QkM1UkZSU0h3ek5BTllqcy9lLytPWk9KVFZlbHJ0TGhK?=
 =?utf-8?B?czhlYXN6aFd0MWhrVEtrMmdjcW03cFpGOVgrMHBVd0dxU3JZcDA1a2RBNjIv?=
 =?utf-8?B?STFlUUY4QUZyNktFcURlVlJSd2wwVzhSSGZONHFTQkR4ZFhSMDNrYWxxbEtR?=
 =?utf-8?B?V0MwYXBnSkhSUzJkT1AwZndJV2NGQTd1aWdOMENiQmJpaFQ5RzJTb2gxTlpQ?=
 =?utf-8?B?YlFzK3paRXpRV1dXdFlPSW50R1dZaU9SS3RLempRT00yN0R2QzlxampUbU5z?=
 =?utf-8?B?S0dRM0NVNHJsUzlKb1BXaTFScDUvT1RhaEZJdWdaSExvY1JFSzJsQzlRUk9a?=
 =?utf-8?B?TFFaTXNtWUYzdWg3dTRSQnBWS1NBamttNjJwK2RkWGRMWnI2SXlPSHJubjV2?=
 =?utf-8?B?QWJvTzZzQnAxSkw1TWtJZytRVC9Pd0d2NHVEZzRwL2lFMWZMOXNPWUNxcjlp?=
 =?utf-8?B?Y0tpMG1DZDhtdUc4RTBGSUF6SlQ0TjE1WVM5U2ZLRHZ3czBiYkdSVjk1SnB5?=
 =?utf-8?B?QlJDUjIxTjVJcmt6WEZydVNUZnJla0pRcVhsaU43REtRNXNhSUhIdG8zVExI?=
 =?utf-8?Q?TanHrshmDd8mJ5nYFs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnZaVmJ2RDRyekRzZjdXWDNibHEwZ01ENHlnWU9mbkU0Q04zNzBGengvLzk1?=
 =?utf-8?B?b0xkM1pZNnQrMnRQN0pMQVdVVWlZeks5c3FyenpKTTZsRUN4NFR6V1ZiS2Vl?=
 =?utf-8?B?NTE4eU8vZjNRYVpQWWZpdllNb3MvbDFxVDZzdzgvR1VUVFdMaTlCRC9KdU5o?=
 =?utf-8?B?dHozb0ZBNTdmNWk3SURKMVJRalQyUnFLK1dLd2U4MUZ1NW5DbW5vUnZaRWxo?=
 =?utf-8?B?Wmt2WjlQQnVvc1JTYjJ3ZTBRTThQaUhBaGxWUmMxSll6UmtKYnd1RzZSa05z?=
 =?utf-8?B?eERTT3U2WDZ5VTBJeDh6bmZ3NGErVCtpY2xxY2ZWSTNOREJMWTNxV3F6RUpH?=
 =?utf-8?B?L3l6bnY2NXpFSDdJOG9tUzhWSTdranlJcG5MeHN2TjkrUGlHZ2dqNDQ3TWtF?=
 =?utf-8?B?SnRPRHJEeEFYVHAraytoNXcvRzJLTWd5YW5kbzNGbElvV3paZ0pOdGVtckxS?=
 =?utf-8?B?NTVNWStyUXFCVDNwaVF0d0s4STE5aTY4ZnhGc3F4VmZ2d01mMzIxbEY2WWZh?=
 =?utf-8?B?eGRFTXJ0YVk3Ums1SmlVUllPOG1jdVFJNCtyNGlFbzVzTmFTd3gwVURhRHN5?=
 =?utf-8?B?bTRiYnUxM2FnY1BYeUI4OVc0cnlJY2pGbnJpSml2NWxIZk5YU213Y0hvRWd1?=
 =?utf-8?B?R3h6ZTY1MDYxMmRXREU1ZjErMGd0RGwzUEVzZm50Y2hoRTlYT3FXMkJRMTNW?=
 =?utf-8?B?ZnlMeFZ6ZUpjTUVZcVBDaVZsZitseUR2WlhVMFZYUGxrK290NlNRbHBxWUh4?=
 =?utf-8?B?OTVDd3A4MjFCQ2dVY3ZiUnVzdEdlNEUzMmIyRzNXVFZHeWlPVnRtN3EvS0dE?=
 =?utf-8?B?c3U5dGtkaEVsOHIvajVLMnBPOVRQa2RQaEN3RVljMHU4aHRkOTAwQ2p2VXh5?=
 =?utf-8?B?WU1vc3UwbFMyVmEzY05QWEM4eStoa3htdWdCZ01oL2J3YU44NGJqeVVqWDh1?=
 =?utf-8?B?QzJ0SGRSUE52cWcyQ3ZXeVRXU0JSRHlub0p2ZmRIRExVNVlQOVc1MWFjeUJY?=
 =?utf-8?B?U2U3dEpzNmxSc3N3ajA2b2hXRFdFQTdTU2xjRjBGQ2x1bFZHamg5YlM4MzN5?=
 =?utf-8?B?N0ZkVGw2OG45b1EyVjZZT3dhOGR5azZNZi95UklERTMxRGp6MW5uSTdZekhs?=
 =?utf-8?B?LzMzOTZsNFE3eU5MV3UveUEwL2hjZ0VQbDZzU0VtT2syRlF5MVRRV09BT3dI?=
 =?utf-8?B?UkRrOGdMTzVzcy9rZXNjT3hoOTZJY1IwVkxsZ0lHLzZibjFiNVhTMDZ2N21M?=
 =?utf-8?B?Ynk3NkZKWTJVREZzbW9TZEpVOWY5a1JhbDlGb1ZFZ21RVUJSdU9nMTZ4b3kw?=
 =?utf-8?B?UmswYXRBRDdTRWJtNERLV0F2SE8vMlEwb2tySDYwZlpaOTBPc3dWVUQxL0M5?=
 =?utf-8?B?SDRQK2d6N0xJUnhad0dUcUNrU25DcExkMk5xSGxEQ1VIR0tONGd3SUZJVVVa?=
 =?utf-8?B?citXRS90bWdsVkNSYk5Za2NuQXM0cnhab2RQa3BtWjVGdEhYbTV2M1RJTU40?=
 =?utf-8?B?T0pyT0IrQVVjVzk4ZHhNMmNIVnl1ayt0YS9HL0MrSzhHb1Bvd0pUR2lNZ1pv?=
 =?utf-8?B?c3ErcUtJVTgrT3VGZFlMYkdRR1h2cHRZcXhlYVV6aWJBbEFrUmo2TEMrbE9K?=
 =?utf-8?B?dTJWY1o4Mm9EZ1B0RzJ1WWJvYWFjdHdJeWpUeXYzNWIxZUNKRzBLSFp6Mk0y?=
 =?utf-8?B?SXZScjJ4dEhvdHUxZGthdW9BVzlrcTJPWExBQzVyZy9aUXErQUtHVVRjZWxU?=
 =?utf-8?B?T3liakFCdytETHFYbzg0WnE1RURmWWZocENUTDMyckQvYmJPUVF1OFNZVXZi?=
 =?utf-8?B?YnZ6V0dVaTVxbUpRUlFxbzBKVlN0RENZU0RHcWtTUitibVYzclJsY01icnYy?=
 =?utf-8?B?RXBjZVNDQncxNndRdTZJWVd3cXFyWHEwSURsTXVDbjh6MEJTeGxoRDdmYkN3?=
 =?utf-8?B?bEIvZk5ubUpUM25YWlRqQVF4NWhNUjdwL1NBWUI2VDU4YmUyYmx2bjB1Vi95?=
 =?utf-8?B?djdPWU5Jcmh3KzBGQVpFV1FLL3R4bFhGaFZDdkpidlpWbUdkVlZMdk93a1lX?=
 =?utf-8?B?VjBMZTZlamRDUDdUMEN3RVliV01PRU5UaXo4eGNQYVZOdkUxTU4yVitiWGhQ?=
 =?utf-8?B?OWxmdHVIbjNyTHc2czhvNFhpSHNOR1h6bVdrUTJPeU5ZNzFZRXZ4NDJnTUxm?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jjhQMmggV63pyQzw+AEGA3luLPUfM6Zptzih7eaxaeCzwFkmsFoSEq4R+ZEq9xrNfD0oE/pr6zea9VgJlYUK0M1r9BwbhoTXJgh8MeEuWElkPFMb7RYMo6aAM4rZou/S7EN7REbkH6g+YllG44Ya+KVbWpWWsy8YtrMh6UaifAvuNWHs1hnq6QPRbSzVVaA0hwdMZhiQn14k0+/mQQThWaR9i8AjZ39cFyhuSFTca8aKSLfdfsxdMNxK5RzB1LYC5CVA6VDisoShbfg7Km4G4gCJZ3/EXJHR7TU2EJUtFSkzhptbvy0LJZG2UcThpiTUpfyhmzrnCjbQlQQG8r/ah9BWgrsxRQNvMf757YGzpeVuXDjUIUDYLspAny1xu8sxmYAJzblxVTxytMemO1jeFgaPihIV1YXtsVKT0ygtNx7rpecvAgUF208ly4rCgUaC7JHlovR2VG1ufTA/c3csMA20l1wKPDnLNHR3qTfhLkFBaV0IdhBAGVg8+zpEFeqzbqhAG/DH5x9+33MXm1LATgZtrnKeVrZl/bQD+zlliwuKQjQdZ0GjvUmp7jdG285+42sme5jkxgFKanybBohkLaZVjlU9a98DBwgD3DBsGuM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78104d7-5ac5-40ea-8858-08dd18648747
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 15:17:00.4194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCgkr6VtpZDpkQEv6EEAtcj9Yxe6UIhyDljNaOx0qMjyk0+u2Fd2dLIOzNChIiuC7WeegyYS8nv76Ou+MEqXt+UChi8r9vTVYlDELCwTLrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6883
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_12,2024-12-09_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412090119
X-Proofpoint-GUID: 3eTEdtrudpRPB-LN_dtYCmokLVLSA2xF
X-Proofpoint-ORIG-GUID: 3eTEdtrudpRPB-LN_dtYCmokLVLSA2xF

On Mon, Dec 09, 2024 at 04:03:59PM +0100, David Hildenbrand wrote:
> On 09.12.24 15:45, Lorenzo Stoakes wrote:
> > On Mon, Dec 09, 2024 at 03:38:28PM +0100, Jann Horn wrote:
> > > On Mon, Dec 9, 2024 at 3:11 PM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > > On Mon, Dec 09, 2024 at 03:00:08PM +0100, David Hildenbrand wrote:
> > > > > On 09.12.24 14:25, Vlastimil Babka wrote:
> > > > > > On 12/9/24 10:16, David Hildenbrand wrote:
> > > > > > > On 06.12.24 20:16, Lorenzo Stoakes wrote:
> > > > > > > > There are a number of means of interacting with VMA operations within mm,
> > > > > > > > and we have on occasion not been made aware of impactful changes due to
> > > > > > > > these sitting in different files, most recently in [0].
> > > > > > > >
> > > > > > > > Correct this by bringing all VMA operations under the same section in
> > > > > > > > MAINTAINERS. Additionally take the opportunity to combine MEMORY MAPPING
> > > > > > > > with VMA as there needn't be two entries as they amount to the same thing.
> > > > > > > >
> > > > > > > > [0]:https://lore.kernel.org/linux-mm/CAG48ez0siYGB8GP5+Szgj2ovBZAkL6Zi4n6GUAjzzjFV9LTkRQ@mail.gmail.com/
> > > > > > > >
> > > > > > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > > > > > ---
> > > > > > > >     MAINTAINERS | 19 +++++++------------
> > > > > > > >     1 file changed, 7 insertions(+), 12 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > > > index 1e930c7a58b1..95db20c26f5f 100644
> > > > > > > > --- a/MAINTAINERS
> > > > > > > > +++ b/MAINTAINERS
> > > > > > > > @@ -15060,18 +15060,6 @@ F:     tools/mm/
> > > > > > > >     F:   tools/testing/selftests/mm/
> > > > > > > >     N:   include/linux/page[-_]*
> > > > > > > >
> > > > > > > > -MEMORY MAPPING
> > > > > > > > -M:     Andrew Morton <akpm@linux-foundation.org>
> > > > > > > > -M:     Liam R. Howlett <Liam.Howlett@oracle.com>
> > > > > > > > -M:     Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > > > > > -R:     Vlastimil Babka <vbabka@suse.cz>
> > > > > > > > -R:     Jann Horn <jannh@google.com>
> > > > > > > > -L:     linux-mm@kvack.org
> > > > > > > > -S:     Maintained
> > > > > > > > -W:     http://www.linux-mm.org
> > > > > > > > -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > > > > > > > -F:     mm/mmap.c
> > > > > > > > -
> > > > > > > >     MEMORY TECHNOLOGY DEVICES (MTD)
> > > > > > > >     M:   Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > > > >     M:   Richard Weinberger <richard@nod.at>
> > > > > > > > @@ -25028,6 +25016,13 @@ L:     linux-mm@kvack.org
> > > > > > > >     S:   Maintained
> > > > > > > >     W:   https://www.linux-mm.org
> > > > > > > >     T:   git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > > > > > > > +F:     mm/madvise.c
> > > > > > > > +F:     mm/mlock.c
> > > > > > > > +F:     mm/mmap.c
> > > > > > > > +F:     mm/mprotect.c
> > > > > > > > +F:     mm/mremap.c
> > > > > > > > +F:     mm/mseal.c
> > > > > > > > +F:     mm/msync.c
> > > > > > >
> > > > > > > Not sure about mprotect.c, mlock.c and madvise.c, though. I'd claim that
> > > > > > > the real "magic" they perform is in page table handling and not
> > > > > > > primarily VMA handling (yes, both do VMA changes, but they are the
> > > > > > > "easy" part ;) ).
> > > > > >
> > > > > > I'd think that moving vma files into MEMORY MAPPING (and not the other way)
> > > > > > would result in a better overal name, that would be a better fit for the
> > > > > > newly added files too?
> > > > >
> > > > > Maybe. I think vma.c should likely have a different set of maintainers than
> > > > > madvise.c and mprotect.c. (again, the magic is in page table modifications)
> > > >
> > > > The bulk of the logic in mremap.c is related to page tables so by this
> > > > logic then, that is out too, right?
> > >
> > > FWIW, I think technically you can have multiple entries in MAINTAINERS
> > > that cover the same file, maybe that would make sense for files that
> > > belong to multiple parts of the kernel? Or maybe I'm making things too
> > > complicated and it'd be simpler to have some kind of more generic
> > > "core MM for userspace mappings" entry or such.
> >
> > I think it's faintly ludicrous to separate things on the basis of whether
> > they explicitly manipulate one part of the kernel or another, and it'd be
> > an odd thing to be trusted with one 'portion' of a file based on some fuzzy
> > sense of which bits are 'magic' and therefore out of bounds and which are
> > presumably not...
> >
> > I don't think it makes sense to separate the 'VMA' bits from these files
> > other than perhaps refactoring things a bit (badly needed actually).
> >
> > The page table manipulation very sorely needs improvement and
> > de-duplication, I am somewhat taken aback that it is thought that I might
> > not be able to do so given I had already paid serious consideration to
> > doing work in this area based on guard page work (not sure if that work
> > would now be welcome?)
> >
> > To me I politely disagree with the assessment made here, but if a senior
> > member of the kernel objects of course I'll withdraw it.
> >
> > But yeah I don't think that's workable. We will just have to hope that we
> > notice mremap changes that might be problematic going forward, I might
> > therefore update my lei settings accordingly...
> >
>
> I have the feeling you take this personally; please don't.

Sure sorry it's text being a bad medium and this sort of thing _inevitably_
being a fraught subject :)

I have a great deal of respect for you so my imagining that you might think
I couldn't do things in this area was slightly shocking, but I suspect this
is, in fact, on reflection, not at all what you meant.

So sorry, I don't intend for this to be anything other than a functional
converastion to determine how best for us to manage workload and avoid
issues in future.

If you see my other mail with suggested ways forward, hopefully one of
those will help ensure appropriate separation and distribution of
workload/responsibility (am of course also open to whatever you might
suggest!)

>
> Maybe my other mail with "VMA users" vs. "basic VMA functionality" makes it
> clearer what I mean.
>
> For example, mm/userfaultfd.c also performs VMA modifications. kernel/fork.c
> does a bunch of that. I neither think these should go under VMA nor that it
> should be split up.

Yeah and I _hate_ that. I mean talk to me about fs/userfaultfd.c, but maybe
only after a few pints :) Or bits of mm that live in fs, but vma-related
and not...

But these are areas to fix.

>
> Maybe there is a better way to split up things or rework the code; likely
> we'd want this code that works on VMAs to have a clean interface with the
> core vma logic in vma.c, if the current way of handling it is a problem for
> you.

I think we probably need a compromise for the time being, and as I was
saying to Jann I don't think it makes sense really to separate the VMA and
page table bits from these files _except_ when we finally have a shared
page table interface that we've spoken about before and perhaps we will
collaborate on in future :)

The key point is so we avoid stepping on landmines when we discover
something was merged in file X which we weren't cc'd on that breaks core
feature Y we have been working on in the VMA part of the code.

>
> --
> Cheers,
>
> David / dhildenb
>
>

Cheers!

