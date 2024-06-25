Return-Path: <linux-kernel+bounces-229579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C54E1917104
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82363287095
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756C617F4EF;
	Tue, 25 Jun 2024 19:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N30n1JsA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T+k4qvWb"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D3517F366
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342756; cv=fail; b=HQf/dLCHTNOwZKJuSivg7/ymurkMPNwjCbG3cEKFIweRMfRsAILq+5LilKLjFkxWdsJ3h3r2Rz9HGZJ5Mwps+IVf24JRTKxPtFfQiUfrr9w6U4Duwe4v9KqwsnLpHwPiyoERazyN2Eo3gf4m7wsKOveSPyGks+pWRXT5/aL3zj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342756; c=relaxed/simple;
	bh=KG07OMTJgswQ4LqEAyXDfqrnVIzFlABhf39+nv6Ew6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lS49I7NYd35Ve9PlOnltxcTQPkr6cJBanWkpxpME2L1ySg6l5aIq/IInRzYNU/TBL6Jrv9kDKucnIZnVERrZYxqu/ZZwjV55qIB1Y1/RWhGo4G5jDV5kz6uemie8sDjxXCbl7q8fPpJaWWjWJKD7106rlNwbheJgRZorUhxq0Vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N30n1JsA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T+k4qvWb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PIfWwb021417;
	Tue, 25 Jun 2024 19:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=FLMzwSR29XDWPEQnsWekUcq8E8clYAdUu5IUQ/x0/to=; b=
	N30n1JsAtjsfzqvZv3QCX+Sew8ns1puamUD4Z2qNSKSqOfR2EwZFq5rkNdMjwCmX
	ioTLoNfW78VZXCUsS6P8gBO0ypWUB7jGgCvCMAFPmXXISHWW20alq6mnpzw2uuxn
	ZwjSgrZjZHoUXnxIcddhz31Wzmwv2CXZxSPcZquJKiebuyr+jawkuKbmeSLCoWYQ
	+gCJesQ/RxinCan8UVx6leFNrS5uAsrt+5j9r6d8ydoQ+3LQMoPNUmI1XgqgdThd
	qhJsOkqObPYWLiGdEeP0+HZibyaSsF/fNdCNvfQTaUt82C3OhUV5E96bVikQQhdL
	QRBX54/xOypTgQOR2pHOUw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywpg99avj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45PIUOx7001333;
	Tue, 25 Jun 2024 19:12:18 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn28rcbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNv0TkiuWW5STURQAvbbZkmMzeVXtnRGNWuPrkFFM4gUMG5S/iD0jVlG/Z/y6zq9fnNRtKLrUQ+gs7rE86EIbjtU4qdtqoyjQRpUrugMrnuZYUP3kK9oIKjmlQD9lDz1BRg9RMmaM1VmsKTiVtDQctDHvMBHzfw4+PnxEVgldeaY3Z5VYuQwySDF0tp5BgzEPofrzlvKl0ucUTqJbwQK0tAnsTOxs5DXHnN9bPCk8qC3fmyxrH8oS5ESzYSN/y8OOpJkDTHl8/EV1CFsMPr+c8nMgnhxPfEGQsJXIpcpsrnr0KAs+8ru3gsOAthc1hwdQY5DPbfBJznk3WwwVSMIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLMzwSR29XDWPEQnsWekUcq8E8clYAdUu5IUQ/x0/to=;
 b=OnJtgjRAIU9acT7TdH0ppe6qJ9BMtb3B7hvl195QBntlCVjHhPHg5pbK1nvqycbAR41CBhggcbwXOJASaVSePay9PYQMGyJeHyY/pnrtmNA779C8BqawOP5JL+mO9Ti2zbyTivPsn72Oy98bdlocNgXmQnchQunLyg6X8DaPQEksIP9n6S0W2qmQYXxDtrf23DHZq8tPq34vIygor6OEK9coY/l5QlwkeDOxrM6Kz8SVmlVjynpGFtwSBla4GAkQdYhEIegP3owsNXH5hl90iedp6nzslgV6axKbxUZ8H6fxD6/PIZ4nyetLZF3cjjRS9z9ZYXEF1l15le5WA+CabA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLMzwSR29XDWPEQnsWekUcq8E8clYAdUu5IUQ/x0/to=;
 b=T+k4qvWb2e7HJ44dM3wsK7Fqiq114fVGV02rKFcxFvF7r4+Vnr7YYixjVMDzEbBleU6uPKV3d4v7K2Dnf8d9S2LQ5EmyCdkgG0SxI7ULW3R/aKFOrZo780fe3QTB4agHShFdCEovMMFSH7H5VlUJzj9Z7D94UZbQRYEnnzTDuQM=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS0PR10MB7066.namprd10.prod.outlook.com (2603:10b6:8:140::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 25 Jun
 2024 19:12:16 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 19:12:16 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v2 12/15] mm/mmap: Avoid zeroing vma tree in mmap_region()
