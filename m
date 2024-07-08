Return-Path: <linux-kernel+bounces-244360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE31F92A31D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68FF81F2243E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177A3132121;
	Mon,  8 Jul 2024 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HLBPUbJg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rr3CXh+V"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10BE81211
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720442624; cv=fail; b=SFAHuJdGPMKHTsOQJYDiAOFqRTtnvEu556QbHGxucMrrjmdIcXMAduu8+6rNS0vmrTuKGuZmtAO/NeEcdKJBJpi9H0xCSLUfT8ZYEfo0rGDLprTAG6FiNBfLNO2nl0jwMIuP2ZTKkCwP9zO0bcoj6jhyVcThpnVyUMhsSVJJVhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720442624; c=relaxed/simple;
	bh=1MolXtyj63Fcv0t9BD/krKE3DpCWhiE21tnp8SlknNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GoUILDs663ubCzV91Nxk1tb6X3yoyrsrHWTYhwfRSahD7C/YCyQnkOUVANiWWXKJcXe1iPjnEMC1oWMu8wHzy4uyIE2ymQgmmgXrzVPtLP9gnKbPJtKQPxQ0/SDFnJlkC8Zrag0qTz1DsDWCwLSlIgJwHw3d8nuMwM7TNT0GJd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HLBPUbJg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rr3CXh+V; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fTEd004395;
	Mon, 8 Jul 2024 12:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=dCnU5HE2utPuEHF
	FLzIqtlo17+PCqj2//fy+hR/DuXU=; b=HLBPUbJg6Y7GOf+Yp4TLJZLfZ7idYh8
	9Mt8KriymjbI6Iyab+3f2S6GaDIjGuVsTGbcZBFIYra4dIDMXEeJu/DEgiAfjtce
	hGzoY1mMnTJZfEkd5kQSh5+lMvT79PP/LCx3kG3/2u4WwYm0VLCka3AGJGITy9zr
	qi3+HEh1P2mBs2BKSkoLi7O7izPl3YPROKK0sJXWbe6mg2VkeehagoBikwMoUjjm
	8LtrtxuJK9CKW/mjRKjDo8mn2nHhcKAcxj7lle13GYPksDeQjqX32WBCwdARGReR
	5T7KWiB3Ud9BfHjFxR8hGeRINzEJqGU/b97UqBalb1xi9TQju22ArXQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406xfsjh9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 12:43:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 468BE6kl014385;
	Mon, 8 Jul 2024 12:43:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407txfbax2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 12:43:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7+fW2ZetM67JpeOAtNCtg+uTjAVU8/5nIDRJbQzbOgr0t0m67tbCAyvY2ipuAV7IrSyb51VOhzjfHtfOy0GC3bY7KbS1iDy4lTdQ5jqPRey/SNXKzJ64ANfzLhdkwE8tw30c9/c/A3aKUdpZzRq+kfyVR4L6L9izi0jQCTSUQ5+DfDcbh0JETzHIJ2kQfNDj+uRHqVEr55q/Jy1Y+HZrWpIHH/tNKdswqAc+IuDhkCkLhwsIhB3NTtXCE9Icrqud7wlSud7tdfqTc+JrNMC/oiZLJve3KJU4ebq3k5X1WVujsotG/I83BEzfnCcVnKqnGcf87K0zQ3EgtLeSKx8YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCnU5HE2utPuEHFFLzIqtlo17+PCqj2//fy+hR/DuXU=;
 b=YXUpqEWpBDArym8JCNBS8Yx+tkNOqOItRbddCIl4os2gho6iE/TMHWq0h0NTs6EfgYuV1Qi6mIHOtPYwukJ8undnNYMDBa8TRkqWbNC38imp7LRa7WwxOAANxgmNuvU/bIeYhsNziCgTCZWVB4DryF641QcP+j9hXz8A5+BGLDibvokQfg+EO+xQAYHrDinx5OKkYr6rRJAqE9vUjf8zQPW2ncqMffSntXIxp+mrQA/5GmMWSDek+PT33AGHWgOr7cKGwQ5ZtOuPR/Cs8G/sa/iYL6SInM3tbRXHIRllnqQS/Trv4coMSs/T6lz7IhNNATYJqA1F461T9ePX+YbRGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCnU5HE2utPuEHFFLzIqtlo17+PCqj2//fy+hR/DuXU=;
 b=rr3CXh+VhxVQfnqhaLS7nrnP+Tagu5gQyYsNycX3M48pTf9WGqFU26f/Wbz2rd3YNZMtasYCwqkmVhlcfD9NzflSTtdjloDD5aQ3koWQJD/Hn40tC+Qn6dwDeaPXcsYqGc1LXAPDVDU/uPRkeMUUIpfl6/bln8LeMx85NOgHzZs=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB6103.namprd10.prod.outlook.com (2603:10b6:8:c8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.35; Mon, 8 Jul 2024 12:43:22 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 12:43:22 +0000
Date: Mon, 8 Jul 2024 13:43:18 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 15/16] mm/mmap: Use vms accounted pages in
 mmap_region()
