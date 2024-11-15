Return-Path: <linux-kernel+bounces-410220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 112C79CD68C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 06:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71D99B221D5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 05:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488C116F8EF;
	Fri, 15 Nov 2024 05:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z2nRw/pg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kbb8VWvD"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A21A28EF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 05:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731648073; cv=fail; b=uQhNfFbg0Ld6RLyyiy8gUBwzfgogYF1nyYP3Gbo+6e6veJR+YTppEtaCSoYtAAmjQNWbwJiAzYBLxbCp5D5xOyEq2e44sjKJ6qNy0aliH/tOODeYryNd3mstWZjExO1m/5Df8tL+5aiI8+1hdampBy/vRBnKSkiOvrXmVKUkHz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731648073; c=relaxed/simple;
	bh=cGiwwXD3fCKf7dKqZ3Ms0hKfHjYSoL7jqHlGE6OHY60=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=jcis/C2bhhV075wzY2SpAJC8UilmV1wF9tBUj0pwJkcVlbanxP0ROVQoSbcgJ/7XTB0BwqVUZvaVn0TzMhAkHoJ0BmNYfT9lWf5t09Y8FTPvENtM7duSdVInIijgkhltKP8A+PF4Kdfzjd7vjU344SJ9s8LaNkhhpp+Y5u1TnUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z2nRw/pg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kbb8VWvD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF4BZ7m025296;
	Fri, 15 Nov 2024 05:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ycKithM18l7osJUFQJ
	HxZyxtZLDnAdas+znKG1wYZNw=; b=Z2nRw/pgm3mz2agBap/RamLo5Pg5cG+rq8
	BIYnj5a96kQFhJJpeboTKMyNK9viM7SSmMyCUSatbde9/EP8f+s8HOkHyTsYXvBm
	I16ObXQjwYupZwXoKU4jvyKDhnN35YkHPJnOyxtb+a/BYeoZmb4yeBiea3eAuwG+
	eBECFs/k8J6jkSQUB+lsiNB71R5KZPUeUw8xt3QG6FtcNxsoHBl5CLwiXKBccYLa
	RvZODXIntWzleKpH2OtaOZcTeuo6ivtlC24aTf9+8uhcIbvP5g7N0kvjv/kTsZIl
	OUQK+rXgnYdBmhwH3kXFXme10bD13JuDXLXJIeYKfpOARffPH0tg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k2apsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 05:20:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF3sToC006016;
	Fri, 15 Nov 2024 05:20:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6c6qdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 05:20:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+9BghYUTCqOk2XTh6P8JC9w7jZ/LO3Bdf9zimGVHzqYxzD+7W3PojJICAW43f71tUDHBHSq0SANXX4fpFF8LKlhH8BkPulZtsFywRlfsmhriPH5J/SIODZ0BJ+BM9JA1oWtmx1+1zKuWLSffmki0THV7ZxKW/oh+R6psKXPvabu3BjiWXPfVwVsoBLCT6SzRefx1AUOBIwcR66HfvKP98pH0BRtv0GwMlrGTHvulQhnfLV07oGIjIH25p/MW8mGFHuPdbyFSNMVxWD2ogym8NgeT9rzILfVwTDOKuUa20uqje19AnGtvZ/SSUAkyVyj0GbY+WbDXVjwI3y6RT59aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycKithM18l7osJUFQJHxZyxtZLDnAdas+znKG1wYZNw=;
 b=V8hVmHhGf/jzTKdQsU55EymJpyV2HBE76vzc2NfixFdFpNoPxe8a9ioehL/iHKKki2yqm+Lc6PkEf5dBhMtJrEEXak475tHpBFLq8ABuT11s+2qxT21S2URl3SGHreqQu/y0POSGfNBYNlPcA7eWfA9lg3d24AnIzynWmx9ffJNOZC/pybCDSd77DuDo/RIePlSFZT/XDq00PJPjz8p5lKqvjQhLBG4zFFCHSKgJhFwcJMN5yz9kX+3bOzqTGFcymtg6I1B02dSgJhAkyGsKv3zYJLAE1CjDj8wRh7YiAVfkSXgo1n+iMBjQ293+HXn4ARAL/PMALILAj24kWcCKXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycKithM18l7osJUFQJHxZyxtZLDnAdas+znKG1wYZNw=;
 b=kbb8VWvD8pSCN3tmRTUnWTZqGypW80lmjZwvkTigeP3Fqwa1RTSiKRAplWLx6WF6NUivhAl9YtjFXo7MriaAkXNcpY2yp0ZT1aGjzcoG+6vSs25dRV/0QHODEfgDHLGmKhbEKhiLW84Ii1i41PhsqO4DrQe5n14ILl+F7vsM1u0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB4408.namprd10.prod.outlook.com (2603:10b6:510:39::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 05:20:47 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 05:20:47 +0000
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241114100127.9xLSy4yq@linutronix.de>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
        efault@gmx.de, sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v2 0/6] RCU changes for PREEMPT_LAZY
