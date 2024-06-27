Return-Path: <linux-kernel+bounces-231724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF80919CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 03:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 488F328640E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 01:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7575C99;
	Thu, 27 Jun 2024 01:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WcoXhMRm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JtmzMYJY"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDD34689
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 01:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719450946; cv=fail; b=Bghfhgunk44vgT1zJVdOcc1aCBRPWQi72foywVKNLHGwGwXoX0gv8xqCNe2WHIHNZHM4xUfI0Qos9uizB+WS2Q75aN+EAEQTVzje93fjcqDbHEeJy4SPjXbDBtLG+j3OjksUexf59Otjpn1y5JDMWND/6Fa8Ai7BygfC6pd35i4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719450946; c=relaxed/simple;
	bh=kZPeTNRgroUAbgbOMWWG+hcVbHHXAASjokUwPJcGu9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vE//ffWfl0GjQFbfwWivVKcPpTZa71st5nJ3wbNprl16en+7Xb/UOWK7u7nHnif+E0rXWTtzbeaayE9MzCzJFhAmln+iBaMh1IGdX+reI6hqSql1nPh9XfC0UsVGkLW0jMYoGb5dxKQIpdbtA/NuqkpY4xu1qYOcj0vNZLeXRss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WcoXhMRm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JtmzMYJY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QLMbjQ011107;
	Thu, 27 Jun 2024 01:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=PmOqPQYXrPCu3EN
	02qEICToIuw23wCIT7mG8Mpz6TrY=; b=WcoXhMRmGpQLoO3MvjB2usXcNZ547w4
	oTA96i/lOuepoVNiKVgxiaTG+P5VwKDw4C65WZtHaC0rYbKFfL9JPZ9h2iaxWFfj
	kYFlQoF6+KCM8XVPocsUkXn8LpLEtRsYJIamAvc9hzFJ1XSL8MypKfCUmY0mNCa6
	5niXxdXnWYxt9nvEZlhojL16zzaIFhSshGiCXM5cRdB0M8w5MZO68MfX18zdcS4O
	m6AbYXxu0zuoiwX8mM/vQfLa7MMQ+pQKVGXM3PeN+FkjyRdNugLNd2IgsW8/byQa
	DsK+oGk+wSjOdrkzZEpHpxXCmjQdPnxfSvl4bdmTeXqCdbxfyg5JSkw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywq5t4qwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 01:15:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45QMo0YC001295;
	Thu, 27 Jun 2024 01:15:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2aetcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 01:15:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNTMegbjJBZtgTVAROKurGiqenBaoW9mOysRUF4qXkw+bOsFojDQl4Xrx0NYB7h8jc/V4wd9fXlKJL/1xczF/0FPjlZ1G+1DvQhemcHaQSMxw6Sy+pY85t9etA/r4p9cUOq5hIBcUYbxmk9Bgyo266I1j/fMinu/I+esRPHCv9Eqn/xElnaYcbW3w0CRVxdkrO0fcZb635W/Z9bVlZEzSpIaFrQ3E5/D6eyztUk38d9QDrxU+bM/fHIJO5PhtQGNzjck1YiIkWFp/WjDS9lARBn0rHInex4SRKXSWBbny8+BZMQWUpMC2REXBxeklF0HRc1CRyGBXbniIcgr+5ohMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmOqPQYXrPCu3EN02qEICToIuw23wCIT7mG8Mpz6TrY=;
 b=fWMa4zxjCmqr+kzaynx9cqEztnfi8OeuuEgfQ845bfsCj6xbJFG16oXi0U9poQAo+m1q/1i8LfNLI7ISd2jYsQSyG07jXnPx/Zlngmh9QhP8QvuLgbjBJhFvCeiJHj4bXuBh7GDyRahr7W39UbPBMJdTBwwLs3IGTJS+op/XVyvbTkr9Zt6fDiJno0bmg7ULAo5mFwJKbp8V3xG1cONHxiZs0AgyZulJWuDf4Z5lMCzdATDEeV2zvWU1JFMMt/3ngepQLpEZOekhheEev46Zp+uTtP+9+jeUiq+dUShkkILxK3t36EoyqKoqZy6rO3j7P2bB8Og71fZ29aXjHrsE/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmOqPQYXrPCu3EN02qEICToIuw23wCIT7mG8Mpz6TrY=;
 b=JtmzMYJYnC8rMEMsK9On9P1sHz36/y34jtEeNCGj3uFIXtl1DyUEb7fgLkechp798ryqIe9dmnou/K99xxzKOyLeHnllyCLJ1zrgch4W2V4p9XMiRALV+iCmxmVNYgdaId4r/wfF19rkqj6cuvLCKD6Ii7uUpiOhFCS0vXh+XAo=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH2PR10MB4216.namprd10.prod.outlook.com (2603:10b6:610:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 01:15:21 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7698.032; Thu, 27 Jun 2024
 01:15:21 +0000
Date: Wed, 26 Jun 2024 21:15:18 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 00/15] Avoid MAP_FIXED gap exposure
Message-ID: <nlq44eay3zjapg23tjprukm7w2ae6qcy5xtc5xsxogsmd52lwu@fhfzf4l6777u>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
 <20240626135855.a4b64612a9104ff163e30bd7@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626135855.a4b64612a9104ff163e30bd7@linux-foundation.org>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT1PR01CA0112.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::21) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH2PR10MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff629bc-d786-4ab3-1ad4-08dc96469d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?VJUei2BkYXZmqaU36kPQwcmzdwwTTFnpLgRNpLr52/Ik9yuH1vX7clb2D+5+?=
 =?us-ascii?Q?jZNU+farRmZmONDSLxuhKwls0JirM149j9ypEilkKj14poY4bny6zYWCf84F?=
 =?us-ascii?Q?aUqUs9pqkxWmxh/SatL5dilBYLP2Zy7MqPlO+f4o96NgyvcAbjBxbTZL3pyr?=
 =?us-ascii?Q?/I68I9V/AG4R4YyI5y/L4OeDXO/PZLKuk4Y7nsq0qHqFbdUkrz7BI/lP8yB7?=
 =?us-ascii?Q?nzjZ9/ElCNzWYQOaAGGNr2rogEKdc75YECYAsuLkKzx83Yvf9AJU4XTig8xI?=
 =?us-ascii?Q?+fStF/VqIIS6+VHaCvga2x6tUdIMtiaQCFV+/Fn9jiswkyBjz2noq3RTrusE?=
 =?us-ascii?Q?T8bYXCztwPlWjMT4FRUUzyzB/c9ZU0IoSFRP58eax7GKS/16NyGUY/kF5g3e?=
 =?us-ascii?Q?N16lqyWVrwZ9IfFOMVNj7nh5vxUXshiYt/4drf8xAkrQz1YqIxT4g7zvMhBM?=
 =?us-ascii?Q?RE4guE9otK3dz9Hl88CSBkKJFwM0OA2rwtkmZhBcmOjS0Mx62Ne3U2vaRs4V?=
 =?us-ascii?Q?pVxRq1/vaArxiRkqyPFiFYzpglaEBja3uUIYXNLRdgtNKfpTKsR7qk7Laymj?=
 =?us-ascii?Q?TJar1WJPEbi1DUwwR4yqGIQZn7TwKb4HPI8uNOrZuhqE/gzdoq+5xBBW/75h?=
 =?us-ascii?Q?FCXpo/vIDUAZzljGiARqgDh/hF9fDAwFhgufxJ+SAOgdJbFy6Zn5M8A1nmhc?=
 =?us-ascii?Q?F+TQfeC4V2CTCLmMXMBfPhTr2LsqB2cycP6m2AK12LaVOYQ8kNhjD7tafPOM?=
 =?us-ascii?Q?5puDtwJfZe9tnsrwcEKvr5xiHtAWw6qnUrGV4/pK/ADq2xyvfBKLkhN3cKUx?=
 =?us-ascii?Q?aODLX//XqVB7E4pVd9zYZffrRdjk7pVDtmdfWSsvUEtlXdOM+48uyaa7JuiL?=
 =?us-ascii?Q?ZW04qfsPjQwlS65cI3k5zrsdL6hkxsEeTAlYNxDaw0d2zFdD+ybDSWT6Wzhr?=
 =?us-ascii?Q?sZSD4O85q+x3RGwCdRp51HmYnkpMM/ijuQNGzC+1fR2ZarEQq49NP29kJDye?=
 =?us-ascii?Q?F8Pi3rFyDuhQzR80t+fKfbOxT9huxrqg1XeX5vGhroMGw+44vRLUNYJ17nWJ?=
 =?us-ascii?Q?9L/RRjnRSUoXGzR8wkDy7J5jhAM2OIezBXwDryCrPMzdrCHw10x13HuEqyg/?=
 =?us-ascii?Q?zl4bvQoqJ2cW8VMsfPxYxvvzsiSo7iH/BMPSVXsBOP6jPoN1tMajl8YzcRxu?=
 =?us-ascii?Q?7G86h/rRYTym327PXxLYyRWEvNSisWYXp1ASd0LrssMw8IjtFIdXS1gYDnpR?=
 =?us-ascii?Q?+UtWiRrW1Na3/xSOP7lGCqZAzyLmfw4uIOI+XZs7fJbx34xTgNetpd2no6tt?=
 =?us-ascii?Q?wXmurH/uFEOwLA3o3mccPjGR?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vHQal/9qg84iVz32OZDGmBYpps+VZeiWQ/pXR40e1EUvCegdA1v3XwMyzSDw?=
 =?us-ascii?Q?hOQDij59mo3OF4T2/6mUV930deQDv5gVcmbCf4CXJaArMYeGil08I9SY0ztT?=
 =?us-ascii?Q?9z5ONUyOPA2CKhNHi5OPstGYYtb5Fg6CsckjHaEZEImeMpOPVACHhK3/tX9P?=
 =?us-ascii?Q?O88tRP9fBFbsAkqNPYp/dQW1vzbEBKavQbZ+YW+qI+T00tZ2dvAHw/Mrr7Zi?=
 =?us-ascii?Q?D0VJxV8mQhMmldIGhJ+lA1v71UMtrPhFmMVyF8pJ2UPhRtqxVkeQQk2FSKcj?=
 =?us-ascii?Q?kNiFbhrl1cIxK72lQ3eUuvS3DsVxo94Yh0b8NPwyOu9QrTMaSMzV/AuUmoql?=
 =?us-ascii?Q?7AUJmphEXcozVcPEpIm577poW/GBe+fLNsLDc6ihRKfy2Fe2NltKRG3/kotk?=
 =?us-ascii?Q?UBh2Ih0FG/MfUpjdv3NGC2s0wRScpXkrwxGMqNPFjy9B5ZixcfH24vqYT9Th?=
 =?us-ascii?Q?hU3cUqb+ByyeizZOnigUPjapqgtOTOJr13GyPVQzLWvpb0wOxknsrJcrHPDm?=
 =?us-ascii?Q?jngsJbvP/9APC1rG3jNPZ8NvZ6FrA1ugrJKxZdbTi+3LIpnpWZENvOM9DNc/?=
 =?us-ascii?Q?0fyL8J8IRnNmLJBbLukmgZvqO8xW08deRzzeYJdU27+yzy04FLNqAGSH6ctw?=
 =?us-ascii?Q?5xKqYYvQ4oiMFwCUClfUKTyjIJc393iWnyfwQnXkJb2gFs2DGrOkFpySGfwO?=
 =?us-ascii?Q?w7PG3SOvD3Gnt5Iquac/J6TS9Fy86/oX7IBSRUxmM8H1l3M7QFVD+Dw2LX1e?=
 =?us-ascii?Q?jFsdbQnRLHN2NbIPiGtwktyi6j5u5N5HNPQIPTtfLySbHcEoz9yQgCqrirP8?=
 =?us-ascii?Q?BQQ/xkpCx3e8AgUsO/EELwjUL1viR3eiZkYkuwp2S+FCp8swTuz8ZYIEBLpr?=
 =?us-ascii?Q?R7A/OO7/j1CH4yEh++mvicG8rHa+CkgsRKLeSI2e+T8yhbRmJfruF4oIxUlu?=
 =?us-ascii?Q?jhGvp7vWtDKU1Ml41Tzb8YLV1EV7IyGNyVqWL/ZLYf6QWnhdQ1xUL5lbrJpf?=
 =?us-ascii?Q?KTfDjNb9iQUYpryvk0a8U7d21MGEjXdw0R8Q0igPAqmNDUfH5Vom2Qd3mJkk?=
 =?us-ascii?Q?A3U2nzGAYvY/c/jtrPe+VCrT0IS6TrIohGVew8lczXSTaXAtoCEhGQY6Ltuq?=
 =?us-ascii?Q?UTGtR0RNnIZktOB6LerdElJWTy+aeSOlbfXZuu9zRHbv9GoILbynl9T2fGOO?=
 =?us-ascii?Q?KaNwCZgfUq+a1HpyxIUYA5IanWap6pjmbBnjMItGZzdHOzqThQGcMFw9F0WS?=
 =?us-ascii?Q?dGLugApvrRSk9wSc6dKUT1NA8wVFQrH8VwDCq1bRXzVXoU314GuUOmjr7VPR?=
 =?us-ascii?Q?5Fnhg2suFUksDjCyRZZOVSzyIiQ00m9gUlqlyX0Fjlpw6C9vd4IkLHx1xVr8?=
 =?us-ascii?Q?wdwC+17dmYan4a/JH28Cv3UcyLfI1+GMAwHSKLBJswHgSJ1IeGeI9Mfx86w5?=
 =?us-ascii?Q?lkHKI83PupYw3cGD0F04Zaf9k4dZXxHmNFMpg/qkdu7xKryXAqHBdvFN3ct0?=
 =?us-ascii?Q?8Av4pJgPGxbLQUcvdTrInUFyVBP/paahNWU+keV8tVMzWbOp+EMgA5AX7aOc?=
 =?us-ascii?Q?TIhnajZ5idR01HprMMMTqXXYBNHjN0gWvqpYsuev?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9UX9JIXdqP9l+nEK9PX63YwRxF9Np7nor/0LRIWUYD4qMPgR2ge+X8lQOlaWM/RQVkDycnBxCQ00eg6rT0AsV6hGTtdQgc0o3otnHVIwRH1TszLTUC6QDyZ0B3lUl/+Z5R9QOFqk2nNrn6L104FH9z8pAUm2wzv0i8DpT3OIf8nciUlfAraf86Bf1gZ/WFV4jaFvCCvJAU9c92aUD4febYsdeTX8dbmQHqH7UWAkz5m6PJdP3HH2iwJkzrM0wsggGNhWAbRu4L9odMLDKVId1Kygaruo7gQyQl59MMmrugEJR5H42nskwJNQ7z8m0A5VMmp7DYuyjhhmGVTKGJiHltRrW2WTAePtMQcfXnDTTRLt8w+KiNSIIdfXdliotnM/F9WOHt048UmI+Uq5Z+TkV4mXH9uof8+TsprlRSSyLrQus9ODZAcEfBJPoPyJgLfRL2tvtIOQzLDRFZl1co2K0ee5yzNoXVEpLb/Jzi4Q6+DR0wmqn3cZhSr0GjHIRRy8/mm2x8iq2V0PGJ50DYXu8IbH2tWzNFt8TVcWY5KQEsgxqXBAr3lkknZhxmUxEV921YKHIvUc3aNrY2pEIWHY9gjwhQAaCJ0pvf0hMtDfqnk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff629bc-d786-4ab3-1ad4-08dc96469d3d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 01:15:21.0851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+0PV3Rvy+drRUoa1L6gDWiQOw66sbgrBlNPAhQA6espIl/aZZKsQkT8dUPt1xhx89SFjAIFtHyvfkzIadtTBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_17,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406270007
