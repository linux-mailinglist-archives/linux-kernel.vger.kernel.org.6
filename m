Return-Path: <linux-kernel+bounces-205178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18608FF88C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 02:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A102862D4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 00:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC61EC2;
	Fri,  7 Jun 2024 00:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BS62xYD9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CyCoQPLa"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A297F6;
	Fri,  7 Jun 2024 00:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717719111; cv=fail; b=FnXYpH5JK6P+D+/lnHXeW83uUbhlMLl6Beff5tRMeiR7l61DY45Rg5EgQA/0bupeAA0XHRUmCfIPOucB7HfAxv7zxqnxQJNfF7a1E0J049h4M1PGW0jZaXjsmt6qJWjCs2124/JNl5BdYYbZvElf3gvEiHj30HoawfIefYwKZQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717719111; c=relaxed/simple;
	bh=cNMPV2nkAUnjJaznYcGxBLqPkIj1u4eW/QymrqQwbnM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ag7uGOkXRPIpm9U6wwLmGVGE3rLoJBLKq6jX2/w61c432qdxbH15irnBzVM/DrP9xKBXjNOUrHLF7djv2aaJfVmyt2asrW4Asi1dT7jEt8QhFo3SC7rS/mUl/0S+y+uZ2m9m0BnXUTX70ciL+DySl6cEuBR1eCaaFj/tksJ6XvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BS62xYD9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CyCoQPLa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 456HxRvn022310;
	Fri, 7 Jun 2024 00:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=corp-2023-11-20;
 bh=OrRMMMTiCyuXhBFNHQHvtoJwOGIE1b56AtbkiGT97mo=;
 b=BS62xYD9yRyjFyTGfg4HRXtVrwpZNrmbPg6S8VZ6YlH1UenTs9qnxIej3tmo/XE+GpzN
 WneAuaI6QjTMgEveJiGRWw6MnKs4mvp+Y70a0mwCUlruBtbDUYyL4wkhNGZavsx3O1oD
 F/PcwyOtd8vRLgDBrsqS8JP1w/iqCSJhDHLtTRt3zLOemoK/N78deTb6Ed1TDEmzQKkP
 M80JxEINvfHOoAcRIyh0a23GK2EHl9OMs51I9PjyfAa0s/C7AOQkA8ApnDnqtSAcDatj
 lbgPJZhzyq+/bXiSyu4IDaEno4Ry/glgNvkNaH1dcmM4ERXKdRAHAh+ji+n8uKpmA1tX qg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjvwd2mqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 00:11:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45709M79016225;
	Fri, 7 Jun 2024 00:11:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrsdtavh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 00:11:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdO5TWxQ3fLE7V2IUmWiCVJr+kwBfuFpkQYwi2WQRz9bK1Wuud3U6zrBqb4QbwmroxCc9gDfD5B5lMwpuGBKaOU5RViGWUhJ1Sc7PDyiBRYqR0Gx2Y/nllATMcvW+b8mw9Pvrn/afeGcuYwuSsJ6yYL37Rr7TwuhPyPZnbAnzzDHWkk9cRmDrxyYGupwsfg0UhyFHhHrm61MEGwmVXCWCHJ3GE/ciIOZWljnH8kJpxmG8tjduxdFR0pTT3aPwa5GjexTq9hyI80zG7glKbUrccXdkldmahFGZNEGvIRM4XOjUIryFLbQddhYnmn0/H3RUVqg3GjxFNt01fCFwG4eDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrRMMMTiCyuXhBFNHQHvtoJwOGIE1b56AtbkiGT97mo=;
 b=Rvc/EwwbR/dQmoyaH0BY6be76rJIrBWzEBv+Xp1/Pnc+jpCjcsr74L4FgTt9Gx6LDY5nuzZi24AafNo6mE83J7bg3q/crXu/C41x7stC7mda3nYpAXcM0Kj7ZZoZknKGhPxxLbjMe128alD+1ItJTNMbE+9nBhejgHJ81tXlg8BN/ieRDIo7PWzuMDaR4JPOlTBI4oS3nKQgZXhDrAR5dVRUPDY4To0wA/3mG5cLDranNhhTGb0Zu5s9PWdVajdcTakfolUBI7y4FA18Izd5jfQWYSN2+BJP11rJ/XaJd9HZtNTN4TAjBNuVMr+HyFHll+8ZyiagSzrrpVRVYWGbhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrRMMMTiCyuXhBFNHQHvtoJwOGIE1b56AtbkiGT97mo=;
 b=CyCoQPLaY6CIJBWJfL5497g5Tkv9ibLDcAIV4xgoehc8EiAhuzXZJMNEr1m6DvTcdM/FDiEG61rzFtxPyNQA7mFrT8vSxFKfVqhJZjN7B+QvegTQo7hMlX9UubqA0LSsl1dWs3FwnVwBtrFfL1HWzl1/3ugGyUeBTxV4ChDU4kk=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by PH7PR10MB5830.namprd10.prod.outlook.com (2603:10b6:510:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 7 Jun
 2024 00:11:18 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.7611.030; Fri, 7 Jun 2024
 00:11:18 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-mm@kvack.org,
        Omar Sandoval <osandov@osandov.com>, linux-debuggers@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        Hao Ge <gehao@kylinos.cn>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v3] mm: convert page type macros to enum
