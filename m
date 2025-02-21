Return-Path: <linux-kernel+bounces-526170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AFBA3FB68
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BE4E7072D5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D93210F49;
	Fri, 21 Feb 2025 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TOyK5qTp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ch7XhjC1"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83DF217701;
	Fri, 21 Feb 2025 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154500; cv=fail; b=ZJC5vYJn/A/4ODNZ7oGP0oSTN44eMnuRVnrLqDK5LZG8nDZFiPnyoalIDP8l2dJ+EIh/F5sUlTUWJI7o3/A0v2HLkVOqpDqQDytBNFW6PqGL+KSY4OGqpDrERi85QMASLG6z9YWN8v9eCBV/yh8hI7eltgEAgMRjvjQ4ACpyAc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154500; c=relaxed/simple;
	bh=O+fvqG95mMIQ9chOTORxoKkMcYqdt3OUUgjI4Z0bqIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OnHXYiJPop9ksRl/1tDcKoIEZRMO52IMHEmkQDXn7XMO8PjIdXhCApGm56tOhASh+3AjdR4fGuErMmEzWAUSEdn7nR6vWYtgzrEyJoCUp1EVuNaSFceZBn3ZvAXp+ZRCRg5GvXbLZSzdrFY8wPV1XYN7dQy+hUjkeMoSUlpsE8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TOyK5qTp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ch7XhjC1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8fbiL002358;
	Fri, 21 Feb 2025 16:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=BAPhEd6EJyc0OoEkzL
	Xlxv1crdU3kxPPApqXueac0SA=; b=TOyK5qTp4bQmeqFGxFySH7wDlyWyxoVUDG
	+VPg3lxEEO6XpMGfIsxS75JeWiWL3T7HTfjn/nK63p2pJmItiPbd/QvexHJ60xOR
	q/0xLmrByPxrvuPSyQuA0pwoCmIyoEG2m4jMDrG51NuMMHmFIJyWtPTJ6MHPFzlo
	qPwK78Q3smCaBxY2vaN1z6Rf1KcwFzPq4hpzoEmex3fAO+vSDjBQoOT8SMnpWR4g
	mwexJ1t/1s3wgUYPlZpdugAWhFFzmyENjucUWEBQEUL06WTXH+ic/1uyj6ClZuTh
	ueG/BPIZhwY16KI9aOmIn5BpqMVwEVCBzMZe5orgzc40GvW6Nitw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00m6pks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 16:14:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51LEuSAR026269;
	Fri, 21 Feb 2025 16:14:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0ssc9rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 16:14:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5u8pWvfctyQt29FxGGBPM9EvEpirMpuA0ffNVu0WYTwoJiwWbbnBO6WvOxwSrYBa86VAiQyyOz+I9l3+f3W5cjG0VUGIAoBUrw1TIhtuIEe1z7GNegmUnWc7X3HIrMIGfPqljPSH2MT9BO71ZJL1ER7yvPbOK88mrKFZRfMO2BnsODfvLz+P2DTP5ZOxCKnLOP4KGyU9FoSXkIJIK+KdmgANVOVOpphwjrRfcxtF+3+2zZlHJDhdr5KsHAOIJ3NF5MJdA5BSoO/fvmMcTLUp4B/h2XUZciEbUf3oEO3P0yKx5wQ0Z/jyd5ZJA8CML49uz3R5lqx2BmVS7WshULVNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAPhEd6EJyc0OoEkzLXlxv1crdU3kxPPApqXueac0SA=;
 b=X24Ne8jzzypcz/NWLaT2Fp2cWwQo6ORbDM8pXIgICpj+Ic8tcY2/WlA+JyVcnlRrMJxk9cE2zrC+w5pCalEkhOABpcJzEAiBufWKSbH4qMSvI67/QWHlrPDkpDmtucaAOaY+Z4Mkg4eA/GKEr7oktIRioLmRON9hvC8DbAqqdZsMLCgBug4MCIGBuOl6CEMt+zGShfPMNXvnXs2ZM/s+zpMrFmeYn7nqd2wdx0Z7eXqY2oQulkLBxYBhxGYiSIy/KPp4nbUD8KmTFEt1PZEVvr5RJxE2x7EUYoSHFD4WoJpiEOTElwiPIBYameyvfD2H5dUWQP2jipsYA++E2HT1cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAPhEd6EJyc0OoEkzLXlxv1crdU3kxPPApqXueac0SA=;
 b=Ch7XhjC1Aa25E6ZgWC5K0K9N1xnJVZWGOs/uGjys5E2bOQZyUCb0Bslan7e6TwODchHP9VVZ1PTF3p3/qnnJnlQqeevkgTLAv5fXYgIpWWVc4mTo3XoKQnqbDvDcqOpRfPJ6U0UaWO0aIRRsLfuaPrOlqYz/SqoPjy3bvfdDgJk=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by BLAPR10MB4978.namprd10.prod.outlook.com (2603:10b6:208:30e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 16:14:22 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 16:14:21 +0000
Date: Fri, 21 Feb 2025 11:14:17 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org, willy@infradead.org,
        lorenzo.stoakes@oracle.com, david.laight.linux@gmail.com,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com,
        oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com,
        peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net,
        paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com,
        hdanton@sina.com, hughd@google.com, lokeshgidra@google.com,
        minchan@google.com, jannh@google.com, shakeel.butt@linux.dev,
        souravpanda@google.com, pasha.tatashin@soleen.com,
        klarasmodin@gmail.com, richard.weiyang@gmail.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v10 05/18] mm: mark vmas detached upon exit
