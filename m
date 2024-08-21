Return-Path: <linux-kernel+bounces-295589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D60A959EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CEB2B259DE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB77019ABA1;
	Wed, 21 Aug 2024 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ec9WyJGo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QcJSZcvM"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E283199FC3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247186; cv=fail; b=SQxBcLy3jJUFZVJNc8PQ+PXoTqTYEOyAJYcvuHy2aPlFu5fE4RsfFkHMzMKIeImFYM0MTcMMyr+WQ+qons2YH73grNT/a8pMCI8Li5gbGNzAcTnJlIqIliSzWwDkzvGY7yw2Dn00f25e51WWXt9rIlmxoLaS+PvDzVvI9hhIGLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247186; c=relaxed/simple;
	bh=hcWIz+23dhm6/oUQMUxUr36QPbAWPI8csq4qsNjsMF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lyHVy0trThcOqzrwCAcuXY+cKg0TWMkvVPDa13tdQnhjMr2y+rdnbVcuxah2T2WkyN/yEqEEf/+cwrS76rt/NiP+cVY/aGBgE06D0fle0RgAbjk356m1WxE21cYiVH0weeWbMNcdB94rbD3WpHCOjLj7YeSkfksGt5dlsXP0RkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ec9WyJGo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QcJSZcvM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LDIVLu031456;
	Wed, 21 Aug 2024 13:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=NYvMs5rexJ6fPnP
	JHbylfehmz9UDSZV9w6l/8RS0lEk=; b=Ec9WyJGoV0cpOw9sTFIEOWLNmXeRX8/
	VOPL4ajKrX8tBxAroiBPvWXRJ+FjfSxmu6QV5tmvypR52jS1RN3f9Ugb4s392QMA
	TtLb/WPzfRT7Jyi4rdJh7jmS8LXfbkPftnp2QwutnfL5bVRWhRohnPQ2QzRIZMcq
	OOtpNkUDuDaL3zIx6JL+DsgOP/qOi+RmXgPqQh4zhotS0ylG16G6XWmoMKpwG7im
	IILhtYDuaFjm5v0jzmai2Fzh8aGV+3SUydddqKJ8TlNZriNDL6Gm210c+6Jeqg+M
	4+ag2oeEhiTGZGRzAcC7IXXISO5uOIfxAJgD+wzohb818BML7aE9j8Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m2dfkd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 13:32:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47LDOInV010969;
	Wed, 21 Aug 2024 13:32:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 415h3989yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 13:32:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzPR4YXdHrNfHENbpXyxGiWxLVyDZEGBM+6r3iZ7HBRMkdWWA8W8PsFTdtR5bZ3JJHqsfh3cx0lvSx7nfcJx7XbPwNABxji9dF5dATB3TyV58k+olHPfkPxknZdxuJY3+tDdSDWAa8LsQ6e4Zdo8F39Er5+G7k7tuC28bAvGE54CdX9jG0Dy6ALclpdMctS9fsT74zEyRzx9lHL99u5soLf45f1AwznB/GyGtqWVxa9w950lWJxyfj1JXbuaJbjFBKo8uFXXsmhkvBQDT5UYyBe2vsvSzfV/pDIbRAAiQPjuq6U5sG9BPo+Xoks7CvSRVmkbpW6rWwtGn2WR1o2NZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYvMs5rexJ6fPnPJHbylfehmz9UDSZV9w6l/8RS0lEk=;
 b=bNz6khopExNqx6BFcB17FxMLbOM4Y+cjbt24LaM4cT+M8P4tqvANae8OgJ4lgnwUdYrUVX99zc1Wu+TVoRCKdvSYfzIJ5NqGsuPJ4MIyuB02VCwFlXXPoI6UFJiHUR82kXHqPFRXkVCWeRik20pVJjh7MR4Zg+UoSLD0oMel0jSTtMc+o1o0sEY2vGgjYmn0xXHILEMumkW75LXdbYE99epyuUdqXRrcuc7fA8a0aoBFl3IthG0M08LHtB2VpKsFue63wIgFjzUYCCjs5AEtttmPlO232miRKUrUof6LeCPY5Rq0ywbWQuZGg/yTAFYmVqj9aqG+FzOw260tBTd9mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYvMs5rexJ6fPnPJHbylfehmz9UDSZV9w6l/8RS0lEk=;
 b=QcJSZcvMtH9GpETDAHWgp/f1Mua5tF4DS8LI2wFhgMkvV4KXgYltOzGK7p+I7bTLKH5ehzSOJu7+lISkQshiIWgWF3A83ZhFMjcp9xqumQJFy3fFqsWmjSe5EeEqvcMa415kycZESnezc6Su7c0TnLgUA+GzESngZZ/PBcZK4B8=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS0PR10MB6029.namprd10.prod.outlook.com (2603:10b6:8:cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Wed, 21 Aug
 2024 13:31:35 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 13:31:31 +0000
Date: Wed, 21 Aug 2024 09:31:29 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v6 15/20] mm: Change failure of MAP_FIXED to restoring
 the gap on failure