Date: Thu,  6 Jun 2024 17:11:15 -0700
Message-ID: <20240607001116.1061485-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0041.namprd08.prod.outlook.com
 (2603:10b6:a03:117::18) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|PH7PR10MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: a953707b-ba86-4dbf-6573-08dc86865a5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rxorFB5LdZJQqXlHbVRW4t4zwc+qCQKabBl9p59gnB7lvRWQaGYNV6x3twJs?=
 =?us-ascii?Q?KpHXrbpuF6MDwHQXQPgGjLScFo8NiUY00nBoYVkRKXxjh+yadPnCFmu6HBQY?=
 =?us-ascii?Q?mOH0U9R6lFV5HYWBa8eYGG0vill9Ft9KYvWiLGXSp2kl6eY+9HSBINg4UrhC?=
 =?us-ascii?Q?3aIZWr4EouUHz5ulM278F6rCPWiRqqF+j2G7nrGDQ5MTCqHsWK3L7SyVK631?=
 =?us-ascii?Q?7aZ6vw4SkJGJXAHUJ2l+dn1lL7sRkU9PGp980F5QZlDZaOivTLOWydM+9VSU?=
 =?us-ascii?Q?Zz/gADckTJCDhxdTCoaBeGqBvaePpsocYVXnELKeFuPdGDOpFVl6TG9lXADG?=
 =?us-ascii?Q?5xYOXw+2jdpQZJAThohVrmT6TvO46EpEMNDNSTtctO6xXp+UDkAcVluqns93?=
 =?us-ascii?Q?aQxS9NEE2tkDCR0ypdMsWLUlReQjiQ3iHNSbLP8ZD8qINLm4RWXKLaIGzN2Z?=
 =?us-ascii?Q?kyHQat3UANRx/xQDDQyvkq0Eril6qgedMuhyH3mtEFhRRKsof3Q6gFEZzsV0?=
 =?us-ascii?Q?U1R4oPQsClH7Z7Ch6Shs5e6i//5liObw6h+ziu5k2hO29031kJ0hsB4x6WqF?=
 =?us-ascii?Q?Kpt7eWg81WMF1hLi0nIeTlCOee65Z5lOkz2dt++eblZryXb69afnrYhUTBzS?=
 =?us-ascii?Q?9Qn52WB45SpfPDFjCTkd9v1glleUKqATJZ2RvpbgzKzRLwL4MuS/te3n4j1f?=
 =?us-ascii?Q?1xO5ILpDjow2tyg4uNcqcJB+9UHmlLoxICAOigLCXatjtUxBq7AvqdfuNzDk?=
 =?us-ascii?Q?pUcTdJb3QVeqQ61Yk7Udbq5IWeG222E/xGdOd67oMJdARo/n6SciMJ1JNISt?=
 =?us-ascii?Q?3z+5M2VOMmwXTJQmRK/cswabTS6cx35COnU5l6Ymgod8+qcjwYon21k7Edm0?=
 =?us-ascii?Q?QdyHuOURePklL93nofSm1ELFK81FXcY+N6yISE9G9EimVW1+Jhjs0tuWNL7T?=
 =?us-ascii?Q?uDllLNFiXxSWe5EsJ4sUEEc3VaFcjs8nUxepSKhUNWApKVxbzNp4G99wccbz?=
 =?us-ascii?Q?Bg1vtzUEmB0AU3pog1lniuS0lAP0M26oxJYY9G7F4lcOaPalp7tcrEyCTmlD?=
 =?us-ascii?Q?KC+v4tCq9dRmfGTIRvkA9jLfERshc1AK2uG3maFacxmXWHr1S+RkQi8VrbaG?=
 =?us-ascii?Q?5hVwFBTosvNztUEEmjLt8K1uloeQvOK+XEf/mH7v3IAxFA2JRxM7LFWNAIPI?=
 =?us-ascii?Q?KLhtrWj99PKzpGkfxWzlUdpBiaOGa3mXjNPAUJSGAWEziicxWRxW9sBKAjG6?=
 =?us-ascii?Q?35ckEuXOkdTVmq6P8fHyP6t3OJYN8xf90B33pDxT3Q1uEHDs+X3eXnxbrqHy?=
 =?us-ascii?Q?q6+eRwyTqOLaxTyKhMBIg5W4?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?I3cDBm5S8msK58UjG0D1naqNwiTOJsqmpkcibo7CkkS7StNOhnFij2X5z9+/?=
 =?us-ascii?Q?EizqAV/thCDg+iRLtDY1db6nHjonXNS/RNmhgmJzKusLblhhzQIKY4jIL9hX?=
 =?us-ascii?Q?D+7b/sIoDk+U4t9kAS6xd7JY+Z23AnypVlL4sSkfJ/0fJSUMnOTSKCVkhdGC?=
 =?us-ascii?Q?A0F6lQo3O+cTiaBtvo+XjQbkEUEDKrEoeuW0FfzemwrWATcZ3gdwVv5ZfkN5?=
 =?us-ascii?Q?M9fOJYX22Et7V2pKVbpII7bt7fsMgEUxDUifVOaE8z1N4XtBiGmTCGr/3zEG?=
 =?us-ascii?Q?B454zL5YEddT7JlRPjeDQmsOyZqxoXOle8/SJl6o0H0dCXfh8ASpIKXZBgHM?=
 =?us-ascii?Q?wwrdjMwd6SZuFhNMtfpBDwUILhCIiBXGfj3DSDT5plyML8DyjSIO7ECouxyI?=
 =?us-ascii?Q?e2z1TicKxFjysYblGO7iDAh2aqWvEpMA+XcPq29AXmuvoj3VgboInU5stIDN?=
 =?us-ascii?Q?i86OWQkx69rRNyGLd/1cvJZ5i08KuEgIFqMLdXu3TdVOSw5kx7VghX2ndepf?=
 =?us-ascii?Q?HSDT62NE21zV7w/+DtVR8yxHpLNfpef8jq4yM6tbKLw4Se9GsXemuequGtEL?=
 =?us-ascii?Q?BvPlAc40ilPZySyKonSc5s0NMEgmKsWIR5K9ZheFwr9nYYienHLJTO9QbtHI?=
 =?us-ascii?Q?ly+/XusrDmfHB1bLIFC8Yl+nIQJh9sfKARAFqzkJ0EUm/37QOFMPK/8dvIRs?=
 =?us-ascii?Q?2spqBu0h8j8jRbaNGb45LHsdaX26FYe2dmpcC6kYSqc15kHBgHrG4sRpcH0+?=
 =?us-ascii?Q?sfBlPLYmqVI/GT64rvfy3fneYUJOBgzTnUoZuWU0jmyIBH00iYblysqgk+zM?=
 =?us-ascii?Q?8BQ2NdJ7OIKEMWdokup0MjXHfezHHgzb/gzaAn+Td2gsW2rsA0laS0Xdx6UO?=
 =?us-ascii?Q?M92YA2Bhazp9gUhWK3uRGETJc+tPgBSLSlVt8Sm6WEHze5WX1xt6bxVYh2Wv?=
 =?us-ascii?Q?qC6+GVNTyF3uuLuaaX1N/CbgCHIgzIpINIlgHft3iCBbbNQAlpY5lnI9/fXc?=
 =?us-ascii?Q?dTsBVLCl17bzUfgrMgCj4ZF73sjTzCBuiOdXvc5nAhkd+u+pjYMe3ag838we?=
 =?us-ascii?Q?wjFyr4KQu5g9IFTyCnhSXxdoCEeaF6mGj9JFWQOEf1VE0kAsuvCow0Nw4iKj?=
 =?us-ascii?Q?r6wPyiCQVj6KfrRTy8XkSLAVpPEStrho8qXRuq0vlge0Olx7LBjp0ThMBecP?=
 =?us-ascii?Q?elQnSAM+cf1AZGRFlDfCaXBBfNDlEnygbUjEa249OvVQ72ZoudvswBWRwc0o?=
 =?us-ascii?Q?pIwHGobHr0ssxcpIlFGxL+XDSeITicXDATM2Cf2z7qm9XVzbj0hGPUE43PnE?=
 =?us-ascii?Q?hOQkSmXZRgMUKzcBbc22jnBHYPVzTUHAmy8WiXm1hgLVsPYi7DrsFgbhDr9K?=
 =?us-ascii?Q?fiA3WtnOFtFgvx3uFC6GaJwf42LvhoHXaoWiGN5qe57f+XqLxGHZ4w7x+TF6?=
 =?us-ascii?Q?hi/Hw8u8xN1FkXOZKWRFi4uH97tF/8lAMyiXaT2Y6VnLAMvKjNqmcXToODI6?=
 =?us-ascii?Q?9BxAuFwojMJksSkRF411m7HgH7nv5PN4GzJfih+LGfGRqCDg3dcneh2nLy9/?=
 =?us-ascii?Q?s34pKnxATqN26d00UWZ2vS3WVKOj7gm+8xykgALZRWpzBXVqEJ2YQp4hcD0p?=
 =?us-ascii?Q?GY1wDG6yfxetqcvG5nH21xmhObmtQnI6252XilvpM3/pFB/xi3jmClQnE2Zd?=
 =?us-ascii?Q?ZuKLiQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5pSMOHlKXiovyHT4vgBHTre4kreleSjglQn0V/uTboR+zKvOBRRyOnMdyMuK2Dxtcz5nhtJ1dRcarTj8LuXrHOcHpTSv13HJlwLj0lQbrZffaHPg4PhaKQuYkZrVATiL7oEOKfMQ54V4jGVCRJ/wTdYLnvy7dx2qVAyaISYLndRlmurYzzAEt888hRyVZXsIsgmCKNs8tOYuAQko4EJLFiGk17s9JArnDalqdhQTXDNfbxV7SaDLSffSdgvcALkFJ6qlnqFH0EBX4yBqha1fsxFhLImyySZqy1r7STWgy1lrw+mdGnV3X+4shnV4g+a394w/8HQscb8s6NV9gNur35PZ1lExMIiG13gXFcBq6wrIIeA4uRBvOw98tVfr+e6jxxY0VuOklZepwGMe/tdjrfzfEhSfuP1GI64OSCUjq4Gm13JaNixING8J5kHjb3Xe0ME1ELk2Zx82N7V9aUr8uy+5vA/X+zj848IuJguDL0YYSfuALLMzP2zEzsb8km6clx+0Tnusdpxw4ITU7d+h4Q342S+gQdYPaNnDp7vt21W65xYnzch8UIqKdveh1qhgGcJv4SlsNAM1H38aUxAKI994jqixi5sKCZ9tsnAJStA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a953707b-ba86-4dbf-6573-08dc86865a5a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 00:11:18.0448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EN150q6ToYnP4eeZF3Xq1nv4yhw1Kvjd7rFvlUo0L/rIXb/4kuRkC8vLJya6OuvAaHyxeUDQo+2GZ/Fd6496EjHE7ThHtNOJfzgpP/DfE+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5830
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_19,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060168
X-Proofpoint-ORIG-GUID: IpfZ7y8xIy1SgUmqZGr8ehY5oNx9UMlo
X-Proofpoint-GUID: IpfZ7y8xIy1SgUmqZGr8ehY5oNx9UMlo

