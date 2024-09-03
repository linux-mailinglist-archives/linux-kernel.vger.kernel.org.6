Return-Path: <linux-kernel+bounces-312909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE78D969D90
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD7E1F2195E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF49E1D86E1;
	Tue,  3 Sep 2024 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TUXDz4aR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bObObj2A"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D481D0952
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725366490; cv=fail; b=aRDI1z/Aslb6po36b7jF4I2jrK6IjvuicTkFt2wFWDn/2HQF0z1TUFOS5+HHW0JMQkxM25Zqz5j0YFE6lOs3B+2XmbeNXmQaPiRSdL0zijBVMu7eIryipKNYd30ple3c0XH4zkusWSEObSekdfrSvOKX2z2U+I30sxTe4qBHzo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725366490; c=relaxed/simple;
	bh=EDMkf2iL/EGNe5iSNrua/pBmxda1FXpFmSoNWdWKpT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I8vlW1+7zpkVRqtumBjXyKAMSyaDaAOwa3oTKWiVoVvIkzpy10aVJP7cR/kXZq/wIvJoiWFzabQBAwzaFmH694B5l1AoSdlE2qvcLI3Xs9SE1/YjeFiTpvmoYjS4FUKy2epr2OYKWFz5DZOK4kbEzMbFIg5pHV2ZKRn3Gt3D264=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TUXDz4aR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bObObj2A; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4837fYXk026676;
	Tue, 3 Sep 2024 12:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=m6EghHSMDg0089J
	n+I3RPwiWT7fpgbyjL9AhrKB6T6g=; b=TUXDz4aR77fQ5iyzUWwKdxgqIh9ccFT
	3ZWbtdMckjPmigha0Ob2ozrJWtLqg5w4jmhzq7agm6v8zguGt0NLKUi6CwGm4DxK
	2+BWQd7kjlKCjam9nTypnNwVQEpK8e14lFz87OlQhfos8fwqV4rWpghT2AVL1mw1
	won/xAXFmO6IQuLgdSEYUKUN2i0feRzwl/4HrhtkQlSDUn5rvrpi69iX2Yo+M3/h
	7I54xLEf4uWBA4iOwQ8PcI8sSnuvukvX5YuvJqHCdxAzuCte2PgkJwvZRnMq380n
	yA9xIUyIc2nikGdCjcz7NrS7VvJRvSGrZtYtl648Cx2llFN8nwGp82g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dr0js1wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 12:27:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483AZAkZ036718;
	Tue, 3 Sep 2024 12:27:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41bsm8mj2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 12:27:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2nvCor2tQfxbBvZJw6J6nZYF55Y4PQLqq2CjtEjtJ+LlN5edvcCbW1Fb/J4zYJnpkmjIQIgPh2HBRS9IS71yM6zPsWubZWL+cTvk0CffY+YLo5YTWJ0ts+DHMcm+f26pYxzlgR5VZ08qrG7VsMIglMwSghoefT4bWaN6NH5QYdpSBeqsXAbDTczgxgfhh7OVj35EvBXwBVPvv6jEyNjWhFSwLbI94glyKry/tgiC/0VZLGxu9aIAqA7dbiKJHfX4LEhp6cvnRfC/4Td/7VrGBV6ybEtCfdjts14ZA3JeHvTTddtxqMFO5+GxA/CHeYA7U++RDYr0g8dv590U4W53Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6EghHSMDg0089Jn+I3RPwiWT7fpgbyjL9AhrKB6T6g=;
 b=VB5roOgH+F183UFVkhnK58FY379BFeSIlpjiegmHuG7A34KBNBOa8QAybZ94eHqPyseE1CiV7X0S4TYP7jNspMWMenB4o3me/LRkXWNEtzdH6haAHqLtr0N0pTizF4CLsRpY5aKNLGjJHcDdrGzsekz1i58jvB2cESo08J96CKaEvFwVD0/tBtDl5GshvLlc60sMK5riDq0xUdYuV+hWyeuocE//MsCLeCY3SoQiCt+sGDcxI8rU0SWqj6OgxUGEcJBUrImiSH6gIwlykgZV7Rh7zTU7njfvrBUSbWEmysGMVxKSaCaS+8OLXAwVmO8LuLNdTH4bGm2U4z01pI2sjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6EghHSMDg0089Jn+I3RPwiWT7fpgbyjL9AhrKB6T6g=;
 b=bObObj2AEKPLz9r75nTE3YzbW/Y9e0zQftC8kJCamFHU5M34OP4lW92qbyuTQ2S37ll8AQUMk0zYiROJOI5+nFdrRbeazj5yMaaqqqX3YMfLEf6L1VrI9M+0VkEsm9rALB9t2IvJ7tZXKeBkWGiabqDi2ajwef39kfSuEbS+T8s=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ0PR10MB5672.namprd10.prod.outlook.com (2603:10b6:a03:3ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Tue, 3 Sep
 2024 12:27:46 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 12:27:46 +0000
Date: Tue, 3 Sep 2024 13:27:42 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pengfei Xu <pengfei.xu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v8 15/21] mm: Change failure of MAP_FIXED to restoring
 the gap on failure
