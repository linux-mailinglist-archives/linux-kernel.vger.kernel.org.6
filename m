Return-Path: <linux-kernel+bounces-409962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB069C94A5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE03A28134B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E2E1AC444;
	Thu, 14 Nov 2024 21:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="b4kDdkPP";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ucL0QWOV"
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359EC2AE77
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731620748; cv=fail; b=UlsYuSY0+/t9GC93WBCcedkZzXdFvI1fqC4RJ4zhADK4XcN5+5iVzimuQkcuW8PjAXgt9qau9/uFxlkd7wXGfeX3PxjcUs7YTrACuuw8qg4AhdqV65fBEQRmRo7fk2W0DMIOaxIDhJnIDsolwLET44ghPUFX9CShnfn/C9gX+wY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731620748; c=relaxed/simple;
	bh=Hbs2iJDkXA7Ixv2P6U7foewD4qOOmlYE8GK4I1c3Kg0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GnSlZJD6geoHZasMpOPadQWIPSfwJl2japywqNR8SQBzrPShWRX5+LD3yJseFUaRfa2Fv1HVifRFkw+VndGIBTs8Yt3nqDdz0V5mLoCuvmrsEVO3A0wRdVGS3nrKrLFjwb6Oa2rFQ0kKkx9vtSLEJb+hUrKDYliFDDttFEoQ71I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=b4kDdkPP; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=ucL0QWOV; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AECNP1w014859;
	Thu, 14 Nov 2024 13:45:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=vf3MXkjw087ep
	31guJav1a5vU87IiYCL4fWzqDGOqdU=; b=b4kDdkPP+cheQl1om+d8OGooAXI8H
	mwfOLhLylE5L77Czo2lhW+NUd71iLktUMJ5ENci2tiBtN70riserk+Nkil1rnx5k
	oBKJF8Bc7QSSbtM7oVgqpED0y9tXN0xr4IpCBi+1gWdpb35TaNxU2kLF5EcF0k2o
	M1x7bOSXnktiSfHDtkpIxOvufkVfQIpsxEpWwWpaXc9GB2JUfjUsVYVr7mwbgQXq
	EFo6zJ6+07yPJiYIwKUtfwURPG3u94THzuaHqH31ePEGiSo2Md4Vwm3huLUomYHx
	1KGI66Ro1KwvchHpXID+gfKeELLIBuSvWn/z/IYHueiRUXajM6elNkQ7g==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 42t7xf5xbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 13:45:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwueBUurYvqBKym07xEFqex8h+PF7ncXgO0haajvoyFGIoDCC7jGCZMPLiu9nRepOL3ynO2HLt81QsyyDfaoyqXG6+jluLZfXCQyrPBn19hqqRdFCi7yPxKfN9sg+Mbo4brlNRPR3Ku+Fm8tvLn/SqjDfSBlJwmekT2Z3LVNePmUaE/rX3F70R+CknPm9xX5xXUhb1ckRVXmTrPQeEqnNeDaBKZaPg5fPIe5jz+HcPGRAPFOIsRym3Hfc6J5FSSZgWlAqi15m74JPqaIaEW4i/ZUsYV07qMnkQvd5OpLio4wuU5vLsuPGHQ8AKqrqhfO3QOvJta9ipFPUNkDgFun6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vf3MXkjw087ep31guJav1a5vU87IiYCL4fWzqDGOqdU=;
 b=hnr00oL2DGD21jTpCNxfqd64BB3a92bueniCeCq3N/xfxHavV60ILDVA7Hl2pbbcZV7XPZ6NvKwzs4bvB2XjW53mu1NPqqeEm/flUUo8iLdwXlrytqs7c+Dw5ocIGTYowtoEsH1Y6ymSaNUKoHV808pxXPdUhVQLtU4iT58si6iNxV3B59uiMIB2viFkR3SU/DKp4DfLaNPU+CmgycVHMaESgjC2orFgORY01wUGuIFdnorLZP+yxpariA7JiERu1RgE16TOkJs8dH+gtem4F+OZU/pcea/To/3M50yyDs1fC/SxN/IDgXkw29wjau1BJtJR0W4XcGCGQMOm62ObHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf3MXkjw087ep31guJav1a5vU87IiYCL4fWzqDGOqdU=;
 b=ucL0QWOVOfI8NX6iRxy0la/rWFLbM6qwWb6aT4yTG8N2N5A3qUxzPQopHo8itLW9q/ecHpb6EhvUZ0iABH8lkFUarV1sRasm+ksorchN+HAZNjYpTT5i8EnLYAlRlT/yQaXhrySpM4DOFw+EQwT1kvyFcwr3CC8n2KQVDfl2lnMpLHuQ65JuVzet6somwyl5nprHw1R1UegEGk3FGCuc0GK0m5cZj9aKabZhLnm6gIxz2tLDlGXixEjlioq5q2jp0ZuEC0cWiq9MxL1CAcbhv/6J0Syp1W70UpsNiSaHPQKNqy+s8tA26mGayUjlOl3aZnc0B1fwriFFekw3HcyRPA==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by SJ2PR02MB9894.namprd02.prod.outlook.com
 (2603:10b6:a03:537::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 21:45:27 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 21:45:27 +0000
From: Jon Kohler <jon@nutanix.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH] sched/rt: use for_each_cpu_wrap to iterate over rto_mask
Date: Thu, 14 Nov 2024 15:05:58 -0700
Message-ID: <20241114220558.1842569-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0049.namprd17.prod.outlook.com
 (2603:10b6:a03:167::26) To LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR02MB10287:EE_|SJ2PR02MB9894:EE_
