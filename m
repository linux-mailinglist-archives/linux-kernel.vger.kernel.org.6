Return-Path: <linux-kernel+bounces-357544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC8C997263
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44896283B1F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AD61A0B06;
	Wed,  9 Oct 2024 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BHGMPJue";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ywyOvEJC"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFBF188917
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492885; cv=fail; b=nJbXQzz2hRm3Zrdb+g5ySR55EQ+5xmJ372HvEnQ7sUHjoXSt52FWD6CtMXQnMqz3pqHRnVjtKXay9otUh75aWsRi96SUuZdJeUaVoZ/36nV9yS0HOXmv5oUEvcGEcIwLCC96Kd+ADSnsEhKwLokACiAQYMUD9QY8rLi2PCF+rU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492885; c=relaxed/simple;
	bh=zNAnIYyCOESkhPRVzYNyxK7BIm3ahPHR2cT96yub0Nk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SlR+W5YoVeKt08S1c0At+wzdbDCtrrL7bkm3uUE5dSXr3zinrfUX+sEy2LQjtLNSppldwTvRbD+7LsL5A3uIictLLw/IfhIZ6huFMIV2YzvrVzoiqSNu3DjxuFmjsq+GUV3kSfXjn2k5+XXTaZC9572XMbskNjW+ZBhOUXQLV+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BHGMPJue; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ywyOvEJC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499GBdGg008197;
	Wed, 9 Oct 2024 16:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=jE+fe6Idzvj13Fan
	IZAVivGO/EBu154K8ANh/rxf6DE=; b=BHGMPJue2T4SWXKQAZAes3eWBjNbPdyy
	pHHzf0QX6ZZJZubZIQ8w04/hXhfsMlce/SfIeaW15M2RnFi46yOx+nC7jnEwx6MQ
	ODUz6ZNfwoBUsJp+qOyBYdAny/mFLwQUhtpDbTXY+EeVMTdNoc49PON60L7QEvGc
	uL56r13knlJrbLARTxLWjMlB4XWP7n3TBpTRv2KEuSv0OkWR4ppDgmVdLBTBdUwy
	DSwWH0Kx/Sbczoq1vXbIA5eHiVfYp4fQQcwVI/Dz1NY7fDrsr41nwdfVXBOoO458
	a++gUyTQLin6m93hhvFPd/03HTx1ricgWkkC19t3LOaguPrepPdfGw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42308drt2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 16:54:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499FW0aP015317;
	Wed, 9 Oct 2024 16:54:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw8vr8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 16:54:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyqMuWH6bC7pl1rGKp8Yvbah/UALs+614lIwbpVzrhekSeNZ7THXi9F5SINaFQIIKbGIotm/UvMjiA9Fr1ZC4/DuqPtq+C5TMIagWdim0Qf2sK0+lb8W0yPRLYEcQKgi7pBzqkhV0fANuav+ohEmJt5Rj4q7Ixz4jcJbM9BDBKZnNa4XcTth74wFr7DR7cqotldbrroP3x6+8vzTvpq4JS5DAXBNvF6qKmOQ+pFeC9r8ZbaxJBIi5O1LsInZqCrHYQ7XVa8TO4mW7mOUIaRtJvWCm4VZvebBLJuzqM7dUl6k1D3UX9/oJTX8IWx6ua6QTkcJVEKHt83SwpDXGl9Ffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jE+fe6Idzvj13FanIZAVivGO/EBu154K8ANh/rxf6DE=;
 b=t6KGn1dIqqqemTXlDw8Ja1/aJecUh6g2Ed5XSKoyeiUP00xwSU2u1mdslMa6SogocPV8IV6IkMKFQ8TfRR6VcWdwC06MJtWwTyoXOvx6Mu99HtRgVDKifunvglj02smTTwN1qPwUhPfWv0xR13F8MsGH8Ir7Yk/Etn/70E7wXlUakr3KpxMHvzHwjkqSGyZoMIY9BonOtnHqDdise4IRJ8b+kdp9PuL9dJ3JQCimS+Pjy19cet2j7ZPO8p/fys985M1VSjHvLLyPxPwmgZSUZAIYGwSVmp+7bIUa4FeoFu3b0BYNPELRY1rGUoiiu63pvrjc5rP9sGSRBM53l2ZI3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jE+fe6Idzvj13FanIZAVivGO/EBu154K8ANh/rxf6DE=;
 b=ywyOvEJC99Iz8ysRd73WE9JwSQE4PqS0wPjke12exf5EiqfJ3DORrZoXHix7jjlPcoazp+eIzfsN3vYYZT6q11GdTfbo9yWhM4AbO5Q2GH0JvbzE99hwtsRrCJVEQtmeo35u/ddKZIE8YDZFvlbjfBrI0ypYFwcP7qK4o+zBMFA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB6585.namprd10.prod.outlook.com (2603:10b6:930:5a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 16:54:14 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 16:54:14 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, ankur.a.arora@oracle.com,
        efault@gmx.de
Subject: [PATCH 0/7] Lazy preemption bits
Date: Wed,  9 Oct 2024 09:54:04 -0700
Message-Id: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0121.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::6) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB6585:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bff0feb-e52c-4d40-32f7-08dce883015b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BwAzqosdgAVHeyvKw9As2GDHY00ZvQ7wyuZpvezhrWguUM4AscCq//ZBzT6a?=
 =?us-ascii?Q?P4BDoYjsmubUvnxMfBxx/cnFVPL5DYTJFsExajtfxA4ZH5h7+KD5VIDlKmdi?=
 =?us-ascii?Q?6gtlDw+oQKG37yOGbNbg35IzETWJ4kGoWWOLq2xN+yQdm2MrRudBIGSmEJS2?=
 =?us-ascii?Q?tDMRzOxxVTe/rCSzDNYkRqaIvXAVcJlepGR79KL9+2uVZrkYNhWGzsTjYitS?=
 =?us-ascii?Q?Czh8AGXRITOIrEznQa4PdEjXIEmW0Sl6uIkT+DA50X8GOJghxkNir64p2PIo?=
 =?us-ascii?Q?P8E+Kfst33/HnZlwr9pK5ORBHW+A9emP3RutCdtopK9dIbEX1snbAddI3XBu?=
 =?us-ascii?Q?ZIo3pxB/w468sdbkJ347bEC+4QVQHx/v0WxJWCvYuDJ2GFlmxpfjlcX4m7zn?=
 =?us-ascii?Q?n3pEuO5gYzA7nW21mk4P8eQ9Enx5VIM58YPNqyGoIbn48MgZHPmWmkoHvYrz?=
 =?us-ascii?Q?DnTdD9m1XIhQVLs1BuU8zFwc44pjGLYpF7j6Z08rYsxJ+y7ChTEoFdFUJozU?=
 =?us-ascii?Q?xCN4ax67g5B9aAVBboQ54gRuAnooECw2TnA3a0kErfRhzn2NXgVfz8rHy5V4?=
 =?us-ascii?Q?N+1Lxpe+UB83uTaccDH/5t0vhsgo6ktps26fBXYgJNcYx1J8PnW2ab3cedMu?=
 =?us-ascii?Q?Nadq+imgSsC1k9TNYu3P7l87oEvXZnDhwlxvz4vNQEUyM0SjD6TfNcPocnd7?=
 =?us-ascii?Q?6avlOi1Evir7DIO/qC1VaedsGbGkVDq7vkzdOhP1RSFNZgoxgLzg3M2/7mq3?=
 =?us-ascii?Q?3R+b55x84ZP3nStEtGGlTlYq8ucpHbsTwYvZuLhWfd5n7WT9zD1mQWWp/UET?=
 =?us-ascii?Q?N4tbPgzhZxlPzoPfI0eC+liJ+pcR4k9zhMwU7lHrtXJXUyLQqfhXYdunvX4d?=
 =?us-ascii?Q?1bT6K8ayQ0ylf7YanvRQwsFfE4oTDrBwteGhoaqMwEwQ7zERY7q1ijl38DhS?=
 =?us-ascii?Q?o2Gig99ihs6EzAKXGPt1andNMdICe4eZl1KmZC99ouaWfU9SxneGwvTjyZDM?=
 =?us-ascii?Q?4urBKQohmnsw6t0ASXUSetUH4d59UgbCM+P2k6xTrk0X/htSQ4F2zoBO2gdq?=
 =?us-ascii?Q?KEXFgYsDmUiLUz/m/UxS1ih5tYctKHnt1RGsmKoYOWF78KLOaPEj8I5yWLGO?=
 =?us-ascii?Q?SWH+4J4AvDIwljaI6p++s0FyP330xz9fEiELuwofff0giTeaWA1Cd1wxWza1?=
 =?us-ascii?Q?h4K241OPplK7z3sHXnwxZ45IXjf+zC9+tj/kulzKnXp02mc//zkPK8x1mhql?=
 =?us-ascii?Q?htCw6qJHEiLYTrpLT2HRVFAZ661JREfkMMxWd2phIhw2fJO++kb0IWRZuDzK?=
 =?us-ascii?Q?Ges=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZdE4UV/SNGc2ZPPDhL22Q9NefvQKzhlhNsY+fI22LIlkcQtTzxZwdBGp3h/w?=
 =?us-ascii?Q?qBQNnusREebjAUEwTh7hPzf6uXXbv8R2Ec7EhoE+uZCdyxe+C+CVeXyWWRAS?=
 =?us-ascii?Q?QoV3ruHXkDAx5TpkftFRZVR9pRf1nW3v45TgHmBETjmyqIQs6qb1ANG0mgfK?=
 =?us-ascii?Q?htF9PnscRz/66scGISNJQuT8rGyMiBUMLM3zj4EAa6ZIbs1JmG1BXVyjwofN?=
 =?us-ascii?Q?tKlr0mDGrkgFn9erAiXcX4MmALlqi465SaHyekZy6hCraR+fpmjm8Frwz1x4?=
 =?us-ascii?Q?Jf2DDXoUnIBinRqCK25m26tSCg5QWKG25uJVju2zB4T6xWenNGoRWYSkH6X6?=
 =?us-ascii?Q?3nq24fCNRovJty1CrXJuTH9FeymIUzzcHG8bNEIGaz9kzk1k5J2Qy0GalN+2?=
 =?us-ascii?Q?AjEnoA4u0jurEbJzmGskOjMye3w/eaEwuNj1gk1eDC1K8axmmYWg8OguvrKM?=
 =?us-ascii?Q?dDsFAyAF+WAHt+pB3rH4iRpK04bZf2vyn/qjq58umLr4CdpWQMfzfb+9cDtc?=
 =?us-ascii?Q?bUyf1XiSYW/yM1sWhVOT5qBzlV09OO217OGFnIByv+YUz/JxI+zH1oBq3WRr?=
 =?us-ascii?Q?HLgu6BRw3akTXG0M9vjSolykNoPsyyzWU78UnXHPHBwabMEXb6q6Ip4i05s7?=
 =?us-ascii?Q?HolmOjP1pgCQUVrGWgqRtb02eDHTF9mO6ns7bWmpH9Oy/+eO8IMJcjsErtv5?=
 =?us-ascii?Q?sIqJeKlE3RCAbu8Rox+tKQtWebZ+rUTvKm7bfyjEOaOWV+AW+79SmKN9o9IJ?=
 =?us-ascii?Q?uIELn7abRhglUGuxhcJMsTLp5pd4UfOo/rxPvLdJNvIUSoLyrxAvq0/rWmTr?=
 =?us-ascii?Q?j+0df8NZTZqPWgW2iPCx69yAJu+bi615MDXte5fuLWpFubSMWgngZFuIN2b3?=
 =?us-ascii?Q?hJjnkdVfxRCTUhzKhyehDffQpcRSaKSGWxz/utEfHeF+ELPuUMkKJiIDx3up?=
 =?us-ascii?Q?B7AuRvQWDH+CGZzpjbQ9xu8qGlPh19mcusGVvPWt0kC8+5oDfSu396xgZek2?=
 =?us-ascii?Q?naDhKs8O60J9R1N+lI93bS2fnRIW9orB7UBKtgASywSQQSYw3kc6agAd+z+V?=
 =?us-ascii?Q?IuC88d1tVPUBub2l+2uBlWVUqvlw4oKVe2jVbBGtXseLxVG0ScnqP5chSGY2?=
 =?us-ascii?Q?ITOeeqBlas4mLh16QIsy38IA3+IBevIiRnxQTIjC6y1NP4S1JO75Uax3Uw9B?=
 =?us-ascii?Q?FA2Lg7dywKZ9SWjWyBMwo2j/H9WtSu2WJHD3MwwET1GUgbsetm5eqzUwNbY0?=
 =?us-ascii?Q?u071/feMYpOSi+WA/OcgZGZh4Gt4GcQZo7zvTllQC7MrLRo7o780NV4E+aYi?=
 =?us-ascii?Q?O3d+OnnfmNIaRZHoV0YpsodXSOj7HfRU9/l2x1wNTK7U/Gao1qI6I74DJQJ4?=
 =?us-ascii?Q?aUBmWVgmlilNMvznAOtROE3Mt9XuvWpK44NXjVDZu0Yu76mdq94eJi35pQBr?=
 =?us-ascii?Q?ZxFvEIw4dI1Lq3aH9XAYOswhQbDwTTkMnXDXnq1U7gGikf39fXKKCuzADNxB?=
 =?us-ascii?Q?XT5O1i4mohxIic+8WLRHNSD9S1TpbtMz/NQ6PGkx+62QFMUPaZIRQDOap85r?=
 =?us-ascii?Q?nifQ2Zi8RfYuHYFXMwPbykDwKgWWrHNGAScMo9aFvP+DJGX1iNeSJjQYVPJE?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QxmBoH6INdOqdzmrp8XDMSSaeyRK4PpvO8hh8jllLuz7nqWy1PKsEFM8LvkOItDEf693Rfr8U1OE4EzwxUg248LVC1ytfMhk83LkpExJO6KVa0xlkvvi7zUQicqU2XNwq6ZQkVNyAQ3fDtRgcDNjf0djXuZFp+4oOa0DyC82RMrKtIFDd7Ekhjj6vqLEVBwykhc/fzGUVj5WxfZV1IDP8zRGUEkxs/0Z3CDnIohJtggSGm2IfjbeoFbl80ry9bpPHhLZYycsBKlcel1gZHfJvERe3ywgBlWH1aRWagnVoaTxf2EpR/fDh9y49RGwRA+YfKsAqvU+Kdzvcg5KlIqana9iQBzRqjvqe9o3hwMJo4GgXIus3pznrD3uA8YIvyHDco0I/nQ0v4ag5rmtNg1f+VtGKp6lEIB3uq/dtsxYThYJyRgKoGtCun9g/4JJy+IgVc98YEW5jHKS9ZjXDMhD+1EwS2gTtEcKnUO4mbV4rfvvSy4eGnXR36bGoooqDr4JR4soLq2PMIvFZlIrhR2T1XgIRcYe+60RLkX7XfA5bojKnG2OIQjhGpVgAy2qwFifdBgqzY9iXYkv8SKeZ7Rt7O7Fhffzn6YHWnX9Z+qyIew=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bff0feb-e52c-4d40-32f7-08dce883015b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:54:14.2388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMKOiFSrE1i6AjdKjp1sCNTSRBEVRpdR2oGh33DO4clb+qTOykaeO/Lsjg/E18YqNSxT+hCCYkDoywii+ImaH5bxTGVWRGRmvsMdGAdIf/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6585
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_14,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=640 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410090101
X-Proofpoint-ORIG-GUID: Q70nqT04boCjvGjIlr4sjNHbJQaOXrvt
X-Proofpoint-GUID: Q70nqT04boCjvGjIlr4sjNHbJQaOXrvt