Message-ID: <52ee7eb3-955c-4ade-b5f0-28fed8ba3d0b@lucifer.local>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
 <20240830040101.822209-16-Liam.Howlett@oracle.com>
 <ZtZ9euGTU9T0PWDA@xpf.sh.intel.com>
 <a753f480-8dc6-42f7-bc6b-32f37d47d829@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a753f480-8dc6-42f7-bc6b-32f37d47d829@lucifer.local>
X-ClientProxiedBy: LO4P265CA0149.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::13) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ0PR10MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b7564c-0fdf-480e-f674-08dccc13d0ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8EEeMTfCxyumtLdwrYeowjc233sUhLvOtWqm2by3UawMNm6vlK1ic8l3YT4R?=
 =?us-ascii?Q?2iO5hFZvhA98TuR9gMJDYpS7gBn3KC2ROPayX3nwS9GhoZlU09rdQtFHD2vU?=
 =?us-ascii?Q?UV4G0rc6FeiN+1sS4J8PtM10hLSMF9Ei37KShQjL1D2Ef5Gph5eJNl5YBO5S?=
 =?us-ascii?Q?CjL2yhNDwFwaO/9qhMJZo6alKBQqbFb/LnEpSLNzc9gSsF2xCDkPE927n501?=
 =?us-ascii?Q?bwgsipe9VThd0HZCxQVVjX+6RKpCV06YRmgaiiWqWxvuf9a+oXxo4LB91tLb?=
 =?us-ascii?Q?f7c/n+BqZ5xbU64JdUredq0mUD93zhr+qyG2vNhR197aIQvoL5quLRpsO6u8?=
 =?us-ascii?Q?GdIUKy3yXea5N/hGlZmi7XyjRv8FQ4WklQ8kT89dUNiKTD3x88Dk49Z1bnfy?=
 =?us-ascii?Q?gOLFgegGIOhGwvslh2GJVxavz5tmf9jauAg40yDXUxjdD0EDJoiwueuQG0Zz?=
 =?us-ascii?Q?CXaQJBpJm0rd86626qxAAlAJc8JZXSiFjBAGZt3s6Rhb3HmUTb2fiWeTfuLL?=
 =?us-ascii?Q?du3TYCxeYnoZxNpHTTEc4nsoOW2zn7pZQtI0S5ABwV3/fhOJl42IWTWdF29a?=
 =?us-ascii?Q?0/u6BScpz3mOZHa3uQXpA4kh1oI/a9gKA6Vj7IMZPo9qN8JLoWmckbVUvdlg?=
 =?us-ascii?Q?kowYvTvm/ZbuTXd7zD/hlmXwqCDHoGwhcMbtLUKnzCKczPeRcsfwiaUVE2vg?=
 =?us-ascii?Q?Y0a1bgwTyxT47UKOlAUZlrJLFg66MRfuqsQgGITUIswioBsip0JxKmYuV6Gi?=
 =?us-ascii?Q?GD5MYPmixy0bWGYEe6OIiadRE7uH60v3BgzIJ+xLmdCtDvrTF1unnPBc4E3e?=
 =?us-ascii?Q?vv3GVoNPTnkUN60y2OVKCMCWKijt387sdP+kqTNN0XitbHpbz5yhwG9ifD9H?=
 =?us-ascii?Q?gnEqf9U8EwGlGBKNsRJOd3e7cQMjupZQ9rpOOSmWCcpgdNJpA4SkkZYgfLgl?=
 =?us-ascii?Q?l9NTyKkCcMP+39/paUOANJ/H2/lAPBqRbVEeqYzM/kJ/hqdNEZRNVv7uXmsb?=
 =?us-ascii?Q?RyPEIMBOKX1Ct80x+8tAZ0XCjYKehu2JRDJZlKsof3g2QSMtfmU4Z4ziDbiM?=
 =?us-ascii?Q?q3E6rIv/lIqgsVbR9snP1JTMCHnBoqSADH4ilc49yILvx1pp+Py//hdo31D5?=
 =?us-ascii?Q?67db3LM6+oG4PoR468B/UAUA+DKnZzZokgcFeZxPyruFZToH4vuMuxYk0PjG?=
 =?us-ascii?Q?IMv6byFQ9YgYPWQhWUrp3RDqPzogp/0kXDBevZLw9qDTQNEgz6jJqz7a965W?=
 =?us-ascii?Q?/sSRBVEa6b9+uskiEgJTSPYxxOh5Am152k7pw48J2ETmRMf24i06xarzL8+L?=
 =?us-ascii?Q?Nw3Nf+l+8u0lQIvl9jU27l7T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mGgFlNavO/QtjeUiEc56cpi+dbZeNqvGrp8IJWFspvGxWSI/GGHgfQ19YCS/?=
 =?us-ascii?Q?ayyHk6RfMsZPQTrQviHo8lVsQR4ghwf5uP2hL+n6FMnbwmcdYxeK05vS/iRE?=
 =?us-ascii?Q?4ZMmtVunfjkt4s+bzQIM4u/LW2Iw6TZPV4EQhQDkOUwPqNkEgZ838kcZeihg?=
 =?us-ascii?Q?eVdXxyL/x5ncdG5wCBMVX9UjAgYI++MvtFh2MQkTgJmD/PfJcYH0orNATF6H?=
 =?us-ascii?Q?dgpS7iHF3TeOGza0CQWb1dGKeEDtx8WLPsrw0Jp9Bj7Yw8M6n8DUQ0vMUKKg?=
 =?us-ascii?Q?mPwQnXR3AYuUzCM1ZFqxkjnTwrB98elwUpqD6be5W7bapIIBromfUEmf+B/K?=
 =?us-ascii?Q?yoawn9yT+WbS8Gc0ufxrmEnfG//WvA7B3pk59kNWmE3Po/llIp2ELFf4+1Tr?=
 =?us-ascii?Q?eSrfWDP082e/jx4QSzckoN975sza06nkNOvqTsnXIh2CzsBQCVT95wZpR7Vh?=
 =?us-ascii?Q?M8NDbzyw7qbuulwvO+iVsmFj4Np7Q+KE3PzMWDGvRKG8SejODQIDcqpuPCkX?=
 =?us-ascii?Q?/F/hWc6X9NlOEm6KnqugewgtkNPql+4eA0b9VbsHoBDSkVOcnZIxAaQpCw1z?=
 =?us-ascii?Q?b1Xygov+mNnE8QQB0w7R/O3eW6zDzQunDGg/rh9Z1QffPqn/PvdTAXw25AA8?=
 =?us-ascii?Q?r3/HAX1ukQ6HN0QgWgy+zdhSRiL8xBa19Sj0DNZgGzd5Xcl0zXYwy7nwq1b9?=
 =?us-ascii?Q?grtpTK+r/i0OqJKzm8s3YPRI2wjE16aQplYYd3W/3w8xoJ80Mszt8cXU/4Ah?=
 =?us-ascii?Q?ld/RqDGTy2mwg6hIy4hkIy9lGygjAFLi7fdSPhg42U4fJUHxOe86ZErgFSLq?=
 =?us-ascii?Q?u6oWIbOgraKeZkI0vz5zRvxNarDfiWTs8gcuAv9QKWJoxtXd4bl3V7puQva/?=
 =?us-ascii?Q?yE7Ky3d84EmvkDStxpeLwa67pJR8qiFDDM4HC94c7TTU6pcsqekcDcoy9ubY?=
 =?us-ascii?Q?osGER6cp1XdknXC6jMeQFIgK+vikCOy72SkP4AebG6Sobp42EKAwZpWfrVLS?=
 =?us-ascii?Q?0/bDO+fkvrYL/M4YiKdTCzUWxjfq7qH+YdPTWk3eZZCYF2DHK5q/aQxjoEED?=
 =?us-ascii?Q?cVKrGBQFEDHCTQtEop/8Ftu1iATvsdY+A9VvBcbW64jOOerqbMQsOEovjLvl?=
 =?us-ascii?Q?73KE1shCt8GXFiOxS3H8QJeeXKzQMocm94jesbsiB0yUZ+1zsvOYtc2SXQG+?=
 =?us-ascii?Q?+oRsJfiM/ZXzCz5GbNRH8bLcPBBnix/c44JyB4MsmKhDtCreJmVjPtSkSF+x?=
 =?us-ascii?Q?uPPskTa8yOxRhbCarnt238aMsjOH2lEatomsNVGIOgv+5JlAbJ4XBc0h8EuN?=
 =?us-ascii?Q?BJFO88iwTwFVizbDWuxeg176T42Hug7W7Siqo0Tr/eFZTDE7YJR6rxB0F0dB?=
 =?us-ascii?Q?yoXxD2e+W5eVTKJLDdH6n0oDJ3G/iHqVSOGm0KZbCsDi2yVLmRuVG53Ltzil?=
 =?us-ascii?Q?CsIINWEgjFTY+DARcT6jn1EEaAqZZ6ZhzZdxLkW8mtMxx/L0lMHAIqsBPGHY?=
 =?us-ascii?Q?QCZzh3ItXTdtQxn9oWZYJM1TYoDKnPcNPlU4P+Wz5WnX4iDBvdP1+q+RQCNZ?=
 =?us-ascii?Q?srsdyOorUVL9IcHxYX/SusTyDkFxq3HfyWzg6qlAFubWAozSfbSc6Fn1IsKU?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3Ad1fEP42ch+j54ji4Sx2BP7v0ucNS80RMJl9eojwvG+3YPqbWv3g9Imm+Ox+QCR4mmmep/mCZmB0PoTXT7VgyvD4qB8RUIiauI2n26wmOzfV2kkb53TBW8J7ONz7IB5QVp3GgqFoqkJKuyPLyf3TRdzqh4w+lRXo2mcfCmyZmCPlvw6IqEuT1vczP8XywnIZToEW6aJLkWZ1wFgOuuKq9La+M+1oGDPa2hWNCJB3H/3d4ktCbO19s0ewsHDHlAmMiocFBZFk7WBs/60n4wrceHaRY4HMGobxSU649Iprh3f5rf60HOaVcC5RkJAgiYQZeK03KOISjGNRQKTa1NT9Un+oafgVPJGpA370tmOMnJimCmQbjMUDHz6IQpjxfjgyZN1NnCHvHyzewRCZ+5xEu3yUn1zbE9Mqvwh93KA/VrsZzs463KkjDV8TowMTh8FNwTYGWrc6Mq9lPvgty0SlVgwpbTkeVXm6E14r0/VNKFg3cLUx8uL0Kb73QLtW+AlgaQs3lmJbvT85pJNhCROEyKMGbrBUPHIwiQK1N2ICwN+dBx8rMkoOmB26vDoVrqgkj6A4siPBtLp2iehATls7eVAeCbMlBK6MwXjtiyd9ZY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b7564c-0fdf-480e-f674-08dccc13d0ca
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 12:27:46.0772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0C4VfJ0wOrZkVd/Im8LZ4FniTSbLGyMYapSFFriAopikVBuN66j4STkeRKB60Qr992+6/Ba4EwfQYk+yVZvHXX+iXcq6KqLDwj/nT4cohY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409030100
X-Proofpoint-GUID: 8_In2jFTWiG-oJl4g0lUwZ_7DA0CZb0O
X-Proofpoint-ORIG-GUID: 8_In2jFTWiG-oJl4g0lUwZ_7DA0CZb0O

