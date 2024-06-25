Return-Path: <linux-kernel+bounces-229581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C942917106
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F83DB276BC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF6717D341;
	Tue, 25 Jun 2024 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DvEmCSX2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QBTG9ZjO"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB8417F505
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342760; cv=fail; b=UjgUyRaTTHSG9f/9ji2IJY7HvBKVrON27/nKUuzX+16PSfNdF9MHCbdpE1bgyQ4J7JSxFFQgjt4SWaxfPHWdN+c31HvOaQ25v5HksmrDILSI1U2lBOaD9jpX6wtrmvqAAOx/s0PR2IA5YfK2C9/s2pcZwrP7U/NPxXvJ8bJm4N4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342760; c=relaxed/simple;
	bh=qJucbtkNw9AOQjx8m8xn/D2NEjYwFmxI5xYuYj4a4OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XE3NGo049c0OeUUl3IDkRzvuy1uBFC99dfjJeznYz3lfQ8jbpo7VoO8nBb1iapqplCM6wkKnHxKe7rEOzURrrXspSSsTxWVuhPnbArUz0zn1Yql7MLMzBIR2eLHBgUlhCV/xvaReDptr161XOoMwRBShl+JgeYdQ8U+C19xtFbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DvEmCSX2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QBTG9ZjO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PIfXVb007432;
	Tue, 25 Jun 2024 19:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=tWeNqUha8Up1eRkUEoS52yWD3cYBN+Ju2CdS1+VKDw8=; b=
	DvEmCSX24jkVGARy83WJTc7JA9ZcLb8J/LeMuXpC3jwBolKzsSzcNADlXICDVdXa
	E/PL3gTSmizEVXPGHTULtwnpLGkUppWyOVemLJbGQm+o3SqT7YCztUWnhcZKR67W
	Rq3kQX6q2jy0fRDfDqKP0lTa6vbAZasIctgpg7Y1zrZ1cf2FO3axdBULSThbf5HS
	UBgE28Zt8FjS2DN2ZM+mXv9lKnQOl/f6q43mIkkbVy/v5yV0jTwJyvZNA0Itnzya
	B5nTYsDXfOMMnfyFtrWMAuZmuwd9/XTGNoT+VfJ8n2xHiNH8FoEhtABHXIXh/F4r
	HSuz8Yg+TgNVPY1umadwPw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywn1d1dns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45PHqkok037140;
	Tue, 25 Jun 2024 19:12:24 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn28fjkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wc0lJZN/7AFEqZf22cYf4g95io0rEdUr/Glfy+1j0BFOIyieEDfXIVnJqcUCJJeT+5Q+58cHgXPEv0Ni+lKwHWloF31UjDCttSwXIpVFbf0Eu9c1H2mP8YAJeE2XecS60Ku+SivFE0z0rsPd9U139p0SQbBx8mgeS6pi3SWQd/Utgbai+Z2xCZsB8KY2/VQDf2i83/oRp2igoJ1Zfog9MIqBGk0rUfJAuly1EOr/YGsj3kiz+ub3PGKLlk3qnFs0TbSkI4JowOuzj8GQ1lq2mbuhLGK+VCQzXKpopuwuLyiFY8aHqgYr4eG1ivXI442pllfkw/b5a+vYZXfdjNqVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWeNqUha8Up1eRkUEoS52yWD3cYBN+Ju2CdS1+VKDw8=;
 b=ns+PI7k7E/4P7d7B2STABjDWdLUOLM3OVfs/o4KDcg8vfXpY90nPoPDKDTB77esdXc9iFX8PLvBn93zs3TnYDImMdeRBWsrYb2pV7mOjemrpKuq4Qan9Kv9222V4GEWh4Vl7gzVYn4zUl6C5+rmDstBRBRFMUkiBgHj/Kbfu1X6k/fa7uAcuw6HVn8sJ2DdtVARvpYnOiAgmGCKWhjHlkjsJqplGXMwgjUPKk3JniePXiD1Ipg7Gx+CvssvncL0nzWXOqCt+3l3pxYqDqQaOHsLJe9qXctRRLZSbGXC/KJDh6TB+++3MhwrXF0PErzLvfGLenc9raAgZGD0ygUPmvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWeNqUha8Up1eRkUEoS52yWD3cYBN+Ju2CdS1+VKDw8=;
 b=QBTG9ZjOdby1WbkPHMGP9oZ2C1IZWd/TvjRyDWjhFjvyrEilEjQSH4d/npWMo2KaJmdBc8VZXjG8xNttg5BojHwOsk7dimh+YxgAh4z3hcdS5m5633NIQGbcXRqDSh92GjEmVAzL0FxrrTsQ64qjkPk/mTf3S1ECpAfFqV5dVP4=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS0PR10MB7066.namprd10.prod.outlook.com (2603:10b6:8:140::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 25 Jun
 2024 19:12:22 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 19:12:22 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v2 15/15] mm/mmap: Move may_expand_vm() check in mmap_region()
