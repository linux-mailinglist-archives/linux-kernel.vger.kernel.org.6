Return-Path: <linux-kernel+bounces-555944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A920A5BE9E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F3416DDDA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74874254843;
	Tue, 11 Mar 2025 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PmF/w/6i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aCpZvnSq"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6C1238D39
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741691630; cv=fail; b=XD8InCfd6bv/vwcQtPegVvDVYMCEZP8VIZ/WYsBz58u1AJ1N2Gjogukj2si/ffJScX3Mi1Ao5f66+l+Hpv9cpkZORIrN2P40pW56iUrqLYgYsE1uyxOnXDiKY5C51jIABX5zuhX89m5sKacR5if19m+VD9bCc36aMEtzyJnVBLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741691630; c=relaxed/simple;
	bh=bDNLxfmxvt2eyfet6JtByeHsE4fEI1CISbg6KbpU51c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GZzu+VvH/JJpUesmKq0JDpUA/il/GXD+43PEiGCNoA32+68rHCsbV9X+HbgqMhulUwVePjWeCR5WQ11wgzNadKnmK+4bcM2y2a+xg0FfDYj/qq4u1bEypwczXedcUWrHukzkhipwmGx5t+65CdAnne3RUk7d48PtEr/8DZ44vYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PmF/w/6i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aCpZvnSq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B1fwYe021471;
	Tue, 11 Mar 2025 11:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=e3+95zkgFlBsHCTYsc
	6bYkN8GpNM4vSFwbDyOiEMIOY=; b=PmF/w/6iP2+bLpUMdM2Ek/OSSPkQg7KVYH
	uylVodIZ90YPIsCeI4KBIp8V72tLYtu7h2kSRH4jPZ7NyvrTD1S0YoR63n/q8jI+
	7bC8qarzJ3GxQpkqw9uIbbwuAN+zwvYkTincK2ydAI9t6cVvJ8t9siSUjaxiAxTQ
	WabgkJFHk7P/zd7ywMoz3uFBlCtTrBDhXFxGcBk9heIl52lg/MACpBkmw0sp17D8
	+L7zzTH6nAKD91UCDUuLtP6lEQ7Yy0/2kWUcklfG61uUmIJvGBWEHMsyv5w/O655
	Lefbn5LUiWNsI2yfu2jWGkbcVaHuIu8o4HfdeBSL/ddq3dXEKrBg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458eeu4jmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 11:13:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52B9kQrp030661;
	Tue, 11 Mar 2025 11:13:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458gcn7uu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 11:13:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t87LeseJapshMo7badHKJ4OYfPNFsoWXvu+nSDBBjTglO25kjzy3znnayyjpLVcl5l1voJgZof8WO98hVJCrfbaIvZ1LcUtsI6z4Ld009NUNZDQnB6HP/v5FEY+4H6sIHcwBKwlFLiWafWrV1mPYV5P6A/fYO6iOgx9g2PSg5UbDapVPTxxnEqXFcVnQuRFU3mXRfnHLLFjVYr3vo5ddVLFqljsrwOD7JDj3ww0m7zd2L7H41ozmwWSQP7gAPzcCEzEDgT6L4T7vLP/c0SG6JD4rZQHziwarG0E4GjNfyurC6A7ycrY0higZU9L3pw4cXqYwiYYS3SCH8ylC6ryh3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3+95zkgFlBsHCTYsc6bYkN8GpNM4vSFwbDyOiEMIOY=;
 b=W+uX+YnSDWRygoztizX+0/m9kcaNcEmyl3JSw4YH10eL9XQjG0uQjiziEjZATHHiFD5Qham2brK9xftI9w3vEIBQYqLrbQKhodhwduExvekPeYgjSpXJX45r/ZPr3fS7Mf4orCo6SAMZbA3i9fLGOXa/POZlDZkHo7D+uzY2dCRS03AQ2JlpnUITs5Mjhv/QSw0W6+N/HzVownVA1txe1R4EZ9WNl7DIY4MuNbph/hFkiA+B5LQWp5te+ig5c1YAYs6p3z1PUy9xDWAZ/eimzYkUgzIceBAd6dbtvCg9+mzZ+T52JLrB/7JVzOtFn3i+aMgLYL9yP3XfGazhndLCHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3+95zkgFlBsHCTYsc6bYkN8GpNM4vSFwbDyOiEMIOY=;
 b=aCpZvnSqnOTPfuLUwrVIdEccLsLt3Ew65+0fMpQmXBk+PzPrMGuUUNeFU3pP91fhv3U8X4z/0Le6IcDPvAR4gntJBKPhOURPE3EXK6DtSHUJSH4yoC3FuIMaJ4tCManpfeZcRZJXJ3jwCjNxoR8gU3e4kLs3oeggWRU3ifgT6Zw=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DS0PR10MB6847.namprd10.prod.outlook.com (2603:10b6:8:11e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 11:13:20 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Tue, 11 Mar 2025
 11:13:20 +0000
Date: Tue, 11 Mar 2025 11:13:13 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fork: Remove unnecessary size argument when calling
 strscpy()
Message-ID: <05250cea-4738-4bfa-a669-a81a64d3e82e@lucifer.local>
References: <20250311110542.495630-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311110542.495630-1-thorsten.blum@linux.dev>
X-ClientProxiedBy: LO4P265CA0323.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::11) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DS0PR10MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d2736cf-27b1-423e-7d70-08dd608dbad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TN1yTHS7u+bntiz2H+xDQF4AYqI/GOSLJda9bIA8XrDbue+v0cCzZpNyioa7?=
 =?us-ascii?Q?J81WEVg44ffbk9NNeJQolSXaUP8Rwhcp4+RkSIaZsRnTpg5nnfEF5VND7K2u?=
 =?us-ascii?Q?1t+RJ1+CzYhh7rswDTj/HKWdG65a57SrqcnS1+IFyCoJ4aSa4E7YqzbuA5Cq?=
 =?us-ascii?Q?mPdlHQfGRiE54qXG4VnnuVJZ81KIZ31h0Z8HHvqykBNn4lGf1U1bp2eqE5SR?=
 =?us-ascii?Q?qiQ9i4y3kYrgwNK7DfzWQbErWmu+4pT/if0o5FfivSx4Z0jV9kC/9DNjy7mS?=
 =?us-ascii?Q?MYmL8+MrKNYIsWbIQYLV2DeO4aF/dmmifd2cRn4A0/vv3hv/PYOOVsi/SmPz?=
 =?us-ascii?Q?VZY8OSMJidYwY0VuS47XDcU9SpF0zMzjxHIbKvSwi0bK++MwvK7n0ZVuX1V8?=
 =?us-ascii?Q?U+rS5/buDgo48NL5YMYR89cQWiN8lAW7YZv+xEfIYciEVnPdOdHGiDz3Otve?=
 =?us-ascii?Q?8nxs07C2jwT31084WLhBWFTvmpFduZXD0qr9a7oWMjt+wTOJrcG2yn5lqiiO?=
 =?us-ascii?Q?bFo+fWtqVv/nszZKR84smu/kh0//IjaUb6Eb5HizmSsggJQmOdse5gVVWf2p?=
 =?us-ascii?Q?Fb1AJwIp1rxAXZsS1sL/cjROgTjM1m+TtJE+RYgR16aXeQE3dJv6/4ne1RFp?=
 =?us-ascii?Q?Kml4pJ2FDEaM4Y1jN5/aLc8E8SsMdSSVX33i3pNE2LMZpJrzIoFhT5ZqVeit?=
 =?us-ascii?Q?CK36StSvZcWtVA3rxzAvX52ix7/MjCRNB/DvzQB08g6QBpb4jWxru+MTnpWd?=
 =?us-ascii?Q?JuyFOl1hICvi1HAHo69LktCAe+xJZMqbWtHxh0GUP4hUmtsiKtnkAuLmxg3l?=
 =?us-ascii?Q?9dVMRy/7UMydhPnIhiuh72ls+N9x/JSLTjxEvVnaSMV4ZCcz2jkeXxDF3MYW?=
 =?us-ascii?Q?F0BwjNrcQ9zBc9jGDjECUUOg8w+y8OsYkuXHSux90DHhVbWh6kuvQ3MWWbom?=
 =?us-ascii?Q?LvZLE5+qKekUCgp4CZAzxMWWKQZBOSSM6dd0lv1dG7gAcbSSxXxTccg7edYm?=
 =?us-ascii?Q?6nbI4WaKMSBc+fRQdjYgBmOU33Ordj7IqD/wbhMHISwBLq7PxwHjuDMzLLZB?=
 =?us-ascii?Q?mMXeVQwMN2UMWjpHU/zESg+CDpwBlWJQCyVx6AjTzEnrVNW5bLv11J1LFjE7?=
 =?us-ascii?Q?k6jpDk0PhTWBpLSS4pdZumQtnU5YavnFMOuL2qDBoS/vpKmGhKmM6VoQ2yie?=
 =?us-ascii?Q?ZrScdS00VBVbHhUDlC+NJkp9Uhp/VUwbPyVHHM1G0cygIO461js7vVD/DQ9o?=
 =?us-ascii?Q?hNCXCqjNYxXvVMDILoJUHnJR9mrRLxqb5kGeOFcDhnLwlzl7jDFyDZM4Tk5L?=
 =?us-ascii?Q?8mKAQtODvia0YBBC6qW436soyDwgPYLuzcUkhhrvmaJuZTOsvFKAelq53qHa?=
 =?us-ascii?Q?wR6km1APL+NjCznONcxAOGGQ5+7L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+OmrzZg1GJkXfbe8TMrGDRY3BEIm88iPnpuDB7UTtAn8XrdTHv+VyjB/n6L7?=
 =?us-ascii?Q?losTpkgpQi4WNm69gHDQTglj0v6hWMqns0MsbhGQ/wiiEE13MmzCvhFaf/br?=
 =?us-ascii?Q?aIAxtCe0H8YgrvroG6jNQW5xpBnSsGSNKwoRbG4SSMoBvhTIjXD1PKChhrL1?=
 =?us-ascii?Q?qrrg198vq08bnBReT180Dmp9ZgUZsSaK2wK1Yies3gYiUzco+Fv+5FkNiXFF?=
 =?us-ascii?Q?fcCNil26u8PortdpFi9tZgmR4JXZT/S7uNXnr+5tUGom3fFCgDrOUVIcQXDv?=
 =?us-ascii?Q?PNYDD9ipaFFFUY7usUbWyEqFjAHlY60HJsC14ei5IL+9v5CGCS4W53ZRt7by?=
 =?us-ascii?Q?77kSM9sL7CAsBDT+bOR1GZJ1A8TdvOADWWnvFfibfj7regu3f0rH7vw+P2cs?=
 =?us-ascii?Q?E4eOFxs+lO3Ye6jtNVrTiPT9MkHNS4K7KPfTYIvTutIvfmQ3Nr2RhMhKpNci?=
 =?us-ascii?Q?fPAPiGgviB6jmheGVM4scRdKObkIn8nK9NqesArixMls1vbXy3oiaXnOb6cA?=
 =?us-ascii?Q?UkO8JvSZpVQgHMwQ4bc56vI0reVis4OPm9RranxfzAzMJNFaYT2J2T0LbUF0?=
 =?us-ascii?Q?pCa1cKD+EDh1vr/BkxPy3glXO1Myo4QY6lDKNRh7DudkD9XxazV26tWBMXoz?=
 =?us-ascii?Q?UVCmOBj84TqLOp/gPB/26l0U7/uBUqHDy69bjKiRQAqxl0I4nZneExHC8LO8?=
 =?us-ascii?Q?s/40hgtXak0SHdbFEmuNbtWozDMJq2BTU7mkf6pu/3BlwFd6Ipe18V79BV1M?=
 =?us-ascii?Q?pkYQLTEHvgAY0plk/CMS1lP920oNfHkvyUYMGUFrI4yetkKyRQBuLCjUsaxk?=
 =?us-ascii?Q?HlcY79T0sywmJstAt+I+Ll+pcuAlfstefMYEiweLFNZ6DPwcims4VXuuFAlz?=
 =?us-ascii?Q?6wxqm5j+ntUVaJvJYom64v0HdFtRkjRs20uwyjGKvqUCPK7tx9DvKjRBVNdU?=
 =?us-ascii?Q?68ACDiCj5T3znz1FqEw6XvVhfXAce1HkJ6KAxrRF1HfRHG7nWbagjIj+by8a?=
 =?us-ascii?Q?LCs3u2cDWL7GyMervl69+TbXniQxX3r6pT+ZeZwo5kSmjUeF5/z01bSKBCkN?=
 =?us-ascii?Q?QbwBR8EGJodBuOy07Vl0bUeC0E2eBM+bUO9e84bDmO1+gwHC87GLLLmtD5aJ?=
 =?us-ascii?Q?OfxIcWln9NYWLrmBwfRqq7vaCdb0d2oPYOQhhVfspLWSC3P7hlN0rCBiIi8E?=
 =?us-ascii?Q?y+P3e5JakdMoMhqnXwJinfEWLDz5dLH1XTAzkmLsjr6o3qMDhOJk8BRNs4mc?=
 =?us-ascii?Q?esr2xWqPdo8hAmmneTmgBPt+EoajqbJe7GGh3eDV7tURNBCxMLkuVjr2IxD1?=
 =?us-ascii?Q?Tlsfp2QhtaFLl9Gi32pwsN31S2YgWn0s2pcQMOk9ZCzF1mlEJs7+fDW1eBMW?=
 =?us-ascii?Q?dWkSw+36dohXz3quRYCL+xtSFknR5UcbY2aLvLBHuemvKwFxm439aPdBDOHF?=
 =?us-ascii?Q?N19Q+AtGgjXiAV1mAzQlflHlCCbF2Dfwqr6v8HY+gy6I2gyFxX4YM9rVCzos?=
 =?us-ascii?Q?IY2mGjIBTfrMHBEP/6yQWBlRkVgEqb20UDmGpPMqcDpdUKvoLZjDb82bL31s?=
 =?us-ascii?Q?1+WATz7e6GFyleHmxpd0G1QLSolfvkLSDReewr2/16CrofOEsaORuY2POoU/?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rBvUoIUVC2Sw5jk5gRjDSwqzFFfxB/9NqARKY2lHQY2aPLabqFJGE/VmCZJSUrG4fcx5W2aqRP6y2rw1srwPqcFprv/IqtIRyYvqtp6NEnZyGWAMO3Pd5KBHNRxawltv+O4YcIPAmfR+H3rlF0KG1IJTixx6mpIpGQo2goUDcFwRMGu2v+21UqtMRbvYX1qhcwf2I8Sufg2161KYnKJXyzAFGqCfeWRpS+OWASjkOxIbp2Xq4VM6/FZ7TgtAhovI/QRQ1l8TDkDQFxxFXJO6owHxui0F+1TmcwH1iK1LMSmLmpe8q1MfLVSDVUOOGYiXHWbanO0awtzFhXKE/ME+rGCzVSYYH2D+NAY88LIDPqsRUf1v2lmnimIxGKdb2QjZAac8fWlP6lJBWtLqjXmbEZw7fAf23kdthpfRI7EViObsG931X6eNq/gF4kDTaj/aX46JjfXAtXjNHMqf6T8lxTLvhQsv3sQc2MHsbDgo1PMyGD4fsh71CbUu4hCK5ncncgTtSQPPEcVPvyWlRK3YvnY4l5sD1ZH1w6Chws2lBLSsywnrSzbUKZ24pE1iwiZazKTSmn/el2/gJBBw9sVEW92Iuq0f0u2WDuCJ8H2kuV0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2736cf-27b1-423e-7d70-08dd608dbad3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 11:13:20.0804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6oweOtMEzUdbeGLhQPsib8cglN9D97hfDio7j8Db8p3wyKTFhGXPsDxQv+BGAEjRf3mgGMAN2PWOKuw2b1KhN155mxVePTn+Kn/WW+u4M4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110074
X-Proofpoint-ORIG-GUID: 4IuAVgdQg_RaRbPzgFLcQfHdar80wS0g
X-Proofpoint-GUID: 4IuAVgdQg_RaRbPzgFLcQfHdar80wS0g

On Tue, Mar 11, 2025 at 12:05:39PM +0100, Thorsten Blum wrote:
> The size parameter is optional and strscpy() automatically determines
> the length of the destination buffer using sizeof() if the argument is
> omitted. This makes the explicit sizeof() unnecessary. Remove it to
> simplify the code.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Hm not sure about this one, it's not really simplifying anything all too
much and seems like somewhat useless churn?

It's pretty clear what's going on here already.

> ---
>  kernel/fork.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 735405a9c5f3..81eef131e23c 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2248,7 +2248,7 @@ __latent_entropy struct task_struct *copy_process(
>  		p->flags |= PF_IO_WORKER;
>
>  	if (args->name)
> -		strscpy_pad(p->comm, args->name, sizeof(p->comm));
> +		strscpy_pad(p->comm, args->name);
>
>  	p->set_child_tid = (clone_flags & CLONE_CHILD_SETTID) ? args->child_tid : NULL;
>  	/*
> --
> 2.48.1
>