Message-ID: <psi2ucxrsvfuy3qjuomrga2cljjqwzczgjxj2rouaqey66tpgq@l54o63sfbfhv>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, peterz@infradead.org, 
	willy@infradead.org, lorenzo.stoakes@oracle.com, david.laight.linux@gmail.com, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
	oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, lokeshgidra@google.com, 
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com, 
	pasha.tatashin@soleen.com, klarasmodin@gmail.com, richard.weiyang@gmail.com, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com
References: <20250213224655.1680278-1-surenb@google.com>
 <20250213224655.1680278-6-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213224655.1680278-6-surenb@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT2PR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::25) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|BLAPR10MB4978:EE_
X-MS-Office365-Filtering-Correlation-Id: aa5a6d59-8588-4b6f-c6ee-08dd5292cd2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WJMQdt+c8qzcEA2RRjGiebON4cwtW4/FE6TeHchdviOBntkQpu92tyThKEHk?=
 =?us-ascii?Q?dcOZ9TRt3okY5bFdiQnIQMwOvUCOGecktb9PgIBUUbd8lYN+qOItu33gcaEy?=
 =?us-ascii?Q?hnxLa9LV3l7S/0+pMo+Cp6zmykH1DSPP94hrVN2AKtShR4cPv3W89zp2F7bX?=
 =?us-ascii?Q?AXS0FuJt8JMZxtqmPYpBuXygFhgg0ipPdFL9xNPSF4eLmesZHWCHikF9FcsQ?=
 =?us-ascii?Q?PLVVyEgG7tBeSXAxL0kCewNmWf6bqSQhc9EPMDdWwIPxPxk+tUnVIR5n38Rd?=
 =?us-ascii?Q?dmr/TZFHsN6Lt0rIg80rIQ/8BHI7pJBMAFswzscjlLI0YHNT9nOBDRQWzOIb?=
 =?us-ascii?Q?xurz5cqmUO6g1Xe6Rfh3LywrjQHSNfADJF6cWlAqUvqa9Suz4nojV8oySTXR?=
 =?us-ascii?Q?V3zxpx/0Jj6JUCWynb10um38eF3k6v/Upt3kJOpokupS5ciAYea8oRrHIBxI?=
 =?us-ascii?Q?nUk8pKT0dA0uYkIZZKb1Ow7TxqVD66P8afxRJJs6+xIfFapb5KzABoJyG02f?=
 =?us-ascii?Q?rJzddygLRNAwWkTn8dIYupj/4xp1rOhUojK+AJZKYooG5EVpQo/pCOdph13g?=
 =?us-ascii?Q?1DqLjStnie9fb9kLSYPlMkZWESbTazoRdm+e03/opJ/hEbLVyNI3K34aL/Re?=
 =?us-ascii?Q?xdOhl2M8LWCs+mNSs3DcBDTz3ZVj9tD+/DlJtXKm6xi/vf1+AiqRieTxwwap?=
 =?us-ascii?Q?e6AvaYZI5YRhyfSYGDhvXwcqxfJciKeL83l5Ud9rgoCtrGuY/VMW7TKCeMjX?=
 =?us-ascii?Q?PqeKaLF9DnPUtdwTYDUMlTJrQNk3nt71Nbh21CERlxrtJZIavgRYHozdd/zJ?=
 =?us-ascii?Q?7e0odsTANcG5VvU4slEjaPQ6UISV31QNT1Recrk9tohQy2TC+H6HEWyFMigq?=
 =?us-ascii?Q?x5+uHov/26msdPIrymj8sCMu03B/wbQincghdR1ZlTPNm5zSXzWsWuMdqh+m?=
 =?us-ascii?Q?eMMN11sh0x4gghNo1dt/7fO5BgCbLYaoiInI2u+b5mAdOsnd73yPpd2IdVBS?=
 =?us-ascii?Q?sAUS4edCvEerRMkrppAtUZ5sljMSnG+PfJW7lEmTfOh4n11WTdQQx3gGL6N9?=
 =?us-ascii?Q?DmK4stnjnXzXieg+y6bvk/7UnB/jJa8F2FrLjxeiIl5I0d0Ae6OONQ5/8DVL?=
 =?us-ascii?Q?d2UkyHKvAscJc8Q+TEZvupiuKsJB6G7Y/yVI0Y0Z6qmBq2A8K8UkDTjVrC0l?=
 =?us-ascii?Q?9gBUvniYUqor6Z7TBMtsf5nm7dLkeozLIvlIvYtidBSvXYLhvL3U4Ds3Huef?=
 =?us-ascii?Q?vGFdmSqgKpgfpBBmae1Lxh6PHWED2/nF1xZEBo4LoyZPpzQIxWSDqNeZNKr/?=
 =?us-ascii?Q?ClvTs22wrppTLr9qGoKKjB3hGZngF3d+ikj9lE+cj2PxH/NndXZI4yD6Zfoz?=
 =?us-ascii?Q?efqi/y9bnWcg0FKP+1rF2l7Iv5bu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9iyWviirjRx59sNrcTjIHTIDt/oxOptbqDQLMCWaFa4VunoW32lKmcpyjdDt?=
 =?us-ascii?Q?JxMQN8HQdlGLNf/j01keXo5rX6h2HkNc1zpCRdvDJmuPdQK+v5Yj4DEMOJdX?=
 =?us-ascii?Q?5uuSPYbK6K3JD2lTz/0363Vu2JigwGJC2pGjtSc0xyW7wbfPrxBXgbo0U44b?=
 =?us-ascii?Q?0JOeSy2cjLHawpa30J9I3eWh/5W87yjJGfPEg7WtPZTYUipXkcs1jPLQ5iAx?=
 =?us-ascii?Q?yIOiD1FYpb3P72bsTNhJC+p8KkEFEOA0+X+LM2moRsllaKscER7eDaYsPJyI?=
 =?us-ascii?Q?d5H8Rj2XbzhTBL/lgecQbf9am60CvQcAXWR5JA7QGmJarPgTl5j+hI9v2AVx?=
 =?us-ascii?Q?FsN6/OY3/SRnVll3cIMXI2P52nXFfwGrhTtUzsndH3mYfaMj0timkG1tCWow?=
 =?us-ascii?Q?towsluK5/THh8J3dPLDjhHqZpHUpumjlhEl3lJazoPmcEKqX4acxmyprub9k?=
 =?us-ascii?Q?M1TSCC4aVWbQAxfYGBYp7kj32oxelEDe3drjBPgjKMeLe7yX1ZijuZq9DgNk?=
 =?us-ascii?Q?xR5K+5TZ9uRv/WyycW/FjB0+IxLg65nXP/nmNvsGQ4ZsqG7Nn8vHXmIAN1aV?=
 =?us-ascii?Q?gzSZ3Mdw86cyb71huXnEJKCuTdkGMJWeYjK7niv+qtcmMF2cEP7ix21qHpV9?=
 =?us-ascii?Q?I/hSW9c6W40aIyAk7dowMFVnFbsiNZ0fgQLYLSnfhjIOfaiD2jCa7GtsO3Pf?=
 =?us-ascii?Q?aP2NUs9DS0TBDCHGuhrBBSR7hNubssbghmSHhY2xTVcW8/DF08AixPNn3EVs?=
 =?us-ascii?Q?Pa0vTw7PCrM/1bUKyVcHBBo+03udIpB+vIAJ+peVd+imDrjxRG3ZHWuzFnDQ?=
 =?us-ascii?Q?8GQ/rnX6fp1/NyBw6+4r7/PptIrsuMBynj/Lda7NY4DOOs0Rlqjd4P8Tje4Q?=
 =?us-ascii?Q?By3E95yLqSapqUyJA0W6A7D54jFg0tyfwSfp+E5M+HKrMhACSSIly9ySnQot?=
 =?us-ascii?Q?aiufEQQqJItSxpmANDUR1xe8kEoyrHISTgKB3xN7Cu6WcC2h7pkn2Xba7xAa?=
 =?us-ascii?Q?XEBqAyGMkPZC5vPf9Rs6otuiXwN5y+cq1AusxfKKjvRHxgEaSunWR1COgAVw?=
 =?us-ascii?Q?dEson8MC5ByzpYVhjqcADphJZ6Gm+yBaGNBRMyvNn5LtrJXv64m++6W+DppD?=
 =?us-ascii?Q?61VoAQI1BwHC3YfYQBu7nefxI5MAeXTerQO1an5uvSyXKaV6PTJbFD6oARrj?=
 =?us-ascii?Q?SE9V60hpzKyr9J2nwPkuDhNrpnk/rnO57ymG3AQncysC9t0zntcKhouGgt7p?=
 =?us-ascii?Q?Hg9Gfgp9y1bygkJpjFxGNIuh+QTvSVs7d0nne5GPdDNZRSPtsV92iEJslXdp?=
 =?us-ascii?Q?DSnVCFjFa7vZJoeNAFt55oJN1ortN/3C22mL8KXbOwbuvo7lpOQqI7+1+etO?=
 =?us-ascii?Q?qAR453cMTVne1k7pjMkBuXiCow3268jfoCZBaU8RYPBffTHL9ttic3rUxn1d?=
 =?us-ascii?Q?HvqHLeKwsOMFcMYGYE8lenbiXaHjX6B8q5D3GCF1WtjseS/3Rb74wa1f5RJJ?=
 =?us-ascii?Q?eYcFaNdfMtM43zfI2xw0yj45sZyGur/WesjC5bJAv8APoYoE5jZERYnDKFjy?=
 =?us-ascii?Q?coCWIY9lziFqj6WQ136qohAyEZFDzljt4eBkv2EA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qFzJj5lL+8lriwdDEVv0FFu3oOef7W2GAGQrul0O6UrwlCewqLAfmmnaiRziAtFmP72doWwNaKrmjAeVb6QO9n2Y//7qhjZM+CX4dstl3w0m+aW6Io+mWhXP2vKqPxkxeWawa+w8Y8Y7qi0Wcy0J9cBpwrduaK6HVyr7OnP0pOx+2UPUSnLMXz8Rmp8HfnfksTe7d4Gvt620bI7OFZeU74/vE8fv+tCa+6/g+hoUwOCGkGvsOAvpCBjfyll+ODFLF0s1fihdL/ysrQywKvo+LGmMWtoRxe9vow3v39cAQt6wNmq5e8KMhKytto/m3ATSDgtNv05D6FFoVujjqrnUfyKagZ8GZRfRX5oMuYGGfmbK0tlSyc3qCCKQeDW2HgHMFi/bNw0InqlynpZEDROzzhSsbbTdONuVC/CWgT5bhnhaqS5v99XnueZo+/gg7t/x50gbwhdOGNDlDwIdP3HrLUeoBHTf0GzNo1yOw0jkbAunDnmHKqBw6DT+hXdzQwGDjJYYJVJabSES0u4cAECxUQ6gXEbZ31TvR6SmBrMU296NsMV5FUQZTCi6H9H5SsitD6XiLwS3EfqatkQAimqFUv+utafsdnHJseVbBzMerD0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5a6d59-8588-4b6f-c6ee-08dd5292cd2f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:14:21.8772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Jhj9QHIko9ha2hso55eh75IV450cwafEOEgywJSd+qP/sPNzoKh9GpBme0wBaBV0OQhzhi33fWyqy1efdO+yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502210115
