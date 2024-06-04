Return-Path: <linux-kernel+bounces-201284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 923F68FBC7E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2356E2840A0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFCC14A4C1;
	Tue,  4 Jun 2024 19:27:56 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86E2801
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 19:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717529275; cv=fail; b=uzbaBy+jtZkl4P7iBTH/nuufKsnAgDoHStG5J9D16YY9C9K7dRd4tVznpyPQeTzVW5OLfOFci6g6edgQkKpBGZXIMAJKGvDaR8ckO/JQBuJQlLaR6XgfEMr3ws7eYonfRc4xNoh6pb7bcYXLRSkD3Q73CbAlILK9xOPAwfzd4JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717529275; c=relaxed/simple;
	bh=NRyKU7kClBxwYOVmRNO3CbBQr2927Fm6UP5awAAWeI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dvdU/IpW2uCSdkyK6MHK0vHuqHCVjORIGdSMrlo3GUJdfhZRIAz9oHRWwCerBppm/5qqyiyLGYkjlajT3dOopLDSPuL1N5i0fnVg2n6GF4/qj7mks0tJcQV52RsGKmE4TPlzqbclLKaFnDOBIH6UchyEZHhqx1maXrMDQo12W1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454JQMSh013716;
	Tue, 4 Jun 2024 19:27:34 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:references:subject:to;_s=3Dcorp-2023-11-20;_bh=3DNvCGc7cydLX5?=
 =?UTF-8?Q?ZVBWYRg64b0DN2WNtno5u6qeTla5klY=3D;_b=3DRdko6B6Q18eoM4ZcuOgeMQS?=
 =?UTF-8?Q?RJ0bNjQFhWlJYrp2lueiNtNnBz28fvvJP9JKHf7w53D4h_DCvNst7nZpBFpyEnW?=
 =?UTF-8?Q?6syocMSsCF+jtWAu4pdBFGeaBCpaIPU9uYU32GxassAlSx4vrpf_zAdHo+33Czs?=
 =?UTF-8?Q?MfDrAsNJF0zXx5RZjVMSnPIeD07MlBU/677/LnChACNRKUJ6WOek1GXsG_g9Z3L?=
 =?UTF-8?Q?4Q+p/ty+GB9StKYualXmG26Ja/uPZW+i+6EqamzEjK8Se86tGC0KIQqKauTq7Ka?=
 =?UTF-8?Q?_giFDyeWDLxP+bfdzV7F2CNKEwaM90FcnIWhewmAXBnQ5IVvWo/nTzYOUYuT+yz?=
 =?UTF-8?Q?3gZeSf_nQ=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfuwm5s38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 19:27:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454HtkK5005470;
	Tue, 4 Jun 2024 19:27:32 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrme19yf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 19:27:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCQ3/8PKAZSiZLqFINY+gW1hqFFqc9kKjCt7qugJTOSggblaV9N9PH7eGyOwQC3T7cXTuKEdzHbSigIgs+TAzRSH0YEBmqZeGpCNeDKiv8SVgtBcjnYVmAXWfCTJDbkhsv2uVgiwc4KVJsUoDT4NYYFTFJ0FJ6ygcFAVR+SEIqMSZcWuWZ7OjbZ7Tba/INB2ONU6tL9V4GNK13I8tzpGiUj+lb1/5Jxw8eRFtFoIzjL62hGDmgHiOTXi8oV1pc8NE/4qZ10lxhPTpMnB35skmZlYs/n3hIAe4L3wNjSOnHwb/yRn7J6qCc9XhR+ODvwiD2Je8n0E9jHhzdwLoWGLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvCGc7cydLX5ZVBWYRg64b0DN2WNtno5u6qeTla5klY=;
 b=NLdME3REZih/q5ZpPDdtddXelt6hoyF4CicUC/Xmf4p1hWH0ySq4aCfBjYSJwlwdO83qR0+p02umYKvZctXh0RPc3Hnwmzp3dYkAfXKtk9jnXAVOcn32/PECd+1b69ld7lxlpHyXa4/y2q2OrDJWXXc+aA1+W7BfvI1n4AEAp/DsuW9U42bcBHVfnR+Vbs+GBj8XG8rML7tjG10EGE2YJ9wp9lQ57ASHLHLY4FmEnsD0+w8w3EVgBvIexhuUU1wY3SjMixGZYXVh7/jhzEySqmg92bBHzKfXfp6iMhc9jG4EvR0IbgFRh9yJkVL/Xk8NBP1BTcmGwtxVqUcwl8RJcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvCGc7cydLX5ZVBWYRg64b0DN2WNtno5u6qeTla5klY=;
 b=lKNKCI3J3Ex23FxGF/wBaKBZqh8U4UXdVhxaanhbPNw7zbiTmnrbRVOh17EW9iq+sa87NnBWIe/d/dV43Thzhdm2OKEYOjvGawOTAUgxj7nf0wWl2lqvh9gIFKYXymOcsVOb5QEQxnNwYxQvrVRl7peFACrKEDzbtVcPEPOVxIk=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BN0PR10MB5176.namprd10.prod.outlook.com (2603:10b6:408:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 19:27:30 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 19:27:30 +0000
Date: Tue, 4 Jun 2024 15:27:28 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        zhangpeng.00@bytedance.com, willy@infradead.org
Subject: Re: [PATCH 05/18] maple_tree: set store type in mas_store_prealloc()
Message-ID: <dn5l7tqprodlne4uxp2fg3wzu6qtvjfp7mbcshphovm7digi4f@53aizlonrrm6>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, zhangpeng.00@bytedance.com, 
	willy@infradead.org
References: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
 <20240604174145.563900-6-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604174145.563900-6-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0487.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::14) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BN0PR10MB5176:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fee1427-c3c9-4d21-dd03-08dc84cc6030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?bhYTaPS5tHcQK0XMRiTtaSrNlbri8DVzuZzbh31K1XSFlw9VUgj37qC53aB0?=
 =?us-ascii?Q?6jNAOgnR+aX+aHTKvvCwCtzaUeAXIZTQCRkogvHl0tE7p1hfoA3f6EJ79VaG?=
 =?us-ascii?Q?7vfe1qn2QLrTHv1Z1aUfM6RxvY50yMw0KrZBwtOZFGquzHmpSbgGHbKkmsES?=
 =?us-ascii?Q?quPItUAEmN7vypKfRkDuxs6bmLcmDSXxI6ZJU6fnjkip+aPP4saBZUBlP1pf?=
 =?us-ascii?Q?VrGL4yy2W2A7zFWUPoBltM1oeurVLrR2fOvA0vOwi3zvLPydY/8KMe6haevz?=
 =?us-ascii?Q?08u1/BBlig0sjnRpk7I+k0MDIpwKBBXcV7ioUgeyv7E2JUUhxIZYvO5psJMc?=
 =?us-ascii?Q?0yHu7UzJvbU0+RC85HVHntN5vamj1feGPtSKZHA5bfwKc3p+Eyi9NRkOFcph?=
 =?us-ascii?Q?yh9KBq3Crvj9m9I/SMIQxch0MgtIpMB+KWpPvTZ01RRoFrijuGzoCugfH/EO?=
 =?us-ascii?Q?QEZdP76zMRvUYFRSSupWm5n2j4XiguhWb/kM0nFaMbgAmDjymbcpHJyXpz4C?=
 =?us-ascii?Q?sSOV62OYqbnMxXmOxinNfcQuFRNP8KIuyVj6ezIHCpKnhoJi5jrG5JoOYPUq?=
 =?us-ascii?Q?JAL1k6I+twwuLdDeDjG6PBryWafS95JXwI14GJQG6NnHQUlCPevX1Y9mj3II?=
 =?us-ascii?Q?FkBzO95K2Kl1yNoe7bXp0sRiGT7oLSyFEohuDegDI1HjOQZHy+nVtkS9nu+h?=
 =?us-ascii?Q?hPjUs27IHZr/7u3UofbbMOVWt5GEkmsr83qrd4omLQtByJ2cgF7EYA3p4d7P?=
 =?us-ascii?Q?mMQdCQS7w1i6vxwVf6yR5wGYulQQRt+q3d1zw0LPinWAy8g0DrFUVCQamx9e?=
 =?us-ascii?Q?zvEoPw/0lk0hB2WD95EmZ6BzidH5DaIyRXvq7TgJg4LYyh8u9LoXe6bzQGix?=
 =?us-ascii?Q?MUWsliQTr8ktBIclEL7o9eI6FJLl5WM1aBpWEC6Ns1OIDWrTK7119sQTaO+Y?=
 =?us-ascii?Q?zcrgihc6n7oZtaG4BgfjbZDQqhJYHx9twgX/OWfxorjddElBm3Tc/rkBmhn6?=
 =?us-ascii?Q?4PFJowf035ohTA7rlBNimDIRpzhdpvvwQR1BEF05X8GWHojTbw02UU9ic/O7?=
 =?us-ascii?Q?gwdribesWJa2ltFzjo3q27HcoqFEK6UBvVUj33R2OrAYOZJf2Csu8gKE06jo?=
 =?us-ascii?Q?dw1STbtvOHmQX1YvxXMzWPa4+9T921k39s0usYOdGy3ol4AENDb1yLvd15pA?=
 =?us-ascii?Q?MToiNzSAOJVCdOUia1CvSim3MDig3Xx5cNxy4h68YtqWmTUawgvR4ek+Gr5D?=
 =?us-ascii?Q?2XVQzZ+kARzwwxo9fFWomjKtNOvY57mUsT3JzW2LUQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XQrNZjoJaL/Z0IwRqf65+OQMBZQNix94GYCalmWpK9EsfLpTxQ8j2VdVH9nh?=
 =?us-ascii?Q?0J+atx+77Chi5RovVHw2NRCnX9ghqyE0gf7B/+xU+1q9rgQe2/HAalIq9KxG?=
 =?us-ascii?Q?XFv6pBRUgDxzNQ2cP+uFHp2FYraEuolBljPX2nsAw0KFnoFT9NVNs+IK7rH9?=
 =?us-ascii?Q?hP3ldHVYxf8CzuXeSdtCvekcn+VdmoAYU3iCUdDaOpA7UIlZLnhW2A8WYcjj?=
 =?us-ascii?Q?k9kyu+QNQ/zZIQ1dAR9ner1IkEeOxsD5nsq34XLSHeVqUWOTUTGJDnxrRihq?=
 =?us-ascii?Q?6OjT7GmqiCe3+uUmmUntQFpkTXIi0lGbNDWIAIzUsbEQGpRgxBvwf3GaDszA?=
 =?us-ascii?Q?LDNFcyzty544AeLUFeHtnqwIBp57ynreYrvDjfzo2ClGW5OBgoT0e95oBWyH?=
 =?us-ascii?Q?bx07aM1LTcT6vaYBcyG4bdHHT0bZ4qOBnQc0YUWOv5MqvejkZZGSUAbTlomm?=
 =?us-ascii?Q?NxhqdVeeeZsJHhOuyvW1qazZNXXF8RPAI1pzXIHH9tBwotD6M5dyIzL1lnDV?=
 =?us-ascii?Q?UskqqF5oVlSxuWt5IsIPlcotU7/xmhGFBgg583OkyQMBhToFdl8KqUlEkST0?=
 =?us-ascii?Q?XZeg+skq8McQ8H89Ne+ufpjZvbjYW9k9iMMdRAySqCoTD+4LvC/9BhQOOoBB?=
 =?us-ascii?Q?L/xDVxfYtK5GjWJ/02o/cV40ASgH7zn1l6b8P4Kv2l4ZYZZEkqGCletemMey?=
 =?us-ascii?Q?nNzTmKklBPS4QeWSDpwJx6hcylllfZmnghL4zzqJ5ksU8pbDJ+kL2HmlPdHW?=
 =?us-ascii?Q?Niicps4RMM6N0E/l/IuNWpD8csfvigeOHThEM0158a78wS/UQls74Ja8a+bN?=
 =?us-ascii?Q?81fjyvPrj/c+DB2rEs8+9glvUN1wjZJaViXMcXilNkp0Z8V5tsK8+xE1bb5X?=
 =?us-ascii?Q?4fzcKz3o/XLuA5MoLEKqAqQOE+uKeCjZVcS+FWdNJHEpvFbDgYj/uervvrNc?=
 =?us-ascii?Q?m1R2+ZDsSp+UueMpJglPBdLDbEd25eGhSOk2doqzm2XK07uGYGkOpVe+q9lX?=
 =?us-ascii?Q?4tlvc2/RqnU68PMLKdEX92VgzgkQ6pFc5eiUbppBUnG2XAWgkyA+YHGHOpb3?=
 =?us-ascii?Q?vQ/Ppf0uWX+g3JQHGLeYAjjMrS+JstFBHGfOiXxB9juy1NK9sCjWOTWPpAWU?=
 =?us-ascii?Q?IPuffSde5Ie5mS5fuKEXQ49/wRx5YqHRRZ1ZAqq+2zdWnKMjEjdyE+vR3pSl?=
 =?us-ascii?Q?WFwrpwa7B/iEj0e5eFki15AKCIFMSFNVGCbmR3FgCHtemSk823TR/OHsdMQc?=
 =?us-ascii?Q?K6p9uU33Ajqa/Wb7lgB+PkY8vU50fD76s0sD1yJzshFNotOeWdDIOt6QJ5y3?=
 =?us-ascii?Q?+1fEeZ37ZKS+DydeYXYzO+0MXYCj0NtbSd1QGQ9S1Ak1SzYKHRqLC45/okoE?=
 =?us-ascii?Q?yL/L20sKmGnYREyIRo+dOzxsDRci3F+Ks+anFKWHPqnmZ6Ics5d1ulJnm6q5?=
 =?us-ascii?Q?hD7eHIk23ag9H+uLKGr6mIrj4Q63i9nnleXnJoP3S7CxPd26MJafF8tBu1bH?=
 =?us-ascii?Q?r1rBJ5Pch7k+8z0w3hePDIqucQM/I8xHZ6UMi9pcLw+qQDMElhNoKrsvrJyT?=
 =?us-ascii?Q?mjdeZJ5j/Rl2WOyDTD148b9AoyKRZmC85S/xEcWQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	41qgYMWUOhH/688FL0hZiBjgPIbSZxV3N/WvUzqJ1nDqU0HPFjrxs2xODCC3R25RuvHXqba6039NM4PdtU8IuYbiWE0fpIttwW6/ASi8l93j7vFAsn/Qsue89SAC5wv9s3vb1DDWBgCxQrH397ICkvaPt4v4xM5ng+F4f26VZHnzIfcihZN1g2X6elXGpZRwufXI3joKpp6fI89EN5EHbgwergAuEgLA6VUk7z3opR/7Am/0BmWHb+9ArS63ag5Vp1IdygsngwURxbM22JKXLtjFATEl8l0b6mjVUYuAV4F5e5nYvQ0oAcL6B2GvSeP4VQFvcOtFh/eph9E8IMnsR8McMkfx9k9/UzXW/PuJ3mcDxuExs83F938Nv0F/g5MDob9pUZlaGd5WAixQhsnifgNxvXYil+nIyGRBlv1YODIOd49D9VthcOlk0Sq0sbaz8yPvfs00NsOawSFL34OXNCtpf0mpoFC1HfVeqLC/iMn5UTjWVYWv+U+s2kMh5pqLoC+cOfjasd8ksl/6snUJDzWRSLO1QLZoFZUIpOApqFpdq07MehdEUGBjCu7+O7TnjL0c+DLyMIASveCwJDs0tT/LgxlUm6R676MHZm3hJqM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fee1427-c3c9-4d21-dd03-08dc84cc6030
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 19:27:30.3132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBI7WsDIfudmtYBbKpwKO1Zi1w6Vs6f4hX8BmxmDa+d6EIC0kYhofHwgrmx4v0ZRw2OaGctrklWM/Gpdm5vt2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5176
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040156
X-Proofpoint-GUID: H3QUZGeIqq1GiL29eKT7NO3ZVhTusqNS
X-Proofpoint-ORIG-GUID: H3QUZGeIqq1GiL29eKT7NO3ZVhTusqNS

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [240604 13:42]:
> Set the store type in mas_store_prealloc(). This is needed as
> mas_wr_store_entry() will be modified to read the store type to make a
> decision about how to complete the store.

You have two of these small patches, one has a different description
"set write store type" vs "set store type".  I think they both can be
combined into the mas_wr_store_entry() modification?  They are pretty
straight forward and the commit log can explain them.

> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  lib/maple_tree.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index b37fa8690558..3780d4bb0415 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5631,7 +5631,8 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
>  {
>  	MA_WR_STATE(wr_mas, mas, entry);
>  
> -	mas_wr_store_setup(&wr_mas);
> +	mas_wr_prealloc_setup(&wr_mas);
> +	mas_wr_store_type(&wr_mas);
>  	trace_ma_write(__func__, mas, 0, entry);
>  	mas_wr_store_entry(&wr_mas);
>  	MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
> -- 
> 2.45.1
> 

