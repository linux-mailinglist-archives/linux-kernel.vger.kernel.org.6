Return-Path: <linux-kernel+bounces-242837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CC6928DC3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 21:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C36CCB23C5D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 19:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB3D16EBE5;
	Fri,  5 Jul 2024 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vjgaxg56";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RtEQg202"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB48F16EB6B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720207664; cv=fail; b=BPlHi835eJ1yqc20AOH2eyw4/Jcit6abwxPs1Wusl+M1rZym+ZzZLLfV0F7wILNAbO2E6+KvrBy4+fCyV/Tu2bMPbZfA6F00K6zDSKNtPi6LHzS2xSqv8UGNxe19t8nMclwnKQtYp/3ZQvVxWtXCI8UI/R6e2Hb+K+j1NW5+ICY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720207664; c=relaxed/simple;
	bh=sZh0bp/5ezJArO5LDWfh8qdEF0YWrMC+ZTYG5QgbG9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FiUMJb4uC0hi5BW6F/QlAhnOy8GBvC0POtH0RwOxAOxCjzWu4eSSPkZOcbfUCgC2/rOsyk8RAVrS9X9cyv2GMV+f93xCPf3/dVqZ5GOJAXrz5k/s1aONW92z1j8CgdxQR35hupbpT7DvnJITpryAmapvoS1RyH3xMekB5amDWrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vjgaxg56; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RtEQg202; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GMZmV013524;
	Fri, 5 Jul 2024 19:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=aLb2uAwhxumKM7t
	zRbvYs4DA/3t4/EZU+AkwKphvdCs=; b=Vjgaxg56M18fGLheb2LUVu+Kw7zPTea
	WXFtSK9QPJS33BP1Fh7WEgZCV+j54xDSQFcuTFKSP/IdwOu/+xN2ndzlzJuBZ2gv
	tFSi7fSkjFEm2kPtrpw4BqD1Kj70Ln3ZeACgfkG/xT6l91iKZliALVLPKu/ePbOZ
	3sab1ath903cc43DJ48SEfgKfsgGSOTuE6X1YUPymfUyj8l+vdG76VleYNmDkrJ4
	kMlUYXgf3l5pZLKWXs4yfQf55od0jMOTpGZOxFjGkB1h1JxdR8rAGiCJ2U1bcfXP
	jgJ7NBwihjKrZzYtUC5pdR6u/OWquWvsQzAd7ab4iO+mEiG7sQl7kMA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40296b4ga6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 19:27:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465H0DnJ024630;
	Fri, 5 Jul 2024 19:27:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qc5sk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 19:27:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHgqeF37EZdy5qIsHOH0q2Pw8wXQW+BQyWsrCuVQU8kJVWHbaG9RCBnfBpXQfH7aBb74zwXKM5EIQWcCPDmzVmIa8qpEkBFVDN27Sjy2EaQfpoAO8dNOn1tAWDG/WqWhSoOrKjmbFOuyq05jJa+U9T/eEkO3s63t0UqB1ys4bECANKzlpkR4TQ+SfeReqr2f+bK367iW5w4Ac/B91TvbqCMZJMYPWU9RJTtFYOXE6gvNbf0pffNcmz33+zKbgXuD2+bNApJDKldxfYjhHNztHTc9nYZrJdO15c1BDeqRantLEzAGvFLLh/bZyzk/DP+ld8NUZHE2AsSv69+Jxeowng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLb2uAwhxumKM7tzRbvYs4DA/3t4/EZU+AkwKphvdCs=;
 b=RZ7iEm78vBCC9eqNMrNkAQmzM71GWFIzBorm8BeKCYal8SHjqVqt3yH4a5B1IQ/l9CSfcV7/FhrSICM6an7IiJ888Vi9mkzXU7DREai5UMpCvSlH5mX7hug2OrZZ2bMkCkDs+pdwimKUgBzGDzNc1g7ufxTQKedJggFnkGQWXcYVJfUBZv+c5f7iynD2zA4hyx87Ggl9YY0k9meW/TSiDfcrXpsFkf+WaJIfGlih4u8YjK9FAHdpFLH5FifW8PHCgs/wdsGBpaVr/hB5DtMudoaNZple55Xwn8M0HCngT9zjOy86GfJwIsDedUIkNfkDmFmWc1UKswOK3FwlkpAL8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLb2uAwhxumKM7tzRbvYs4DA/3t4/EZU+AkwKphvdCs=;
 b=RtEQg202I5H08WYODr3unTJ6EIuZfQfx3kgkXYkNTmkoSGyXVf4DnlVahDcHRvhQpMbbGVV+3nN7GYQMns2woB4GpYHLEgmmGRZHhZw5xRNEu7W4MN5MmllBFpHsvz3AaA9gFgNMgygmw4K/5vM4VxAYcZxVn4k2mII0cr29Oi0=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CO6PR10MB5789.namprd10.prod.outlook.com (2603:10b6:303:140::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 19:27:21 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 19:27:21 +0000
Date: Fri, 5 Jul 2024 20:27:17 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 06/16] mm/mmap: Change munmap to use
 vma_munmap_struct() for accounting and surrounding vmas
