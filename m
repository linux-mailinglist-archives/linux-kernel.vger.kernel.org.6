Return-Path: <linux-kernel+bounces-244368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5759792A34B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D223282155
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ABE824B5;
	Mon,  8 Jul 2024 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JjzGlcQl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W6xtI3gF"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4AE3FB94
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720443225; cv=fail; b=fELP+PtLCRbE0HqZseQ1R/dxeLQ9shnweZcnVlW3UBtyY8Z4ewP6t9CcVVcS2FO+/csy9ltdVABRHHmVgJgMqhGFySrGfTUyysGcHcoq6a8PuEqq2dpfXdVBTHTSOnEDpZipbG8a3nT5oB0Oh/vvYWcqWLgqVF9F99pAQ00Q6wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720443225; c=relaxed/simple;
	bh=m1wLHD3lT4WWZx1I0ywG6UYs49cruGozWci3KD6/5Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NJNqZDGfV27U58UsR8eXYPO+C12pI32JxUorXP1LPstW+YhklcIBvv9PAzX7TI81JmL26+ZaWf9ujJpGYQXwxtcn3XItdmpwe3QUoJaF2avi9y8TmnQOcLi0FJkSwAE58GySgBktWEswiYcIdnBNKaKpptyCTRwJg3cfaaiqtGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JjzGlcQl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W6xtI3gF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fccW004442;
	Mon, 8 Jul 2024 12:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=WihLDam2zpygRFB
	V8/MyTA2mGPsy8creOeaWUz9QekA=; b=JjzGlcQlM/zprcWOuwEUuiya4lXqV3+
	7203v3ihRevD3Ta3345xZhL14Poybq7Vxc/+bXkPFvUfzdLrT9OoxJoGrIP/ernd
	Jb1WqcmnXkPBjcLcqL2MlfD5hC9kiQG2Vp2XXLvHbM1xzQLkiHNTv37LXQ4f9c7C
	+v5yhLfgNgHDeykTPyy+wQ3Vz64389y1htDmbsS2pS+d9Iy93qrO7ZBS5vUs/Ra+
	yefDpHPVo4j2I2/E51zJX2MLQy5yhMHnS4l5Jb1zmq6ygMKzYxRugICGm97GCnXl
	If7VcksJS2uck4vxYtJMWnuzFaSOvRcyIDHZvLXaHYAOEFtl0dV9OsQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406xfsjhvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 12:53:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 468BZFMg007191;
	Mon, 8 Jul 2024 12:53:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407tu1kt85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 12:53:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYySQWqkDB8pDKlLcpC7n/vgByvxgFxzQwYmw/yRf7a4cX/aT+repK/j/cePg89z65gAiq+01dDW7qqMmozn+qIhv+Y/OShSmRAXSpgDAuxNYKPKStRllTrfB1LJMmxwyfFWDjakYjiYPGmlru3/76Pu+XPItboAin/lC9OAmuE5se6mAzw02M7aBW+Vk3lxieAppgq4XI8yAdICMGSNLNv3b4PPQLeQvO2AqCYnLwIceNeJkzdy5TmuXCq0mbktK0MKJQocMc5sov+2I9BQfc2gZQwtjQNR1Te27YQ3MzIOs7Wx6EldxEpwyF8kF5OiUFN/AWNv7elsU1EzOX2SSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WihLDam2zpygRFBV8/MyTA2mGPsy8creOeaWUz9QekA=;
 b=jSJbG+ttwk7HTlWNq/rP5lbEEJQqcDfMIxJ12ZcVfzZWacgvPo86OoYg+mlUa1g5aPEEMiXmyWaHN01AVNeOQl1VI6uAjuLLQplmB4c8xtexVfUxMrunCpHvXiXCXWFORWbcRuFAvDYZ/JZfozQ+UW/nzK36d7Hr2XCVy89yVLc2KKoN8BU0lv4fPjm88afGSeznns1UFSc/h9uHJAyrxNYm+B7COcf8UULERjsYIm7tATcLe3kZD4ZxVSl6KzjmpzE1yITDsG9rV7opy7jVR9Lt6IdxtSydYancJXE3y9B3sjhE8AHjEHpII0VcH7VDhW5OzjK8wtact/qdG1U9mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WihLDam2zpygRFBV8/MyTA2mGPsy8creOeaWUz9QekA=;
 b=W6xtI3gFxqf48LuaQk8BVcR8pw9u4HSTxSLVNhgxbblT1AHML0+Yg55cgxfRE7Hn8Kx5n8XKhQgVmon4pjruG9oLmoe0ywHHxvCECy1C5aZgAdXW4woZ3D7hmWBY5ZXspry/ZOq92d5Hf9fJaZBdzQ0rASrFkZUtXdydlUVarbQ=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH0PR10MB7025.namprd10.prod.outlook.com (2603:10b6:510:283::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 12:53:04 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 12:53:03 +0000
Date: Mon, 8 Jul 2024 13:52:59 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 16/16] mm/mmap: Move may_expand_vm() check in
 mmap_region()
