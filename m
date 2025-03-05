Return-Path: <linux-kernel+bounces-547591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BA6A50B5E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA3416A85D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D7F25333A;
	Wed,  5 Mar 2025 19:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OijDrW88";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fVXd0WCU"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A84193073
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741202491; cv=fail; b=TqIKhAwYTi5MF57ES/QhPlzUAvkY3fPstkfvBFxx6lLQ1HBZ37A0+l1cdP51GEjl0T5z3Ly1kJnhetWdsl5t9vbQmiD4hRmgngQjEIYpcrEM2pQT4HWa3DofnomlE2CFooDYfi5E9dixtQh1P3R4M7MV7Jk7DcR/3Mi29+7lg0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741202491; c=relaxed/simple;
	bh=S1XOtF5J+3FQF8ZwkOc3hfMDWcqKxCqO3WhI5mQ2GaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OLTCkwLH97qpe+M8mq0TBTOqleFiKuHZ+uKf9lG++AlKcLVwyGfUO4IvbPT/6XLjdgbJKVRvFd7ZusJ+6FkY9wKESMcqAX7zEHIKenZykENZoyd33DRLs/TRHv00Q4ahEq3AEDoXBzhtfjFpdJz5CZ7b6QSQ+NKw6sXQ3xVi2Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OijDrW88; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fVXd0WCU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525IMcbE030911;
	Wed, 5 Mar 2025 19:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=zd+151XTcUpG89CVKk
	43e+29/NVIBoLaez26D4uyB0Y=; b=OijDrW88KewPFJT/9N7/JwnGn223N8HSdi
	vDVO1X62s1w10emZeYVGriQI8CeRf7K7Y9JGW/NvE0+TOEtO38Z35YOIrGu2AGOc
	kiRqQLrnMsdu9qYKco4chCYl8wu7nzEfeaqBpOT+yCtvm/r+c4n+G25LbCH0e26a
	OJh+FfbAW+W7GZxMdTl2YqmLDwWl6ZrVfFYEMdoplOHtg4owQ6kD+vnv2PfCleae
	PA8Ao2vLHPKv5vGm246QagLjZjcTx+bsrEQRxrmX3urZsGK2ZDfDOdaumB/nVLwq
	nFFN/xsntGbLY5eYoKdieTqgc2PbSxdTp16T8C8/S7PiApXjnRRw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86rcnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 19:21:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 525IA3pw038403;
	Wed, 5 Mar 2025 19:21:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rph49jb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 19:21:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhcX0CwbBUYr5S8z9QiWMgnSCJTLUqsna+e/Dna1Oo6rIlf7grav5/oL7BZECym6CNFCUwlz9wnnKGSqlad2hm7L4BYKbJsXr5me7D05OaqJOrUawQdetq5P9Y7CRtxLNshWv7c3gpRj9cFdGlWgpWylxI74jPu9/JcD++6nwlLineqcbmQ+yGZz65f/c7H3y5EeQ9DC8+Cz6ZOjtHh2Z4qBFibp+uLd5Qlc3adOKbQEaiTGQhTd14P9q0FL64ghtnuo4fP9FwEo+8TyVFdIBp6jnEG3dh0AvAxDiKcp/3zG3j0DQv5qMavPm2sHUFNLOEDgqg8TrKKXHp9xbQ63Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zd+151XTcUpG89CVKk43e+29/NVIBoLaez26D4uyB0Y=;
 b=h5BGf5646rt+Cg5fp1TcoqY3DLt7biZtLd1TrVJezsRrfRM3UrMccimWhjoxZfAxOQOf+DC/6gyVoi3oU3DCMpccXL7viU0krS4z76jnImRJE1vYTCUeHoyOn7tvLTcASfkzRPOvnJjzCJfHOIi1O74KZzWYqIrTUckev6H2YsPQgIM8ir/zA8YQ6rEP2cOysdEA94EPx3rSQlTQq4NmtnH0MIUlF46xGq5aEKHAe2OE5Xc0/NaD8WkeDLGImfyOWcTN3TsrFqFUURjVWKokas4m/aoOlQFU3ttkp6nj5ZJBwT/ZAJ2+aEfpsESpY617txFtep1Nk4PdjJvlQimEiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zd+151XTcUpG89CVKk43e+29/NVIBoLaez26D4uyB0Y=;
 b=fVXd0WCUOMZHH5U1Eo3GrMuHUId2cVE/nne5XxkhIsI7K6h1FUVaS4FRm0Fw7UhZqQxphU4BADeIe55QwWvxhYK/rD4Tx5pEEWwbYbgyYDm25wQrpZ0p0uXG/fum6YUGzcK9QFI54eZZLPuZ3U8HRByUjnrAYhCmBXY2eVUKURM=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SN7PR10MB7103.namprd10.prod.outlook.com (2603:10b6:806:32b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 19:20:40 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 19:20:39 +0000
Date: Wed, 5 Mar 2025 14:20:37 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] mm/mremap: initial refactor of move_vma()
Message-ID: <ovtjegskokdpz4gawasilhazfalrhgtgnoh6qxsjtbcenaiao5@glwldebq37in>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
 <b4e64684d6ac753d5a66c0da0da5f4b94d033859.1740911247.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4e64684d6ac753d5a66c0da0da5f4b94d033859.1740911247.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::8) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SN7PR10MB7103:EE_