Message-ID: <f12e65e3-adfb-4140-9aaa-e7b11cab972d@lucifer.local>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-7-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704182718.2653918-7-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO4P123CA0530.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::13) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CO6PR10MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c413703-3309-46b5-ab34-08dc9d287dc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?m6Xki0BA27sLf1U+4CVWV0JIKAx4BntQrwtFenMaGdstkqlfDHUFbEgaAlAh?=
 =?us-ascii?Q?BNPmhdKSZWllnDbiL6jyBDFLgaCdYaCt9zqoB+7Crk761zxwkb4IPEH4Uydi?=
 =?us-ascii?Q?3LNR6D/I5QcoUWtui9vqZn6zYNC04rn4r5BAzQIHQ0Pj0oOT4+tUZ4XXCRph?=
 =?us-ascii?Q?skhjLjMDUPAV9nu4VTsxhFHZmGLtzNtMwVM+/JZTise8w/zDz/5O8S4pSN+3?=
 =?us-ascii?Q?3OAcOifBf5zeDw7917LcSYwZAOzXl3qXqm5j48CcuK/aB7ViAOQioj8IMdnt?=
 =?us-ascii?Q?Utn7oMuW/sRiNWlv/XOSI2dkEeOKYCvyrF967+1JQ7tJi8h3okh1skUH1Vtp?=
 =?us-ascii?Q?A77pFumW8mYnRG//4X8KJOhOdRYZjfWKpZ8MlhkgfmPpfHrFwwc4QyvoZNrZ?=
 =?us-ascii?Q?bvrQyRzQgYyglEZvsiN0JcKXpO42R+TnS91RaP/tJ2O1PcPWvvr8c6ICe4oI?=
 =?us-ascii?Q?MfXnopCVVCVkClI66wn9iSVh6R2NI9Gyp8U2NUJVCM4muMFtEw/W5iftUxk+?=
 =?us-ascii?Q?LAaDIBL/4A2s70fAglbzrauAzAbtXopETMoBo17HMWWxt7umPMiYhxvHGFZM?=
 =?us-ascii?Q?P/1sygaFABcjKBaSHF3YZ/Hmrsp7qZ32+P3zhgc/VUHwuiwc3em/ie/7SJMB?=
 =?us-ascii?Q?/TmZvTGxGCmvEncOe6yR+DbVwa2MvdMXPFtOJKqXLu/kIbhLNImB+4qEwV7r?=
 =?us-ascii?Q?W8nzIAnq5OXG0ux2MNVSr/Q5zqvjLiL18ywcEXH7NFFNlQTocYOrFoLCECI8?=
 =?us-ascii?Q?c0HQsQwRur1BbDo//kNhgSlabtfZ+0GVb4pwizCPCt3AchKnKVyYFq0MctZC?=
 =?us-ascii?Q?JjZZHmUrSJMDxxfKRQAi5qWyGS03vvxOxXk3+teOVwrKCLQ84364aTQfZmYy?=
 =?us-ascii?Q?b0C0kGyiDIatr21AGJyJ2gIoUBw4UyudpozQ+u01HFC8l5rNk1wmcO63X/gc?=
 =?us-ascii?Q?jS3NQ6MgTVZTTGUgLf6PzRHsYxEIPpanw7oLGw18HoLuIzMOgyDIN7eHH51J?=
 =?us-ascii?Q?7SOIvYhFFCMo6BdVnrt7X0daNtORkcFYP6oujKcbnNQpEzCrHNoEvxIEEKci?=
 =?us-ascii?Q?tUNkM/Nc1FgQBRf0RMbB8eCCwM5al4CwP7KYgY1HdaFTD4KXBPzE2iBOJV2Y?=
 =?us-ascii?Q?slcSaqo5lgoZinWnBKhS1uzc9DFPVWBE+l0o7Fj0RufYIW2eA+TwJTqmCvY+?=
 =?us-ascii?Q?c2mj8KhHbIY0g/rII7IzV8X+e2Judfm79lEYWYYoQ6XnvgDX+W9V0K9Rxb37?=
 =?us-ascii?Q?8/xyBABNtXz9ZxZvcD3DiV85tPc7yd5Wccrh7fbYVED63Ke109AV+I9YM49Z?=
 =?us-ascii?Q?dJY062kbgMbil13cn2HGZXUzydVGdnLTb4PnLcjyU8UV7A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mHJhcOv0XWPMLhwrFplE2Ii7EBtTWqw3xCWUiLTzmHNFrq3SFCJOArrueb0s?=
 =?us-ascii?Q?xi+dAUsIjClaQHKn+shZTHLtXGRTp9CXYQrsxNoa9aahD9V+2N8WScn/oRoh?=
 =?us-ascii?Q?/8isbSKOUJ8o44Psz1IMmeYkA/ifpiGPtdo3KqSzmqZAgz7ugPVh0D6nI7FF?=
 =?us-ascii?Q?2QC3Kk6CmD/Y7Kk+COx+F5Qts/psPQnnvUVPx4q3kpBu3+QhpzmgDRgzj7Py?=
 =?us-ascii?Q?iztbfa/2nj0Tq5RuF17NeqsP6qSdfQFgIKfqiSE9t0DkQ5rZcIgwWNHbewsM?=
 =?us-ascii?Q?gsjF04Ayjtt57rKTv3P0ewUix45I+w6tcfI6L9VHGUHShnv4u+IsRtbTE0TI?=
 =?us-ascii?Q?hV5GNUMOEdIbxhE60W0cnDtZQTL+pbLgI8PvMvVlcp7viyKea1ITMeVezjcQ?=
 =?us-ascii?Q?APoXdpVmJEZcXdl8tQEleIxCzk3w7IujC7D2h7u+l/hjzAWZJZzEh6dD5Oi2?=
 =?us-ascii?Q?3GZ/Yk37XW8+OvHvfNYC/JByIHzM/v2G6hngFHcq3CSg2b7R2/mdKpaeb1Tx?=
 =?us-ascii?Q?/8G1TYqunZpJx0jEPihpCmV1q2Lh50+lLW2Eqfo19THuJ5y+xxlisQmUpoC4?=
 =?us-ascii?Q?2+eetKx16gkDO7ssRmbPgOgysHldc6+UI81HihaLxWCGamHASnL4Njcd/ixR?=
 =?us-ascii?Q?x0S3I+uzNlDJLvtzoD4YWsg+QM1/Mflgirwga78z3Jdavw2c/rAngbC1IFtX?=
 =?us-ascii?Q?6j5fKc5VehNX04Xu+4tQRrhfojuvPQVLIGUwGZ2u0pOHhA4u8rcijCjawBjV?=
 =?us-ascii?Q?QIWq1pw0oPJT7xVxQ6vcsq77LdJl2wprCj9Fh3bI2gBkG7hz/POgt7hQiuOu?=
 =?us-ascii?Q?nyT+Og95YNsr3HjVpJLmjrmSCQd5R2r7WkaIDijqIfuknjqEoFM/G26ZF/DR?=
 =?us-ascii?Q?fYjkRDEybqXKo9thvm8PUUHDNRKiMKdNk4vHv4dEUdgc+UwPwoM0+25SYJgY?=
 =?us-ascii?Q?ZvaZtx35YJ+yXQZ61hnIU63lpukuqTYS6JPUZFofrLuQavdrXhxdGa46myYz?=
 =?us-ascii?Q?uM440IXs3qLgt9JWaHpokeH6oIhjUkEsEnxQpvsid/2FjvOc6nLF2bAUn0yt?=
 =?us-ascii?Q?eaDXXYnsbxFWjMF4DJVV7jrYOnQCTpsWLyISsozLvgIbhGKw40B4bT9q/aIH?=
 =?us-ascii?Q?QUCAnjNbkGgjr3LNlZxPopkUDla4/pJaEpZ9iWCoh72f7aWUn/h6bG/32Q/q?=
 =?us-ascii?Q?WQjZk+hr3FVZVIy9wnGLMENBDg+g+deg+8S7za/qCSM+fhXrviWmZC0ZrCEp?=
 =?us-ascii?Q?9pyMM6HdzlOL7GnQ29xllyk1u89xjXuy5xer6tDT2aTvLK8fyJ1DY6X5Shhn?=
 =?us-ascii?Q?FzUJPi/w2KN3KTeWiN9aQodvXw2jW4/jQPc8JJ+ovNWR1hNUDccHWxeVJMjn?=
 =?us-ascii?Q?VRpsK7jEL7LUotzBb4QvCxgSFf9W+dimkvMHmVS9wyG4Jl7EJ+V7MXUOF+Ct?=
 =?us-ascii?Q?9cSjQ2jVtXpPmPZSIMNbk/CazZNVKZzY5zogULwsgb9OhrF7M1WwrYdpHWGV?=
 =?us-ascii?Q?8XOgFol3EccACZqgH007BvG0Zt46PmWuGiqyy2qXQ3fO4vKOXuqK9c3SBCjz?=
 =?us-ascii?Q?S4zntDZEdTvDzTcj29x9pRsTZH7JZDI+dcTNkgZIE4nKEIWV2OchoaQLIRp+?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	j/qwCXDEZST3us8iVD6fkMZnb3ohtsGuHBeJ9ppuU3880u9NQHVVMyOivtyXnDYYEFvod0S76qpRbOR7+iS/p0sUzH2xmsDafHFDoefwrsH2jzEqNmNpw7cCsXJcWqTTJ8RSwPiLHDB+vfr+8BpKxiWzQUGTwWn0DzGFbkbC3MOO/MwgXAlSZzPZLrR5pSKoqizd/EO09FtUs3F5BtKYhaLLxbgtElENGMzRzGSf0wBwoWNLFrAgQMsLcEzFQf4EfgiKuEUdw/FuZpVQ1Pu+IUsuR4SgKT+rUqK/r5tV5uNmdJQ83mVItahMMrIy/w4e4sHJjvXB88dMd5cNuNaRwOPh9EvupcwP/ryCpjJN4OK4Nc5ngZ04JRtJSoNVfLm9n41LA8NiUvBR02LOiAfU4/e7PA66WMdOJL1ESxw1HALbTJLyl7a1UryDOBNwkZpvKMrrdP66wRRi4Ys1rRS415tB2cSY9CZx79SUvonvkvYViPL7y09oV6zArNRDtTzGP35nWgNFLCFV5Q4gLPQoFHP4rX/o6+CfjTI6Frzuwu60gkFWeZQ26Gqvh2A1B6kQ+AHx11ugF0bSlsjHR+9x/VbgahlA3FKbXoTGDr8saGE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c413703-3309-46b5-ab34-08dc9d287dc9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 19:27:21.6896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xUrG4XjCmKBVuks2vKOEDdrbt46ec5j/iWPznulyWhSMxkKAa5rcC0YXaAF4fHeEUlB3rOAE73wWUraNDPkKvndNC3VUMpGU7m4LT5mOuxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5789
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_14,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050141
X-Proofpoint-GUID: XsO1LUK7i5BcKd9b2pGaTk-55hsxWNkB
X-Proofpoint-ORIG-GUID: XsO1LUK7i5BcKd9b2pGaTk-55hsxWNkB