Hi Andrew - TL;DR of this is - please apply the fix patch attached below to
fix a problem in this series, thanks! :)

On Tue, Sep 03, 2024 at 12:00:04PM GMT, Lorenzo Stoakes wrote:
> On Tue, Sep 03, 2024 at 11:07:38AM GMT, Pengfei Xu wrote:
> > Hi Liam R. Howlett,
> >
> > Greetings!
> >
> > There is WARNING in __split_vma in next-20240902 in syzkaller fuzzing test.
> > Bisected and found first bad commit:
> > "
> > 3483c95414f9 mm: change failure of MAP_FIXED to restoring the gap on failure
> > "
> > It's same as below patch.
> > After reverted the above commit on top of next-20240902, this issue was gone.
> >
> > All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240903_092137___split_vma
> > Syzkaller repro code: https://github.com/xupengfe/syzkaller_logs/blob/main/240903_092137___split_vma/repro.c
> > Syzkaller repro syscall steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240903_092137___split_vma/repro.prog
> > Syzkaller report: https://github.com/xupengfe/syzkaller_logs/blob/main/240903_092137___split_vma/repro.report
> > Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240903_092137___split_vma/kconfig_origin
> > Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240903_092137___split_vma/bisect_info.log
> > bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240903_092137___split_vma/bzImage_ecc768a84f0b8e631986f9ade3118fa37852fef0.tar.gz
> > Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240903_092137___split_vma/ecc768a84f0b8e631986f9ade3118fa37852fef0_dmesg.log
> >
> > And "KASAN: slab-use-after-free Read in acct_collect" also pointed to the
> > same commit, all detailed info:
> > https://github.com/xupengfe/syzkaller_logs/tree/main/240903_090000_acct_collect
> >
> > "
>
> Thanks for the report! Looking into it.
>
> > [   19.953726] cgroup: Unknown subsys name 'net'
> > [   20.045121] cgroup: Unknown subsys name 'rlimit'
> > [   20.138332] ------------[ cut here ]------------
> > [   20.138634] WARNING: CPU: 1 PID: 732 at include/linux/maple_tree.h:733 __split_vma+0x4d7/0x1020
> > [   20.139075] Modules linked in:
> > [   20.139245] CPU: 1 UID: 0 PID: 732 Comm: repro Not tainted 6.11.0-rc6-next-20240902-ecc768a84f0b #1
> > [   20.139779] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > [   20.140337] RIP: 0010:__split_vma+0x4d7/0x1020
> > [   20.140572] Code: 89 ee 48 8b 40 10 48 89 c7 48 89 85 00 ff ff ff e8 8e 61 a7 ff 48 8b 85 00 ff ff ff 4c 39 e8 0f 83 ea fd ff ff e8 b9 5e a7 ff <0f> 0b e9 de fd ff ff 48 8b 85 30 ff ff ff 48 83 c0 10 48 89 85 18
> > [   20.141476] RSP: 0018:ffff8880217379a0 EFLAGS: 00010293
> > [   20.141749] RAX: 0000000000000000 RBX: ffff8880132351e0 RCX: ffffffff81bf6117
> > [   20.142106] RDX: ffff888012c30000 RSI: ffffffff81bf6187 RDI: 0000000000000006
> > [   20.142457] RBP: ffff888021737aa0 R08: 0000000000000001 R09: ffffed100263d3cd
> > [   20.142814] R10: 0000000020ff9000 R11: 0000000000000001 R12: ffff888021737e40
> > [   20.143173] R13: 0000000020ff9000 R14: 0000000020ffc000 R15: ffff888013235d20
> > [   20.143529] FS:  00007eff937f9740(0000) GS:ffff88806c500000(0000) knlGS:0000000000000000
> > [   20.144308] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   20.144600] CR2: 0000000020000040 CR3: 000000001f464003 CR4: 0000000000770ef0
> > [   20.144958] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [   20.145313] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
> > [   20.145665] PKRU: 55555554
> > [   20.145809] Call Trace:
> > [   20.145940]  <TASK>
> > [   20.146056]  ? show_regs+0x6d/0x80
> > [   20.146247]  ? __warn+0xf3/0x380
> > [   20.146431]  ? report_bug+0x25e/0x4b0
> > [   20.146650]  ? __split_vma+0x4d7/0x1020
>
> Have repro'd locally. This is, unsurprisingly, on this line (even if trace above
> doesn't decode to it unfortunately):
>
> 	vma_iter_config(vmi, new->vm_start, new->vm_end);
>
> The VMA in question spans 0x20ff9000, 0x21000000 so is 7 pages in size.
>
> At the point of invoking vma_iter_config(), the vma iterator points at
> 0x20ff9001, but we try to position it to 0x20ff9000.
>
> It seems the issue is that in do_vmi_munmap(), after vma_find() is called, we
> find a VMA at 0x20ff9000, but the VMI is positioned to 0x20ff9001...!
>
> Perhaps maple tree corruption in a previous call somehow?
>
>
> I can interestingly only repro this if I clear the qemu image each time, I'm
> guessing this is somehow tied to the instantiation of the cgroup setup or such?
>
> Am continuing the investigation.
>

