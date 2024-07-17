Return-Path: <linux-kernel+bounces-255265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C769933E2F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17DAD28470F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A336B179A3;
	Wed, 17 Jul 2024 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ip4pIId0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pXI5uHL+"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EB8180A98
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721225288; cv=fail; b=U4JCMivZnVx79cf/5GiJZHiksSe4xTu8oaGkR0NstC6bFhmFlYFSB9eDkEp0cvo/+gg+9Pkba+C8bJkV0sre7U6HdeXnrnjT6JEUD6x6uP4As5tyKZ7yuWJE1PgfFa4fHetlzMepWkxeLLGUBlcDGYSH6thlCsJepH4aI1FkAqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721225288; c=relaxed/simple;
	bh=BP4ugQ1Hogmat0Px1sYVmydF4W+s604o+FG2SN3c/wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fgb4cLeTV67OD+BGQDpRw69p8htYNOwUoPY0SRZN5jth0iI3ju6KF2i/Vxjz+vsl0gCo69iID452RMyDopgz2TywClL/+WoN231a+Ao3XBEkGGhxFO+HCpXZAVA8ewxQ2/NiB00NNNvSA0kBByASFNpE5vgt7zFhZqieoQKQ3P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ip4pIId0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pXI5uHL+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HE5YGr007750;
	Wed, 17 Jul 2024 14:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=aa0xm250JroL6K5uRfPcuMnV1GfuhH1vPy5EdaE16IU=; b=
	Ip4pIId0DlE7QMgF6hrLxe4X/oQv86SS/nGiOmoCz/SoH9wYUMkZkVbszwPYUoaE
	Wvy8x4y8Fi8/YCFGIeUARpR7d+rTrM13vSq4qbJ5UWyQvxxdhTCrbTeYkKQzUtds
	oBACABQ6qr4gZi+P8FXJ6LGQEmCxevGBhROPtabM0Yd2aGs4PgMB2wLuIooB/Rur
	lLJGhr7lU0TQbxbPAdpOBX95CaA+At9fVeebHD+ducrdgV530+jgUxYMTvpZGIcv
	v8OlJOkjLaaVjxyhgB7AVRxUPrqGYQsa+iH7wph6H3Dvn6Los2Dwwz9zIME3KMIJ
	BgYKH3czr4Ie5hPiTZSfbA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40efdm009x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 14:07:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HE50h9039536;
	Wed, 17 Jul 2024 14:07:35 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwev38gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 14:07:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhOBp+QgA1zuznj+b0sZtIGTiQgnFbJoRhsK8My9lPek0+RHcMmnvIKxZm6sjTBASFoUPKWiwmE5M2SoYR4MoIg+rYZObA32b7aaujr76UmEGSK2AqwI8sVCOl/kG+RLLqbDhUWyHMdRxVX9oFQ7Liup0CakMDnoyEh1k0GqXKLU5faW/TZMf8CPPF75koBxxi4T+EYr+L1SsnTK1zKRkWnSrX/4fooxUokDIffUw5NkuHe+PYuERdLT67/RVIvok+E7UoUsoUSh5ShkY0IgRRPyMl4FZMgfTMsh9E0EaFv4AVeeQ/c7DwP8W6Uvx0jBkLY/zRls56uWlCcrKn+p5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aa0xm250JroL6K5uRfPcuMnV1GfuhH1vPy5EdaE16IU=;
 b=y/GXctS8wHsZArsk4EGFaY32IeTKtkA6EAi2yeJ5Ja7gm18dn0Ye/mAWhkO7lknKNmD4hPA9OB9O26mP9NT54jhwHBjuvGdMB0tmLRs0kyVYx63xaPiXPpIIh+EwPz6ZwI9Bui4uvj0+Vrun+0S9l/T829IAD5U2ScfayroeiYpHBlosmV3YvZJwU8Kxfzc+DD4+PgT8gb2lgNYaPPSFF5Oi4C63hJ7CknBTngT9NY+5t7HrsaEAynHeqI01YNJSPN+vCXOBNtMHSqLzdob0vfEU2FXUiW0GqZLJUgkEh8ObRxy3tGW2G5rvCAGy+2eWijZHI+SVBCCtgnJfofMYnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aa0xm250JroL6K5uRfPcuMnV1GfuhH1vPy5EdaE16IU=;
 b=pXI5uHL+i+Vb5Gl3KGMpCdLdqL/Jw5dU1tIIF2smZwJSLRZbWq3rjydukFW96TfskgLz9nIdSztTmnhD2m7f9ud6NgD+Szdi9l9J9kNp3aGj+PtiubG4QJz6rT3enqmji0q0jY9A7FmCsm0KK+EBYfFQ0z5haFJ+X0ToCaySgPc=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DM3PR10MB7912.namprd10.prod.outlook.com (2603:10b6:0:43::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 14:07:30 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 14:07:30 +0000
Date: Wed, 17 Jul 2024 10:07:26 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 18/21] mm/mmap: Move can_modify_mm() check down the
 stack