On Thu, Jul 04, 2024 at 02:27:08PM GMT, Liam R. Howlett wrote:
> Clean up the code by changing the munmap operation to use a structure
> for the accounting and munmap variables.
>
> Since remove_mt() is only called in one location and the contents will
> be reduce to almost nothing.  The remains of the function can be added
> to vms_complete_munmap_vmas().
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/internal.h |  6 ++++
>  mm/mmap.c     | 81 ++++++++++++++++++++++++++-------------------------
>  2 files changed, 47 insertions(+), 40 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index f1e6dea2efcf..8cbbbe7d40f3 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1488,12 +1488,18 @@ struct vma_munmap_struct {
>  	struct vma_iterator *vmi;
>  	struct mm_struct *mm;
>  	struct vm_area_struct *vma;	/* The first vma to munmap */
> +	struct vm_area_struct *next;	/* vma after the munmap area */
> +	struct vm_area_struct *prev;    /* vma before the munmap area */

I mean this is about as pedantic as it gets, and, admittedly an annoying
comment to make, but the ordering... can't we at least put prev before
next? ;)

This is actually a comment you can fully disregard, by the way!

>  	struct list_head *uf;		/* Userfaultfd list_head */
>  	unsigned long start;		/* Aligned start addr */
>  	unsigned long end;		/* Aligned end addr */
>  	int vma_count;			/* Number of vmas that will be removed */
>  	unsigned long nr_pages;		/* Number of pages being removed */
>  	unsigned long locked_vm;	/* Number of locked pages */
> +	unsigned long nr_accounted;	/* Number of VM_ACCOUNT pages */
> +	unsigned long exec_vm;
> +	unsigned long stack_vm;
> +	unsigned long data_vm;
>  	bool unlock;			/* Unlock after the munmap */
>  };
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 76e93146ee9d..2a1a49f98fa3 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -523,7 +523,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
>  	vms->unlock = unlock;
>  	vms->uf = uf;
>  	vms->vma_count = 0;
> -	vms->nr_pages = vms->locked_vm = 0;
> +	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
> +	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
>  }
>
>  /*
> @@ -2388,30 +2389,6 @@ struct vm_area_struct *expand_stack(struct mm_struct *mm, unsigned long addr)
>  	return vma;
>  }
>
> -/*
> - * Ok - we have the memory areas we should free on a maple tree so release them,
> - * and do the vma updates.
> - *
> - * Called with the mm semaphore held.
> - */
> -static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
> -{
> -	unsigned long nr_accounted = 0;
> -	struct vm_area_struct *vma;
> -
> -	/* Update high watermark before we lower total_vm */
> -	update_hiwater_vm(mm);
> -	mas_for_each(mas, vma, ULONG_MAX) {
> -		long nrpages = vma_pages(vma);
> -
> -		if (vma->vm_flags & VM_ACCOUNT)
> -			nr_accounted += nrpages;
> -		vm_stat_account(mm, vma->vm_flags, -nrpages);
> -		remove_vma(vma, false);
> -	}
> -	vm_unacct_memory(nr_accounted);
> -}
> -
>  /*
>   * Get rid of page table information in the indicated region.
>   *
> @@ -2634,12 +2611,15 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
>   * vms_complete_munmap_vmas() - Finish the munmap() operation
>   * @vms: The vma munmap struct
>   * @mas_detach: The maple state of the detached vmas
> + *
> + * This function updates the mm_struct, unmaps the region, frees the resources
> + * used for the munmap() and may downgrade the lock - if requested.  Everything
> + * needed to be done once the vma maple tree is updated.
>   */
> -
>  static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
>  		struct ma_state *mas_detach)
>  {
> -	struct vm_area_struct *prev, *next;
> +	struct vm_area_struct *vma;
>  	struct mm_struct *mm;
>
>  	mm = vms->mm;
> @@ -2648,21 +2628,26 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
>  	if (vms->unlock)
>  		mmap_write_downgrade(mm);
>
> -	prev = vma_iter_prev_range(vms->vmi);
> -	next = vma_next(vms->vmi);
> -	if (next)
> -		vma_iter_prev_range(vms->vmi);
> -
>  	/*
>  	 * We can free page tables without write-locking mmap_lock because VMAs
>  	 * were isolated before we downgraded mmap_lock.
>  	 */
>  	mas_set(mas_detach, 1);
> -	unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vms->end,
> -		     vms->vma_count, !vms->unlock);
> -	/* Statistics and freeing VMAs */
> +	unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
> +		     vms->start, vms->end, vms->vma_count, !vms->unlock);
> +	/* Update high watermark before we lower total_vm */
> +	update_hiwater_vm(mm);
> +	/* Stat accounting */
> +	WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm) - vms->nr_pages);
> +	mm->exec_vm -= vms->exec_vm;
> +	mm->stack_vm -= vms->stack_vm;
> +	mm->data_vm -= vms->data_vm;