In-reply-to: <20241114100127.9xLSy4yq@linutronix.de>
Date: Thu, 14 Nov 2024 21:20:42 -0800
Message-ID: <871pzdnkd1.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::15) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB4408:EE_
X-MS-Office365-Filtering-Correlation-Id: 8677b186-a65b-4e79-0018-08dd05354338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M1FPbjvuwERZY+csjfnUU7aAtsce8pMtJQrvJPqppLOPOMTAj2rz2Wy7L15f?=
 =?us-ascii?Q?qlDbI3Vj0yd86dMJ6Y7mrDAU1HHDjnxUgk7HAZE+Rq+Xk0y5r2wUwNxQ7Sm3?=
 =?us-ascii?Q?s7Xk2ju9WcH1zFyN6pVdFmZygac++6DsaKaW3+/X+DwcmPM854wCghv3Pm55?=
 =?us-ascii?Q?PdKGppoABhMn8UO9I3iyNqETmGzAE+0bhYIfq9gNF4zbgPfhE8AtcZzQA7UA?=
 =?us-ascii?Q?uWvDTLsd0ns7L4dMme+++rPnWviG1JP6VKkr9o8T60G4c/bkz2gqRHL9Jbhk?=
 =?us-ascii?Q?xK3V18C2EKlVYSPnkj7VOFnG15FocdY6LxhNiSIWoyVDNSw+kfLofikUj9ee?=
 =?us-ascii?Q?hi5n2a+nVR+BIasbeihHe9ao7/npHxFH0wcHyd6zH/iXPg+yjZ+Oqo+zXKag?=
 =?us-ascii?Q?AChsvYLE9oO1eASF88L/SgyZokHWizlJ2OlytjmrFdkaP9eXylc424q6X7GU?=
 =?us-ascii?Q?+hK/0R6aSwmzLrP7GQDFIR6J6uM5lNr/Lt/AAD+A/YhD4DjjvPMzWlsdGD4T?=
 =?us-ascii?Q?I0bMZ5r3BPR5Ze5L36Lzvyu2Uq8PLZsNZBbuw9rzlzi6z02n643POCeJcPt/?=
 =?us-ascii?Q?zVS30SGM6mBe86b8Vh42gtTUlHFNZRfli2gMo6uw9MdSsPsmRjJvhbogxZ9T?=
 =?us-ascii?Q?TDGaw/jbtBovsrtEoG2clO6rH1gWO8W5A0nKXggCX31TnrylUWgsoO8Y5AM2?=
 =?us-ascii?Q?TruLnc2+YLFULFGE1MGAWKGZL7FaKPyRx+Bt1bUqX+E6oCWowTBBgfZ0680E?=
 =?us-ascii?Q?F5QF/5+0nEy+1iq8YyIRkA1SWmw6xf/OAsD4Sg1eznQyxoYYvUqzAplCp8wR?=
 =?us-ascii?Q?fo2g3jj3RHfm++vEyP5ntuJ42/1oqzc+cPGWNXg3t3Z7N79wBunA4q/7P6Dt?=
 =?us-ascii?Q?1Uqi9dBMWnZNtxCNcjgvnfzo4KD7flkfDkZHgDJai061ZARCy9nWAfhnuq1U?=
 =?us-ascii?Q?vPdmmm0pgX3gt1KMb6FvcYZoLf30noydweDT7nQzVi7lfPPAwdXdsy7VW31B?=
 =?us-ascii?Q?BZ3x+t631hY/ugAN/LSR4MzqmZWtwqX2w6JfGr3dVeVzsM4OStLVa23eaNVn?=
 =?us-ascii?Q?G63i8YeMS4/ffjL34zXwMcA97RIgGI9VqFakztBwqd6IHiWlmpteUWf2rClM?=
 =?us-ascii?Q?O3FJI9oXHVr9aobyvJI0AaWOPLMdO7u+DjDEpKjsHU+O2QeCE42eK75Qe9AR?=
 =?us-ascii?Q?p/JL/YQuiFlvlqQa3UHN7cSmS3rWvCKKB8qv9evPIRHZEEhHw866wJ3TzOL5?=
 =?us-ascii?Q?qFHtJ12LDvnQGkQrBtoOe1icVWtvDFxZDOEJerZrzGca/0MSlR5DmvWoWvI/?=
 =?us-ascii?Q?v9pfglhvElFJAMRqwAj0eeY+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lv7TdiUxBPTqdsohKv/WoJwNtyS1Xl9K0EfWxlbmKXTJuhglKlYD8mAlKqh4?=
 =?us-ascii?Q?CQfbYJBo8qwbt6EncqWlRWjONZlPq/xwbZKAZe8L1WPes/y8X4hRz9RUnzG+?=
 =?us-ascii?Q?MSWG0ncbJWAO0jQZJmMOMpcvUImCN6sVvf6NFAmJYwe4KVw7nIOozGcm+Yxw?=
 =?us-ascii?Q?NebqRKuy/NcNavAY4SZn1eJY+PJ7j8+/EJ8eJZPl2v6Ry08K8FUmayGi5xk2?=
 =?us-ascii?Q?iwSRwqKqOvhtP9J7CiSHCa6co11h6LQLHYXYqJtv6vXCaTWTxVcLkqdQkbOC?=
 =?us-ascii?Q?VVbG9kD7AMb2JXIIl6okNAs9t7knkiPgVLHIDgnCAf4lGhRUhk0tFLkKMGqG?=
 =?us-ascii?Q?KVxWiSraRyi/9zM7mP4VssvC1CjWIoeNKAfkhq5vgc8pXqCz7k7WlPC9jRYv?=
 =?us-ascii?Q?QeqO3PQOqwJJGvfWhxs9lNJLpcb4fXKVaxEWz6KS6VfrH3V+VB9ssn84I9e2?=
 =?us-ascii?Q?hy1TetZOHM6XuQDlsOg4OIVLJl9eXyiyQXCOdCCFXtjhlvIhX+AcuEnMjw1o?=
 =?us-ascii?Q?zVxk4w2Wo7b+iV6RzfPfGjUnU0ee+rQ8M7kyxE2C3IR2uRMh2Z3ClN5UpSlf?=
 =?us-ascii?Q?FWO5kO//CicDCtjdu+C5B1bsVCjZrq5g4tlSlLtesvThL67VwW7vHRqnku2c?=
 =?us-ascii?Q?oH1rG5hhmaf0YrHYfZSU4cW6F/TxyLXkQr/+z/NAdDKr0SLnw++b39bIRggn?=
 =?us-ascii?Q?EA465QV94dNqJz/0S+wo25CrLzXd86RLDcOkBO6r3+C6x3Ij0Ab+CyusD5g6?=
 =?us-ascii?Q?LsQ/r1NFS/aMIQzAsAxDCRpLFEKNVAD5K09T2t+QkEgG3v4SDpNuNwY3Cyvp?=
 =?us-ascii?Q?P7PIw16C0Nq6/WsZeyyMX0U8iyvxz4ycy3pkVgsqIHt9koAZgQmFWH0QJNW9?=
 =?us-ascii?Q?+FAmgobBZg5FYBdWDbzZ4fc79sXISJHQPSsl7LLuw+X8GzgWu1Xjw5NA1YiV?=
 =?us-ascii?Q?bQSASFGf3/aLRXkgx6YYr5xF7F4sFHE/uC8jA8tMXxlC0PhNrqOQgsmkWi4T?=
 =?us-ascii?Q?b1ZOhXCzfpLqxVWb5Xkzd/nNDtybILXyhHZz6sQZ4Y/UCbRiCyNABYWU04k2?=
 =?us-ascii?Q?zKdR75KqIdZD6EgkTfV3FcM+ezDxNV70tPo3dY1hkVX8K+3ehs94YlnZ6Y1d?=
 =?us-ascii?Q?r3bk9MvjdNHldZQkpbPRJWv9ozmhXqYz7WaGAN9z+eJBLPZVq8X4EsKUgKam?=
 =?us-ascii?Q?h3kwv2HkSZCZjyfPiIfnQGqWYUIsPJHklSl0S6C9/NN6z82KW786++LKZxgr?=
 =?us-ascii?Q?7GjkPvHVG0ARN+2c6PVMDFNJ5YOIJry6FCqlylk3CGWgOK4TdKK23Ky0Yoi7?=
 =?us-ascii?Q?nxepLWpC6CNZLuINoUY5yv4CfQY5uvQH8wglz2CUhAE7i2Fcb7dCPrlv59N0?=
 =?us-ascii?Q?gVg8j6HdWnbHqWBjFLmuJXLWI0XR2PRzFLJcxChHR/XreXHJknRtBhNLtbdp?=
 =?us-ascii?Q?nLm9X/mkrouYPCzjjRLV8/VMW/peRjFfAmeE6BKks2VSdEVVDPq7wkOBxy6w?=
 =?us-ascii?Q?6yYUmDDxW8BPP0sn6trM0YqywjndnJTAEdieMc8GdtyLHhkYJM0dkYmkPtVa?=
 =?us-ascii?Q?stYmpjtW/e8sYVr9qiXp20YfAmLvDfUUNwAr57Lb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qtIZpidbINj7I8cLv8y/hZS4Trbya/u00u/iOa2TIBmMV79Q311zL4REBMbUSJmCU/yx4xAk9JTgWTiH7K8+CP3u+mvxSVm1oNeQw/En75h+UyEC09BrJJOLabnf0ehFgLWGMbnemXMAJ76JMoLgWyaFpke9KIhGJJQk8U/LzukkWu/HjWdQH1eLVJT6af3whLizfa4ZC0IFDEP7MOt8VhZ8Xjorphgx0GaWRO0HCFIeum2372sE4YaMoD58Z9PUgGZoBlExdQHHBt8R11rZPhXRurvHa+iEiZNNOCO5BzEUXOtVSy9eHewO2ErGmSkCNW0deHpPaFS9O+FNkJOzAPYxPZNLZSx40dJHlFeMfkjgUMB82GO4BBJ6YUESal3o7s5WTycDZweNNG/KRKR6Q3YF91HvtPbcfL25sde2uo+H+T6D5UHujR/5xlEXfSY8sw05VBFD1YSGbDSSobBLCbbO+EKlgzebNvMqKHprDkoii7feag+R5j4HgfB/2AZ0B4bMwRgR6wrWvvcrWPL9WnL0013SmhsPG8NX/M0Sikacjbc5jyXtT7tBPq6Wyhlrjag480cx9HO8/+qygcZg/wLa06nPqt/MpoapBaizsjo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8677b186-a65b-4e79-0018-08dd05354338
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 05:20:47.8726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0Czwjf5hX79TrOwlYM37qHz+2GWZgaiKnHfIUWTrIjR2hSZAsnRtten10vGFSrSfCyw2ralOPns8tNE0xMaL8zdyXuSvCdtLkQ240nNhc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4408
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=712 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411150043
X-Proofpoint-ORIG-GUID: FqiILNzYpLTEY0iY-xPh4NzTPEV5Wu7T
X-Proofpoint-GUID: FqiILNzYpLTEY0iY-xPh4NzTPEV5Wu7T


Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2024-11-06 12:17:52 [-0800], Ankur Arora wrote:
>> This series adds RCU and some leftover scheduler bits for lazy
>> preemption.
>
> This is not critical for the current implementation. The way I
> understand is that you make a change in 3/6 and then all other patches
> in this series are required to deal with this.
>
> For bisect reasons it would make sense to have 3/6 last in the series
> and to the "fixes" first before the code is enabled. I mean if you apply
> 3/6 first then you get build failures without 1/6. But with 3/6 before
> 5/6 you should get runtime errors, right?