Message-ID: <2cg4n3ydwsfqqen52axipoakmx2manqr3c4z7jnxh4q2f4lhpr@ifxs7y64w6do>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, sidhartha.kumar@oracle.com, 
	Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
 <20240820235730.2852400-16-Liam.Howlett@oracle.com>
 <17400fe3-c39d-4620-accd-3fd912740cbe@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17400fe3-c39d-4620-accd-3fd912740cbe@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0045.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::18) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS0PR10MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ead5fb5-9669-4748-ef3f-08dcc1e59192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3fgqoKFU3VCkEst0lgl8xXAPq7x9wukBy/UBDsQw6d/B598Pq4eKVH2uS0ep?=
 =?us-ascii?Q?uu8UWo51p/LtZsADG1oWMUek2ycjHl7WCWXWIHfpKK++Jmewsvit4T7DUgo8?=
 =?us-ascii?Q?xo8NsRHXxYIqg9RWURrgq3auS/fa5qDytWy79dru+ud+5kiIrqrTvnWDJso9?=
 =?us-ascii?Q?VrKuLrT4L6f4kICu8UhAtw0jLf4ACgboURXx/nvI99TaNC+p3KkEKDuITIO0?=
 =?us-ascii?Q?4eYbFil5Px4Xu6YIU1NsSjq6hRMjC4LZqwDtBqoBTMwtGoVVGFuE8XTi0Wbw?=
 =?us-ascii?Q?jXWrNSWH+C2vvno4mtDQnsYeYmX7bmFFbfyFof8nRy+xTYrruZkz5PoH6LRA?=
 =?us-ascii?Q?nZhluG5v8fRG/p9EoUjJc+7HGewbSz3iGFYosGudqTwOYXXkz0mUpxjmf0an?=
 =?us-ascii?Q?CyBV8K+dp3AITZzhm4TCQwvLBc2BRplHyeDznRDoIrLTHXNym/gfEhTmsdZ0?=
 =?us-ascii?Q?vF6uV6Ae4nYMCz3r1nksRX2EmXaUKubwvTFp776zeDpBSZF2x0F5hlUZTAel?=
 =?us-ascii?Q?D5+BAy1V5ephn+TKhtcMVwsPz/ysV+j/OusjHvDauF2rGTosklnEdIlB+8wO?=
 =?us-ascii?Q?yMI5ZHDma/riHjJD4dL4y0v1t6gJ8G8FZZs8tbjk8Ck/D2kvTG+5CM9at9jl?=
 =?us-ascii?Q?zUmTajX157wPSz1fO6fYwmW3uoaHezVjoDXptxLzdypI4NTZk/8+ule/VGpZ?=
 =?us-ascii?Q?R3PdVlBG8wU6uhcgbXWHJHMiMh9JWTxUazpvTaQLBt+34/R82G3g5uy++GCs?=
 =?us-ascii?Q?bvxtcEbJ6X9zEq1ZsyY4K6hQcU4N65kOH2+K0hQbIAjiT44RgbrMfRG3fSKU?=
 =?us-ascii?Q?vl4ndvN7X9jDGDclVAgqVlGOcgADQ5mG7CcDyxCiTnhpUlkaz8fS3p8kkR+u?=
 =?us-ascii?Q?iY6IS89Q3jq7uHkia7wUSoOkWpWvdIo71TBoKPaBUx11eeB/HrmtDTTn0fx+?=
 =?us-ascii?Q?0F632fnur45kDtKExmWWLkDcwTmjxTM4O4jaoy3b+rr53/VKxodUvAxIX1f1?=
 =?us-ascii?Q?OLv1g4jrVMwZYsvyOVQUOhjfQ6HUEPB5b6FTCDhYaBMDyDhr1PT4JpDVi8bg?=
 =?us-ascii?Q?c43ZCU1+7zrB3IuPmoGRBlj8C2mxW9uRtxHJX/WvRtgGvBSdS27jkV7bpyZV?=
 =?us-ascii?Q?MF8F5hUJ2ur6NNa/jnWL0/vLz8mMYmgjgI5AtnvHIvdW075WTDTfzyGKLKky?=
 =?us-ascii?Q?g7HUuw7MXLgboAmA+8HSC6JvT8MiRhS48cVoz0lxNBw/4QeeBQK1swACdnv/?=
 =?us-ascii?Q?6Eo6WzIRKVmHkCUrOFNwSzqWGZO5o9mvl2gyjb2/pjmLC84jBCpP7LKPPNOT?=
 =?us-ascii?Q?2314HE8VKxxy//vF8ikrzQ+TfOs96cB7RsoQ4Gxyf2vpiQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TkQd3IkwNxoPhMES2NQ3tsxWxCQu/sPWe1wmvPWNhFtLuMEsitzHgZTVmteJ?=
 =?us-ascii?Q?sEnPn4X6KO6CAjJfKuqf6sofJ85HiZtnymwourd5+v/uuxVBdupHirfxJLMw?=
 =?us-ascii?Q?+/Uj/dI5JWq++xp6W1u+SO8w63Mr5qKfTM7dD5ybDWU2a6EgFLRmMCfCZYC3?=
 =?us-ascii?Q?k6KnzjtpDsxGk7HNC7tImd4jgz/nvLcNLJxhrP4/Ztls5kX91W9wHlF+SuZv?=
 =?us-ascii?Q?zI52qxmDL6NqsWGVbFhQ4VxhDQH/PwtF4wjiJ55hjyVXrTCcj9Cy3UbKJ74A?=
 =?us-ascii?Q?NfMn+pqticHNzT4j3yHGHHeiU0842QQDxxm9ESJHjnxJe+HIoMf4uwY2zzIS?=
 =?us-ascii?Q?q0xU2jn5zHfC9Z3hRDr7uStpLvBlkHhLS28ADjOpmAlKrTScHbRONb4SnuSH?=
 =?us-ascii?Q?KpDT7vrNjFmcbN9dNJIYqBt++m9CnngQgLsxzQXVPr0YSoKsjvx3cKjN76vv?=
 =?us-ascii?Q?X1WAe6CJDSguo8NPe8mWp1AmszwgmpyISDZL1eO+aRaitVtVAxrtpukM6MAu?=
 =?us-ascii?Q?EPZC+t/4tYBfKacu7REihEHr1xQ/zEC91pJJkmx+qRO8KmNlC+1eI+pVRbBO?=
 =?us-ascii?Q?qFA/Hla/KfPAPhqTrl2/KWwBi95KUPNsQ+UtD8chs6C8A2ytQyz5ebHwHkFs?=
 =?us-ascii?Q?ouJDLf+ERCq9uwzDa2XXrjbqtDNiFZ30prlCxCc/NyNpr5f3AnE5wLVC0S83?=
 =?us-ascii?Q?E7PJ1H0HWBqRqJBTCH8LokcbQ1+niXpn+Wt25W3k1fegocsCjHzbMd3htAlY?=
 =?us-ascii?Q?eyHbgm13P2E+wMwFVvRiz139TGWt/mDcLb2ypsNnYCSC11dFxHfl1MTWwVHe?=
 =?us-ascii?Q?wVyop+kX73i1zgDYd4NhKsupN6+7jE6kLTgp6r5lbgZntsTWBxqo3UnrPK0t?=
 =?us-ascii?Q?llkE9EtA5MXW7PF52EkiBs9iT6c2yFPFkG73o2ssid6VR5Wf1479y6CU7H0V?=
 =?us-ascii?Q?PpAv/oPC7WgChxJx7JhjlkhOD+4VjtpUsL5H+OaCjCU2B5f+0kjWjtgUeOoj?=
 =?us-ascii?Q?9j4F/LzHdCIZA0YLgVJa92zipCb9slXUBmcBtkqeDNDrgdjB5laYvkyHxqbK?=
 =?us-ascii?Q?T6NJ4nWxwKSEl9t5j5r4CGb9qNTI228uN8bhLq8xVxRpRiUelpI0YF63QQPt?=
 =?us-ascii?Q?AhTCoiDEHeEj+qJGkBsTLcKF8h8frvrOh3EvhkX6OhLWzHXdw3je9ZefY66z?=
 =?us-ascii?Q?XG8W7JpbQHy6VyB5ULV0rildSiBh2XUx6gTrx1XIa6tcRr7xIEiRWH4NdxAy?=
 =?us-ascii?Q?fnZEVRDDhC+jVAjNhSXe6qCig8MSXhVCXE+TstQqUOXkP7cKJcbkW+Z7gG4H?=
 =?us-ascii?Q?jTwETM1GkCZSQRhb0TwcOr1Wq07F6uJyq91MXeIdZUGQk8kmTM7f48NahSkV?=
 =?us-ascii?Q?zJ/ergbgsfKJqBG+UOY+W6k6Z6xD8VKLII6QeIGYn2XX9FIYUR5RWv2JIkz6?=
 =?us-ascii?Q?o/z8f5GqcJmnqsKCgHkM3MMxZnoPzdpg1V3qm2p+o8eQWbx8Eqr6l6RXz4Df?=
 =?us-ascii?Q?04qcSuOjG7PxidLs2M+wDSqkX4k+AIv4B5zlt+tipjzsnqnaOGGk7r6HoPKG?=
 =?us-ascii?Q?669zSlAtamRx4P/veaJwyj8aB8CPOnK5VHHtl0rbJEftDbZ26tQv0hbOzZDr?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vT/kFITYmONjBxnzHYUZ7bzWaLqvrlzIeWyyMQBkHsWzqZsg2xuR5yX4eiyyp2PODqcq2o3GfLJf8dI5xPRGtr3JSIVThjjAkx6FzuUaQYbRcRSiY/QdEwyrGp+EaPzE7LyrmYBZpdIzHGJmHK0o20axJTWOXkYz3tM9zbJtRjJwBoRxvCiWC18SEQHyzEtVtLZChHC7/dE2Mlg6PB+UTVIzu+IWjfjQex8qIYZAQSo9+I0zi/anlBLE9aiiyQWuKM2wwJaAvirvsT+Dedk93R1C9m+DMK3Npiu+nKp8kI3c3gwe2zYv8Zg0miTQokDR4imhdIyaY2Z4VDEcrAX0csCnF+J5euQIVdBXD3rpgtBYWG+RtLyWt8dKnfbdeML8hqn0qRSYYsuXitpYyoCkxAsKLHD6ml/6UfGPTRQFPoWS13W8QtCFRZ1i+ttrDLY90dnp3Yxcy9gZhubjde+NCm4PyRJhL9I5T0WPNYicylPEkHpNbthfDHFFrPMTIVcQS7uH7Gjvzaul2iUhKp8XWVBYJFNrB/kjvndh2b622IBkKQVBTCsfxiRZVCNRDb0aOPldBuDu0PYCy0W0wnY2HzgNbCAogweGwX7WjyzzyjY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ead5fb5-9669-4748-ef3f-08dcc1e59192
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 13:31:31.5296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lws0WLvjERi3UGUbxmzWFnOcIhgU6I8dxL/g85qbjaDBlciZdwUncvWFA4zfPQgCJU2+EHgNvFUJNN7zOcUhLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6029
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_10,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408210098
X-Proofpoint-GUID: nNGHk44Lz_SqdWWI5hyM7HHBUYyhk8FL
X-Proofpoint-ORIG-GUID: nNGHk44Lz_SqdWWI5hyM7HHBUYyhk8FL

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240821 07:56]:
> On Tue, Aug 20, 2024 at 07:57:24PM GMT, Liam R. Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > Prior to call_mmap(), the vmas that will be replaced need to clear the
> > way for what may happen in the call_mmap().  This clean up work includes
> > clearing the ptes and calling the close() vm_ops.  Some users do more
> > setup than can be restored by calling the vm_ops open() function.  It is
> > safer to store the gap in the vma tree in these cases.
> >
> > That is to say that the failure scenario that existed before the
> > MAP_FIXED gap exposure is restored as it is safer than trying to undo a
> > partial mapping.
> >
> > There is also a secondary failure that may occur if there is not enough
> > memory to store the gap.  In this case, the vmas are reattached and
> > resources freed.  If the system cannot complete the call_mmap() and
> > fails to allocate with GFP_KERNEL, then the system will print a warning
> > about the failure.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> 
> Just some nits etc. below, otherwise:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> > ---
> >  mm/mmap.c |  3 +--
> >  mm/vma.h  | 62 +++++++++++++++++++++++++++++++++++++------------------
> >  2 files changed, 43 insertions(+), 22 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 6550d9470d3a..c1b3d17f97be 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1622,8 +1622,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		vm_unacct_memory(charged);
> >
> >  abort_munmap:
> > -	if (vms.nr_pages)
> > -		abort_munmap_vmas(&mas_detach, vms.closed_vm_ops);
> > +	vms_abort_munmap_vmas(&vms, &mas_detach, vms.closed_vm_ops);
> >  	validate_mm(mm);
> >  	return error;
> >  }
> > diff --git a/mm/vma.h b/mm/vma.h
> > index 756dd42a6ec4..7618ddbfd2b2 100644
> > --- a/mm/vma.h
> > +++ b/mm/vma.h
> > @@ -82,6 +82,22 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  	       unsigned long start, unsigned long end, pgoff_t pgoff);
> >
> > +static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
> > +			struct vm_area_struct *vma, gfp_t gfp)
> > +
> > +{
> > +	if (vmi->mas.status != ma_start &&
> > +	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
> > +		vma_iter_invalidate(vmi);
> > +
> > +	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
> > +	mas_store_gfp(&vmi->mas, vma, gfp);
> > +	if (unlikely(mas_is_err(&vmi->mas)))
> > +		return -ENOMEM;
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
> >   * @vms: The vma munmap struct
> > @@ -136,15 +152,37 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach, bool closed)
> >  	struct vm_area_struct *vma;
> >
> >  	mas_set(mas_detach, 0);
> > -	mas_for_each(mas_detach, vma, ULONG_MAX) {
> > +	mas_for_each(mas_detach, vma, ULONG_MAX)
> >  		vma_mark_detached(vma, false);
> > -		if (closed && vma->vm_ops && vma->vm_ops->open)
> > -			vma->vm_ops->open(vma);
> > -	}
> 
> Yes.

Woops, closed isn't used anymore here.

> 
> >
> >  	__mt_destroy(mas_detach->tree);
> >  }
> >
> > +static inline void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
> > +		struct ma_state *mas_detach, bool closed)
> 
> Nitty, but seems strange to comment abort_munmap_vmas() and say that it
> undoes any munmap work + frees resources, but not to comment this function.