[snip]

OK I turned on CONFIG_DEBUG_VM_MAPLE_TREE and am hitting
VM_WARN_ON_ONCE_MM(vma->vm_start != vmi_start, mm) after gather_failed is hit in
mmap_region() as a result of call_mmap() returning an error.

This is invoking kernfs_fop_mmap(), which returns -ENODEV because the
KERNFS_HAS_MMAP flag has not been set for the cgroup file being mapped.

This results in mmap_region() jumping to unmap_and_free_vma, which unmaps the
page tables in the region and goes on to abort the unmap operation.

The validate_mm() that fails is called by vms_complete_munmap_vmas() which was
invoked by vms_abort_munmap_vmas().

The tree is then corrupted:

vma ffff888013414d20 start 0000000020ff9000 end 0000000021000000 mm ffff88800d06ae40
prot 25 anon_vma ffff8880132cc660 vm_ops 0000000000000000
pgoff 20ff9 file 0000000000000000 private_data 0000000000000000
flags: 0x8100077(read|write|exec|mayread|maywrite|mayexec|account|softdirty)
tree range: ffff888013414d20 start 20ff9001 end 20ffffff

Incorrectly starting at off-by-one 0x20ff9001 rather than 0x20ff9000. This
is a very telling off-by... the programmer's favourite off-by-1 :) Which
then made me think of how mas operations have an _inclusive_ end and VMA
ones have an _exclusive_ one.