Date: Tue, 25 Jun 2024 15:11:45 -0400
Message-ID: <20240625191145.3382793-16-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
References: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YTBP288CA0026.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::39) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS0PR10MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: a91fc411-bbc1-4898-dc5b-08dc954abdbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?VLVtHGEQgkKPvHDM/8+NyPH8klJ4AtcPZbwKPn4qFlAszdhakyqBcEmCV9eG?=
 =?us-ascii?Q?lKph+vDjNAR3tu44kIBzy41WSgzaI2erEWJjt2T3dlfOuQ0TTNVZ0dZL3cff?=
 =?us-ascii?Q?pkar3eaU5V3Z8YRhEhBtNpc1E+d+IDwQpkmmz3P9EJ3wVdkV0kvSUrk3PFbw?=
 =?us-ascii?Q?pRbCf3SK8l7sKG/wiExs3DBx9JvdlfigdacBiqzVg34U/p8gKrNeJ/cWY3VV?=
 =?us-ascii?Q?hqMGc1h45vp9PiyYbJnr/M0qgtjfDUs7nrijLX0JmzCnyEja3EDVHI7lXUml?=
 =?us-ascii?Q?Ww7q4Dwb3hL4ZOkXKeshfVZogK+ihlmD/RGFVxPJMijl3u/uTZDmxB78Nxts?=
 =?us-ascii?Q?Q4Knr8zRRGhBFF+Nivgef5Jo5lUP5RMbqUGSF1Y+UN2y+tstYWtVjOnOqRq+?=
 =?us-ascii?Q?FU08jY+xyf9n3nQagz22ZymPlVwH6WdJ5noWi9U9wMrhLDgcaSEEQPuqXvDt?=
 =?us-ascii?Q?kjErd2EAoizs6JaEEgtlEn7ALfhQ9bdkMv9CsSpkaGEYzhLLpYzHiDNffBze?=
 =?us-ascii?Q?yr1SzLpqKClkpuliN6YTVzVgfZuc5Kurax5aamkeIo2qYK+uvDnXzvJm1bCO?=
 =?us-ascii?Q?PR4wrHnrGddNUx0gTu2LvlfU+2am8gk+gugXtiJNvmUlj3YxYRg8Kr8vcLTo?=
 =?us-ascii?Q?92D/cPQJ9pWpmr6zIe1XBanyoKseAGU4K8LWgrgPAAUQUgn3ImPLkPsWdj+x?=
 =?us-ascii?Q?2yCqUyWnstXFheUwk8n03IBIv9gOxDyrXXnFUzWkOTJSm6W9loY3JoKt+SKc?=
 =?us-ascii?Q?d8gmxbcjCzsgaPdruNKE8JmjM/n8PuLnLwVMJcGng3rZ+pIinUjoLNIsaP4U?=
 =?us-ascii?Q?h9NfsibWfZu4pnZDD8YbKwdq3e1P3joPNNP1GbpgMSlvlIOHQBeed3ZyFPiC?=
 =?us-ascii?Q?mbZa0FepZHLa9m8p5hFlim02hMF2XuDW8QaPTX/uSwkj3bMQG3SKJEhdtW/R?=
 =?us-ascii?Q?7i27/POgtHp6/FbKAH+ecp0Y9otGMZb6CRAtnkQfkeuQ0bk0u0j0GbzDP3FW?=
 =?us-ascii?Q?nUgH1FCjYWNF5oNnD5bUldbuFKgIiYzTqaMUpzKroQlLFjzT8wxx3JOPqBg1?=
 =?us-ascii?Q?BWCdr4rlx+hIuwTzKdwlNJH1RAGxB36F+GUaUh2eziNaEK+C8cebsa5HJ4Sv?=
 =?us-ascii?Q?ACAEVgErsxQYYKiawijqbuwDsLNo9Za5vKXldRFWQaI6AlBwJ4Us0ue0uzOI?=
 =?us-ascii?Q?Zw8LgiyA8uXCRGBUAYeCSe6Lht4w29QVf3j4gJaqy9UaW057blvCqgV9pCex?=
 =?us-ascii?Q?i6dh5yA+OxLsg8mMsQ27MH/SzwGLgVM8dMhusxkeEDYoD/I9k3MvoWKSgPTF?=
 =?us-ascii?Q?WTo+3zzkSgGjRE/a4yY8rZqZH7ORtrkq19GvZo6UUpAYcw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8MM9aeZru+X7LJlmxesPTnfgT0eXIjal6ewRTRk6it44ErAaySARE/momXbw?=
 =?us-ascii?Q?9Zu6KUPLoA4uV4/LnonIiONhrsCQOXFdU9FJNVJSyiwZPTG4/YuXUuC262HK?=
 =?us-ascii?Q?gqrLPwWr8bp33jDsEJ5KVoUsIzZ/H606TX/m5aO0pLn1gic6qdy7+kXo0cot?=
 =?us-ascii?Q?k/32qGHpQrdQnKPD700o1EoiED94Nti3wm5Jf1RBgbhT4H9d1SWKyJLsuWTc?=
 =?us-ascii?Q?MerFsvLExekzFQ5RaK9bdn88W28a6hSQBEKBTafhJ8pHm2KJH1udXWaMuafW?=
 =?us-ascii?Q?HvndmM/CPjUnc0NRscEXBNZz0oUOtoBMWLoh/b9ZrA48QHSlFerB4Rfo3VQG?=
 =?us-ascii?Q?irycTYPoAqIU7G4ALVYqp2gvUmJebWSaRaRogPqZVXFPBmcHGR09zU1M6X41?=
 =?us-ascii?Q?tLU/hBYVdU5NL/7QkAYgjx+eYeTHRKD7oY+h9vXUAf/D86rkl0JoRuPcC6Fn?=
 =?us-ascii?Q?/PsleXLrencb/sFLwUlOEKPC5YVM7ztw0Wi31fewNMYuaxhBpoiiC9c70I9d?=
 =?us-ascii?Q?9ZDXhP50LfHV1qusYFCL81S11A7/iuElAu0LvnNnPpJVTKr7nIlvtLeqdgNl?=
 =?us-ascii?Q?TtUeM0sdNmWoD+n3dMjmK+kxbS2tEOL4M4yZ8UUP1jEF0ULnQLgK2gJ3juZ8?=
 =?us-ascii?Q?wQrbYnkWKwM6Brj5VaJeSnkZkYQHrvt6+cDSlyo5OzNA6nMmfPriplKWfobT?=
 =?us-ascii?Q?ytIJVrRHYtiD/uEAYqlt3NXH2nPLIEsnP66jX5UUwqOkJx3fHhCAMSGWtyA1?=
 =?us-ascii?Q?Go6ysI/EPGsg9ez6l+F0lL9oUPx5EioNT0OIXAfD8h8ko3FzQGYyoukaJndS?=
 =?us-ascii?Q?TLRtwZ+1zQ2Wx5oenDrCNtJU1EBq3e6W+l+g4xC0AHM2n5MZ0i7d+CYrnZPQ?=
 =?us-ascii?Q?BHxL9UqbRugeHsDlou77ZWVJ3NNpGf/vyw9VnSNWB7/OtVfFhuzyYh1CqHdI?=
 =?us-ascii?Q?CynnJyR9i8kKj3mAmD5WYp38IVKcWI5nqvfh9LBezc1XYGbEE6VtVUEWxb2s?=
 =?us-ascii?Q?BxIkmz4kFACCTxtan5b+mYXhast/EOIpYTy/+uO22eavuGRuEzdRkE6euCNm?=
 =?us-ascii?Q?87pHxXAJLHwsbNmUqOZ4GsQ3ydHj150cP9GWtVe4HoaJEp7PIPhk0eQ/YAt2?=
 =?us-ascii?Q?UpRGDd6JcMtK/T3ZMfO2TaoEpUmP2jSycNuPyyIUVoLR9qdskdZeH1vPkrMw?=
 =?us-ascii?Q?O7f6tXNY2FomyvjvZt+yEO8ZK+L6N3Pc2nI3UlDBQA5bHLn6hKqL/uBPKRfw?=
 =?us-ascii?Q?y7nkJqkbkEsTMqw8wP05mySjE5zTuHRu/X1KFopAovIC7+ne5Lf1iAjmmayp?=
 =?us-ascii?Q?cUeiZgUuHZVQSY86LRENSayOJdi06uHleMt1859r9XfPMYvhfKmsZayz2glB?=
 =?us-ascii?Q?83TdbmQoJbPYmVevgdEpdHmOiO1qafMggu3r9V7FdgUWCsD8ZJ8IXeyvYlWe?=
 =?us-ascii?Q?8u7l0USAgbNrNGnM5RQD0b0LSHuwsfgWsyxr79xEnjY1XsOV6DFuOLQOG1Lq?=
 =?us-ascii?Q?U4iAYLncjbpDcIHPSZHTLY+rBhbB90Af8WgfDmXl85B797szXk/ccCpqf6KP?=
 =?us-ascii?Q?DNwRx5jtkvWCmAgQhzoiV4pUQrrwITfy4bxqKwW/Oe8u325VjLGDURLnd4Fu?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Qc41SRMMATOJYthAJauWQZD+t1Lx/9kv8OmEbHadYd1SvDQ7cpGFQEv5XnJmucA3CGT5Z5WJrNSzrMJ4pcECiQNP6+rNvsD9uE2OoEZxU3oHI3ByJrJ1ZfLMtiaZwELPbdH3fTn2UiZ3Wg39pLhC9lfsKmtXwjeIDV5s3mzPSenIDDGQgvPnKb/DE70eHCdYmV+WBKGXt9RJRNurOECIy+GXwgAUDs+IkzYvyWn/0/x/hKrd9BkKkdMwUSTiPBRFjTbBYN625TvUx8jcsuniMICEZI4LCqSW7bd80qpaM3je2RwCSLo4eBlPM70dbCfbxRIUaCRxJauFMGQCQ2O6sumg0rSlXazxq3DJIYM/39DT67TK8Mj36nk0B3qO8huqDpG15aQH+rGar2nV+cZ6bVQq0oR5LEtyFS0op1iV4zEP4n8LwAVZEXzFooDI0/E46PmlIuijZ9s71I4ebCO9f3LSdpAOOo+mbw2Tfah56t6PPw7lm743letgmZR8v5PRUesXXbf/QPtjNtZpU+FlmiVCvDX/985leP2Tvwf6K7JBQwY1XNkriF3VSd0CG/2ltFSqBBMH+cEqFbkPRrb9XBb4A/zspzBkK+vImpuyA2I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91fc411-bbc1-4898-dc5b-08dc954abdbe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 19:12:22.4219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10/Ru7xxAP+NFp3SpwHoYAjTWI37cvxhKrczjU4HAQCHVgHYxrJoU2yxqr8ns4X6KzhilkIGOPK8BpOBLnQAhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7066
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_14,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406250141
X-Proofpoint-GUID: YkfakiUomWIeKsJ98R73bpq7pu2zfHLO
X-Proofpoint-ORIG-GUID: YkfakiUomWIeKsJ98R73bpq7pu2zfHLO

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The MAP_FIXED page count is available after the vms_gather_munmap_vmas()
call, so use it instead of looping over the vmas twice.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 36 ++++--------------------------------
 1 file changed, 4 insertions(+), 32 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index adb0bb5ea344..a310b05a01c2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -405,27 +405,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
 }
 