X-MS-Office365-Filtering-Correlation-Id: 15b10126-5bdb-461d-2f45-08dd5c1ad0be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uBuolGi1VaSsflTD6VMPHc+rBZ2FCDo7bZB/WIQDrOs98XhvwuNhu0QqlvaF?=
 =?us-ascii?Q?V1sUz4u3JxYQytCJ7wA3ZAhpMN3phK0gmFhf0ALIbRe4GcODxIQQZHIQJ5hw?=
 =?us-ascii?Q?dnlouuTvj97xNojLkX1VcdjofsPxdVtUPeDvecmHl42C1WwtsHhP8gnclqRq?=
 =?us-ascii?Q?qChYTaTavVP9HqgP19IawvFo3jJhpLu8YcpBjUA4t0O09TqC0cOoQVV1wrT9?=
 =?us-ascii?Q?HU3d4XlaVYrScIgygJvV/bgYJegTDd0VE+cBiOGaOfudRnc5yUIetBjGqSVV?=
 =?us-ascii?Q?mvA87AVZSkJcHCzigHC5hl57Ql1tZPst52kYSFuyZVGe33Czo3Lu/PMS3cvj?=
 =?us-ascii?Q?h4m+x1Glvx5OFKZyEAqLlvWL6pS9hjlAPGIw7kHYHTKVDybhlyY9GoBVGXcW?=
 =?us-ascii?Q?zESGhtLEWpZinE5bTn26jmzHzbXTvs4zQ6URHSoviPb4JRJ4pBLvV2RmKlsZ?=
 =?us-ascii?Q?MiOJlMW9pPtmu45CciVvfOe03mrhRm+iR/I9RHNda8rzKWAaBWmR9rCybhoJ?=
 =?us-ascii?Q?s5kUyQYyBtpQqO9upfKIhy+3KSuO8F0ImzRS1A0fZxBHxrsxOJ5FeCEImb2n?=
 =?us-ascii?Q?PL7caZAxkZHSVeh80SCpPcbjd7wWLw8khBFzOVB8jaYZ3XoOHk76vqPc72sQ?=
 =?us-ascii?Q?FMiPTTyNOkjko0D6jaR1zeT2v8/O6sZdvtItTdfACodFW7FJId8Z3vaoMOV1?=
 =?us-ascii?Q?S+wz8l+U2Ud+2UOEdEf6ls/E+nQd8Pbxv6hU+UKzQq1UU8sYqX/kaEHq632g?=
 =?us-ascii?Q?haZZu+Uaixhgkkuz54vfCQtr9doALamXZYiiKt6TtKclbhkKkUea/+dQT5LQ?=
 =?us-ascii?Q?NPhkW426HxJ1NWp4EzG2+7T+dQG0KzCo9B/DdiMUJ6mAXt84d/C3VCPBDo+u?=
 =?us-ascii?Q?BobIRESv1B4RpYceRKmWPZcERY2jH9dpzQsdhU3vAUlnN+yq9Z/xdDYGAMHH?=
 =?us-ascii?Q?SoS6Q2trVx8uVzAp6mzvFHS8GHY8SIe65yeWILvvr+n9WCsPABghBSitxBhx?=
 =?us-ascii?Q?X++R6w54PyU7IetM39FUBU5p0wKfRdrCZ7xqazoXzMbzf85ivGSJcOKhRDjB?=
 =?us-ascii?Q?ygsw9dpHwAPV2ua98mjpVmHBCoJGdycoK9p0EOuxIrspTOBzFqkXF9s4w+d+?=
 =?us-ascii?Q?prltboylGK2w0Y+rNA3ky8qccwtgneXeLcf0AnX6HxDYvdYmPYz2VyA4tHmJ?=
 =?us-ascii?Q?GjV4XDL6ys88IpWgwwQwLxBnBeMgTUJludTMaTtC9kjm+yXmCl0h2sp0Om+Q?=
 =?us-ascii?Q?ME8jpue5HRqeqG9cwfsW7dwKLjdNnO67+0gy2lXUxZKBG9wUsG27mVLpz6m6?=
 =?us-ascii?Q?fvJGnqnUVl2zHWOmnT9o1l/IWAi4MC8HzEf60yj2g1kz88y8e5Q/n2rLkuLq?=
 =?us-ascii?Q?3gq7kuJY6wnB5vGPw9B+sWnr1d+I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hrf2dgX3Nmbj8nhsIsCpUa2E0mdRi9rbPYMKZpU8WEv0gCEPpjycyor8SOPK?=
 =?us-ascii?Q?xp9zm/7AsvUlqXOGGNZm0wYr3BidN782QhrwjVlXKzA9fwOqVlvAGjTCy8/H?=
 =?us-ascii?Q?wlnuKBgjqw9TuumYgaLdglLK47fPeyWVCZGdzRW9yk2Q3PZgcFM0KtPDdryf?=
 =?us-ascii?Q?dP+yCSW7ZXbaoX6xN9eyEzks74vhuzJ6jx+ymGW76nGNlzIsarRraY8kXVkj?=
 =?us-ascii?Q?1K1GaE+iJJ81eVEf5zJ1CBP7k1sdYcVmiQOcSFeVmBsGz4qQLHEKvHDfhqRQ?=
 =?us-ascii?Q?VtjZHQoaLiiXMLd/+EPkB0q2tUA/47ua2bxPJtXWGrPAkt7ZA2Mzu9sCnw6H?=
 =?us-ascii?Q?CyiFjzaiKSlMvwUX2pMo1aVeprHI+O5AlDz+4Kb2Q8UsahA4zo1g0qM3/hkW?=
 =?us-ascii?Q?UQ6U1RhYFuhPAhUwj3qr7sXG3az2geqxr1R0a8uFO2AjH8JRLd+qP0JeHe94?=
 =?us-ascii?Q?WKKfCrvDhjCnxMmv+dX7iCSmQnNbcklPIL8lWf/IDmh4iyZZgkFoWrSFxpMa?=
 =?us-ascii?Q?NgbP0QM/yMHPn2QjX9gT5gLUeODHRh7zQ4X0xOVNMzMArhrCZPScyO0GR5sS?=
 =?us-ascii?Q?Y+WheixKf+NpDJBUzCVfYajA4xaujUS1urWytkvCvu3cCb7sQLSMQ3xTb3+k?=
 =?us-ascii?Q?eWcC5mDuubVZZvsHFOK0NUU5j9WEAmVngjpz84666TY9e699zChLe3TcrGpI?=
 =?us-ascii?Q?fC+7AA9WPbw2PIOzPPA4vXybNbBCzQFDTSaXagZR9vxW9veEaKZh1LEwg7Hz?=
 =?us-ascii?Q?bNg5KeLqoMG7A35CImvz0/vltqZ7xRiN1Qd1zYU3gypknXQWffE8p6foSqIe?=
 =?us-ascii?Q?MW1BNSf18MxmyP0E4blLeDiuEGZYPVO+ei5LogQN7vF3bPt1dLXF6+HfscNL?=
 =?us-ascii?Q?p5Q1JMwDeJZtAYsYKfFTlP4k+KJw+FLCC7yJEJF64b5BmaPqpk2qgy7u8K2G?=
 =?us-ascii?Q?DpmO9VKZnQoiQyb7yOpDbDGWG7EIg16LEh7fiGDItQpcZmW5hFbd1LVZ/QCz?=
 =?us-ascii?Q?CpZM3y3AACTa8C9FEVdTQlFp3sQVr6X3j2nbRInD/o4iWZBa0o8/j42crc9d?=
 =?us-ascii?Q?jHIh9B+HajZ2KK52z+G5/mScATtrf7NMzYumlLta1rM/OTRrJWy+3MalUaJN?=
 =?us-ascii?Q?kNOfi7aYWkqYGpV8q6kZUle6WTe4j0R6JuREeliZfYtrF6DqViZIsYzbK0GY?=
 =?us-ascii?Q?q78o4iLyF7lHmOOn1ndD1mR1B8CfCxncvNM0822mqxpUjpvTz72IFK83RERE?=
 =?us-ascii?Q?8IvIfVzsorEw92zuZ7IDHIFIvhuIM/Q4mOD2NWj19M6re8fItGWo17jTRf7h?=
 =?us-ascii?Q?8j3fCmzBzNWnL1c40iWaNxs1sj5uMFQl/Ss67ssEg2e7cP+/DdMA3K4qN4ii?=
 =?us-ascii?Q?5L/HJvH5731HHwGOtNspJEgL7RYAfXGZOVoDByDx/Lr0M3qwVRb9JkccInnI?=
 =?us-ascii?Q?qnfzCXjCRLYMro+xapsakk0w3qydSCA7yntJYpSVYxTOlwQw+menuzj8HOix?=
 =?us-ascii?Q?aw+k+cMh3NMlJNB21DOKuocS+a4L2ti5NTljObxtzzDw9UyCpT0sVhqV2eAU?=
 =?us-ascii?Q?qc9egL3PRdYyM0ar8ZbmGWEHOlXL020tnCGLYvdB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	m0l1Tv4K9/o3XO6aeAEtkiG8kOKvXKJVu24e3gJkBCVWcxbLvxmjI90LB/sK7ExhoImeHbk9PWvfnZoAAjkmsjQACTID1/bxnWw7gDkNZzm5TPxEGNzQXQGDaYL3iuBt8g92AWjHC8A+d5vx8Nc2Bwl6dB8ONuNTo+/FVCyPgbMmVF2FeZ8M7NQnZAQKdeLhmfeWCpLCAKt1theWxIaKlDgZqCTOC22/GzEQprC1Go6p0GX1LEchmRkPW1pzt8dP62AscewkGNmsZBwPu7c2ekF2JbFuxhnZNzLy4QzS7jUklru8fAiC5xvSvznC3qQB6QaVjDqWrQSwABOQMx16cwsW32IEWGG3lpAOXPYDljg3NG0KnwlA+RiC0CByzrhZiGeCG91c+Kdo7DS54tsiMmTucRB/Ol/8UOyH9PBuAbBq/fw+VcMXEKwWO9cZD23WVQ04L+I88FGXw9MTFMuJq2L+SuwAnm5OixWZff77Wst4lnKJZoRZaNLfJM1OjijbBA6d9aYwLkB/LiUO4p1kFkTVF+QssBhjBVBy7SHuRqWmCr+GpScAsL8pZdav5o/W8KOqwq1bkxSSO5a9mI4K+gj31qR0asMNvR98iIpo/cg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b10126-5bdb-461d-2f45-08dd5c1ad0be
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 19:20:39.8582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuMPjauyGXFItTSXGORPXAsR6O6ZiB6JTsp+7/iGlikWdUz2imlhc+U8K3k76acdeTQlFRFzoiaxuNFb5qlBLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7103
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_08,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050147
X-Proofpoint-ORIG-GUID: 7Pc6BBoY7EoDwl_u-i4O-nsMRBhE-KZZ
X-Proofpoint-GUID: 7Pc6BBoY7EoDwl_u-i4O-nsMRBhE-KZZ

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250303 06:08]:
> Update move_vma() to use the threaded VRM object, de-duplicate code and
> separate into smaller functions to aid readability and debug-ability.
> 
> This in turn allows further simplification of expand_vma() as we can simply
> thread VRM through the function.
> 
> We also take the opportunity to abstract the account charging page count
> into the VRM in order that we can correctly thread this through the
> operation.
> 
> We additionally do the same for tracking mm statistics - exec_vm, stack_vm,
> data_vm, and locked_vm.
> 
> As part of this change, we slightly modify when locked pages statistics are
> counted for in mm_struct statistics. However this should cause no issues,
> as there is no chance of underflow, nor will any rlimit failures occur as a
> result.
> 
> This is an intermediate step before a further refactoring of move_vma() in
> order to aid review.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
>  mm/mremap.c | 186 ++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 122 insertions(+), 64 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 7f0c71aa9bb9..fdbf5515fc44 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -67,6 +67,7 @@ struct vma_remap_struct {
>  	bool locked; /* Was the VMA mlock()'d (has the VM_LOCKED flag set). */
>  	enum mremap_operation remap_type; /* expand, shrink, etc. */
>  	bool mmap_locked; /* Is current->mm currently write-locked? */
> +	unsigned long charged; /* If VM_ACCOUNT, # pages to account. */
>  };
>  
>  static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
> @@ -821,35 +822,88 @@ static unsigned long vrm_set_new_addr(struct vma_remap_struct *vrm)
>  	return 0;
>  }
>  
> -static unsigned long move_vma(struct vm_area_struct *vma,
> -		unsigned long old_addr, unsigned long old_len,
> -		unsigned long new_len, unsigned long new_addr,
> -		bool *locked, unsigned long flags,
> -		struct vm_userfaultfd_ctx *uf, struct list_head *uf_unmap)
> +/*
> + * Keep track of pages which have been added to the memory mapping. If the VMA
> + * is accounted, also check to see if there is sufficient memory.
> + *
> + * Returns true on success, false if insufficient memory to charge.
> + */
> +static bool vrm_charge(struct vma_remap_struct *vrm)
>  {
> -	long to_account = new_len - old_len;
> -	struct mm_struct *mm = vma->vm_mm;
> -	struct vm_area_struct *new_vma;
> -	unsigned long vm_flags = vma->vm_flags;
> -	unsigned long new_pgoff;
> -	unsigned long moved_len;
> -	bool account_start = false;
> -	bool account_end = false;
> -	unsigned long hiwater_vm;
> -	int err = 0;
> -	bool need_rmap_locks;
> -	struct vma_iterator vmi;
> +	unsigned long charged;
> +
> +	if (!(vrm->vma->vm_flags & VM_ACCOUNT))
> +		return true;
> +
> +	/*
> +	 * If we don't unmap the old mapping, then we account the entirety of
> +	 * the length of the new one. Otherwise it's just the delta in size.
> +	 */
> +	if (vrm->flags & MREMAP_DONTUNMAP)
> +		charged = vrm->new_len >> PAGE_SHIFT;
> +	else
> +		charged = vrm->delta >> PAGE_SHIFT;
> +
> +
> +	/* This accounts 'charged' pages of memory. */
> +	if (security_vm_enough_memory_mm(current->mm, charged))
> +		return false;
> +
> +	vrm->charged = charged;
> +	return true;
> +}
> +
> +/*
> + * an error has occurred so we will not be using vrm->charged memory. Unaccount
> + * this memory if the VMA is accounted.
> + */
> +static void vrm_uncharge(struct vma_remap_struct *vrm)
> +{
> +	if (!(vrm->vma->vm_flags & VM_ACCOUNT))
> +		return;
> +
> +	vm_unacct_memory(vrm->charged);
> +	vrm->charged = 0;
> +}
> +
> +/*
> + * Update mm exec_vm, stack_vm, data_vm, and locked_vm fields as needed to
> + * account for 'bytes' memory used, and if locked, indicate this in the VRM so
> + * we can handle this correctly later.
> + */
> +static void vrm_stat_account(struct vma_remap_struct *vrm,
> +			     unsigned long bytes)
> +{
> +	unsigned long pages = bytes >> PAGE_SHIFT;
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *vma = vrm->vma;
> +
> +	vm_stat_account(mm, vma->vm_flags, pages);
> +	if (vma->vm_flags & VM_LOCKED) {
> +		mm->locked_vm += pages;
> +		vrm->locked = true;
> +	}
> +}
> +
> +/*
> + * Perform checks  before attempting to write a VMA prior to it being
> + * moved.
> + */
> +static unsigned long prep_move_vma(struct vma_remap_struct *vrm,
> +				   unsigned long *vm_flags_ptr)
> +{
> +	unsigned long err;
> +	struct vm_area_struct *vma = vrm->vma;
> +	unsigned long old_addr = vrm->addr;
> +	unsigned long old_len = vrm->old_len;
>  
>  	/*
>  	 * We'd prefer to avoid failure later on in do_munmap:
>  	 * which may split one vma into three before unmapping.
>  	 */
> -	if (mm->map_count >= sysctl_max_map_count - 3)
> +	if (current->mm->map_count >= sysctl_max_map_count - 3)
>  		return -ENOMEM;

With the refactoring, it is pointing out some things that need to be
reworked at a later date.

>  
> -	if (unlikely(flags & MREMAP_DONTUNMAP))
> -		to_account = new_len;
> -
>  	if (vma->vm_ops && vma->vm_ops->may_split) {
>  		if (vma->vm_start != old_addr)
>  			err = vma->vm_ops->may_split(vma, old_addr);
> @@ -867,22 +921,46 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  	 * so KSM can come around to merge on vma and new_vma afterwards.
>  	 */
>  	err = ksm_madvise(vma, old_addr, old_addr + old_len,
> -						MADV_UNMERGEABLE, &vm_flags);
> +			  MADV_UNMERGEABLE, vm_flags_ptr);
>  	if (err)
>  		return err;
>  
> -	if (vm_flags & VM_ACCOUNT) {
> -		if (security_vm_enough_memory_mm(mm, to_account >> PAGE_SHIFT))
> -			return -ENOMEM;
> -	}
> +	return 0;
> +}
> +
> +static unsigned long move_vma(struct vma_remap_struct *vrm)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *vma = vrm->vma;
> +	struct vm_area_struct *new_vma;
> +	unsigned long vm_flags = vma->vm_flags;
> +	unsigned long old_addr = vrm->addr, new_addr = vrm->new_addr;
> +	unsigned long old_len = vrm->old_len, new_len = vrm->new_len;
> +	unsigned long new_pgoff;
> +	unsigned long moved_len;
> +	unsigned long account_start = false;
> +	unsigned long account_end = false;
> +	unsigned long hiwater_vm;
> +	int err;
> +	bool need_rmap_locks;
> +	struct vma_iterator vmi;
> +
> +	err = prep_move_vma(vrm, &vm_flags);
> +	if (err)
> +		return err;
> +
> +	/* If accounted, charge the number of bytes the operation will use. */
> +	if (!vrm_charge(vrm))
> +		return -ENOMEM;
>  
>  	vma_start_write(vma);
>  	new_pgoff = vma->vm_pgoff + ((old_addr - vma->vm_start) >> PAGE_SHIFT);
> -	new_vma = copy_vma(&vma, new_addr, new_len, new_pgoff,
> +	new_vma = copy_vma(&vrm->vma, new_addr, new_len, new_pgoff,
>  			   &need_rmap_locks);
> +	/* This may have been updated. */
> +	vma = vrm->vma;
>  	if (!new_vma) {
> -		if (vm_flags & VM_ACCOUNT)
> -			vm_unacct_memory(to_account >> PAGE_SHIFT);
> +		vrm_uncharge(vrm);
>  		return -ENOMEM;
>  	}
>  
> @@ -907,7 +985,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  		old_addr = new_addr;
>  		new_addr = err;
>  	} else {
> -		mremap_userfaultfd_prep(new_vma, uf);
> +		mremap_userfaultfd_prep(new_vma, vrm->uf);
>  	}
>  
>  	if (is_vm_hugetlb_page(vma)) {
> @@ -915,7 +993,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  	}
>  
>  	/* Conceal VM_ACCOUNT so old reservation is not undone */
> -	if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP)) {
> +	if (vm_flags & VM_ACCOUNT && !(vrm->flags & MREMAP_DONTUNMAP)) {
>  		vm_flags_clear(vma, VM_ACCOUNT);
>  		if (vma->vm_start < old_addr)
>  			account_start = true;
> @@ -933,13 +1011,12 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  	 * If this were a serious issue, we'd add a flag to do_munmap().
>  	 */
>  	hiwater_vm = mm->hiwater_vm;
> -	vm_stat_account(mm, vma->vm_flags, new_len >> PAGE_SHIFT);
>  
>  	/* Tell pfnmap has moved from this vma */
>  	if (unlikely(vma->vm_flags & VM_PFNMAP))
>  		untrack_pfn_clear(vma);
>  
> -	if (unlikely(!err && (flags & MREMAP_DONTUNMAP))) {
> +	if (unlikely(!err && (vrm->flags & MREMAP_DONTUNMAP))) {
>  		/* We always clear VM_LOCKED[ONFAULT] on the old vma */
>  		vm_flags_clear(vma, VM_LOCKED_MASK);
>  
> @@ -952,22 +1029,20 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  			unlink_anon_vmas(vma);
>  
>  		/* Because we won't unmap we don't need to touch locked_vm */
> +		vrm_stat_account(vrm, new_len);
>  		return new_addr;
>  	}
>  
> +	vrm_stat_account(vrm, new_len);
> +
>  	vma_iter_init(&vmi, mm, old_addr);
> -	if (do_vmi_munmap(&vmi, mm, old_addr, old_len, uf_unmap, false) < 0) {
> +	if (do_vmi_munmap(&vmi, mm, old_addr, old_len, vrm->uf_unmap, false) < 0) {
>  		/* OOM: unable to split vma, just get accounts right */
> -		if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
> +		if (vm_flags & VM_ACCOUNT && !(vrm->flags & MREMAP_DONTUNMAP))
>  			vm_acct_memory(old_len >> PAGE_SHIFT);
>  		account_start = account_end = false;
>  	}
>  
> -	if (vm_flags & VM_LOCKED) {
> -		mm->locked_vm += new_len >> PAGE_SHIFT;
> -		*locked = true;
> -	}
> -
>  	mm->hiwater_vm = hiwater_vm;
>  
>  	/* Restore VM_ACCOUNT if one or two pieces of vma left */
> @@ -1138,9 +1213,7 @@ static unsigned long mremap_to(struct vma_remap_struct *vrm)
>  	if (err)
>  		return err;
>  
> -	return move_vma(vrm->vma, vrm->addr, vrm->old_len, vrm->new_len,
> -			vrm->new_addr, &vrm->locked, vrm->flags,
> -			vrm->uf, vrm->uf_unmap);
> +	return move_vma(vrm);
>  }
>  
>  static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
> @@ -1245,17 +1318,11 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
>  static unsigned long expand_vma_in_place(struct vma_remap_struct *vrm)
>  {
>  	struct mm_struct *mm = current->mm;
> -	long pages = vrm->delta >> PAGE_SHIFT;
>  	struct vm_area_struct *vma = vrm->vma;
>  	VMA_ITERATOR(vmi, mm, vma->vm_end);
> -	long charged = 0;
> -
> -	if (vma->vm_flags & VM_ACCOUNT) {
> -		if (security_vm_enough_memory_mm(mm, pages))
> -			return -ENOMEM;
>  
> -		charged = pages;
> -	}
> +	if (!vrm_charge(vrm))
> +		return -ENOMEM;
>  
>  	/*
>  	 * Function vma_merge_extend() is called on the
> @@ -1268,15 +1335,11 @@ static unsigned long expand_vma_in_place(struct vma_remap_struct *vrm)
>  	 */
>  	vma = vrm->vma = vma_merge_extend(&vmi, vma, vrm->delta);
>  	if (!vma) {
> -		vm_unacct_memory(charged);
> +		vrm_uncharge(vrm);
>  		return -ENOMEM;
>  	}
>  
> -	vm_stat_account(mm, vma->vm_flags, pages);
> -	if (vma->vm_flags & VM_LOCKED) {
> -		mm->locked_vm += pages;
> -		vrm->locked = true;
> -	}
> +	vrm_stat_account(vrm, vrm->delta);
>  
>  	return 0;
>  }
> @@ -1316,11 +1379,7 @@ static bool align_hugetlb(struct vma_remap_struct *vrm)
>  static unsigned long expand_vma(struct vma_remap_struct *vrm)
>  {
>  	unsigned long err;
> -	struct vm_area_struct *vma = vrm->vma;
>  	unsigned long addr = vrm->addr;
> -	unsigned long old_len = vrm->old_len;
> -	unsigned long new_len = vrm->new_len;
> -	unsigned long flags = vrm->flags;
>  
>  	err = resize_is_valid(vrm);
>  	if (err)
> @@ -1353,7 +1412,7 @@ static unsigned long expand_vma(struct vma_remap_struct *vrm)
>  	 */
>  
>  	/* We're not allowed to move the VMA, so error out. */
> -	if (!(flags & MREMAP_MAYMOVE))
> +	if (!(vrm->flags & MREMAP_MAYMOVE))
>  		return -ENOMEM;
>  
>  	/* Find a new location to move the VMA to. */
> @@ -1361,8 +1420,7 @@ static unsigned long expand_vma(struct vma_remap_struct *vrm)
>  	if (err)
>  		return err;
>  
> -	return move_vma(vma, addr, old_len, new_len, vrm->new_addr,
> -			&vrm->locked, flags, vrm->uf, vrm->uf_unmap);
> +	return move_vma(vrm);
>  }
>  
>  /*
> -- 
> 2.48.1
> 