Sure, I can add a comment, it's probably more useful than the one above.

> 
> Also I wonder if, with these changes, abort_munmap_vmas() needs a rename?
> Something like reattach_vmas() or something?

I can rename it.  This is exclusively used in vma.c now besides the
below use.

> 
> > +{
> > +	if (!vms->nr_pages)
> > +		return;
> > +
> > +	if (vms->clear_ptes)
> > +		return abort_munmap_vmas(mas_detach, vms->closed_vm_ops);
> > +
> > +	/*
> > +	 * Aborting cannot just call the vm_ops open() because they are often
> > +	 * not symmetrical and state data has been lost.  Resort to the old
> > +	 * failure method of leaving a gap where the MAP_FIXED mapping failed.
> > +	 */
> > +	if (unlikely(vma_iter_store_gfp(vms->vmi, NULL, GFP_KERNEL))) {
> > +		pr_warn_once("%s: (%d) Unable to abort munmap() operation\n",
> > +			     current->comm, current->pid);
> > +		/* Leaving vmas detached and in-tree may hamper recovery */
> > +		abort_munmap_vmas(mas_detach, vms->closed_vm_ops);
> 
> OK so I guess rather than trying to do some clever preallocation, we just
> warn + get out?

Hmm, clever preallocations... I could maybe figure out something here.
No double failure left unfixed!

> 
> > +	} else {
> > +		/* Clean up the insertion of unfortunate the gap */
> 
> I'm not sure what this means :P 'unfortunate, the gap, isn't it?'

Right.  Perhaps I should update this to 'mind the gap'.

> 
> > +		vms_complete_munmap_vmas(vms, mas_detach);
> > +	}
> > +}
> > +
> >  int
> >  do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  		    struct mm_struct *mm, unsigned long start,
> > @@ -297,22 +335,6 @@ static inline struct vm_area_struct *vma_prev_limit(struct vma_iterator *vmi,
> >  	return mas_prev(&vmi->mas, min);
> >  }
> >
> > -static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
> > -			struct vm_area_struct *vma, gfp_t gfp)
> > -{
> > -	if (vmi->mas.status != ma_start &&
> > -	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
> > -		vma_iter_invalidate(vmi);
> > -
> > -	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
> > -	mas_store_gfp(&vmi->mas, vma, gfp);
> > -	if (unlikely(mas_is_err(&vmi->mas)))
> > -		return -ENOMEM;
> > -
> > -	return 0;
> > -}
> > -
> > -
> >  /*
> >   * These three helpers classifies VMAs for virtual memory accounting.
> >   */
> > --
> > 2.43.0
> >