X-Proofpoint-ORIG-GUID: bKSo53TpdxFpGaecC8mU4hPCH4CCszeb
X-Proofpoint-GUID: bKSo53TpdxFpGaecC8mU4hPCH4CCszeb

* Suren Baghdasaryan <surenb@google.com> [250213 17:47]:
> When exit_mmap() removes vmas belonging to an exiting task, it does not
> mark them as detached since they can't be reached by other tasks and they
> will be freed shortly. Once we introduce vma reuse, all vmas will have to
> be in detached state before they are freed to ensure vma when reused is
> in a consistent state. Add missing vma_mark_detached() before freeing the
> vma.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
> Changes since v9 [1]:
> - Add Reviewed-by, per Lorenzo Stoakes
> 
> [1] https://lore.kernel.org/all/20250111042604.3230628-6-surenb@google.com/
> 
>  mm/vma.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index f72b73f57451..a16a83d0253f 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -427,10 +427,12 @@ void remove_vma(struct vm_area_struct *vma, bool unreachable)
>  	if (vma->vm_file)
>  		fput(vma->vm_file);
>  	mpol_put(vma_policy(vma));
> -	if (unreachable)
> +	if (unreachable) {
> +		vma_mark_detached(vma);
>  		__vm_area_free(vma);
> -	else
> +	} else {
>  		vm_area_free(vma);
> +	}
>  }
>  
>  /*
> -- 
> 2.48.1.601.g30ceb7b040-goog
> 