-static unsigned long count_vma_pages_range(struct mm_struct *mm,
-		unsigned long addr, unsigned long end,
-		unsigned long *nr_accounted)
-{
-	VMA_ITERATOR(vmi, mm, addr);
-	struct vm_area_struct *vma;
-	unsigned long nr_pages = 0;
-
-	*nr_accounted = 0;
-	for_each_vma_range(vmi, vma, end) {
-		unsigned long vm_start = max(addr, vma->vm_start);
-		unsigned long vm_end = min(end, vma->vm_end);
-
-		nr_pages += PHYS_PFN(vm_end - vm_start);
-		if (vma->vm_flags & VM_ACCOUNT)
-			*nr_accounted += PHYS_PFN(vm_end - vm_start);
-	}
-
-	return nr_pages;
-}
-
 static void __vma_link_file(struct vm_area_struct *vma,
 			    struct address_space *mapping)
 {
@@ -2936,17 +2915,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	pgoff_t vm_pgoff;
 	int error = -ENOMEM;
 	VMA_ITERATOR(vmi, mm, addr);
-	unsigned long nr_pages, nr_accounted;
-
-	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
-
-	/* Check against address space limit. */
-	/*
-	 * MAP_FIXED may remove pages of mappings that intersects with requested
-	 * mapping. Account for the pages it would unmap.
-	 */
-	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
-		return -ENOMEM;
 
 	if (unlikely(!can_modify_mm(mm, addr, end)))
 		return -EPERM;
@@ -2977,6 +2945,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			vma_iter_next_range(&vmi);
 	}
 
+	/* Check against address space limit. */
+	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages))
+		goto abort_munmap;
+
 	/*
 	 * Private writable mapping: check memory availability
 	 */
-- 
2.43.0