OK I was going to ask you're READ_ONCE()'ing and WRITE_ONCE()'ing
mm->total_vm but not the other statistics, but the original
vm_stat_account() does this so. Yeah :)

> +	/* Remove and clean up vmas */
>  	mas_set(mas_detach, 0);
> -	remove_mt(mm, mas_detach);
> +	mas_for_each(mas_detach, vma, ULONG_MAX)
> +		remove_vma(vma, false);
> +
> +	vm_unacct_memory(vms->nr_accounted);
>  	validate_mm(mm);
>  	if (vms->unlock)
>  		mmap_read_unlock(mm);
> @@ -2710,13 +2695,14 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  		if (error)
>  			goto start_split_failed;
>  	}
> +	vms->prev = vma_prev(vms->vmi);
>
>  	/*
>  	 * Detach a range of VMAs from the mm. Using next as a temp variable as
>  	 * it is always overwritten.
>  	 */
> -	next = vms->vma;
> -	do {
> +	for_each_vma_range(*(vms->vmi), next, vms->end) {
> +		long nrpages;
>  		/* Does it split the end? */
>  		if (next->vm_end > vms->end) {
>  			error = __split_vma(vms->vmi, next, vms->end, 0);
> @@ -2725,8 +2711,21 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  		}
>  		vma_start_write(next);
>  		mas_set(mas_detach, vms->vma_count++);
> +		nrpages = vma_pages(next);
> +
> +		vms->nr_pages += nrpages;
>  		if (next->vm_flags & VM_LOCKED)
> -			vms->locked_vm += vma_pages(next);
> +			vms->locked_vm += nrpages;
> +
> +		if (next->vm_flags & VM_ACCOUNT)
> +			vms->nr_accounted += nrpages;
> +
> +		if (is_exec_mapping(next->vm_flags))
> +			vms->exec_vm += nrpages;
> +		else if (is_stack_mapping(next->vm_flags))
> +			vms->stack_vm += nrpages;
> +		else if (is_data_mapping(next->vm_flags))
> +			vms->data_vm += nrpages;
>
>  		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
>  		if (error)
> @@ -2752,7 +2751,9 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  		BUG_ON(next->vm_start < vms->start);
>  		BUG_ON(next->vm_start > vms->end);
>  #endif
> -	} for_each_vma_range(*(vms->vmi), next, vms->end);
> +	}
> +
> +	vms->next = vma_next(vms->vmi);
>
>  #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
>  	/* Make sure no VMAs are about to be lost. */
> --
> 2.43.0
>

This is a big improvement overall, very fiddly code.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