Message-ID: <235952c0-0007-41ca-8399-dd388e5596e3@lucifer.local>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-16-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704182718.2653918-16-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO4P123CA0077.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::10) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c06827-ca94-47c8-39ca-08dc9f4b8d71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?dlSPIJ9RD/iRHFVfv1l6mcK94L2d+RBKm33eV6gR45gpeLDM8CyV35lCZlU6?=
 =?us-ascii?Q?tXuyeAm2HYlsrIRZlwvBjI0N9K3qGX48YnFBeyZiP7+zX1/lDx8NwwCon9ot?=
 =?us-ascii?Q?ZqVpNJSzXyRS1h94dwHJQE+4eoR6CiBIuXrQIs6XdsN/WStCBxNIJwe625jL?=
 =?us-ascii?Q?+mRbJ4RbHKQF1t1eKUbXA9xY619l1SdsROLPowAIaSFWoLqIz3oVMdzaVHR/?=
 =?us-ascii?Q?VkDKYVahKzXtMB7xHXVXw6yOdKw8tDc4ogrertQ/nLQpRQrrxHsjfAchcNDn?=
 =?us-ascii?Q?yypow9wRiHPd+m9L8G1yVotscWP9q4fZJ9VCCUEhGGUb6oBPoENC03NYGxWG?=
 =?us-ascii?Q?q7MWeamGND+Rs74/49N0FM30pTsvMOolqCH3TxfecpO2Lx3lHmvlbozwWq/n?=
 =?us-ascii?Q?ZgwsZrJUZNaiYtozZ5Ff0aSOfEoLHxRtwdIwhkPgCYCH4aJyeolf9m1QJ1B6?=
 =?us-ascii?Q?jzfGVC5dL3s+9mAITDrc0snobwDuputJ3+olVv6XrL2HTPEAB3MzUzfwh2cn?=
 =?us-ascii?Q?LT1QAjwFuQQl7cP/qWIwzbCmFcyJs7H7VKnd1wghPfGObzc9PHLBk5Bb91oS?=
 =?us-ascii?Q?bv4+0PZlFBtAQ275VHVcrmAbHFWqL7bjnAan5IPfDPcfuhqfP1SEgXGaA+Hn?=
 =?us-ascii?Q?+wwvYxkK+Ft+TXjA6YdDZGl5oEDk0MVXl9WxLCA3OwGMKk2PB+MMs6XffWqc?=
 =?us-ascii?Q?sMhKpaGz6jBZ3vvt32PBctj0CzHaqQNWaxRXNVO+lDr7hxJ9+v+GUzMifcVz?=
 =?us-ascii?Q?c+54KbqpC+0gFOib/7w5AjPBbr/HXUdTkjWR05KsdGVBabfvw64/iBInxLrU?=
 =?us-ascii?Q?zdzzQjKGoM6EQ6l/FXRodUCWDUi7WvOsxfh6iX/2oM6DsUFwQqrwJBcuOFbV?=
 =?us-ascii?Q?pJwbXfrGv7tMQLsRBrT21l0qF9V0bJWoK5XXsDnx7vVLYWU9TWrAaQ64qghE?=
 =?us-ascii?Q?CYOYmuY9R4MkFZ0Vs2cAqbqMb+XT4fnskviHcJ95fBjXrmf4LM7GCbn6EmkE?=
 =?us-ascii?Q?yyTjWPEEYCXLR/pPvjkR+NuCMAl4zocYmUv6RfV8Ji9fq8ysjzjWDT+b9dES?=
 =?us-ascii?Q?LU8YXlTsKW2oVUHK6EoM3UQjXeNHzfEcLpCY6AvjSb8zrKrsl8FffDtKNB+a?=
 =?us-ascii?Q?jMJRuH5logLzu+0gXm1TubDSSI9wTKZoJK4QptW84qke7XaoDOAqCOxA5RO+?=
 =?us-ascii?Q?F8ZKLR9q8JJND5V+wEiIVW77350qlLJLFfmnjxXt8zXHu+gPPESqWO9Om1xz?=
 =?us-ascii?Q?VNn51sMudVIlWLW0gxNs1mdrOnEM9AxDXG58tPAiNP66iI6+iJA94zPb8e+4?=
 =?us-ascii?Q?s3lTGW5DTL8lW9MyOH6kwN/pnpQOU9Lg1ZO8sk9audO33g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dpbZ7AHt4wOLBspvRFoPsFfCyPW/vd7lcPT4erZmVfZdRtUmQu5BwB8dIuhr?=
 =?us-ascii?Q?tGZa7P2CRVeioZ0NPE2ZeNV6PTEsPIfp/tKkTEUPtsNg/oykXkAdOGBXNA7/?=
 =?us-ascii?Q?lO+4UtjZjwnJTEhy4ahqdwrcgIiqgqaIE3TKGWOk3az8U1krE1jQRoHZ7Qqi?=
 =?us-ascii?Q?pFceDP0i93klVLBi6V/lQlsMk4tFuR51Op/GfPLbqXrcYEatY8iXUDfBgV0Q?=
 =?us-ascii?Q?p3J1ppIGehBgjehOB9N/etWQNicXF/AwYfLfevxAbHicXb+/I/mYjnoRp31X?=
 =?us-ascii?Q?qNgfJRlxtWKA4sY/RVQgUSVCDZ/4p6Z1FyIBiBH7SZoicQw9HPo4iKr+REnY?=
 =?us-ascii?Q?QTTnlQ80mYPeQuAci2t1ZO6qEbSKMHzTRhwMjoyda939q7cSd4uWkXtG8O24?=
 =?us-ascii?Q?6w3eLqqspM9xdhkJgpim6Hhj8XsxdewoDuod4eHtkNDsDBq+NTYEj0LVIeet?=
 =?us-ascii?Q?vM/99vsu+eCYu6YUbmFczH8RraJsaXCtLdXTZHK2MpYGxhBAq8XVKJFFDt42?=
 =?us-ascii?Q?848XcL5ixGw8CKfaZAeDo9FC+Oh2nzqgoeoDfCwcAokpXT0LWkZQo7QZW2x9?=
 =?us-ascii?Q?Wj3nPGmEy3GPnbYys1n+5APuQnOGZAnj2NR4GcUBeGXWOZ45O8d9T6SwqLFH?=
 =?us-ascii?Q?mwRKvnyrN9DqB6dau+VncLhE7N/UqOvcq5SSOVu6kK1+oXCIhQ7v8JfHkrzp?=
 =?us-ascii?Q?5BJdK935pFjOymBSjmcCQcZFIWeBmjh6VTLQzfbjy+sMnEK9VmyJPNpC0c2/?=
 =?us-ascii?Q?RjssvKPSf7Kz1OIkBGvwJR1MDKbo5Ibi49IUSVZDkzAF68EAagoXq2vMVOwv?=
 =?us-ascii?Q?d94qf0ReVQNAmcYSK/aflWe9p5sbEhSHdolGQ8iv5vHYxYBh1ik0FT1a3cIw?=
 =?us-ascii?Q?G4XDof+bWe/UMfXqAlUbCKoqxtNKaFdJdefynrjmytWeKc1SQWGUWZPCmKiL?=
 =?us-ascii?Q?E8vB5dvLxrde1IwUjnPxA8HGCkr2uvIE/qkg2X/3IWVa4B3fy5wu8n0D3R/f?=
 =?us-ascii?Q?2KSYEvpsH7HrKuSIFY42SmCv/JiOm9K1OdHFT+p0ZmH+imsSsklCRZLFRgVr?=
 =?us-ascii?Q?6aIoh3syEvdifptJVnAelXaqQdlMq9KvpqJgyeUXJHbq+2/kiVcHVL8DM1bT?=
 =?us-ascii?Q?QG2emMXer9EaAVu7Gy2xPecgOD/qVo4samFT7oQn/wYgIco0g41JiO9oD2Ql?=
 =?us-ascii?Q?zptsXSXWzvNeqw1KX+ICpf8BrzWRtGEvUseFxyQmVlyUo9aVuL3JpgYMaMmx?=
 =?us-ascii?Q?9wkFk9uYheklf8d1m1kC0vOaZg7q75SU82YbgowzyFIMRIguBT5HTFCUb3uY?=
 =?us-ascii?Q?67HE+Nz7HKIrAodJZmV8d5kajNRAEMwkYK1OF+3qfDuJ3Lf4RjvFn62VuSoR?=
 =?us-ascii?Q?SPfBo8oepSmRkXl4J7kB/NTKD05HaVBaP9TqklGQBzQijz2cgVBSFqYv6kxu?=
 =?us-ascii?Q?VpHJjBrHBgGCVWz1xijARqTqcLxuET3bm2VUa/HqFXGU3sfYxNx5MQ00kp+C?=
 =?us-ascii?Q?b6ZkTFij5Xxi7g/oy6DGZZq0KtV6IbtijjwXDdXJ23EB+lJpRiOh4DoVtgem?=
 =?us-ascii?Q?Hwx7bg713BTy/+CFX4lo6NznF2UmQIe7ksVjVC9mZrncBDZ+bHbV+ZCzK4i9?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Py8uN5rma5n5KmlSK9OoljcEU4GYlcYJb+24KjdWIgZIyNWO87jfXcIeV6v5xsyBB58hqOsob0PqcW1BnI9yrbQ09b2pu3eWD/xpFjzvEZdHt2JEDCHyXNHPajSNDuS7DNqmwuQ4QkXyppehXaaawa2RvbH5LK537GHu3dRNHwqXAhDrFSO5XyjwdmOgn5RNWpZcSw+VB/ob2nuu9bpO8aVLDp961VRNvFnbv+yJygdvSX2S8kobp+eUDVvYGffy+7BuE/h8GtHwlx5lDED2knCNrwiSdzu1QOXAPXfCEgS4fcXsSrlr/WSbbU6eLxW/8WUV4GSP2DbwAvF2W0ANg89u6cNKobzIP0JZmcy0Iz9cZUIwMsEh0IJt18WCMIaJMJ0FXG4GhwKm9tcIifPHQyRZ6tzDZtw/Pv3bzPM73Uh8Nf0wLqcN4aAWBb0vfOs+bPEDKGVfPws1Eb3apnb/hvYGs/i0csBT6yww89RjefE8aQt/44h1FB2PoaMbIcgdcDc1znEYVrzMGi03/qJ+LAG63WJpspppIL4Qde/F7GohekIpKYyz7ESrMB+9z4v2zhWLTJF6cSJr7ee9RnzQl2TRSbSiHdRKX/zUxLjz12U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c06827-ca94-47c8-39ca-08dc9f4b8d71
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:43:22.4931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: de8UyH39ZXgRkh81z9dYYOhBDj8nmjSenVyfjFBD2nbr6s5HPqcHp3jKZpazoo5rT594O2XyJ24TGo9ZBm9840Jsr5vE2r7Binp3c0SszJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6103
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_07,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080096
X-Proofpoint-ORIG-GUID: 5nElWvVjwJVnlJnKsCY3Pz8RuvxXF6oS
X-Proofpoint-GUID: 5nElWvVjwJVnlJnKsCY3Pz8RuvxXF6oS