Message-ID: <ttl2yp5nyri23keuzfwfywsgttglpzxizm5itjtftnlxmqnruc@4qyltsy6mqjy>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@chromium.org>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
 <20240710192250.4114783-19-Liam.Howlett@oracle.com>
 <CABi2SkXLM2oXNLz-kMy=3LWJjkOPGbS2Vc2P4nfZzo4r=_MUJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABi2SkXLM2oXNLz-kMy=3LWJjkOPGbS2Vc2P4nfZzo4r=_MUJw@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::31) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DM3PR10MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 416f8e1c-bc08-4b5c-d6e7-08dca669cba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VmYvUU9xWFo2M1F6NlRBMVgxMEhCK09rNCtDVHU4Y1VOQkhlQUdiSy9RcHA5?=
 =?utf-8?B?Zld2Vk1kSjljL2hLYnBRN3dLWW96OThuWHh5MzRvcGNkMVI4K1RCODJVUUVU?=
 =?utf-8?B?dE0zeDVFMUlrOUw4OWdiN0pXdnVLQVRvZkRxc2dvRFd4c2dFOHNnQU9vODB0?=
 =?utf-8?B?OUQ4ZDFpQ1E5TFJkV2JtZ0Ixc0cxVnprYmNMQjFJQTZyODU4Rjg5c0MwNS91?=
 =?utf-8?B?MkRucW8zUGx0YU4yU1Y5RFdvOFdwZ0tEbTVHSlRmUW5hSWFvZTdUMmpoQlFq?=
 =?utf-8?B?UU1ZYlg2T1dMUW9HS2Z3OEFzdmNGaEJDQmJiWlJNa3U2bXNmVUlMQWExZUpx?=
 =?utf-8?B?bWtjRFpaV1g0Y2lMTWdSY3J5bjQwWmVpV1o2aVNFazFCSm9IRWJMc09SZ1I2?=
 =?utf-8?B?TDh2MXd3cGV0MC9LUVZ5MVFEMENJcWRhUEkwdXdvWlpqVnRjZ2pkUktHdXQ1?=
 =?utf-8?B?SEp2WHRUeFlDUWt3SVZVV0JSektaZ2JaVXJKZlpldkhyNmxSYkRndnhWbEZR?=
 =?utf-8?B?QnBxZ2lxY3hFR2dsODQvTDdZODJ4dkVMZXN0N2x5Mi9LVU01VDU4SjdsdHRu?=
 =?utf-8?B?bWhzMGNhUEJSM2tOamZNWTI5cmpncjhjZkoyb0tuL1pFTGRGSm5seUhMRWJL?=
 =?utf-8?B?bWdwNUxJeXBJRkJ6a0tXbHdhdExmeUJ1YkluRmpqd0tyVDNrd1llZkR2RmV3?=
 =?utf-8?B?QmNmZ1BjVjd0QmYwUFAvMmRxanJqdzlXNmE5K01DUUtuYjZMYmRVeURReTdW?=
 =?utf-8?B?dHhwUVoxS1NHMFp3RG9HVkNzdFhZNG04NnpXanE2Z0tRVXdxNzUyaERsbVhR?=
 =?utf-8?B?c0VNNWdSeFFYeU5oVWwwL0MvbXZrTTVDSFpLenJWOHh4YzRpbWdKYVpGL2NN?=
 =?utf-8?B?WXcya3hZbHpGYWhiU1NHQnl2dTdSa25kL3c4cEJHdzhJUVhNZThrVXRwN1Ju?=
 =?utf-8?B?OVlzMzRUYnJoVVNXWkxneTRza05iOFAyNVcxNzVCbzZiaVNGMnJXdWhwRlVo?=
 =?utf-8?B?enlMRE05a3RBa1NWWk85ZStwcjZocEhqS0o0azRjWEgwZDg1UWJNR3NpSWZF?=
 =?utf-8?B?OUFUWUpLSjUyU1psMk9KcEZpYVg3Ry9mem81M1Fqa0hUNEhXcE8xM2VPK29U?=
 =?utf-8?B?VTdhbUxvSTEyVU1XVy9mTEtLNjZMN0V2Mmo1eDIxYWR4T3ptSnFKSHB2d25U?=
 =?utf-8?B?VUYrQy90ajhES1k0bUd4SUZ5c2MyNGsrcVZUQVJPUy9LNzFuVHNtbVJCOWk3?=
 =?utf-8?B?MS9INU9GSmd4cWh5cFNMQzlDUThQNnV4c0I5S3cxMjRMam5RaTNqSkhwS1dQ?=
 =?utf-8?B?VlpHcnljdDRYc0dTMWYvNjQ0QUNoNkdBa2hDcWRTVzJOOFJZOXM0SFpHZTNQ?=
 =?utf-8?B?OUpOUk9kbWh6TmtiRDV1cy9zOWYyZE5LVEh3NlpDaW9Ga3hDU1lWMkpEanZy?=
 =?utf-8?B?aXdZYXczb1F2b2o0Vi81U1hVbC96Z1JkTnN1bm9aWG1iTHQ1akZxa3NqRkY1?=
 =?utf-8?B?WmpseUNGb2l4TVhiZ3ZtOW5rVi9mVmZHb2hTNnFtTkcybU5yTWdicXNqMlU0?=
 =?utf-8?B?WEFnMnoxMDhHTGsvMXNoRmlQS2orc1lvSkovSUFuREhvQkdzZjUrbXNINHdF?=
 =?utf-8?B?THJxUWNVa2ZRVU85WGpLbWFHV2ZLYmRWdkFtNFQyRVlXZEhqMEU0ZTlZUFRx?=
 =?utf-8?B?M3RESzl1eDFpSTVId2RjSjZwL1E1cG1CL2xXQ3ZEQUU3NXVpdFFlSXd1azhM?=
 =?utf-8?B?cWxnc2ZwWkI3RC84YURuTU5tM1cvc1c4SG52L2hPSjcwY01CNzN4SEpHQjdm?=
 =?utf-8?B?dmtabzUweld0aTBuUWIyQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YlpMTUpHeTRyNnQrSGVZWU9kTnpzWmVtaUt3VmJ1b2VXcnVuOUVyOTl5NDFy?=
 =?utf-8?B?UE52VVdVbkFTcG8wL3dHeERjWHZZQm1xLzAzcDJoRkl6TW5zMHpmaTBIQVpw?=
 =?utf-8?B?YXV4NUMwblBlbXRxcEhUOFRCRzlaWURndUxhcFE0SWh2YktNMUlFQnN4ZmJ0?=
 =?utf-8?B?R2p3eHFSekZac21JRGxLTDdsQUxJOWdmdk5Oc1JaYmhDODZkZFErV1VQbkZy?=
 =?utf-8?B?UkNUbklISTRIUjh2S1ZyUksxcnJJVVZrL3BIVDIxNmJuYWV5YS9LeE1wYlZa?=
 =?utf-8?B?OWwxTFRtSk9TN3pLR3FOdzFTZEp1THd2bnkxaVNZUUtKeFpHcVNVSjY4R1NY?=
 =?utf-8?B?TmMrVW5LMTBpZk9mYzJNNmlBNVd2VXlRSXFFMUxsSFFaR3Fab3loTmw2MC9M?=
 =?utf-8?B?bEU2MGc4MC8yc1JGUmE2NFZzTEU1TlE4dHNnQVlIRjBhdlJVbG9JTHhPSXBa?=
 =?utf-8?B?bXJ4Z3dHOCtlZGZqbHpwVDh5bGxPZVZMNUg0NHVmUHJxSGEvRmM4eXZGaWFD?=
 =?utf-8?B?L3hJbVliM2l4eFlOL2xENmZHM1o5bW5ra1dHenI0cVdIdlNJWDQ0aG84dFpR?=
 =?utf-8?B?U0RFc0pMZHRpUSs0TStaUG1pUjk3a0J5UGJlYWlxYWwvVzVDMjd3NVg5SmpU?=
 =?utf-8?B?V2hyU2VjdkRnY2ZkaHp0RWhPM2hVc3BhZ1ZPUmNQR0lFdk9VcWVwcUgrUFdx?=
 =?utf-8?B?OXVYMG5pbFlMbHo1RWo3TUVaOENZeklwTTZ6T2dIclZ1eTZlZGUrVHM4dnNZ?=
 =?utf-8?B?SWpTSEpGalcxNUxzQlRpUGpFVjN3RjF4WVI0OVRFd0E3NTg1VWpjWld1MWhI?=
 =?utf-8?B?L3R4SlRKbkZOaCtsOUFpeEd0cks1Nk5nYnlJMWMxWklwcDNJMVJDOUluU1o4?=
 =?utf-8?B?R08ydmMwUys0U0JUUmluNG55L0d4Q0o1bDNRY3loRFBpaEwzS3ArSjRHUWhj?=
 =?utf-8?B?Tm9uUGlxSzlrVzNVWXNUSkdXSmFXUnFMQ3NaNEdUZk10MDZTMEJoVm1vKzR4?=
 =?utf-8?B?R1FLS2JIL0x1MUVIM3RSVUxTSFR5TzVoNm1aWXBiVXRKSzBLUjUxcitvdlgx?=
 =?utf-8?B?SHl3WXNUcFIxWGhvMVkxbDVKa1p5dFZMTUo4a08rR2ZlVEFnZ0xnNzFSQUJX?=
 =?utf-8?B?cWVmcHExNFJySzVUNm0zaEpYV0tEMDVXWDVJMGhmNVhMelZwVDJBL3hzYUxo?=
 =?utf-8?B?Y2V1d0kwSEl3dVZRMVRmYlh3Y0YyRWZDK2MxNXpnOTJYL2MrdFczS1pZWjI2?=
 =?utf-8?B?a0RZYmd1TUg0OHNlMEJsazNNZUdSbWpFT21zMWI3Z3p2YWtzSllES3AvUktW?=
 =?utf-8?B?ajFyaGppcDV0cUUyd1d6b0JGNDR2cTlQZGFLa1QvVkV6MWRqV0FiVkdjczRa?=
 =?utf-8?B?RkowcjFyMUo2ZGl5V1lMM1Noa2hDSm1kb2dQR3NJTldxeDFraTZ5RTdKQkpn?=
 =?utf-8?B?S1k1ZTd2MDVwMC9wMnBYcXFSZ20xNUkrRy9KWGo5VHJ0a0VMNU9mV3RUamUr?=
 =?utf-8?B?RThQVWpGVVNrNE5pV3ZpbnUzRFV3aDZacG9uN0thTXVlOVZ0ZU9id0lNOGVT?=
 =?utf-8?B?WlRNVGlPcHBDZjRYK3NMWTVWQ3owYnBVVVE0ZXZmcVZCVHNwV1MzaU1nK3pV?=
 =?utf-8?B?cVlRL1BuWW1hVm4zOGpxOFVJMkU5Q1d2Uzh3a3YwL1h0Mzd1QXJKdEJSK0w4?=
 =?utf-8?B?R0hCZ1VaMlhmQTk2WEpzRks4UDFyK3FPai9Mb2llelo0YlpsZUVSalhURUw2?=
 =?utf-8?B?U0xRYllBOEwrZUlvb3cwYXBCUDdYcnVIQWlPTkp4OTFiSUFJT2hMQk43MVYw?=
 =?utf-8?B?WnRVTzJON1FBYS9ZeVovTmVCMWRpa2ttUDNOWWZNQWN6eFJEd0tIeHFNV1Jk?=
 =?utf-8?B?Um9OY1dQU0hqV2ZLUXBveXRYM0xTTExJYXhqTklHc1Bva0RKSUZTY1E4dEVK?=
 =?utf-8?B?MlZycE5yNm1rWWJ2Q2EvZVVob0xvNW4xd2d4STdOVnJoR1BhNEpoU2JyYlFz?=
 =?utf-8?B?NEIrU05YeFRHNGtZcUZCYjN2czlzRmFXaWN3dnN4WDdiK2RheCswZVV3T1pi?=
 =?utf-8?B?TnpzQmc2eElCbStPeWQ0OTNvRVE5Y3VIS01oR1NhSHFTanBNRnB6ZlFMZkUx?=
 =?utf-8?Q?EnHdJ26BBgu8mAXCHPNcHCZ0z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MQed6NOf9hO8V3c/2xehkWcmUZ7VOnn7g1T6688Vsn3gV7r2FsUxwmTZzVEE0ah2vxRfnDjp8NRd5xD56gbVXEM4mapkLTZi3b+oIIJBNQyP8sB2x2O9rk222Wj13R7td2RUchBqpeKscvz226VD51Z/9hCOEniJ3ZSu2KWCjKGXsUFp6+QFMnQHDlrdOEtllvVdhJfvrBXcdAvb0QUaxiDnxUv3Vmt8DwPOLd61hIHcXB6p2IHrcehmDiM0BTj/KqQiw3HZaTjwr0e0l90QXQdhj/pIXDGq/jIx2xsylA1WpRKoLmlXI3G6HFa3EieX+Wh4rjK9DO+jbsIesO27i09fZn9hMro50skpHmVxZIAy9/aN9ACGlbth3duc3jovn+UVwWp2iN4TlNgeHHiwoDoG2yi/cNjRkq2AaDFbI9HBWg+XUR+EotxSsfWm+L+RTIMrY5jmdBi4LG0T9uopvkQFXc1XKEbR1oj+65LPiCT3/hP//97zVg8X0tZlLR6exQ8EVlhiXsFVQhe0H8R6guEYj9dyw6DmxkKxIS6FyZlY2TGcnXE85b6VzNgId1V1c7gE/5TEJfZAnKrDBNH3GcvjZthWtP9DE/BxQS1bTa8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416f8e1c-bc08-4b5c-d6e7-08dca669cba8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 14:07:30.0566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXGzYKWbyL9yw8MalM9UCp2y9iLISTba3vjf8novSz4vocID7LDMsjdybxe7St4i8MKnRFMhrcoS1DEGhev/2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7912
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_09,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=979 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407170108
X-Proofpoint-GUID: DzGZtqgO_pUFJHKnlsDoSNxH6JWv5izK
X-Proofpoint-ORIG-GUID: DzGZtqgO_pUFJHKnlsDoSNxH6JWv5izK

* Jeff Xu <jeffxu@chromium.org> [240717 01:03]:
> Hi
>=20
> On Wed, Jul 10, 2024 at 12:23=E2=80=AFPM Liam R. Howlett
> <Liam.Howlett@oracle.com> wrote:
> >
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > Without an arch_unmap() call anymore,
> Is there another patch that removes arch_unmap() ?
> Can you please post the link for the patch ?
>=20

Thanks for looking at this patch.

The patch to remove arch_unmap() cannot be used as powerpc needs a
replacement.  I will be moving the arch_unmap() call later in the unmap
process like it was before mpx moved it (mpx has been dropped from the
kernel).  I will add you to the Cc for the whole series next time.

Thanks,
Liam

