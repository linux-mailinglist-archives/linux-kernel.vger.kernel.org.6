Return-Path: <linux-kernel+bounces-413158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F0F9D14AE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 148E8B26A35
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B37A1AA1C5;
	Mon, 18 Nov 2024 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S2K6xCTc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x0xik+XI"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023DB1863F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731943289; cv=fail; b=lc06HptBfTw70N/2jGRnBQVc6gWB+k3JP0ZPH8WBWQy9Rqi6CNZKl2DU+jZhRCOk2WLpsYCgbmZM/pKrSfl04fy0JdUCaT0NF4YKfzitVBNdEdCm6vpfQKSmDQAfwHTnQXSDmgWHP+Lf5bizRn2+gFXZUAhpUaHtDrjYYmKyR5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731943289; c=relaxed/simple;
	bh=LesEW0V2/kLN81z9yWDpt6JlTENBEcQOJROxAP5FXmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r7JYsqTEv6mvDZhe2OojzZfNiR+16Xs4GXuZrEO0RiUs1Kb/r1vIZM2f8KkeSZjM2IHzdeHRdsZAiutfr+8s9RWkS99AQpjs1vQrP9gsGWP8qS0k2x/WPD3zEso2wvVgA/V6aUmQwtg3Qr+vdxNSI5f3IsQrXJyEz9fQmN2zEa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S2K6xCTc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x0xik+XI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI8QWbg004575;
	Mon, 18 Nov 2024 15:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Z+FXOdSzu0uVwJ7VjXD2U968/IvmsgtO8X+ElDDwy34=; b=
	S2K6xCTc+NvqxrFAswd9jXCt9JMMwX962rujtHabF4mF8fWCEVnMdsVwWX90RKF0
	WlFebABrz7BJaTJ1cLqf5yd7RCEaYSPCI2q2397h67ZttF4DHvMMGaRFoZBAXbJt
	uotYHQ6TVHEZLIafziqrGzgu72tEGq6GAEm7WFY5Ctl4Nbej/7cbsVzQdRq/0gAX
	3BarnNMCN3bb/czRorHGUl435fqXXZKuJXqyZoIHi2Mkdqn1A8GbltTwNJL4/Tgg
	QjIBF8qbrciHeZYvU6lpHJFq7KpNrr+a9jc3khzn0rBRao7n9egb6+/6ZlL4Mgs0
	JVQlUhtxWSH04kzp5ysq2w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xkebtxa9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 15:21:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIElHak037259;
	Mon, 18 Nov 2024 15:21:15 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu7ecag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 15:21:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3KmExde6GdkLsUy12K9tLJ86jROZRzANO8gtb07sPlgXD78+FpPMVQh7Kd8vLfQCK30Kefhp0p83a+7R1w1jsT5u+BEpoko/Gnpd5wKYikzToLr6mnGlsnWYIeyZRxhInI8zAh8l+EaDazOxhRqblPZAp622lL7iyo4g9yCvp3Y2zRUgVH8Mt2FzzXhfaN0xa1assnv35Fqrk1WEHVAbXfZZmFxEDWNIWJTGqmSA194i4MnkiCpICvt4B+BIoIPMH97bKPC7M5qFJ2C8rJNp0qjU6kyAxkmiklA6hNvxjn5EJ8rk38qc7HKJhkkepBYfIJbe1WFcEZig3YZpt/Wmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+FXOdSzu0uVwJ7VjXD2U968/IvmsgtO8X+ElDDwy34=;
 b=FenRAVACISXDxftgSVHaTTIaLadeA3NnJxkIC9YE/oPy2e0LjC39WGTJv+G8u4P5cAYpLRz6doNXP2vkuzr0RiUgncyj+FUsJu2BQvyixGFCVspXcNU/8qjKFVxkBVu3kj29uohrB5jSaSD8oKpJvc5icuymE1XWpgIHS01kkW63JAdiuQpq6JC0ZlLazQya8S+eqfKXjJdH44ZSWKS+ezQVNLAMewJJtNwR2Pw6Erjkx8en8v26CKN6eBs3QoZcUj2obrnMAcFCXZT72HfSTJeCggN61moUDylwev7KUjLtcYmEAunZ4PLExl+NdHsrtg9e30UQUeqyciKD13Fuog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+FXOdSzu0uVwJ7VjXD2U968/IvmsgtO8X+ElDDwy34=;
 b=x0xik+XITQAEF7z9Ce7WoWO3efZhrj012s5r0r/zTYFtXAIN+paoRqC2cXh9TpFo2p70xFj060yjAu05VaKj6J41tAtBUT42IjhT9Y5PcUMaNYeWT2dUFYjTdhw5b6J2yr16ecSj7ZkcsIFpPhZ4iBehaaw0lyDKnv/tvgK2COQ=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH7PR10MB6380.namprd10.prod.outlook.com (2603:10b6:510:1aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 15:21:12 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 15:21:12 +0000
Date: Mon, 18 Nov 2024 10:21:09 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, jannh@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, syzkaller-bugs@googlegroups.com,
        vbabka@suse.cz
Subject: Re: [syzbot] [mm?] general protection fault in mas_store_prealloc
Message-ID: <lcxrbfsd2b7prbxecdawlzht3m6knl3kopuomkqelbten5nkud@cyfqy26ndbzb>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Aleksandr Nogikh <nogikh@google.com>, syzbot <syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, jannh@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz
References: <6739c892.050a0220.e1c64.0013.GAE@google.com>
 <ko2rebsgpuw3akuwnsghjsjokhh2m6jshbr2ahsipkyk3txylr@3xpad7pj23in>
 <CANp29Y4YHHXQJ3qyd_bnDT_xz8Hkwpsckj_YM8v0XswyeBuObg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANp29Y4YHHXQJ3qyd_bnDT_xz8Hkwpsckj_YM8v0XswyeBuObg@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::20) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH7PR10MB6380:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a5bcc3d-1ac1-4c69-4543-08dd07e4a308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T015UFpDL25SOGwrYTlrd2R0VjVQWi9VRjF2T3dxVkRpU01PNCtvWjAyalY5?=
 =?utf-8?B?Q1dyUmJVaERwM2dqTG1oUXAwSmVqT1h5NFZ1ZXRhOWFiaFV0aFVpSnZWUVor?=
 =?utf-8?B?em9zUXpIUGlzeUxISmJKRDFBQ2QwY3lVUVpBeEFhZENhc2YvWFhXRnljeDVO?=
 =?utf-8?B?aFlNbjY2dlQ0ZURjSWlKMjFpdVdyOGh4eDZ4V0V3UlJrblE2cHA4Y29IdE1R?=
 =?utf-8?B?SSttdzFrbmF6TndCUWY3VG8rVDdqdmlyS3NpdHNqUXpYTVE3Z3FhMGdxbEtY?=
 =?utf-8?B?TXM2SUY5ZlNLaitvNzVMK0tLd0QwY1ltaHE1NVhLaWY3bVBtcUpWeEJJbHF5?=
 =?utf-8?B?b1grUGIrcEZYVmY4bVBORndKS3BYdmoyYit5RTZXeW1UMzk3RDJDdjUzejhm?=
 =?utf-8?B?c3RKS1cwRDNNWVl5bDJJUDEwK3VtSTVFWW9oNXJOeTJxbnBsMU1HckE3N1NY?=
 =?utf-8?B?RWRFY016NFZMa0ZYSjhadFZRL2ZleU41NXNKL2J2THg4RGZMZjdRNnpRV1RK?=
 =?utf-8?B?UzVWYXZ3TGpZSzRDYjZ5dnVRKytuTkVvQ1dJa1RBbkh4cTZVR0NuRzVIM3hX?=
 =?utf-8?B?K1dOejF3SjZRcEdnZ2FLZWI5QSsyZ3doVUk4QUQ1Q2p1Tzl1ejJNVW5CcG5v?=
 =?utf-8?B?REh2YVFRMVlPb1pRd05oekxYT3hCWXVzOStOV2tpaHFMUzVmTVNhY3ZTb1FC?=
 =?utf-8?B?TE5pd04wbW5OcnFHL3krNHRCWVE5YmFaQjFqZVN5c01lbEpPQ0FqMlhEMTAw?=
 =?utf-8?B?OW1pZEhHaEFBVjNmalNsbHJiaGJ0RTgzQkFxbjVrVVhKMWltaTlIM2U4dHNH?=
 =?utf-8?B?UFVPNXova0UwekQxVGNNSTVqeEtyYVFiWGJFRStFRyt6MzZpVW5ubHBiU2ZR?=
 =?utf-8?B?Zm42Z1J3K3BGY0pTbG40aFg2bk56cUFEdmQyWnQ4ek5lMHFqbDJNdE1xczBV?=
 =?utf-8?B?TnR3L3NnN2U4amFkRUd0S1hVUkFyRFQ2THpQMHk4a2daWGtBS1RMSkZiQVow?=
 =?utf-8?B?OUVPRTlCTjhjdXI2RmVNRXBjWkJJZ0h4dDhvV3E4KzJOMmNJdi83NHdWYm9Z?=
 =?utf-8?B?QUJnS3R3bW5lQ3lVRTg1ZE5QY1N2Sjk2VzJQU0ZnQzBRSy9paVJDS0xSVm9L?=
 =?utf-8?B?NEtMYWhVY0hvTXBQRHpDSHhmTDgyeEdNdHpxaDFYWVV2bG1oRThSQXNIaklK?=
 =?utf-8?B?WlB3aDhsV05IK0N1eXVMTkNpb1BaUGI3dDlTNFhVZHdlQkhmRHlxdDBkd0RE?=
 =?utf-8?B?UFE0N2JMM1N3bzN6MTdXc3Fwejd0Ull6VVZ5TTlYWUxKMFFiNnRHUjdlc1NN?=
 =?utf-8?B?S04vYkUzaFZ5V1dBQWEralJ2d3B6WVluUFlDbEhEd1V6ekJxTnFJMTJXNDhy?=
 =?utf-8?B?QklobFdUWGFzQ0NvdEZCc2tiNVNjL0MxT1FhM3VMajRHYkh1Z3J5RTJWRFla?=
 =?utf-8?B?aTJBTFZxb25FQ1lVOG45U0xDdTljc1hOOGptUi9vcFlUZk9NR3k1dWo4RFE3?=
 =?utf-8?B?R2E1V1E4WC9mL2F3aW5HalZNRE1aVGxzdEwycGVsckpIWmhjNTNpbktWWWU3?=
 =?utf-8?B?ZXRGdjFqbTNndVluZGtjUFVkRlRvWlZJMXc5cEJLTUFmUHVBZGtra2FtOFR5?=
 =?utf-8?B?WThtRkcvMTM2V2ljNUtCblVpN3FBbWR1dWhVa0pQOVR0L3FrWURoYTdKNkV5?=
 =?utf-8?B?NGE4UiszQnNDbm1wdkx1UWE2NVhtTVZYMzg4U0syaU5QMUNhQkNNSzlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnVHSEJjOGJEOWswblFmL0EvK2ZieGVyMDhDdG1LVk5seUNiS2VPZVZaZjBD?=
 =?utf-8?B?R1d6NkU1M3loZHcvcmVXTG95STM2K3FZVTlKQVYwejN5VHNtQnEzNHBnUmdO?=
 =?utf-8?B?NnN1OGVuUWtmaDZ5Q2lNWkpGTmsrc25HUThQdDFFQUljM2JWVDcrcWlyT0dz?=
 =?utf-8?B?Q28xVDB3UGtrWHNXNHZSNXE3RXIzVlRoNTlWeHYyNmRKbkJYRDdZS2N2dzJC?=
 =?utf-8?B?Mm4rb2pYMVlEci9ZdllCMjEzTEVyVHhFOWFkeVNnODIvRVFqS1pKc1hvdFFr?=
 =?utf-8?B?K1dvZmVhVnBaRGh2S1dRT0VnQll0YXVYTlVqOGc4TXJ3NHhlVTJ0SU9KUjR3?=
 =?utf-8?B?SXlXVjE5SlV1aUZET2dnQjBhb3g2Rnl3SU4wNGptaldFSjZDUVBvZnhPTWJY?=
 =?utf-8?B?VXpsQXQvQ3ZYM1BPdzVUOXVlRVZtYXQ0VzNpcWw2T0l0V09NM1JXZm54ZVdQ?=
 =?utf-8?B?SmFBTEJqTDd3ODFMK2M2ZklGTVVSUjhiWUQ2Ky9mQW0wWHBWL2xHMlF0bXYw?=
 =?utf-8?B?Y1dQY1duSCs1RGowbnoraHh1VHJ2U0RJOCtZNkl6Mk1JWnM5bFoxRDYrL3JP?=
 =?utf-8?B?d1l0c0JPWlpLR09Za1p4WXVHVXdSOG4zdmwrZldBaWhjTDdjdk43aHpuSnFo?=
 =?utf-8?B?UGZVY3AxWFVqMXRuTUpKWWtoRnc5S1YzNEtsejZOYytjZ1ZzUVg2ZUtkSTZx?=
 =?utf-8?B?ZTVoSkcwSGZJMEx5YWlmbFBwTHlMOWJicDlSKzY3ZW1lNzg1VWkwcXoyb0k5?=
 =?utf-8?B?c0tYeTRKVTQ3S0lrbVpHY0NFSGQ3OG9XanBoQldzMFhqL2xqcXpBMUQzNnV4?=
 =?utf-8?B?MjhXU2pmY3lxL09lak14Z1VrZXNFbmJuMi9WTkFUVVQ4MHYyMVFrQmxLNHk1?=
 =?utf-8?B?bzBkOVd4YU5pbjVINmV5NkVJQlZFZkQ2clA4VkdHQmkrUFBWUXZIa0RObEgz?=
 =?utf-8?B?WUxFcXphQ2hueUp3QStmdEhmYUlqR0wvZlNkeWl4bnByeUxZcXRmZGRXOHh0?=
 =?utf-8?B?OHBES0JmWDRQV0tuMTN5cUZzVzJLQnpZaVQ3c1BDcFFVTHZwaXZWR1hDSXJv?=
 =?utf-8?B?TkMyb1pDeU9jUDR6d3VMb1UwWW9vMEM5N09NSUN6V0NDY3pJY0RBZmp6cXpw?=
 =?utf-8?B?THlYZU1oRStGaFFNaFVJc2xXOEp5UnhGSWMxV21EWEV2OVBXVFVnaVh1WEQ4?=
 =?utf-8?B?VEplbU1UcjI4RThTbC9UVmhWb0pVdE5xODEwNFlMaDU1dmxhRnBFb2NuZHJU?=
 =?utf-8?B?VS9mYk9yYlhTcVhqVXZ2QXlDNDlOUWQyYWVEaHFTYTBuMzMvdnl3aWNhcUZ2?=
 =?utf-8?B?KzFkbTZJNnNBR2x2MTUzNks3SDQzNFEzbWlNYS82a2tXQ09JdDVWKzVRUGsy?=
 =?utf-8?B?dlhpWnJJS3Q1cnlveFA3eWlKUmFLRTEwZ1Nwb3U0a1ZCSC81ZXB2OVJhRVBy?=
 =?utf-8?B?MWQxZngraVppNTBDcG04NVAvQmFIZUI2QnBKa3pKM2NvUXFDYkxlbFlSZkpL?=
 =?utf-8?B?OHd5SGppSkJCYUhvUlBYQXkwUDRrS1d0ZGNOaytsaTgyQWx4ek02dklkZzIz?=
 =?utf-8?B?eExDN3J1RW8vbWxWKzBxODZtcVd3VWNYcUNrcmNiSHBhQ2R1dXpwUElCM3BP?=
 =?utf-8?B?eFFjYlZ4bk5hN2U2V1Y3cTg2bWg5NGtCeXpTUDVLRHVUYlhwVFZ4VTFVQmd4?=
 =?utf-8?B?SGZ2cm5qMHRmcllsOExFNWs3NVJhOGRzRVlKTE14YTh2MlZSVGNQaEhDd05w?=
 =?utf-8?B?WVdpS0hiVk10NlExS3QxVUdXREtodFZVdkFYbGQrSG9YanV1UE9MUnV4WjdW?=
 =?utf-8?B?YnEvSlJKVGpNQkZhL1U2a3lLQzkvNCtXay92VDdESTREbmZlci9jS0lvRk1m?=
 =?utf-8?B?em9Db1A3NG1ldnBzZ2tZUFRSOWF1ZXhHaVZZUktOalFzeGlYVU1CZ21HVUJJ?=
 =?utf-8?B?c3NUQVhoMTF6L3RtclFZdGtKbXZZNCs3aXdYanJYYUFRZVI4SWZaRkhaY0JP?=
 =?utf-8?B?ckk5Z3FqQnJ2QytXRTl2SmRIa29SMUlWRmxKbGozMmw0aytRYkhHdzhucUtC?=
 =?utf-8?B?SitGc2hiSVlURThxQWNGS2laSGNtSThKaEVSMmlkdUZmeGhoSnBBaDlnNGU1?=
 =?utf-8?Q?SrTDHIPz/D8uuL/hc+Rvok7Py?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Sz82/4Q0CnM2e+XzcWobKZx4ZX+z48gedz+XPTe5g9fXDtj/YR30jt8aNIQYALMPIwNA51AIeQM7eZngE6zH02u0ZP7RBtAMEIu2vfu9FY05t7yilI089zz6QYPs5tjqMfV1iyWQiyTCWO0Ls+xo1oTK6vEo5ppNU4+mZDOuU2RBS/+ofFUA5YpZ8u2WVGBo9O6QfwI8CqegEG1sfpfLsUVE18ZWnQ7EnL0XFgCcD4T/sp27PF0dVXkfHYH+mVG3ekS+SpFbjALzGjQKnv6WAgbKxM9d9Lpsa4Yv833QoNidQqw5NObx0S8mirrqZyC74T78y0cRF5cbDu/yu4v3P06hUKeD7B+cV6Qql+e8qXOxAnJanbYzk9oKaHrkgNPsVbNeMDp1DdwmuIaW6+qbYsw0Do+Q7aL8UlMnWe2CghSsA80b/2+i5JanRJ+MUqROs0pvIheD382X2Dpb7fhxBq5HmQmKFbePGnJgH+MO23TqFfElRI9VuQXesy5l5UWDTdQWRA7A19mwaW8ptXoDhwG9VxhMmR2H0nwH+7Nmld1WWOVi0z9sOHRKx+oc+imuD1q/v3fPbxf2tf+AgNTGooJU1asfj7ZzTvkBPkPydMA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5bcc3d-1ac1-4c69-4543-08dd07e4a308
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 15:21:12.7920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBlA2aAPAvvoMjIbLqfsmVy6VeXC2yNogjJ4CBDoyvVH/DdXA1/qDYQ/6B1xSvjwWur+Bh7Ka1CI4VTcaYtqqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6380
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_11,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411180127
X-Proofpoint-GUID: T-2qD__4XtvUZwhIw-grVWu7izhFAWST
X-Proofpoint-ORIG-GUID: T-2qD__4XtvUZwhIw-grVWu7izhFAWST