Date: Tue, 25 Jun 2024 15:11:42 -0400
Message-ID: <20240625191145.3382793-13-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
References: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0199.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::23) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS0PR10MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ca0bdf-217c-4db7-4f78-08dc954aba3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?mztLcOeLkbYIIZf65nkyiSuPyUhXJmiOhpQrYKOTfcDdhUPo1VTDEadg7lI2?=
 =?us-ascii?Q?uJAJQ47xMUr9Lrsycj0c/yPxNxuc0PIMz71H+cd/hTP9SDtCWQywY+vftGNk?=
 =?us-ascii?Q?9xc5XhYIaoXWgG9R6zPBUVQoDhtsYrufww57MqfOS0OVnl7LzN7WQr0ddpa7?=
 =?us-ascii?Q?dJWHzbld5PyBsMXkPRSV5Xa5KeVstdby14xhgmaTSU0sksvVnDps2Z5JAS7+?=
 =?us-ascii?Q?ySD88J8y5cALYbNzHSNt2KwF+f72SY5Nw0gAJlHAoNOKR/MG26Gl9Un5fUBD?=
 =?us-ascii?Q?5ZR5sd4Ba2CDk9YZei5PVuzWl4seLcB3yhlg7y+01vn+EIUrQKqo/7QjP2B2?=
 =?us-ascii?Q?LBAp0oncMXYgN2/nMEVp+Q+2MAM60nnj3kgjjih3BP6nEYP6BiogXyetfUS4?=
 =?us-ascii?Q?gglTSxNNc99l47CSISjWNRP4CzWq6WaR2B+iy0gcA0s2r5Jc7AE7d7MdF3uQ?=
 =?us-ascii?Q?n3NYhLBaRsaoLXcfEABpp+meyoaWpoQ1X8nP71NoCAbe49kfCOxY1nVPeA/w?=
 =?us-ascii?Q?SZeg26asvZUyevp/RujKcJJ3kXQKqAO1mKQd0xi+mxDaXVEoDKzVhRnmM2Rg?=
 =?us-ascii?Q?CVAuDk/3Rz61bNW5GwjDLbgw2YdaS8b2YDcH8BvCAlqjUnmhxFACdna5hUmt?=
 =?us-ascii?Q?nB8xu60NgdoquES0okLCrrVRKlFQ7NZGU2UnCL9WSf9CJ3gyNs+sugUliivG?=
 =?us-ascii?Q?/nOlyahDVwInGpYEbtwfag16m1113WT/fLukVRMkgEYlz4HLBR8L287nuiu+?=
 =?us-ascii?Q?9zPtFRP4SG7THp3nAN+2jJCcGwvtIKwktj7uH25FTo0EJD4Y3SIpS8JmCm4I?=
 =?us-ascii?Q?FbXPoa9QHcs1o0pJbII0DsQu2DUvJ00xTrnGNh5xw21060jwYlX0j5euYDyd?=
 =?us-ascii?Q?HeO/dV/07lq6TVU8KSqcuTImVfEqXykloGLQgZJwqPe16/PNhU4RBTP0zBPz?=
 =?us-ascii?Q?JdtZZcfV0MGG9+yvjE8gy5uMMnHn6ZA5bltk3+Bs+I1nVjluzu9F7C09z59e?=
 =?us-ascii?Q?6AcVF/K9N1cd4F2mJcw4ERjE7mIpbQ1eXYtNx6i9AmwWgNUpT+KCnLkAE1B7?=
 =?us-ascii?Q?xFX4Bxv5hXmakTrx51YodPcsl5WU8Sr/0ic+ZwZPuskPmn9rh38oEJuHtAtO?=
 =?us-ascii?Q?78ddoj8dCNPdu0BVwzfwU6zGCznE2XZjp48ddKgAxxTFSOwpVqUf0lPefHqo?=
 =?us-ascii?Q?zUVjbYjvkBhgNHNWHomn5pLeruQWHS3ne2iWbjyr7Uyy1OeSfK09T7B8OsYz?=
 =?us-ascii?Q?crmLY22vgCgq5c2GGByJ08qe84krtNooWUUwtfgZnyTLpuSjteHPANWBzDmY?=
 =?us-ascii?Q?JcSMVweBTywR6URpwTwWGw2FohYE+i2rr4b/aysE+JEojA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pHntuzeGr0OwO1l4QqReDOBX0GEFNTYvjEr4JmSeiqRZaGPvmAGUV2G7m3Ra?=
 =?us-ascii?Q?/zXCDQaXMbKZ+OvUTSxsY+xBOXDr7v+zMmN2RX2uBLh+v4XtvW8e2R2YXiKk?=
 =?us-ascii?Q?Bs8ZmgLhDlk9L6nlaggSxzk40z5ytl2hbpzrdkmQszvI8XE8TVLMLuJ+vsCB?=
 =?us-ascii?Q?9mC8QBEhiWQqiI1NnKtVjH1ivvxiKFCidUIoh9QUNx/296LAdTs4XaIRb2i8?=
 =?us-ascii?Q?6txtSYuADo4PfVyDqxdpqiVHdHnRWCGyJL0QwO2eJXFGv1FqYziGqLr5wppD?=
 =?us-ascii?Q?FpSVNA0iT1N68F/FcUyXovlIVct3OR8eoRZB45weGUUuCC86ze9wJpacHjtS?=
 =?us-ascii?Q?DmmJRBcB+z6cHf3oiY9xQUaeUnqGFHXXMzyJlqb8psViVjdYhwOYI7Q0lZeO?=
 =?us-ascii?Q?yZgj2a2wbk6lUoTrUugvkPWt7eMp+Fdm58HQjvHHpmChEcKm1L+v9DAq3ijR?=
 =?us-ascii?Q?lFuh8yoA8i2D1zHBue1MgcqvrFFifgmwA/pAENTXgEHA5zx0t68ntmKQv9ug?=
 =?us-ascii?Q?x0WQbPH7lAnspJgh+TSt5vYQ/2bu3qWPMnhso5vSegfZU+HXwIgA5VoCcPnx?=
 =?us-ascii?Q?C41rN8NNVpStRZiq8tmR6UlNtpQeflaql+b35KPIi9NtbhxKH5H+8qgNqDjq?=
 =?us-ascii?Q?/8blJI36brOrDwgj1FT7wu6IPplwPhp0/DOnrMDZKRQHrOuqTSu3T04wdQbp?=
 =?us-ascii?Q?FSytoJMBpuBzEB4ZlhrvM5YiWRl3x+d42MBFPLs42EmI1kMsbgZTVwx5QphA?=
 =?us-ascii?Q?mATGr23kO7dO96DePGGRtmXJMo/JJx9U7Ipv5KhMtrz7yKQUmFaKriZVdpZB?=
 =?us-ascii?Q?AoKOj3RSfbb23AHS9/p5Bq/fSrCy9J8vwr0myB0/Frnh9KkEsuIGgKT7IbKh?=
 =?us-ascii?Q?dX+gPhFuapKQvdzJPyerOzwEOAEzpY74tOu3/63kemmgGfciNaNYvO4YJYnD?=
 =?us-ascii?Q?XAp2lLJIPHl7046+f+mlXrAGJ0uF4A6IR58LHpT2g+9DVgFL2vjf/dx9E0tZ?=
 =?us-ascii?Q?tW+ELSgnEs3HuqTEoQ9HSGakd2jIGgZPqpgDFMWTdauwGyhx1ar8XOnsnDM0?=
 =?us-ascii?Q?GV7k0SlEChX6EL42pwNqM35RY1QZAQkX0fg+4i9vur2kAZ5IvUDKYsUfs0+c?=
 =?us-ascii?Q?GGNBJhmvmr1a32RTnc3cE9I1RZRlGi6iIubDH/MrNA/xjS+J4pP/L2RzAuk+?=
 =?us-ascii?Q?OiI6mhorrf6M3I8sLRJKDA8k211Mp/hRqTl7y0YXxYicIBx7dSjyq+YnbEw4?=
 =?us-ascii?Q?08p0MnObyA4rmtQkVNqtCtIaUSta7b/OuERz2XqcNkeFF2hZOAB5fxu7pYXq?=
 =?us-ascii?Q?UzwNBQk+Vplpwj/clfeC5PbEqxgD155Pq/PVXE+LiZ2JaM5BLM/Uf65fNs/7?=
 =?us-ascii?Q?2ni4MCrT/sDHs96SSoq0lSnQZvoKUA9dA4eKKkf7tdIRp4RbCcm33SyJsXPV?=
 =?us-ascii?Q?gvDg7P7cI5HDkmwqmq1ZSOxKIL91MUHhbsl62mkY1vCKRNv3t/sonU6/HRtZ?=
 =?us-ascii?Q?Db+bZBuPDeD0A+2I03I2Lxz6frDKqSXy6W5zl3YYWMXFHIr0ayvKRvXU8E6h?=
 =?us-ascii?Q?HutySO6fKKXD3sduvi9jCASh07mN2lkPLEmmiOypby2KwZ7oHr7jzQMn8VrC?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qReHgEFtEWPdZEjALGOHJsTraNNYfpo/ddaVamY8WaGhPKh+zEmmlnXblr3NzVyhhHvubCVy+SZtOwyrBnSH06rXEdCU/iAYQQKJQDh1lRGR0tIeRcBtKgX/s1nv75mNCSt61V2zp153haSSwTNHT04U6hD2O7WfhyusQYS4vAHACFr82YSGZcepmZAhv4bm0fLSnXCX144+ABPVg/Z+vTBqEByL7Lk+fn9n0ixPB9OVszGR7d8RFQD5sigWNQoCRcdvR7oKCAZJ9YyBI1/9gakk29TVS73BiEyCYavj2lqt6xXtvRihYwo3pp1SrGRHJDB8qDHVQubiPONxWtIOCEdpcT48zf1kYxDaniDvVz1bbsbcK7CiOqedL3XuGlqXWFfBwIAOHlKbIdYFEx/C4wbkOIeAYrwjHOpm/h6RV3uCjFLy/X1Unj8wc17AY21/ozQRbdb3AAuMvLnvF88xH2zBV0ZPR78wpO31PS4DARX2wMhSao/cXXjzO4fs9Bry+UDMta+//vW16ZJTnRHwtoDfDV5fKAvF3zVHu3tiY+3ej6fmR/wohYEjbCE6yXoRaVD2guEyLLTytTKND29ZniiZ8IVgaCnDAVjNxE/taPQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ca0bdf-217c-4db7-4f78-08dc954aba3a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 19:12:16.5089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vH32XTh5Z7R5mZ4lso04p5CVsM6DB3S5YIF8AtOa1QFaXrO2D2NfrT37KrvyOYY0H4yjAX80alNw/XKufD760Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7066
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_14,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406250141
X-Proofpoint-ORIG-GUID: _GK6VpiDVsHhyEHGAtwo8rCkUpBH2HzW
X-Proofpoint-GUID: _GK6VpiDVsHhyEHGAtwo8rCkUpBH2HzW

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Instead of zeroing the vma tree and then overwriting the area, let the
area be overwritten and then clean up the gathered vmas using
vms_complete_munmap_vmas().