Message-ID: <8fbb424d-a781-4e61-af7a-904e281eba8c@lucifer.local>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-17-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704182718.2653918-17-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO4P123CA0177.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::20) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH0PR10MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: c828d01f-a84a-47ed-2e56-08dc9f4ce7f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?J1lnrW/xG/fTlLhSbVVXbWxpbknuXw1IbmVfwNjHgyEDRlE83FnAC4ddl3Jt?=
 =?us-ascii?Q?2iVclLmHNPyBpC0zJ+JEXUcqHmrHU4g/sqtblJ0brbc4WasJvRp0MdPlg68Q?=
 =?us-ascii?Q?1EEKg6SMNfqr7/hEvHZ5B3muPyZ7lWspHo0R1SA1FkP9WO4C5mOfzHnhzrhR?=
 =?us-ascii?Q?gHhwqqJ837JgxGQAfv2hLCiESSXEEFxpwvqWNOc5xJd4ny+BMHsWIbjaht6I?=
 =?us-ascii?Q?gih5Acvj4jd6hX77Ko9FD6elM7UW1IXh1Dkr4EziskW5Gc/jJAaLgBDmYbw2?=
 =?us-ascii?Q?I6UwZNbln6Wds2UzMTDDjnFkNbHGmoFwkcmUHXJCQgbQ/rrmfZ59iTBJi6i7?=
 =?us-ascii?Q?o+Ku2qqPOPpY2BgR8Aohj4CTeUbMV/EqNLGXBtF1d47nljD2XVRq1KhVcW+Y?=
 =?us-ascii?Q?S6s2GNxKtyJ/Zs+USXvxkhJrD/ku2kpRR+t+xVRjB3nSaS+vNrDVJ9tKORXf?=
 =?us-ascii?Q?xOeCqOB46/71IjokxDmyxGbp795Pqga+GeIjigyCIUtdolLVgRcRJWxbTP1i?=
 =?us-ascii?Q?GGSn/CU2Ls6CycXbpPjvWC9A2WBcyQML2eSYGcx45croLJvOfRnUJY+F0m4P?=
 =?us-ascii?Q?sfTKf1aLnnYaXxPUFc8ZoNIGFqAjen96vNkslZvgapiZC9KFAFPIucfGzLO0?=
 =?us-ascii?Q?OVT57dJnWP874a8OCciGJQ2m/YVirQ9Y6Rx98idLdXUprQXmnr/wYDBaPDfS?=
 =?us-ascii?Q?/wOebJ6pvu8vV6uax6vlaIM9JpGz7TxdqQ2B4Lpp/J53BV/9DwIwcAWp73mG?=
 =?us-ascii?Q?Hxniz+ws19v16aM9NZZBa22IlWCbTpMuprTR3P7MLu5L93XXK3hs/NAQwp/U?=
 =?us-ascii?Q?Ea1lhyitXMHdnDnXR8x6TOxv4N09h2zHcBgGQ3aSDtBVYl2E/38pSr4GSTYB?=
 =?us-ascii?Q?S4YEaHPr6kzL0jzxZMvwhU9JxSl/2XpOKJOPh1aJ2YDYOS5PPQUGYkqMGGYh?=
 =?us-ascii?Q?r1IZrvS5pgXOGT+81ydLjVr7CgeSnCsh6+9JAG3vrRUh7tU453pT6y7cw5OH?=
 =?us-ascii?Q?kk0obaDmMpWiRtFt3XxSI2XYCb2bYbIoCe67nBwY6n5DeSp27DDkCBeEP0yK?=
 =?us-ascii?Q?KushTVgmqt3fsy3Hsw3MwnuLVf9r1+gfHifZz26hUofgAQsPwY9OqdW0A9yU?=
 =?us-ascii?Q?uOV4fUlBSDUWWtlyQtHg2T97H75MKPlqd1lK+BtFu/a/ufCCSd1rWydbOYw1?=
 =?us-ascii?Q?WM+DBEGj822lfop55oEY7+iq/Sz1yXBzky9vJhCRrYtIUn980ioOntSOUllq?=
 =?us-ascii?Q?GcjljKoT9U34pV2tBHLOulVcY/FwHCHyBuaAbrCFQiHOABKcFvifC15IbWEl?=
 =?us-ascii?Q?yDgW33yIN0U3gufJ4638U3KHyngbKgasVYjFz8xurAP6qA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/ltuz6b5SsJXjXRbtddFOstQVwAe8xHAoKRiii9aXYvtAon6YRVmmJVlGpsE?=
 =?us-ascii?Q?zwlIDvGvBP+PxerluW/qR6KQkLZIO8NhTMo9SiryTcBKvODnM8Co3sc1lT6E?=
 =?us-ascii?Q?SRL/u52q97z+oCxVyoELU4H4rgKnI1dtP4SkEx095bFPLNasS9x2QlpUl4s/?=
 =?us-ascii?Q?PX8IRgQkdrnrfw8TKYMxlvSICumIPgwtlGNth87o/ODm5wVXd//kTBfD9QdJ?=
 =?us-ascii?Q?reI9lMr/WhdL88XMFZfTDzENJZiPtemswQbx4Goi8DgHNa8yGlXbGv0lD0N0?=
 =?us-ascii?Q?J+0IRLPk4EenkW1/LU/hddUZTh94Bra4xYcw16l8QkQJ75vD//bA0ZVQ+aEs?=
 =?us-ascii?Q?xqCWamq2Sf9K6kXKC1FUUJEjAJVttVsBk7KTpZiFBwTKPZx+ELhlQB/234rB?=
 =?us-ascii?Q?0CPfBcP6P+u/K1tWXHEV2CrA5cvV/xvK6ziPRnQFxsg+3bC1LHf2TQvpFMiv?=
 =?us-ascii?Q?xk85c7x/84TVKU1LUgz3CFpe4ED/yQnEXnWEPO/7iLS1aSt00MZzIg6S5tRp?=
 =?us-ascii?Q?ItZ0Y98T1ClyXIbxXrHCTITFZGwaQ3OG65cnE0Fe1RHuYNW2x5ccfnQGTgLk?=
 =?us-ascii?Q?dIWfwmLyWjGblcR4GMnt3AH2qV5XqPiom0fkEGeARzA8oQBXTJEV3AZ9xViv?=
 =?us-ascii?Q?WmSb+5dHL6CY5Ym/GREImo4PvWN8Gzf4xlFVEFF1fbIYQEAYhhP4MD12LQtA?=
 =?us-ascii?Q?RyAQcS4ipwK5TPuGjwpPCW+IEHxQKu9tl7RcO2ygqcVOsAKHZU0mYjBHs+Kd?=
 =?us-ascii?Q?tDFuPxB9abd7HmzzHaQl2H+j/35aGgj3u+bfcmyNRWH8Oh51xjUoT+M2VJiV?=
 =?us-ascii?Q?5w2EKpi14JOuN4kzJwioEw7W5yZ3PKBVE4hLuwekwrCvaJFbYsJbxsZfarIa?=
 =?us-ascii?Q?yRHQOoRL0sKm7wEu3yXLQXJGSlWKqFY0WNUu07NewTVQtrY2js1ksH5oKyxv?=
 =?us-ascii?Q?dmAbXY5vUcH0TmEOOtOcfigAiotpSgTtdfMd1DYyaodstd2MheIIzI/SARgl?=
 =?us-ascii?Q?Y1Ks+va8N9IKOOh1uY2xuXfGg5lgJdqVh758g119DboYni+5taBBh6C13ZGH?=
 =?us-ascii?Q?rsgkp/ukwk343W7DL/WJcDvVE6Iq8CmFnwCzfPktQw3rTMyDFUGzMjRdReem?=
 =?us-ascii?Q?u47bx4Abb95KPvk7mRB0TB/eHk1YZAcG2zZ6J4nccBKFXigpD3zXMX/in5ep?=
 =?us-ascii?Q?gD/2gOxVQcuxR/mWTfu1UzcryGeLzrIHt4oX1s5ukasSso7GJ+QHAnaS2s9s?=
 =?us-ascii?Q?BF7+anO7XIGM9bszJRvkrnSOTUOE2b/ZxcwddjWGxt/ZT7O00Zdml9XwU4x1?=
 =?us-ascii?Q?vqoV5AsslGP2MpW/kqYkCIT7j1wrNudJJnqacW8Iqh/1BHbGhl9regZTDY/5?=
 =?us-ascii?Q?t3DH+du8Okp5lF/Z7FoieaUIKxDZ/rjXS9ojuoonYJ+Mf8yBZlbjdA/OFaG7?=
 =?us-ascii?Q?gO1ApvziJiU+oHpJBpy164JQEI0SCAY8seZQ3DDEcqGL4Con1F41Bvz/HnAg?=
 =?us-ascii?Q?Q8f6mbRFKyqmyOQ7OIe9CdZXnxeQmSfv19M5gsLrjG/meo4jVCLWaEPesAmB?=
 =?us-ascii?Q?TCwxpA1zCPo201S3iIuj39Dqd2Hd/DftFRVT1LsJ3niET7wjV/u2BbQvgIMi?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QFdQ78h6QvipvyfzbImbP8GU/00sxxPDhyUEiGe3ECk8xMkSMIs5b99iSJxXrS49lQA5EuXjJXtv568c/p0G51RwyK2g3iNK1fVFXcZa65FLwGAPRGgkXthhcHPdjOlw49srLnTttwQjKGQaegCMECKoFBvFcov7i4It4FRCaPwBmrZe6ULc4kGbbpSXqTmB8/nYZDyZSNVPSsrBDpFBcpppJBRMn1aWY3j3Jlx3o8l1j3JuH3DS2xeFm565IahMwGzXMAwRvErlubpF15EyPV3lGlxBqfvqEFUZC81680E4QogGWrdOtEcc7x+H/7JtaDIGTfBbQ54/+dEb5uRBAma4Hx7swax3UJVSOShvAXuErWcROaOpRslqIyeW+qyATtZNeyS5j26YqwFWvcXOjLjxwE1k0ohiCDAY7/HgHuTrCjuiuOJc4AHveNC05CaVWpcL20cFgwsa0xayRT8xmlTEP+GwRVQ7YLI7sEUCrF0mefbWFMMh/W/dmuk4FabZV54tfio7S7TerOd6gI01uGjqaOQ+mTuZgDqhRlsyxGZW6fdfr0miaPAEKIVLiFFQxc+rbiLuo4BPLrASXu8gj9xu9EAutwhoBXfJW0tx1XU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c828d01f-a84a-47ed-2e56-08dc9f4ce7f8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:53:03.8871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3Ly7b3MoNUpzWFV7FQ9juxUl13PNuXqubKdmxVPKTyEr9TxRYXgOEY3LwCx7OYwFc4KjZ72qZeGJCcxWs+kG6vdj2A8RITADWDMdE3+sbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7025
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_08,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080097
X-Proofpoint-ORIG-GUID: Agjzl9OC6fMPSsQvpa-FH_Wes0gSKzcW
X-Proofpoint-GUID: Agjzl9OC6fMPSsQvpa-FH_Wes0gSKzcW