Changing PG_slab from a page flag to a page type in commit 46df8e73a4a3
("mm: free up PG_slab") in has the unintended consequence of removing
the PG_slab constant from kernel debuginfo. The commit does add the
value to the vmcoreinfo note, which allows debuggers to find the value
without hardcoding it. However it's most flexible to continue
representing the constant with an enum. To that end, convert the page
type fields into an enum. Debuggers will now be able to detect that
PG_slab's type has changed from enum pageflags to enum page_type.

Fixes: 46df8e73a4a3 ("mm: free up PG_slab")

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
v2 -> v3: rebase on mm-unstable
v1 -> v2: include PAGE_TYPE_BASE and PAGE_MAPCOUNT_RESERVE

 include/linux/page-flags.h | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index f04fea86324d9..7c0a8fd2c8c17 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -945,20 +945,23 @@ PAGEFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
  * mistaken for a page type value.
  */
 
-#define PAGE_TYPE_BASE	0x80000000
-/*
- * Reserve 0xffff0000 - 0xfffffffe to catch _mapcount underflows and
- * allow owners that set a type to reuse the lower 16 bit for their own
- * purposes.
- */
-#define PG_buddy	0x40000000
-#define PG_offline	0x20000000
-#define PG_table	0x10000000
-#define PG_guard	0x08000000
-#define PG_hugetlb	0x04000000
-#define PG_slab		0x02000000
-#define PG_zsmalloc	0x01000000
-#define PAGE_MAPCOUNT_RESERVE	(~0x0000ffff)
+enum page_type {
+	/*
+	 * Reserve 0xffff0000 - 0xfffffffe to catch _mapcount underflows and
+	 * allow owners that set a type to reuse the lower 16 bit for their own
+	 * purposes.
+	 */
+	PG_buddy	= 0x40000000,
+	PG_offline	= 0x20000000,
+	PG_table	= 0x10000000,
+	PG_guard	= 0x08000000,
+	PG_hugetlb	= 0x04000000,
+	PG_slab		= 0x02000000,
+	PG_zsmalloc	= 0x01000000,
+
+	PAGE_TYPE_BASE	= 0x80000000,
+	PAGE_MAPCOUNT_RESERVE	= ~0x0000ffff,
+};
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
-- 
2.43.0