Temporarily keep track of the number of pages that will be removed and
reduce the charged amount.

This also drops the validate_mm() call in the vma_expand() function.
This is necessary as it would fail since the mm map_count would be
incorrect during a vma expansion, prior to the cleanup from
vms_complete_munmap_vmas().

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/internal.h |  1 +
 mm/mmap.c     | 65 +++++++++++++++++++++++++++++++--------------------
 2 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index b0300cb22353..2ad6310059eb 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1502,6 +1502,7 @@ struct vma_munmap_struct {
 	unsigned long stack_vm;
 	unsigned long data_vm;
 	bool unlock;			/* Unlock after the munmap */
+	bool cleared_ptes;		/* If the PTE are cleared already */
 };
 
 void __meminit __init_single_page(struct page *page, unsigned long pfn,
diff --git a/mm/mmap.c b/mm/mmap.c
index 5efcba084e12..b7f47964aaf0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -406,17 +406,21 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
 }
 
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
-		unsigned long addr, unsigned long end)
+		unsigned long addr, unsigned long end,
+		unsigned long *nr_accounted)
 {
 	VMA_ITERATOR(vmi, mm, addr);
 	struct vm_area_struct *vma;
 	unsigned long nr_pages = 0;
 
+	*nr_accounted = 0;
 	for_each_vma_range(vmi, vma, end) {
 		unsigned long vm_start = max(addr, vma->vm_start);
 		unsigned long vm_end = min(end, vma->vm_end);
 
 		nr_pages += PHYS_PFN(vm_end - vm_start);
+		if (vma->vm_flags & VM_ACCOUNT)
+			*nr_accounted += PHYS_PFN(vm_end - vm_start);
 	}
 
 	return nr_pages;
@@ -527,6 +531,7 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
 	vms->unmap_start = FIRST_USER_ADDRESS;
 	vms->unmap_end = USER_PGTABLES_CEILING;
+	vms->cleared_ptes = false;
 }
 
 /*
@@ -735,7 +740,6 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_store(vmi, vma);
 
 	vma_complete(&vp, vmi, vma->vm_mm);
-	validate_mm(vma->vm_mm);
 	return 0;
 
 nomem:
@@ -2631,6 +2635,8 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	if (vms->unlock)
 		mmap_write_downgrade(mm);
 
+	if (vms->cleared_ptes)
+		goto cleared_ptes;
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
@@ -2639,6 +2645,7 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
 		     vms->unmap_start, vms->unmap_end, vms->vma_count,
 		     !vms->unlock);
+cleared_ptes:
 	/* Update high watermark before we lower total_vm */
 	update_hiwater_vm(mm);
 	/* Stat accounting */
