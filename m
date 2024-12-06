Return-Path: <linux-kernel+bounces-435692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1A29E7B15
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C7928369C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EF722C6D2;
	Fri,  6 Dec 2024 21:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NOcJR5ho";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Std+IzJ1"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B14204589
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 21:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733520999; cv=fail; b=W0WNMjw/TkMCTGewd95t/XmHMsGuryprYc3xIOdRSzvMK6HWnf1gm98TEP+o3SfZLwkGG1v+apA8hfQVeUclHdBN90tmLND1ISCpiD6q/hcVo5R72cmK262iMpVEJMdJPGTCIUFoV87CKhRr1b+LjjlgToOXCPzbTSNGsLQ/27o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733520999; c=relaxed/simple;
	bh=b6oiy4wg/09383GwVshr0dzM6a6Uq4w3ELQJDu31N00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SyTsuS/SlrTaHr6Bwmxnwd5vRa6+dMwB3z8mkYb9zVmh5Zo9WEq23RCCe3AJIfpk3TCrCO9Gca3Oc22YBBRzIG/5lSgOcvMKV3g4/d6Wb8L8o9HOzmDkYB0fXKeU+ulAB+QIbhqsfyzXDY/9CPKm72BRoUzpET2scPa4EclKqbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NOcJR5ho; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Std+IzJ1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6LXSK9025998;
	Fri, 6 Dec 2024 21:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=U3yfrcY/TrV5/3w3lnDWvN5/N3HZZfh6cHJUveolbHo=; b=
	NOcJR5hoS7ud7CjwOWkL57Zkp4wyhu2iI5mX8b26XESC3KwCe6d40Q7s6Mcs23gY
	Rcpudhf8+t3h7uISJQoEOXIi7txqQGEM1nTv5dakso/YT/5cc9b0HF8KHn/CoAKf
	U89515d09lci/7Qs9Xrd0wAZ5tniGHn8DGVO65nQcKRgnfVZuhzvt/KxPOQ/4s0S
	U1TIzYxa46c+xdHX/A+ltnD0jiHV4RudfRDtaJJGhlzd3GB/+ZD79Vsrn8wnE30z
	NxLC/biI9BiqD53FD3aBPYd/6ksPXUdFPH3XuqV3thW2J3kX1YdRECZBVPO3Pi0i
	CVE3JM9+e9FJWtoPxZZwEQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437u8tehcr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 21:36:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6LORqL020148;
	Fri, 6 Dec 2024 21:36:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437wjhe4wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 21:36:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDczIq+Cmm7Wud1q+pCyKwR0AjD9VdHc5X8p0Vx+liUhHZAPcvoaGh5pNCXci83UkNCVqTEz00QwxOq6kw+z9IoRpzPtBrswENSWtRFVDWxQEpe0u2t5CAkNV7v6xK3CbJFFqWaR13TCOEIwMlVmlPO8ZU4iyx/js4fGFPEktDomgf6xTi3I1IGmS8eGKHOHlL9EOWLFbu/YoA27nrpqmaHDnan5Af00fMFTYOsvlrEU9fFwkEoYo2SFrjdR5t66rxzo9Intezgdi1nk1PtaaWtWjvuCdqiBELPIr+wc0amwKu5JyhqRsOMsFqlWjElszJ25k6+N6/pvo86RSyJ8YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3yfrcY/TrV5/3w3lnDWvN5/N3HZZfh6cHJUveolbHo=;
 b=W4GVa/p6rkOlhw9p5POfBOTU8aTwxdvNS0uF9FbSZOzqjHj7oE9NwqSD22gADrqaDnrPY3s/4GyQBS2Wk6hDNVhsXRAwCQyc0K/PIz/PpT/An/z3iphhtku3mfUR+2P+g2rwYYjzwZrkq56IpXmwkGskmULSPFZeCqQJ/X2DnENLlQI7JD8rdNj+20chfUfd1krwyZUjhXr1Gsx2WDZeTiTmw8Zq5naaiBU/U9WyxMeyK2ZgJh6Ft9T+Ysy9N+WFPbWQqAwBaQWhXGS2RCRF/reqvQMYVxGUi9cDXLsbNH4Anje50IbYcs5RB1PetKbOFbOpA1oAsfmP70TNhU0/Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3yfrcY/TrV5/3w3lnDWvN5/N3HZZfh6cHJUveolbHo=;
 b=Std+IzJ1yLUN1qOdk2NrgzNa6ICioWV7n0RUazXg+dhUDRjaU0CuNJHyayL09MPOsqpVb8s/o/DtDbZs9DJn4NVX0diTF+UHimdYGyW8gQbI+zxcLkjuc1FvugNCDuh9d33HgP/W9bYWNVu3WyKMpZy8zuuvO3co9qy2jhG3TmI=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA0PR10MB7370.namprd10.prod.outlook.com (2603:10b6:208:3dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 21:36:22 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 21:36:22 +0000
Date: Fri, 6 Dec 2024 21:36:20 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: syzbot <syzbot+91cf8da9401355f946c3@syzkaller.appspotmail.com>,
        Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in __mmap_region
Message-ID: <aa37bada-558c-41cb-963d-d3106036eaa2@lucifer.local>
References: <67536a25.050a0220.a30f1.0149.GAE@google.com>
 <CAG48ez31brKBFSMW2ANZQAM4P3nzoico3yedtmBv3MK59-eeog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez31brKBFSMW2ANZQAM4P3nzoico3yedtmBv3MK59-eeog@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0319.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA0PR10MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: b26813c0-85de-4070-6c9f-08dd163e0787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEs4Zk1WUFBmN3g0U090NnNyUXo2WFR3RktIM1RCNlJIOWd5WXdIQVM0MzF5?=
 =?utf-8?B?QnlibnN0cGdoTVNUdVUvdUVkQ1hZaWlhZUllQUgwZTlBL1B3WlUzM0V3cVBi?=
 =?utf-8?B?dHNvbWdDd1g1Y21tejBMWWtzN05mRVhxQnAxQ2VyaUQ4dlpxSlEycTdTZWJr?=
 =?utf-8?B?b1FZQWZUQnNWUnY2dFdzWFkyajZYNXg1Rm9zenRMdkhBQ1VmMThIS0MycUhS?=
 =?utf-8?B?ZGMrNVlSekhsN3p4bmNwMUhIWjRJeFlUVkhMN2Zzc1ZCK3F3K0xsV3lTc01Y?=
 =?utf-8?B?bkVUOWJMU0UvSUViaWxKMUtVT3FyY1prZDk1N1VqeE90OWZBdE9iR1kxcVhl?=
 =?utf-8?B?SU9xc0lpdHdDVDlCOGZQRThaUlUzSHh0UWd0dTlyQkg5c2pncGdPalZ4d3Jn?=
 =?utf-8?B?MyszQWc2L0JFU21jU0w4OGZiTlI0K1RHeEYvTVJ4SmJEWHdweFQ0akRpM2pX?=
 =?utf-8?B?NTdSSDR5N1hvMmFwZ01MdHRSVDhsMU9FK3I0Vnk2OFp1RHNxQUpCaUZJS0c2?=
 =?utf-8?B?YnRuMHlCc3JaV0pIMkg0WGpOL2xQMDJzOFJybkJId3VvQ05KVFZHTEdCNzJh?=
 =?utf-8?B?T0N4dEVVZVltMXo5STJDOUNham1nSmkyeVhJSkkvdENkNDZiSW5kWC85K3RY?=
 =?utf-8?B?amVMY0E0dTRCVittcGdyVTd2YjdtMlhtMlF4VXdUTU13TWFnOXQxOE1yRnhq?=
 =?utf-8?B?RG9PMlRFbDBvWFBiNzBEUWlSbmN0V1JUbWhYMTJUcjlFemVxM1U1UUVjNGpx?=
 =?utf-8?B?MnAza0c3aEdhbHI5S0Z5Ny9oZE53WExFSTJ0U1pXd3RQelNMb09ETHpTNDJ1?=
 =?utf-8?B?c2dibnZ4cVNWVTdPdFh5UjNwVGRLc1hZWldGTlI0SzlrVmJWZVNwMUV5eGF0?=
 =?utf-8?B?V29rcE9IdjA3WWhPRWZ3RWZLR25EL1hKR1hOZ1dKV3pCZ0lXcUY4aDdEYUVz?=
 =?utf-8?B?YWl3YklrdVp0NUJrazlIYTA2TG84QzhSQ3hFcFhxbXIyeGFSeVRkMTlQWEtH?=
 =?utf-8?B?RjE0MVNQWHlvL2VaNlB3TmJ6NC9VQ3I5OVg0d3hhZTUwK0FVbXkzYWczaW5O?=
 =?utf-8?B?OUNPM0lQOUt1Rnp3TGtiN21ZL1B3eWg1UGNGbVIxTUZMVlc1ekhyZkIzT2Rr?=
 =?utf-8?B?T3BQMjFJVzJ2bzNDN1R1VDU4d2k5SXpJQ1VaS3JYbjU4K3crdjV2MjJ2TUZN?=
 =?utf-8?B?YXdNMCtWZXh2TVFmZDhwekpiQTg1Rk5KempVL0FDZitVdStxamhJTStZdXkz?=
 =?utf-8?B?cENuV01NMHd2eUd4TGh1aHlqd1FBbmVTNWQxYTBGeTZzd3kzSzdxakdmTDd2?=
 =?utf-8?B?OTM5ZHU1SU4xSi92U2hWQkFMTXlMQ2hPcUFTdTgzaTFRK1h5MmlLYVFjaTFr?=
 =?utf-8?B?Mm1mWkNmTnhoU2tqVGgxaDluOVYyaGlSTHpjeHdHcC9oNCt2SXd3bkQyalNF?=
 =?utf-8?B?amtNRXozaC9IejZpK0h6clVnQm5wSFV0cWlmY3JWTjhGbURsNUpIMmtVR3BK?=
 =?utf-8?B?VWdxNUM3OWp2WEx6Vk4vL0p2UXJkbGI5eGdXaCtpZG5sMi9mTjFVZmgzQnlr?=
 =?utf-8?B?Yis1Z0tDWWlZOVlTWStDQWlTWlFnaWtMaUdqZ2RkcHJnSjFIMFFQRytYUmNj?=
 =?utf-8?B?UU1JWUtieDFtck1XY2VlOU82ZnI4L1dob0VYdmN4Y0pzaTgwR0Rzb3JvMDFv?=
 =?utf-8?B?aE1TblpCb3U0ZWltMy9YMGd5TW14aTMyYW02dGVtRHdRZExIWS9oV0VOeDV0?=
 =?utf-8?Q?PG6YkfoG1LXU4xER8g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTY5WVk4OWk1M0wxamJiNTFIc0F0ekZSOEJreXVBb1UxMFNFbjBEeWVKZEFX?=
 =?utf-8?B?YWlzS0J3L092bWtTc0JJVlNScXJkbTZ4TTVVVFcwOG5WYm5qbVhDZ0JkL3ph?=
 =?utf-8?B?TmljSHFxelM5Q2xSS2xMR3JlN1QvZXd2LzBkQjkvMXRkYXhqN2RxZWhnVlEw?=
 =?utf-8?B?UWxQSmVJWSsvVkJnUC9iK3lKRXpNckp4dm92THJkOFdrVEFoSnpMVi9QUWI2?=
 =?utf-8?B?ampPb0xEWmNKN1FlUWQvV2d1OTRVWEpZeStnenZkVUFtTEE2a2s3VGkyRHRt?=
 =?utf-8?B?RG5qUXVONEt0NFpiME0xeGN4YlBUNW9QUTlVdjdOZXpLVmgvYUIvb2hFSFB6?=
 =?utf-8?B?TjRKcmpxU3VLUitWeEphZm9SczcyKzdOd25SK1ZOVnc3SG1JNmR4Sk9oaVk1?=
 =?utf-8?B?SW1qL3p2Q2dOWkFPZ3BSOFhlV2RSb0d1ajR6VW5MM09PUVByUVhZN3BXOUdx?=
 =?utf-8?B?aWg1dnJEa0lyZGFxdU1XV0NyTjhzNXpydnJXOHBzUmpBWnhLSGJMd2hFYktE?=
 =?utf-8?B?OW9PYnl3UE55WlVmaDhRN3pYSHJrek15WkdYMjZLMU5laUpQVk93cFh5Zm0x?=
 =?utf-8?B?cHFaQzR6VHVhSjdKZForZGticmQzWitTb0FVcGRyeGhUbm41QUNieFBVeXhU?=
 =?utf-8?B?ZDZOcytPdTdLTDJFRStna0RZeElQZFlHSXZralFzKzdFTnRDMHFlTGNyNmlw?=
 =?utf-8?B?YjUrY2czMHA5MWg3S2JDUnFvNjh3RFM0VHVSUVZ1Y0szMXlPTnFiNGpBa3NY?=
 =?utf-8?B?dWdrMmhFS2lKTDU2Zzd2cTFxbWhOM1l3YnpZMmVicVV6aloraE9IRklkdExv?=
 =?utf-8?B?Q0FCQitIRmtrdXMrbTJsakZmaWQxTHNxZ2tlZ3RrQnY1eUd4TXJMc2Q0ZUNB?=
 =?utf-8?B?UFJnREZ4SHQ3UzkxL0hBcFJ4emFVeTQ0Q1lac3NUYnN0Y2VsOXFvSC9DOU1T?=
 =?utf-8?B?T005VW50dkRpVU9GNi9UVU1qRTlaWGlkZHVpaytPRzF0RkJDNG55MXo4d0hz?=
 =?utf-8?B?b1p5ZS80ZnlpUEpTMXZBT29uNmNIOVVHbDZFckxBU3ZPaW5rc1JhUW4yd1lx?=
 =?utf-8?B?bUhYRXZ6eDZBRmN6S0pNWitnOVVrd3NXTWR4TzNaMEpwRE5hWVBSb3pYMHJ2?=
 =?utf-8?B?aXU2Y3RKeHkyakFJOTdId1oyVFd1MVZBekVFd2JuN01ydEhzdlExb1dLTjNk?=
 =?utf-8?B?LzdpeUxCVkQ1WUdmUXB1UUcwS3puUGg3b3IyNDZjRXIvRElPQ0hESklaVTdo?=
 =?utf-8?B?NEhsWjhlM0xLL2x5L1F1emFDREMycDNnYXB4dW9VWVpSQ0RyQjc4Qk5QYWFD?=
 =?utf-8?B?eHhteHdtaDNPNkczNjAyZ2VtY0lhRkpyWlkrdmg3eFVRVk1obkhOQk9YTWdY?=
 =?utf-8?B?d1V6ZkQxQ3Y2Vm1oV1VlbHk3Y2JkSmJUWkV5TkdrbGJJbUExNzRFSkM5dzZR?=
 =?utf-8?B?UTdGamdKaHM1WmRwekoxWm9EbUFuQkgvd1JYbVRRTUQ4Q2IrK3grVVRFTlRY?=
 =?utf-8?B?Y0trc2dES0NpVmIvNHZZZkVqczVHRlNtNHFCYk9aMHpJa2ZyQUMvbmNzR0x1?=
 =?utf-8?B?bFN3aVBpalZQaG5jQXNIWEFOeVB4VVZMbFROTzd6dFdObkg0aWl3Qnp5TTkr?=
 =?utf-8?B?N3FCM1FIM1VDVUp5OXNpRlNQaVZ6VnBuaEdBRUNtTEhFZVJmdmtzMXBCWlA1?=
 =?utf-8?B?alhybmtoOUx6Vld3VDdOT3hGRDRlMWh3cC9pZzVpRThzMDV5WXlsVU4zbm5a?=
 =?utf-8?B?bS8vMFQyeHZHbkdxREszU3pCN2pZRm1Ta0NPYkcrc3NoZGpRWGxSR1poSVlv?=
 =?utf-8?B?K3RYR1dkWWtSK1BNQnlXL25xK2FSWlpta1Fvb09sM3d2UHVYQlRGeGM5ei9z?=
 =?utf-8?B?UW1maHZqVnB1Z3ZEZkY1LzZyY2lCNkhqd1J6ajUzcGtmbUkxeXNhYUhVODd3?=
 =?utf-8?B?Zmg2RElaRklzczZNK2F5UVQxKzRra0RyaUxwMFVNUnhsWStHYjA5am9zaHpT?=
 =?utf-8?B?NU1VbHZBQkxFOUFkU3BpMER0QWxtUUFwMThCQmxwWGJ5am9Ic3VyNFB0ZUNE?=
 =?utf-8?B?c3hVQ0xyYVRkbTZpWVUvaGNXV0RkaXVJY0YvdW9MVGt4anZmbmNrK1I3Tjda?=
 =?utf-8?B?SnlsZEthMGVqYjRldVhwY1NzNzlJSHpWUldQSWwrUkJjZERONVdzS0VqWHlU?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tdm7Y+Xnwv9U6BWly9I0C6tpr8vrf2kwv1Tg4/QIYHldF0fC+PF5LRkCwiHb+ySFAVFVzEnGgb8xbZEvr5+Wt+wCMh1LOa5mkvtK1MnlugVw0WDtIJqI+a9GmOupNOelp7YhIJTgEsNARN3OXM7I70e+vnEJuBpaPSGGagzMR+GD7lWhlCMGxycGym13k2I5jNNNi8BuIcjskFh9E5rIJUra47yt2MLBDpCYPzcP00yfbxidcyIImo806H5FwKgufEZzWQNV7fJSEKDTgzMXf3Ix+aK9BRFeoH8mS/Z6ToXsVq6Qml5LwptLlRStzzZYAj5Kurnf8bF9KTmPG82RUqxZ5aO0iI/Fh4254Pv00O4TO3oZut84jLnWaOBJEbLh5FUPDeOpscbsXtPBa5MN9nX///7j716kE+7XbmzyGVj8QHN384INW4N2YkAsA1MqUURD0OSTUgD2hbRaU0ZvU5njIrwZ3lyRvCe3DSnDPlaifpRPukbpEcpllckatVApr12HIb7k1JZ3yH9YFqjB2E+1chJCe0ylinw6NmK1PM8rggyWPjodOJimQHd0F9N61Wksk4yxZHm6z9X5FHZeVqtzir9rUt8qTL08tWFRjYA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b26813c0-85de-4070-6c9f-08dd163e0787
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 21:36:22.7465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NMwvBlYKR3Z/m+JXi1t+zWFw/17byA9UDCccgL9b5d8nQjxbJyqnWbtTCRaOQSVhFmcjpboBnWJVQebvkleebI3ysh7bQpm1ymNbnGElTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7370
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-06_15,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=751
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412060163
X-Proofpoint-ORIG-GUID: qGnACrUKcBD1W4gZH_Kat8FHIrthknmE
X-Proofpoint-GUID: qGnACrUKcBD1W4gZH_Kat8FHIrthknmE

On Fri, Dec 06, 2024 at 10:29:39PM +0100, Jann Horn wrote:
> On Fri, Dec 6, 2024 at 10:18 PM syzbot
> <syzbot+91cf8da9401355f946c3@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    e70140ba0d2b Get rid of 'remove_new' relic from platform d..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13300330580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=91cf8da9401355f946c3
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124130df980000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a280f8580000
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-e70140ba.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/91f313d8125b/vmlinux-e70140ba.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/a9bdf286943a/bzImage-e70140ba.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+91cf8da9401355f946c3@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KASAN: slab-use-after-free in __mmap_complete mm/vma.c:2408 [inline]
> > BUG: KASAN: slab-use-after-free in __mmap_region+0x1802/0x2cd0 mm/vma.c:2469
> > Read of size 8 at addr ffff8880403a6118 by task syz-executor239/5461
>
> This looks like it was introduced by commit 5ac87a885aec ("mm: defer
> second attempt at merge on mmap()"), which went into 6.13-rc1? From a
> glance it seems like the "vma_merge_existing_range(&vmg)" in
> __mmap_region() needs a "vma = " at the start of the line.

Thanks so much for so quickly noticing this...!!

Ugh you're right, what a mistake. This would fit the report completely too,
as the existing VMA would be freed etc. etc.

I'll write a test to trigger this path soon, writing mmap_region() unit
tests is on my TODO list now they're in vma.c

The line referenced seems to be to vm_stat_account(), which references
vma->vm_flags which is in other words the first time we try to access the
vma pointer, UAF...

Patch incoming in one second.