X-MS-Office365-Filtering-Correlation-Id: ce942bc9-f623-4b15-73a1-08dd04f5a6a9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pEh2zCSwbLFFgBuW1+Ik0SQXjzc/ZjgvaCbgNOWrrBVrkbZ5278TBkCJ5sRK?=
 =?us-ascii?Q?PC5GItuEab+C8xInrsQO8NQ8TPZeKlBeGC+c3OBNeaclGgqa7o4grS97sIRN?=
 =?us-ascii?Q?BcNFVp9OQw13g2hi5+ndVdmWb4ajMqykENh7/RvuIKQCp+BLZAq7F4utGJjD?=
 =?us-ascii?Q?obILHecqNQwH49nkAVqV2dKCvruBqg2Bx+oVPyg3WKKl/6F6pEy0pRKyDDd3?=
 =?us-ascii?Q?yHDVuHbSfISkAwpJovSfryM3tddZ0LoWZJiwqHXMkkK9NEvp6lY2b2rbo8wN?=
 =?us-ascii?Q?3UTyCwMMpwTNxnF6Fna8OLm3NqN3gKjWdkIunm2+iO6q9eTDHyEXq2qkCVMh?=
 =?us-ascii?Q?4xSS5kj1Of0VXm1PQK/tf2v2YvduI10i/Tjo/ppwRzNm5m0pXzjLB7hnp1vx?=
 =?us-ascii?Q?nwRA/85i7PXIOO0k2gHrgQGo0yePUlF0esXoI3rxVTR0DniHIyjLtIw+g+Vn?=
 =?us-ascii?Q?HoPo2ZPgISQnKf4bLdII/SNXhgpAB6/kXASZTD7t3u9p+OGBaq8SHWCAcLV6?=
 =?us-ascii?Q?bf7HAc7IGicl7XsTpjPBHSUs8UjgDNtWKr6xJWxPjEjWTKiV9AMcIYniKplw?=
 =?us-ascii?Q?97heWqbZRnjiPYO/o0ILxnN4ErgGhLO0ITGrI5ltvvXkjHlS/Uyp7mnImhR7?=
 =?us-ascii?Q?RBu0JuhVTgy2dcCHsCGUJKmxaTa2vsHAK4uHo+m07jBT4mVWU98Uo0pWhtJp?=
 =?us-ascii?Q?2skwaJ5rLhycBMeQDMYcocH0Zrs6SnCoiSMYq5cFfuT+Z71FNIT8vXoQ+Oxs?=
 =?us-ascii?Q?KJw7ODvDkX/mBed9Tf0QXzSEE42EWK6PAVnFGfVJJgCTH8eaHh0S4XfrFzPP?=
 =?us-ascii?Q?PoumpI9lQ0TzAYULnarwiHDIs5rJ9nb9V1J3vOrxD3QdmtqXub/rJnQ+ybpd?=
 =?us-ascii?Q?chvLr4kkIFoq4NkAN8nqBurB7KiEe9L2QhSgP8BM3Jc1KVvhsW5vEBe1vVVY?=
 =?us-ascii?Q?PR3P240rvQKCxEzBo+FJVmr6Dp2QYntDuBqS8UFd3IqE4NjRFu62xdtg3FaT?=
 =?us-ascii?Q?9v0lkbOydfNslPHNN0Ispkp62/8UHz9B2RUHiONIkmvRgKFbgQH5203b3RpW?=
 =?us-ascii?Q?9Hh29It/bucttOWDyU2/f4eJpruxNQC1NB0//fpwY+v6FuEiRtrBVgXP90ym?=
 =?us-ascii?Q?rq61AOcdgSYC3rtyaTa5ds9J1Nqro9RYDWbKYnooAcuI24IkfUHckkw1qkTs?=
 =?us-ascii?Q?b0pgYtEgQL2vh77KVQWU0z5bLWIiNBkKqykBhOLL4VC7TBWLNmVvW0wkLHjo?=
 =?us-ascii?Q?kO9VsF6itz4vxjOVNg1b/tFsOg/9M8PXxb923etU4sH3pxyUQVsgcTW7C9Lt?=
 =?us-ascii?Q?cl0IRNIoR+N5pX1T/23DkVZuQg42K2DyYBCnRA7PpkskRZyW/tpdcsL/xdnc?=
 =?us-ascii?Q?wM2GPmHOfr1fXFTqYlyjfQCYEYi3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rGlzUxx1wGz350onwJ/4QObDyHfHJLuR6ca3+buziycqf86BYKidSW1aWIei?=
 =?us-ascii?Q?aMgs3F0uShpkpoWSkI6XyfOso2XRmcNXXhR7rpRRldqKokDyBpWuNEu8rkd0?=
 =?us-ascii?Q?paldFcaN24BrtJT+CNHO6Jm8ME4L4BNHiWfollE/3tJR22B5+VQVeda43nNO?=
 =?us-ascii?Q?crq7wyahPyG7wOE1EmOe8J83KvpibMa40zst89EdYk+0C906IMGTc5XLlfvy?=
 =?us-ascii?Q?xJLlv0SJIBMrx8Fyq3D+OOZT2PltsenVWz7WoovO93RywTHGZ49oJjIItVXP?=
 =?us-ascii?Q?lhAcMUYOJ9PS60KL5sk2uVnqKWp59wwQa5CJhkBpkTVVrCCZRAVgBxDVxxGG?=
 =?us-ascii?Q?qQDOI5wyV+4vF7PJqKtyIBJr2sE05Di6QgBK8n1JuTSYYYcyzmQWqRnGnkdd?=
 =?us-ascii?Q?yA4aGolqGUP5PAgbwLsME+Mbo4VMD4TssRPnVS7mOqzEBRLoJEuMf+Z54x31?=
 =?us-ascii?Q?SI4hBzLKQbBxB/wnsJPemvKydzsFKq1KjwaZvCgGXJrcJ4gy3flhiybyIXVL?=
 =?us-ascii?Q?dzPnIDXCWSzpJ9y3hL9kWoocKD/HrDYz5yq8Dig1YIgdBwcyfohkSELncdUj?=
 =?us-ascii?Q?77r1CGQmojIxDT5ben4lMTkvffZTIb46mJAKLbjMnTjaUcHvZVneMdx/e4VZ?=
 =?us-ascii?Q?+n/n9NS4COZli8P5ex99ITubC6jWFD8zR1fy3bDXaByJ8dZmN1dzwKrTVYmp?=
 =?us-ascii?Q?Hv6izeDcSA85gONqK21hkjemBNOl8xWvNghzmqUkePGcdGts6HZhabWwT2Ef?=
 =?us-ascii?Q?UipFt/eZPXssCcE+dswlEWows5JmqQuTTrErkmFvDmSEriysRzgUc98XNXYk?=
 =?us-ascii?Q?83bay0n7feIvV4zvflog5JoDxIbtz6s5pQIkw3JnkdPfBOZgwOtGnMD7ZNyP?=
 =?us-ascii?Q?lNYBveZ2RSB1bi6OV0+icgoqwQ47UsiYLgB0/KBEjZoA1Fb4Vml2KVu8WJEJ?=
 =?us-ascii?Q?SQzziiZAL+0+E5UVCLt5ZcTAk1hIcqf5Lq/xB29Itjo0yon6z2pDCwtbjG+7?=
 =?us-ascii?Q?CYBx+6TSeDZwP2cPc/5hXz1wkpjDgCOa8pOH/gGglNvWMpZZbbMJeQaoZfiv?=
 =?us-ascii?Q?VmddDaXmBqPFNgoEcZzVlw8bbIfsXu4yOJFfd1vBh/SBajnvaiWPGb0nnC2s?=
 =?us-ascii?Q?hG02zvLz22guQhIloqn1D7KDFRc9ql+zPiDyGvNH/K3XlF2YWAAlsnqGmyJP?=
 =?us-ascii?Q?/hk1FJKlJNNCRuUEHbdj715rVCzYIz3w/sr/XYkEhaoti9LBHpo8qNY4dyui?=
 =?us-ascii?Q?mctR2Kc4CkbaI9ZQm9KP5Z+S2SlRErpgHRINNfQfrD/UoP5ouqIgEd0W3r/r?=
 =?us-ascii?Q?sZq1bceVhvEllJBcysWpZE7WmGhOL3iv58Ru95qXt8GiiJyUzM3UQM33H94v?=
 =?us-ascii?Q?ZtY5/fH0bkdVcWcdzih/3fn1QyqZbcX2WGbxMIAn7ocZLk6hkEPKwsfKp5YA?=
 =?us-ascii?Q?HWzD8//PcUV2rrFHWqldca+YvPCC7KE0tVF27OFi5jvGEx1Je5PjOIeYPzXg?=
 =?us-ascii?Q?EDZYvRbkNdneYO9QiMomdlXoCpyxfwmzXfgtvw/Ob1cSMJYze7ah0A462Iet?=
 =?us-ascii?Q?lYwikLexFMLU3azSue4l5mkUQ2iKEIZq5/2Fl+yEt5TIhGo5jREcUYpenzou?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce942bc9-f623-4b15-73a1-08dd04f5a6a9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 21:45:26.9072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWr9ANF/UPGvWfjr79CQ38eM2I7/msCHvX80ASyHx34GtQkH582iNSN70dbZ4jg4zGmyi568R3gm2Lj0ogvx58R6IFb33Ca5wuEAQTIA/64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9894
