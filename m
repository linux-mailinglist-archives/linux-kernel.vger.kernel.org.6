Return-Path: <linux-kernel+bounces-213881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEF0907BF2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F18A1F23E05
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C8A137758;
	Thu, 13 Jun 2024 19:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XmUokmGK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kJXtCOqO"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD81EF9F8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 19:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718305352; cv=fail; b=KteHr6fUy+npb0AUkdZKRaShexyzczfxaHdH5BOhByHJAg1KLek5Z2r4+oPmkuZ6bxrBoY02XrndYXiU6avnpjzwcyl5mhChz4RQIJe7YDJdmj7KNVfgZs3k6BBXR5jifHZgJku2Pims+g3T7f8hRvQtHPgCKPwfDaQY+uQPzRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718305352; c=relaxed/simple;
	bh=bnCuAyRjfDnlbYD1fHWPWYGUOh/6GVh8nCgodjpTfKA=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hCi/dNQuuNu4b1iTMFHxxjgFj/cjQdG09e4BMBRZ3PuTnd0bCV/V7VGqZKsZzOkfXpFAKKqU+5NjIBNSLU5p1/yu0IV6cy+ETmHpZKlRrICHfTMYyp9cYwnOPrDgiFo5oJAbyKndo020ffxiKMO3izi3j0TK/7FGffVx1FyoS94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XmUokmGK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kJXtCOqO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DEtRwh029006;
	Thu, 13 Jun 2024 19:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=1Q5G2Aar3WfD/yE
	Mdf5gxYdjGSnDLOHvlj22ZP4GDWs=; b=XmUokmGKBTEbB7+lfQyl3bVgIMz+DQR
	YJPH/IofV5ZQX1e2JDqu26u117DiZOqWNYXjnHqapYmVwnim07z/IwiuhUjfK+Sg
	E3kfZjhNoZUMIdksp79X+N9WzAaDyFY4qNRHi5BlOveE51eirMfOKU/Jqh5Hq5W/
	4QTcqgzAUmxwyprdIDg/b7jCvsG3bMg9TmVPqLVjP6ycTtt+Lp6iuOyCevmtcDJ3
	DgmrOPFex/WVZhHZKhAUwNXKWb9QNASz6cykfUHIDQ5FHgqgchqBjQ6z9lbNGdcX
	2h883CAZ0Ty5kxyEHmFMA6PwqPcXUmRFVDBLwvhRhHUfC/JGvzPsGeg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7dt8y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 19:02:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45DHRLaj014400;
	Thu, 13 Jun 2024 19:02:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yncexbkt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 19:02:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lP8Y+Wi1dPNrZpbifh8HklCUA4dSGd2FrkaCbgoTGZ4xncnzs1X1H4QuG9ZYnh/zA285fq+50zXP8eJEPkQUQNuGbOFDFwmZ70F3oPlyrP4husRP70GaJuTUB8qrqeSrw1xK3s16ILxsA9z1F0gs6jIiQk1j0GGIHK6w6C1paMfa0E1Glz+sHouUOcn/JveD2kHKv2vfoM0nIUCYaS3Ut3y24bdHFjyomcpCctd0169YQR5JCUVjjsjXqGPSfpGihTmnLyiO7YrAdfAfc6IllarMG/s5nVZN/RbBqweeSE/dQN45OTahX+u/OUpnKWyKoPQWDYAXg1LbmmtsP3nmZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Q5G2Aar3WfD/yEMdf5gxYdjGSnDLOHvlj22ZP4GDWs=;
 b=WBnOEV4nVcBvnmGDGEDRKw84QJTWaF71Ml0blIHpNnNdsHBPmtitpAdNAk9aPeP1hd7tPfoNKz0CGcsikwWMauRryTOkwQUZSCi9fNxEjZ3w/V287pBt8fAT8ibRcMtaRxcYq/5Enek5t6t5hBfk16JFAENFax2rj9NSNtR49mFWBw8MjSr1b4AO5RIuuVVJgWkIFWakJX5mknlP+W7j4yPXmZRAxSZ2pIp2d4BVS4JNwmqqNV7yA3WVLY+lFyhQuXqYZ0xBOCYABD30lYRtjh9lIatplFR/tXaTUXc8BrcMdX/bXj1FZEUcN6tn1eIvNiprZyZzrlTM93rPhi1NCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Q5G2Aar3WfD/yEMdf5gxYdjGSnDLOHvlj22ZP4GDWs=;
 b=kJXtCOqO4Upog0x+wO5nSEU4+rETQmsKom8GEdDe3LlVwV0h5Lkulujj0oRwfrDnZIMdYxAAba2691Nxflwn3sPEnMIgjFBlDOTX2orKa0AzTJ+FJ/ILy+TmDeLbEoBWxfo7dpsIAKWKjuhJXH64G9YIJ4qQGPQEbUwFyNPZ/4w=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB6857.namprd10.prod.outlook.com (2603:10b6:610:14a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 19:02:17 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 19:02:17 +0000
Date: Thu, 13 Jun 2024 15:02:14 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: syzbot <syzbot+c67d06ab25a9bc4adf35@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, maple-tree@lists.infradead.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [maple-tree?] BUG: unable to handle kernel paging
 request in mas_walk
Message-ID: <2evz26hvycen5il3jij6znplf42i7b77ofunby2w4hncayoxp7@yn2p4tt3e4fh>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	syzbot <syzbot+c67d06ab25a9bc4adf35@syzkaller.appspotmail.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, maple-tree@lists.infradead.org, syzkaller-bugs@googlegroups.com
References: <00000000000066aa68061a072231@google.com>
 <pe4qk33vuo5o2y3cpz6wiz2cpx4d3ka3esqfe4jkayhakb3k2h@7yti4hkgmwvo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pe4qk33vuo5o2y3cpz6wiz2cpx4d3ka3esqfe4jkayhakb3k2h@7yti4hkgmwvo>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::20) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 641e2146-88c4-4c10-5599-08dc8bdb5819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?oFStK8IYK4/J6nwF1O0XAShTumMlcMx5bKeiv8U/IR5ZUyzKbRlufwlO8qyD?=
 =?us-ascii?Q?5BQFOgLTinMdMWbA5tRdO6B0FceYVsbZrWkTc2qPY5zsXiFiATApVj0friOI?=
 =?us-ascii?Q?Ykjc1CMIBcCSKxtzDFkUou8Lof6OcbI5mgptIMTY+9MxPdsavEXumki+4BO5?=
 =?us-ascii?Q?f58qLWsF1+9NO0MHaXjU8R8R5hrhlKSCBGl5QE71DcvKcSz3Anbe+6qcLEJi?=
 =?us-ascii?Q?CJOSGpWhOA6WwPE/yNx3PRnFQ41ctHVUOLm1HAiFACu7ndMoABGOsziXG33j?=
 =?us-ascii?Q?eo4wVii2qu9fLY4gkdPn4vIj3J7m66GxcCS+X6Q+kfK0jC2rtwfCD9P/1l1O?=
 =?us-ascii?Q?BtoYqEckdyQRjco0TAK8a/spwTRbeW/yJ1zm21WYQ77qlZ4JnVzH4T56kx9+?=
 =?us-ascii?Q?p7m5/74VDhYhxSKS8sEN15ibphKdH/aB6pnpWl4blgeNCiYOQGMnl4asX7qa?=
 =?us-ascii?Q?ebvcCHvizamhrOuzhVD0Tf4q0iQ0GMKYfU4SBLxx9uBvdcOyj5ifHjNago0J?=
 =?us-ascii?Q?v1eovW00EXWd2tcd3POehHh/rAvyALbMxfLfleBFCa9VJcFmkeDmGOtB0/P0?=
 =?us-ascii?Q?OgNkiDd93bNG0O2MsCCEET5FKZl1dKSFp8+tybMegRXYopsSjQnTr8wT9nE7?=
 =?us-ascii?Q?IVCiT4PWpPwfeofdHIZA7vyLrvO0ZYfAJCKvHhDTnrtk2ZKS1OSpcIbRe8+W?=
 =?us-ascii?Q?IbYDH6Q0uagEs+gYN/ufh7BCRjD16Ue6Jb25tkR1JtRL0VXvpOtX99PcwrhM?=
 =?us-ascii?Q?B/l5RlKy5nlGdJEoZvmvGSixLfGUba2dgQpIQz2OxgLQuXFdv1ncp1x5UPcn?=
 =?us-ascii?Q?0uFS3HUhnNvzgmiUbF9sB+kNYcmXWj6lkQuAOzhbj6OxfZJaMzzohNxxoQai?=
 =?us-ascii?Q?dsvyRCX8b2pt9uCFQ/LTbxdBiEeuoLmv4YlTtNUt5fW5vm1F9rIKcdx2spiZ?=
 =?us-ascii?Q?umdB/qD4pvh0lrXL4T8qvyXqBlwPIYqt02CCtyrrSwYAp7jB8FzJa8wBwJBu?=
 =?us-ascii?Q?j2c0uLiEXSb2mCCp7sUVCNnHhWA42JubxGYyLxQkqbD1KiVBuuE8AnZ/3c2E?=
 =?us-ascii?Q?zedM6Dl5oxj3syoE2qbsGlJfzxWYGdnrYvpm3avBhmdEQY53loTaDQ31BKXe?=
 =?us-ascii?Q?7qjIreiCWnbBOkvUaZgSK6xZ/PATYtRrW8bKLpjy4PWACADOGLN6uFNBtoxk?=
 =?us-ascii?Q?CQ6NevnTU259FskQQ02klYOIr6GdJkfD34VqauRt7pgaZ+yRXeM48UwxWuug?=
 =?us-ascii?Q?6OM0tTdGsgmu9ZuxhaRw?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xF77S3Q4XHrIKS/0r3Ek4JNMYrMecyz8rwONiypT8PERBAHNHtpisGX/pnGx?=
 =?us-ascii?Q?c4kJ32cfEKKKxLWjAYey6wJOAddK701o3bqFyXDESm4ZiMyf1DOMSmP8NlDp?=
 =?us-ascii?Q?8yMRrfHPv4tpGao8C0ZfzyPCKoGLZK+iOVuFMp0yETsz+EwclmnrHFaDYdyy?=
 =?us-ascii?Q?x/Qa/GwGQHSRIWyoeo2Cx290cKkS7eMKhmlE2LFKeb/TC6cJfNAU3rGnNIHU?=
 =?us-ascii?Q?Qd4i1lDG23gp9LnzA6MWVa8UY+6e3xdUHuQppq8Xq+njDCoapFld+BGx/yV6?=
 =?us-ascii?Q?7I7a6Wj+86JKLGqSaqx1f5Ip/bbxyKrGzk5R6Ik9a+O6U37ESn6HUkJro2Yu?=
 =?us-ascii?Q?tzczFCpI3wmB1XxVoyforncEqlLByboMz2yb0BHmRE4MS1eC31xxDfMiccy0?=
 =?us-ascii?Q?8o10ByhAI7zw9wLp1IZ516L/No2L9tk7OzYDxbt9z7Z8d1F5OEW6bLucOvCJ?=
 =?us-ascii?Q?casz/SFnPsViC8EvVsQ/m85QVIEGKXmW6mLADWySXZ+QfYB8WuIOhPph2K+6?=
 =?us-ascii?Q?EwjbRosEllITzNqadbgC6CxTof0oRjCHzcwl9pvEGbiSm6g/S0zduQuB1hJX?=
 =?us-ascii?Q?Seb/5vf0Gn28rqvC/RccT1BLlbFZC5Puhv5wF6QT9BifYqQlsRMa40n4YAQS?=
 =?us-ascii?Q?OKvmSuHQKqmBWFb8Am6AOq565P0BQN/kWnuO58WLYt/iHWo6Q9E+30CRldxf?=
 =?us-ascii?Q?E1mwX2ix8mdgVsXxjrCQ0azwtB63+I9zIKp23djGO3273/TckRANsBybGD3l?=
 =?us-ascii?Q?Zbp85AWlpFaoTRjjigXXYPmbuOtuVMdFCZ9FJ9Y4m8BpYe3RKbEuAjpQMsY5?=
 =?us-ascii?Q?NgOo1qDsVC81XjrIVOGAp0zC/hU1BfBIx3ROc7IPJ47gGFUNLjw4iZKIVu1r?=
 =?us-ascii?Q?PZq45yJyLdGjalqfXuopPu9jjLOHrlDspE2BdM4dABwQ+WynS0KZ9hZzmju4?=
 =?us-ascii?Q?FPgRxQaz0iOcGF9/j6c5maHzROnY8P3kpXxfoNdhHcv3plsHrR+niMgMMlFM?=
 =?us-ascii?Q?lnPYl4k5tPR4lbG7iM4jquBadZtPR9feEqZIwuIqI12cAyNp2nlqhek1WM4h?=
 =?us-ascii?Q?WEfI6z8WFJSNmxK8HXbsbYFQ3Vd6GoRMWRlk+U+uM6SbVzLYkNI0YrtXYcrN?=
 =?us-ascii?Q?iC+0UC7jXXkh0xWD8+7ITqT2a64nSBF5CO7YVO8KAnhqEs/D5vP8aizHa+WI?=
 =?us-ascii?Q?pnd66ySBqv4mAjYfo7qj9ceNm5OF5leEdgx9OZoLuPePdqbM31BJ+yPbKtCt?=
 =?us-ascii?Q?CQxvOASR0Bdzqq5AkGcA3ojok3CW6hIUfb3meHc6tMMs6rb7TL4ma0BZAqy2?=
 =?us-ascii?Q?og5ol7XmEgl7qlh+uWF/LDxfMpLQOXTf7aML0twPaVxHQ4iuOeBOVY9a7+O/?=
 =?us-ascii?Q?6OUdncyKDBuXNxLc4oUL+TKOBbW5x1ZSU7sozT1l+wF5Vtg6OWI6LqAkDAKr?=
 =?us-ascii?Q?mz1Cksq2AtiWLoLFwA+tye3egqvp4jnmqJxckMicmw52QUxqlnYZgNBcrKNx?=
 =?us-ascii?Q?t51K5uLmckufc106nd/tlX+bvRkuXdNudBzPj/1qaQAdr2LmDirSCyw6U2+X?=
 =?us-ascii?Q?HWTkCRY1MBtLu04DHNHA1hx5cFol27jeW07pd45a?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RA7Am0JTGTrA1B0vT7w2+p9cutZCoereIF6VGdTVCkd8mrE5mj8bdDD7yOARQX4cQpfdWLQnE405UkzEovhudB5XozagzSEfiJWcWp2Ywtq8+19mNwhP779bjqN/dppgtcIm+rEI4r+TVifNKlFDTh7pg00RTb4mUMDtbQueUEeF67CgW0v23FYvDBeRGdl2aQVaG/w7WGHvqh4oXZMAzRV7Go6EIBEDGHhdGo36tX7c2bSxhTSVvgff5MSI3OZejOUCEAiq2DlLVvy0C8v3/YCuHfnpZAu2z6uFaEwRWPs1KtyLISGK2fCTDBbh7N4jwswD4I28zgHkK63pwhUw1L050g31nd6EEJwjx5F07ph43l897m5EoXBR5F0GRBmGqWv3LhrazqFIRQWkW/+HK3ILs14Honyw045p8fzhX6tQ7GfCvMsReSV8ADRnSvXjBQk7VnjyyMk8NHxNAiql7weX6w5Zp2zFeUjSEgtLC/VJWhYaZlCoBEwF6sSFQzYkciTAEWRfIn4Hj9lfl04b2WNZPQA8w1jOM/sjVLx2bwCt/WSZYUfXF0+SrmEYwslw3mrS1DlpQuwXefWcc1DFiFG2RsX0xzj6MDU1A/TreDg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 641e2146-88c4-4c10-5599-08dc8bdb5819
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 19:02:17.3614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: td9jsSHQdr6Uz0+LSn1CNBxCFtsqKTmK11sVxg+GMfVuMx3285x2aswLSdgyz+TLCFAlPtEdMf7kLxKNIsCUlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6857
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_11,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406130135
X-Proofpoint-GUID: dtFOvPvyjxe4xUNZF6HkCpbIcrirk_rL
X-Proofpoint-ORIG-GUID: dtFOvPvyjxe4xUNZF6HkCpbIcrirk_rL