On Thu, Jul 04, 2024 at 02:27:17PM GMT, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Change from nr_pages variable to vms.nr_accounted for the charged pages
> calculation.  This is necessary for a future patch.
>
> This also avoids checking security_vm_enough_memory_mm() if the amount
> of memory won't change.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Cc: Kees Cook <kees@kernel.org>
> ---
>  mm/mmap.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index b14da6bd257f..b2de26683903 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2980,6 +2980,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	} else {
>  		/* Minimal setup of vms */
>  		vms.nr_pages = 0;
> +		vms.nr_accounted = 0;

This kind of highlights my concern about only setting some vms fields, now we
have to remember to change this in the right place or happen to know that
init_vma_munmap() will be otherwise invoked.

>  		next = vma_next(&vmi);
>  		prev = vma_prev(&vmi);
>  		if (prev)
> @@ -2991,9 +2992,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	 */
>  	if (accountable_mapping(file, vm_flags)) {
>  		charged = pglen;
> -		charged -= nr_accounted;
> -		if (security_vm_enough_memory_mm(mm, charged))
> +		charged -= vms.nr_accounted;
> +		if (charged && security_vm_enough_memory_mm(mm, charged))
>  			goto abort_munmap;
> +
>  		vms.nr_accounted = 0;

Is setting this to zero really needed here? We may be done with this, but if the
vms value represents the 'unmap state' of this range, surely the number of
accountable pages remains the same?

>  		vm_flags |= VM_ACCOUNT;
>  	}
> --
> 2.43.0
>

At this point nr_accounted is no longer used, but I'm guessing a follow up patch
will remove this? :)

I was wondering why you used that given the gather function also separately
calculates it, but I guess this answers that!

Generally this looks good to me, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