@@ -2927,24 +2934,19 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	unsigned long merge_start = addr, merge_end = end;
 	bool writable_file_mapping = false;
 	pgoff_t vm_pgoff;
-	int error;
+	int error = -ENOMEM;
 	VMA_ITERATOR(vmi, mm, addr);
+	unsigned long nr_pages, nr_accounted;
 
-	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
-		unsigned long nr_pages;
-
-		/*
-		 * MAP_FIXED may remove pages of mappings that intersects with
-		 * requested mapping. Account for the pages it would unmap.
-		 */
-		nr_pages = count_vma_pages_range(mm, addr, end);
-
-		if (!may_expand_vm(mm, vm_flags,
-					(len >> PAGE_SHIFT) - nr_pages))
-			return -ENOMEM;
-	}
+	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
 
+	/* Check against address space limit. */
+	/*
+	 * MAP_FIXED may remove pages of mappings that intersects with requested
+	 * mapping. Account for the pages it would unmap.
+	 */
+	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
+		return -ENOMEM;
 
 	if (unlikely(!can_modify_mm(mm, addr, end)))
 		return -EPERM;
@@ -2962,14 +2964,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if (vms_gather_munmap_vmas(&vms, &mas_detach))
 			return -ENOMEM;
 
-		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
-			return -ENOMEM;
-
-		vms_complete_munmap_vmas(&vms, &mas_detach);
 		next = vms.next;
 		prev = vms.prev;
 		vma = NULL;
 	} else {
+		/* Minimal setup of vms */
+		vms.nr_pages = 0;
 		next = vma_next(&vmi);
 		prev = vma_prev(&vmi);
 		if (prev)
@@ -2981,8 +2981,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 */
 	if (accountable_mapping(file, vm_flags)) {
 		charged = len >> PAGE_SHIFT;
+		charged -= nr_accounted;
 		if (security_vm_enough_memory_mm(mm, charged))
-			return -ENOMEM;
+			goto abort_munmap;
+		vms.nr_accounted = 0;
 		vm_flags |= VM_ACCOUNT;
 	}
 
@@ -3031,10 +3033,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * not unmapped, but the maps are removed from the list.
 	 */
 	vma = vm_area_alloc(mm);
-	if (!vma) {
-		error = -ENOMEM;
+	if (!vma)
 		goto unacct_error;
-	}
 
 	vma_iter_config(&vmi, addr, end);
 	vma_set_range(vma, addr, end, pgoff);
@@ -3043,6 +3043,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	if (file) {
 		vma->vm_file = get_file(file);
+		/* This may map PTE, so ensure there are not existing PTE */
+		if (vms.nr_pages) {
+			mas_set(&mas_detach, 1);
+			unmap_region(mm, &mas_detach, vms.vma, prev, next,
+				     vms.unmap_start, vms.unmap_end,
+				     vms.vma_count, /*mm_wr_locked = */ true);
+			vms.cleared_ptes = true;
+		}
 		error = call_mmap(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
@@ -3133,6 +3141,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 expanded:
 	perf_event_mmap(vma);
 
+	if (vms.nr_pages)
+		vms_complete_munmap_vmas(&vms, &mas_detach);
+
 	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
 	if (vm_flags & VM_LOCKED) {
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
@@ -3181,6 +3192,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
+
+abort_munmap:
+	if (vms.nr_pages)
+		abort_munmap_vmas(&mas_detach);
 	validate_mm(mm);
 	return error;
 }
-- 
2.43.0