* Liam R. Howlett <Liam.Howlett@oracle.com> [240604 14:08]:
> * syzbot <syzbot+c67d06ab25a9bc4adf35@syzkaller.appspotmail.com> [240603 22:23]:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    4a4be1ad3a6e Revert "vfs: Delete the associated dentry whe..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=128638ba980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=bd6024aedb15e15c
> > dashboard link: https://syzkaller.appspot.com/bug?extid=c67d06ab25a9bc4adf35
> > compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > userspace arch: arm64
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=106f71aa980000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b4ffc6980000
> > 
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-4a4be1ad.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/75957361122b/vmlinux-4a4be1ad.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/6c766b0ec377/Image-4a4be1ad.gz.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+c67d06ab25a9bc4adf35@syzkaller.appspotmail.com
> > 
> > Unable to handle kernel paging request at virtual address 00700000077b9b78
> 
> I don't think the bot is testing my forced update of the tree, so I'll
> try again.
> 
> #sys test git://git.infradead.org/users/jedix/linux-maple.git syz_20240603_v2
> 
> This is a revert a some patches - which seems to stop all the crashing
> for me.
> 
> Looks to be the same as this [1] syzbot report.  All seem to be related
> to madvise and these patches are the last to modify the area (besides
> mseal() specifically calling out madvise, but that would not cause the
> issue).
> 
> The patches I revered also name arm64 as special.
> 
> [1] https://syzkaller.appspot.com/bug?extid=7eaa0d7b9fccf21052f1

This should be fixed in 6.10-rc3 because of the arm fix in the area I
suspected.  I have no way of verifying that since the bot decided to
stop responding.

This puts us in a difficult situation of needing to jump on bot bugs for
security concerns and wasting copious amounts of time chasing our own
tails.