That's a good point. Will reorder.

>> The main problem addressed in the RCU related patches is that before
>> PREEMPT_LAZY, PREEMPTION=y implied PREEMPT_RCU=y. With PREEMPT_LAZY,
>> that's no longer true.
>
> No, you want to make PREEMPTION=y + PREEMPT_RCU=n + PREEMPT_LAZY=y
> possible. This is different. Your wording makes it sound like there _is_
> an actual problem.

That's too literal a reading. It's just the problem ("matter or
situation that is unwelcome" to quote from a dictionary) addressed in
the patches.

>> That's because PREEMPT_RCU makes some trade-offs to optimize for
>> latency as opposed to throughput, and configurations with limited
>> preemption might prefer the stronger forward-progress guarantees of
>> PREEMPT_RCU=n.
>>
>> Accordingly, with standalone PREEMPT_LAZY (much like PREEMPT_NONE,
>> PREEMPT_VOLUNTARY) we want to use PREEMPT_RCU=n. And, when used in
>> conjunction with PREEMPT_DYNAMIC, we continue to use PREEMPT_RCU=y.
>>
>> Patches 1 and 2 are cleanup patches:
>>   "rcu: fix header guard for rcu_all_qs()"
>>   "rcu: rename PREEMPT_AUTO to PREEMPT_LAZY"
>>
>> Patch 3, "rcu: limit PREEMPT_RCU configurations", explicitly limits
>> PREEMPT_RCU=y to the PREEMPT_DYNAMIC or the latency oriented models.
>>
>> Patches 4 and 5,
>>   "rcu: handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y"
>>   "osnoise: handle quiescent states for PREEMPT_RCU=n, PREEMPTION=y"
>>
>> handle quiescent states for the (PREEMPT_LAZY=y, PREEMPT_RCU=n)
>> configuration.
>
> I was briefly thinking about
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5646,8 +5646,11 @@ void sched_tick(void)
>  	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
>  	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
>
> -	if (dynamic_preempt_lazy() && tif_test_bit(TIF_NEED_RESCHED_LAZY))
> +	if (dynamic_preempt_lazy() && tif_test_bit(TIF_NEED_RESCHED_LAZY)) {
>  		resched_curr(rq);
> +		if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
> +			rcu_all_qs();
> +	}
>
>  	donor->sched_class->task_tick(rq, donor, 0);
>  	if (sched_feat(LATENCY_WARN))
>
> which should make #4+ #5 obsolete. But I think it is nicer to have the
> change in #4 since it extends the check to cover all cases. And then
> we would do it twice just for osnoise.

Yeah, exactly. The check here only deals with this specific case
while the one in rcu_flavor_sched_clock_irq() can handle that more
generally.


Thanks.

--
ankur

