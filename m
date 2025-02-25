Return-Path: <linux-kernel+bounces-531789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBBDA444EF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7BEB167BB4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990611514EE;
	Tue, 25 Feb 2025 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QIyQMLjK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WkENbmNq"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EE913C80C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498491; cv=fail; b=pmM3ue74mOpeHlbis7JcunSTG6q4luZWJkKwmUzWgU3/DtUd0LQc55wWFoqExL/0bwXnhQMCMtR41GupoI6iiQ5IW9su2ejOzm9lS4rajRjmEskWpx/rNZ3bcuRGf47uZkqrrSfs/5JpVZX4ehvtogNjYZ9mRGX7IbrOfOu5+dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498491; c=relaxed/simple;
	bh=5J6DAFAEZIi3eMeT1eaUeLRU97fpwzmGlQz0jJSW8g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qiqBKwBW0CEfhsTggJry/tJrNfwoAvEBI0jhmCuDmeKBxuF4HWG7DtpJlFD5kpDAF07pD1YNopz/GRaWiz6n52VdbK+6C6nThHRgbFZ3f+EyPLQdLoWhQxfz6Qu0JB26z0wdm+IGLT75kUR2/jQCirziCnJBUDYhXzjBoJA3kFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QIyQMLjK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WkENbmNq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PFMcej002124;
	Tue, 25 Feb 2025 15:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=xnOX+q6qi/jyMoqCuW
	N4G2sZXoczZWWieAhCthzM5ng=; b=QIyQMLjKOjZFThRqGXiLoUjOv8n86C4rI+
	Bf5JTTuzN5/zZLIIeJPvAtO9ot27e0lYeXFb+MDb9lmRPyU7Z+QrjjzbhdiHD7RS
	GBOcfTFE8zanYCxERPt0u+lOo574uRlh8PIsw+YeOzZ9ekKaNrY2oeokk4ZK9g3D
	Yr4sbWmfVOEehj8Y5JQkVG9KmQAZkjoq4eEfaPKnnfw24hWb1I0idyga8oZ3swZm
	YkN4v0Kicc8C88cn7RT+sulpBthjwoP9MFcGQugR/PY7kE2oACekKvvTgX7rPQH3
	TvddzJV8gxaNctFSBWeIzw3FsGBfQxzPqkEA/ePA6SgJOQiTicWQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y6f9dffm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 15:48:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PFcKSL012594;
	Tue, 25 Feb 2025 15:48:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51anbg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 15:48:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VuSjh3ZTTyO5p+X/AOzwYV4zuWp/83a/hPYrX/gocWtCA29Fm3SQLF7Tc3VE6HIIhsCjCNxMmCoPsOCp0ku19Mo82tIhtqEL+CKdx4FGsWoWCZDDfjo/69JHFrTRWDahBDGHfsiAKhX8WMFvjXPcLihwHzENsMH81AtPX8h0k7BntwUijUpmEO/TWSkKJfUO2sGvjd8IhZ51n+zvE8G6MoQYxonuk+v4rpCWL656As4+XHlCj8wTtBQbVsO4geE6PL1EbexHNtJxv0gBAI/eLxqKod2WBhch4RZEzXFdH67linqxMklv6qBUd78zUiYykv6UsyI0XpQHE9oMPhDLug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnOX+q6qi/jyMoqCuWN4G2sZXoczZWWieAhCthzM5ng=;
 b=dx+R+7ssRpNEpOSwtHWcKkIOM6A4jwbWG8w7PP2aoz11ePICi8iHeaDIlTUwdKkoQZiZSxsY9nGfGmVudomtRSsgEkYvy/xfdiY4GGFcNW7aAPuMVgbqv+a3kDnX5uWG4+jL/UA7gzDDyKG/FLWMnd+LwYRIWAGf/XQ0xZnvWACt+roJjxlqkwUn4n4dRea7GM9MwdZQHEeatW/cKLizLkYcLr2ToDR2/XSkgdfoqF4DtrwDbu2iQV2mkb337YVgHiOYUQBy9D49YDzNwyIYyF0jAHlZ2A2Dmk4ktJe7mZ3R2dx1/nIxvUaEsisDjoRj+kMW6OeI1HJB5KzFcyB/ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnOX+q6qi/jyMoqCuWN4G2sZXoczZWWieAhCthzM5ng=;
 b=WkENbmNqiWUXFje/PpORTXaK7TcaYGvdvA+NN8+ig9F3m7VmNiY4kSKyALifRVrM0WaGznbhCKaPIM6o/XwoMcm2y0GHkAnXrHBJSnLKcPeqqJv3LZzJHRuNQEtbVu9gK4CXQ9tsS4vGeKmaJTU7DIFlIXtUnhSuDiJd7pcqbZE=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CYYPR10MB7674.namprd10.prod.outlook.com (2603:10b6:930:c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 15:47:58 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 15:47:58 +0000
Date: Tue, 25 Feb 2025 10:47:55 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        richard.weiyang@gmail.com
Subject: Re: [PATCH v2 4/6] maple_tree: break on convergence in
 mas_spanning_rebalance()
Message-ID: <vpy4kd24dq3mx2wwtiqkmxdnndlact5trv4pwn55ul2xzu4zkz@adyb5e665grg>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, richard.weiyang@gmail.com
References: <20250221163610.578409-1-sidhartha.kumar@oracle.com>
 <20250221163610.578409-5-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221163610.578409-5-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::21) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CYYPR10MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f3f5ca-db2d-47fd-2533-08dd55b3c6e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hR4TESgDHZJ8GscmroG5Gsxvbi4HJWBAYjUg2Wj8cRy+oJNtBf8z+BB9kP1T?=
 =?us-ascii?Q?0/lbU45IB8/ASBD4L2y0H88KGkeeZlISplBdBYYoUM+QmNuFWR0xasoTdcwN?=
 =?us-ascii?Q?laxbQ3ezwdkQFlkNrsI7GtOiJXLPfi3vsmSb6urfeZ72NejAi0jHwmo2u83B?=
 =?us-ascii?Q?wp6uHO9W3zbRv7KlyW8wUR0kotJ+hlr8ZMa21LiXLAztxhbOfvO3Ihk6OgO7?=
 =?us-ascii?Q?81ofB6jt9fwGA7XpJzIpGEJ0cbtDd03ty3j/PT5jEXjDVv/nUgEFl+tCGvLd?=
 =?us-ascii?Q?hRLY0MKhmZYgj4ooMLf9nZPFDtdoTGtn5LdZXftyZAMeaxyjUJ1wqtMzRB3l?=
 =?us-ascii?Q?Zbt1yPhQOduqvhZavOOCHNn7cRlY0fKxmGG6FKv77NnSEQyYY6ppyVy5C8CB?=
 =?us-ascii?Q?7nw1ZJSWFkOrB4eflNDNNoZgX9JDRJCHKQgdhOdg2cwlBzYmOpWp0BfrZbLG?=
 =?us-ascii?Q?Q8zGF9PDY+yEbQzRAOtH0XE9F8iBdBh3wgjngrUFsSSfqHusdlSCsoh/IV8D?=
 =?us-ascii?Q?8qRrL1C9K0Z/QPb42Ra6TP1VT0GfYPMPWUzsQuDTc2ohirihwuR5FHSNy2e3?=
 =?us-ascii?Q?ZcwUopA9koaj5V8pQ8TCBjp7sR82CML/7PuYz/h5WwY7gcuyvQRbpKKviiZK?=
 =?us-ascii?Q?lwi364BUeA0eMKvM3zRZnlr1jyrQykaj8TWTXOkNLPQG2n3Qan4RaAjBouwF?=
 =?us-ascii?Q?PbnxILcyYjIXUOLbjAPmYT08jbeh9l7hBCWMZ6IscV0swKBTjGaNzffRykZW?=
 =?us-ascii?Q?/Uc+iUH5wuDMycH3la3F01YTk2kLzYnUF0PjY5xl7rr9bDtleh+J+poij7s0?=
 =?us-ascii?Q?+s5eAWCzTd9ZDkxBb5YxZ9I9TQcL+kT8Ogk9vNi8fAkS9bvlusm8wpca6ZPS?=
 =?us-ascii?Q?e8AJwT6w41pJFQm7X22NN1I+Mmzagv07J5mt/V1Vl1w51HRapmlU5fi7s6CW?=
 =?us-ascii?Q?R1BAm3kkvHDW/Pt80Z8253go9ziS+FcZjAOnM+4fhTXNYH63OXW3lvz+W8c8?=
 =?us-ascii?Q?NfT9ouMrYUPd/JgXJrBpH75efW8Qo7xScMflhHbj1Umm8Lc/6KGZiedFnyC1?=
 =?us-ascii?Q?yffjARxBH7srqBUy8/3d1DTZaZrSqYXFu0RMYay5s6ywOAIimbDG/eWL6+2D?=
 =?us-ascii?Q?zN4csZ6/P6sNzTltamW5D8aNeucvc1dkhp+DR47hjispjwhHPKQ8VsLNolJ2?=
 =?us-ascii?Q?fE/5PrnRWlhsKR42BfS93qLlR3yiX+eCPCmkSl5n6vtDuDexqyC808LqXk3I?=
 =?us-ascii?Q?ldJ2Fe5Pw/f3I0NLLG5Ne3AU1BRhhisrmZ7lZYW7z8jwRGIakVznvJzksjmv?=
 =?us-ascii?Q?l6CsjlVS/qmPoHx44HZEVKoBsqmrxPZvDC0cDLQY6f74YPau62lhLlny6VvJ?=
 =?us-ascii?Q?7/ZSso+RH5xbAyuxzqLxadhAFXRF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ekFB7dTW8Dt+icvA6p45L2mm7fw/mnLcWMZmikeGBLB69f8m2nA9P6SKmCAR?=
 =?us-ascii?Q?9ZaOH9pmG+btTOLWdvhbeyS4YbdoYvU4s2+Jri4Zh0KWCdDms0TFiP3tKgx9?=
 =?us-ascii?Q?5j2bd4lJELF9eeEiLuFhWRVVUDeAe5jBnZp9wLLn5R7xGW7za8a9G59ihnv2?=
 =?us-ascii?Q?5VcKbl0rX95S0BcF5YtMKY6t92mU6gYxWJPajCBMkgLa+hbnnPKzSxxJ649A?=
 =?us-ascii?Q?HZCJZNW/Yne7Ke9SqFh915u6F6Av181eGQV2lHMQUH4nMjXD6ERpCF2qS4Fx?=
 =?us-ascii?Q?G9BsIY6u3TV1v6+evoH/5fqI16NozCfxuRdSmfsNHvn7e7Manx4Ahil0NxKA?=
 =?us-ascii?Q?iMRYu8/ny4on9PjrTRdAmbpoKOmVYhTrJyf5atmJklglzjvL+hO+W6hWfp3c?=
 =?us-ascii?Q?wWufcfhKarJVmq2tmjG5pzM8h5iCioTx9sj1MR3ewqHzhsbw+vLekBTGyWyl?=
 =?us-ascii?Q?ozartiau37fXgEQbQFpNW6e1SL15SR+cNO6lc908WkhlFZIm3irEdMYxXKvV?=
 =?us-ascii?Q?7qJ7yBGR9IMhZtZ+J2tJ4Ll+7IRExJ1A92h/IZ6tXBN/3JObjXrwkM2EZ1mv?=
 =?us-ascii?Q?zY82Ju7K3OxM6wmMq/WJOYOpOpJdwUPjM+PTU/vYSlbHoTxarkmDARvWVoZN?=
 =?us-ascii?Q?8dtkR+4RcndUqhV37uiU4t8oYaLLOMXgGSYZ05/NCFAnSBRBRjzbF6bYObTX?=
 =?us-ascii?Q?vBeEcTnACnkXgj8jQgQ1PKrW/OBG3yQhFQEpE/DcFuRPap9vwZjm8wta7idq?=
 =?us-ascii?Q?tdP1ufguTwDeQ2dRg0rvk8ciw2D8XcnLvTMkOF/A33L83siCSDu31Cg2TD9d?=
 =?us-ascii?Q?zXE/m6+lYVnPlYOj0O+nqr0Uwd29dnatfNBmQN0ylqh9A5Wx3yjFvPgho/Ze?=
 =?us-ascii?Q?/XaVWc2SZBVFKlDQ31uXXB0hIuBkmlUYToAFMLV8rHaU40PijWudB0qjiXBP?=
 =?us-ascii?Q?TEN5cLxO18VdakwEjrdC7evNGJMDsUG1Zcc7wymvS4IozLcu1AuqN4IJI66A?=
 =?us-ascii?Q?C9QF60GLDol7lxCQtB22JPBI87XCksNsZr9D39jjPfw8LGv76ss98hDWPI/v?=
 =?us-ascii?Q?UHmza7jCEa0la5h6tcWaBysLqGPMXdCZedpdNpEmBiOe0Wh/Kut1QOSobK+U?=
 =?us-ascii?Q?X6keOFUpIMU84GnR+k3A8Fq9Wsl2w6dgN1a2mjV/k/30wuzcCfL9+UuAKzo+?=
 =?us-ascii?Q?mhG4H6hhRRREQneHAGqu3RMdce/JB7dRj/tGJIlAXsZsv5Jw7rNuP06f1EDB?=
 =?us-ascii?Q?q2prao0+IOR2s3/3LyOGQz/7CRjq5lgna9vWU1CIZim+EgcFCRy/UnAKUflf?=
 =?us-ascii?Q?iYxQwWghz4IF8G6CdcO20N1kNip6Z+QhNsImPSCWmxA+V5xHiJQKNsRUvh72?=
 =?us-ascii?Q?+jhglQLn2cLnK1y6LFvoVwsPIsZkwFwPd2sPbrwPWdjrzzsOwngOZmmHpeHh?=
 =?us-ascii?Q?t14REHgLVDVqJ8PuN04L99GhD1d0rnVH46ei8mfpgHXUpAFv46Uovp4zYJ1W?=
 =?us-ascii?Q?i8DmnHRhSvoLshWeBwYfaCICj+KKPneCqLf150e2PI9V8dr6Qhoe8z7vxMnV?=
 =?us-ascii?Q?pStcfHjmXjbPumCTTU0xBGoCfLk6NN9Hj7TjeKksGOJrnhrRJEyA7ugYfTFi?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PlEA0C9ZcldmXrrF5XbkmiAPYGgp/BRNCCqwhgpBva2UzxiuJdSxzH61pbzANsuzcWDxGyqVRpGNiSccqW9f85InBYqvdBxKAqkVtGo8UcmPXSh49r6aqHERKK14s8zytKUu7uxPrzDQqlyW2OAZAsfLya+0LASo6xv66cY4snXfc8h3Lh+6YrIUJx8JSLAavH6UMDY6N8xR70ygXsUDFqgOnT837RHkaiv9dbZMCnbPP2NupzZN8i0xZEnhVIv5AJr7FMZEqgwKL4HMBJjQy/jRbLV7MC78HOCO9UapfyeWg9Ui/EZynqm/x98EapqlsHuw+EYmY6O8XB36al9HsjuUFDqNVLceJ8LZ0Bpm/fYkjqoCT4Vjerm/oFZ+hOB/i+nLjttAy4Vi5DJRTiDof6Pn8ixe3Am+7D0/Ininz9T4UAHguvYGmf3oZJgNqnuhuZj9JzjmdsGgL28FpCfJWPgZIjDH9Si1/XXnfP29HXrm46EuD6cZcvWNi3xF3abT7qCMtw60dqRoHGJHuqqPeiwjSur1nTaXkdWQR1Se6YFXDZ0HQb4XuliTzQ0UMb0bYTOYvR4GfLE8VQK44wGmSpbXq7MYujj2BNRajI61ow4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f3f5ca-db2d-47fd-2533-08dd55b3c6e9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 15:47:58.2647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xi/TG9AyDmOMyVyx9tWr6WkU56NmDcWbLQ9QyJjfA+0P2STQKs5pHK8tszEbBYxRteo432rqENV3ImIzhzcTWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7674
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502250103
X-Proofpoint-GUID: VcQhn0VxOOVSM-6C6ZHxquvaO2_DIPFF
X-Proofpoint-ORIG-GUID: VcQhn0VxOOVSM-6C6ZHxquvaO2_DIPFF

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [250221 11:36]:
> This allows support for using the vacant height to calculate the worst
> case number of nodes needed for wr_rebalance operation.
> mas_spanning_rebalance() was seen to perform unnecessary node allocations.
> We can reduce allocations by breaking early during the rebalancing loop
> once we realize that we have ascended to a common ancestor.
> 
> Suggested-by: Liam Howlett <liam.howlett@oracle.com>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
>  lib/maple_tree.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index ef71af0529f4..4de257003251 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -2896,11 +2896,24 @@ static void mas_spanning_rebalance(struct ma_state *mas,
>  		mast_combine_cp_right(mast);
>  		mast->orig_l->last = mast->orig_l->max;
>  
> -		if (mast_sufficient(mast))
> -			continue;
> +		if (mast_sufficient(mast)) {
> +			if (mast_overflow(mast))
> +				continue;
> +
> +			if (mast->orig_l->node == mast->orig_r->node) {
> +			       /*
> +				* The data in b_node should be stored in one
> +				* node and in the tree
> +				*/
> +				slot = mast->l->offset;
> +				/* May be a new root stored in mast->bn */
> +				if (mas_is_root_limits(mast->orig_l))
> +					new_height++;
> +				break;
> +			}
>  
> -		if (mast_overflow(mast))
>  			continue;
> +		}
>  
>  		/* May be a new root stored in mast->bn */
>  		if (mas_is_root_limits(mast->orig_l)) {
> -- 
> 2.43.0
> 