On Thu, Jul 04, 2024 at 02:27:18PM GMT, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> The MAP_FIXED page count is available after the vms_gather_munmap_vmas()
> call, so use it instead of looping over the vmas twice.

Predictably indeed you removed the thing I commented on in the last patch
;) but at least this time I predicted it! ;)

>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/mmap.c | 36 ++++--------------------------------
>  1 file changed, 4 insertions(+), 32 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index b2de26683903..62edaabf3987 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -400,27 +400,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
>  		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
>  }
>
> -static unsigned long count_vma_pages_range(struct mm_struct *mm,
> -		unsigned long addr, unsigned long end,
> -		unsigned long *nr_accounted)
> -{
> -	VMA_ITERATOR(vmi, mm, addr);
> -	struct vm_area_struct *vma;
> -	unsigned long nr_pages = 0;
> -
> -	*nr_accounted = 0;
> -	for_each_vma_range(vmi, vma, end) {
> -		unsigned long vm_start = max(addr, vma->vm_start);
> -		unsigned long vm_end = min(end, vma->vm_end);
> -
> -		nr_pages += PHYS_PFN(vm_end - vm_start);
> -		if (vma->vm_flags & VM_ACCOUNT)
> -			*nr_accounted += PHYS_PFN(vm_end - vm_start);
> -	}
> -
> -	return nr_pages;
> -}
> -
>  static void __vma_link_file(struct vm_area_struct *vma,
>  			    struct address_space *mapping)
>  {
> @@ -2946,17 +2925,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	pgoff_t vm_pgoff;
>  	int error = -ENOMEM;
>  	VMA_ITERATOR(vmi, mm, addr);
> -	unsigned long nr_pages, nr_accounted;
> -
> -	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
> -
> -	/* Check against address space limit. */
> -	/*
> -	 * MAP_FIXED may remove pages of mappings that intersects with requested
> -	 * mapping. Account for the pages it would unmap.
> -	 */
> -	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
> -		return -ENOMEM;
>
>  	if (unlikely(!can_modify_mm(mm, addr, end)))
>  		return -EPERM;
> @@ -2987,6 +2955,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  			vma_iter_next_range(&vmi);
>  	}
>
> +	/* Check against address space limit. */
> +	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages))
> +		goto abort_munmap;
> +

I know you can literally only do this after the vms_gather_munmap_vmas(),
but this does change where we check this, so for instance we do
arch_unmap() without having checked may_expand_vm().

However I assume this is fine?

>  	/*
>  	 * Private writable mapping: check memory availability
>  	 */
> --
> 2.43.0
>

Looks good to me generally,

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