This series adds RCU and some leftover scheduler bits for lazy
preemption. Goes on top of PeterZ's series:

 https://lore.kernel.org/20241007074609.447006177@infradead.org

Tracing and RISCV bits from Sebastian at:
 https://lore.kernel.org/lkml/20241009105709.887510-1-bigeasy@linutronix.de/

Please review.

Ankur Arora (6):
  sched: warn for high latency with TIF_NEED_RESCHED_LAZY
  rcu: limit PREEMPT_RCU configurations
  rcu: fix header guard for rcu_all_qs()
  rcu: handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y
  rcu: rename PREEMPT_AUTO to PREEMPT_LAZY
  osnoise: handle quiescent states for PREEMPT_RCU=n, PREEMPTION=y

Shrikanth Hegde (1):
  powerpc: add support for PREEMPT_LAZY

 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/include/asm/thread_info.h |  5 ++++-
 arch/powerpc/kernel/interrupt.c        |  5 +++--
 include/linux/rcutree.h                |  2 +-
 include/linux/srcutiny.h               |  2 +-
 kernel/rcu/Kconfig                     |  4 ++--
 kernel/rcu/srcutiny.c                  | 14 +++++++-------
 kernel/rcu/tree_plugin.h               | 11 +++++++----
 kernel/sched/core.c                    |  2 +-
 kernel/sched/debug.c                   |  7 +++++--
 kernel/trace/trace_osnoise.c           | 22 ++++++++++++----------
 11 files changed, 44 insertions(+), 31 deletions(-)

-- 
2.43.5