And so I tracked down the cause of this to vms_abort_munmap_vmas() which
was invoking mas_set_range() using vms->end (exclusive) as if it were
inclusive, which thus resulted in 0x20ff9000 being wrongly cleared.

Thes solution is simply to subtract this by one as done in the attached
fix-patch.

I confirmed this fixed the issue as I was able to set up a reliable repro
locally.

Thanks for the report! Great find.

----8<----
From 3e7decc5390b0edc462afa74794a8208e25e50f2 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Tue, 3 Sep 2024 13:20:34 +0100
Subject: [PATCH] mm: fix off-by-one error in vms_abort_munmap_vmas()

Maple tree ranges have an inclusive end, VMAs do not, so we must subtract
one from the VMA-specific end value when using a mas_...() function.

We failed to do so in vms_abort_munmap_vmas() which resulted in a store
overlapping the intended range by one byte, and thus corrupting the maple
tree.

Fix this by subtracting one from vms->end() passed into mas_set_range().

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vma.h b/mm/vma.h
index 370d3246f147..819f994cf727 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -240,7 +240,7 @@ static inline void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
 	 * not symmetrical and state data has been lost.  Resort to the old
 	 * failure method of leaving a gap where the MAP_FIXED mapping failed.
 	 */
-	mas_set_range(mas, vms->start, vms->end);
+	mas_set_range(mas, vms->start, vms->end - 1);
 	if (unlikely(mas_store_gfp(mas, NULL, GFP_KERNEL))) {
 		pr_warn_once("%s: (%d) Unable to abort munmap() operation\n",
 			     current->comm, current->pid);
--
2.46.0