X-Proofpoint-ORIG-GUID: XmTq_q1rCugYz-t5nDMpvX3JNZ0v2VJZ
X-Authority-Analysis: v=2.4 cv=C6C7yhP+ c=1 sm=1 tr=0 ts=67366f79 cx=c_pps a=sGbpJkUcFVeWJOR+0qTsNQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=2lh0ntXajQgLOFLV97MA:9 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: XmTq_q1rCugYz-t5nDMpvX3JNZ0v2VJZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Reason: safe

When using NO_RT_PUSH_IPI, using for_each_cpu() over rto_mask may cause
many CPUs to attempt to pull load from the same CPU, causing RQ
lock contention.

Use for_each_cpu_wrap instead to spread out which RQ gets evaluated
first, similar to how _nohz_idle_balance iterates over idle_cpus_mask.
This strategy is beneficial when there are many CPUs in rto_mask and
many other CPUs going in and out of schedule() at the same time.

Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 kernel/sched/rt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 172c588de542..c883ff122f5d 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2308,7 +2308,7 @@ static void pull_rt_task(struct rq *this_rq)
 	}
 #endif
 
-	for_each_cpu(cpu, this_rq->rd->rto_mask) {
+	for_each_cpu_wrap(cpu, this_rq->rd->rto_mask, this_cpu+1) {
 		if (this_cpu == cpu)
 			continue;
 
-- 
2.43.0