X-Proofpoint-GUID: NiMPqfkMq-0kCYjdpsncLXI3mrQ1OoXM
X-Proofpoint-ORIG-GUID: NiMPqfkMq-0kCYjdpsncLXI3mrQ1OoXM

* Andrew Morton <akpm@linux-foundation.org> [240626 16:59]:
> On Tue, 25 Jun 2024 15:11:30 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
> 
> > It is now possible to walk the vma tree using the rcu read locks and is
> > beneficial to do so to reduce lock contention.  Doing so while a
> > MAP_FIXED mapping is executing means that a reader may see a gap in the
> > vma tree that should never logically exist - and does not when using the
> > mmap lock in read mode.  The temporal gap exists because mmap_region()
> > calls munmap() prior to installing the new mapping.
> 
> What are the consequences when this race hits?  IOW, why do we need to
> change anything?
> 

In the (near) future, we want to walk the vma tree to produce
/proc/<pid>/maps.  Without this change we will see the temporal gap and
expose it to the user.  This series was initially sent to Suren as part
of his patch set.

We also have the new interface for an ioctl request to a vma at or above
an address. I had highlighted that an rcu reader would be ideal, but
proved too difficult at this time. These patches by Andrii are currently
not using the rcu reading method as this and a per-vma locking
clarification are needed.

Since there were two users for this code, I decided to send it out
before the other patches.

Thanks,
Liam