* Aleksandr Nogikh <nogikh@google.com> [241118 08:13]:
> Hi Liam,
>=20
> On Mon, Nov 18, 2024 at 3:49=E2=80=AFAM 'Liam R. Howlett' via syzkaller-b=
ugs
> <syzkaller-bugs@googlegroups.com> wrote:
> >
> > * syzbot <syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com> [24111=
7 05:42]:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    8e9a54d7181b Merge remote-tracking branch 'iommu/arm/=
smmu'..
> > > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/l=
inux.git for-kernelci
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D17b0ace85=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da1eb85a42=
cb8ccec
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dbc6bfc25a68=
b7a020ee1
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for=
 Debian) 2.40
> > > userspace arch: arm64
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D147521a=
7980000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D102e14c05=
80000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/ad658fb4d0a2=
/disk-8e9a54d7.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/1b7754fa8c67/vm=
linux-8e9a54d7.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/50315382fe=
fb/Image-8e9a54d7.gz.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com
> >
> > I was unable to get this reproducer to work on my own image, even using
> > the config and compiler specified in the report.  The injection was not
> > happening at the same location as the crash reports.
> >
> > After using the provided disk (which was tricky), I was able to get it
> > to work.
>=20
> Just in case: did you follow the official syzbot instructions on
> reproducing the bugs from the attached assets? [1] If yes, what extra
> information could have made the process simpler for you?
>=20
> [1] https://github.com/google/syzkaller/blob/master/docs/syzbot_assets.md

The instructions on getting the source we need (without adding yet
another remote and fetching the entire repo) would help, as well as
booting the kernel.

ie: --kernel <file> --append <root=3D...>

The missing part for me was that the commit listed was already gone, so
after Lorenzo responded and restested with code in the repo, I could
pull the kernel.  Maybe I could have just fetched the ref somehow?

So these instructions are good.  I didn't see them in the emails or on
the dashboard though?

Booting my own kernel ended up in panics about the rootfs missing, and
some fool around with that.

>=20
> > Booting was painfully slow, and makes me wonder if there is a
> > better way for reproducing issues in the future.
>=20
> I guess that unless you run it on an arm64 device with a nested
> virtualization support, this bug's reproduction will be slow anyway :(

The initial boot of arm64 seems to just sit around for a while thinking
about booting.  My installed vm was using uefi, which turned out to also
be a pain point.

>=20
> If you recompile the kernel image without CONFIG_KASAN and
> CONFIG_KCOV, that should speed it up to some degree.

I think arm64 on amd64 is just slow, but thanks.  kasan seems necessary
a lot of the time.

Regards,
Liam

