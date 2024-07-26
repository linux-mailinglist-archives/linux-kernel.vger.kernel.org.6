Return-Path: <linux-kernel+bounces-263659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D3193D8CA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF10286B1C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E365482D7;
	Fri, 26 Jul 2024 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="If+6QPtA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GlGCmjbe"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CD6335A7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722020217; cv=fail; b=NxyZr//Tr1xqmpJSf3G8D1N31ZyCodRGgQAPPhnXFwUGwzP+jjrfOCCUXvPFNmDKiPjj9w9P2wRObxHun/sgmWMVXNJjwz2nEIesk0sV+e3bCkGqJYWc3RL3PBsTJrwc5pC7xdBksG1ASFuHDMGmSz8VMS3jJTziVvIZ+REIWyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722020217; c=relaxed/simple;
	bh=/1Y5oCw/44o4kmJWIgHZiCYP5+j9eeeE+P6EYgxuz0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NH2HefFkgXU2AOdW2HiB/TzGl+brSICzJ4XkvVQLrHFsRb1VAYe1HgwwVWsZ8zwkcZZMJV0jyiTp/H85i0jrNAWsqq0XDHPqnpV71ZIkTx/UD3pinlY5CmtigkLbqXisF1B7h/KYVgulcgyw5BweEoPyOmz1eNWeAnxohPhD5ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=If+6QPtA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GlGCmjbe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46QHt3V0012583;
	Fri, 26 Jul 2024 18:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=FxFG3d7RG0L6tue
	VE7TZxLRf2ipSNhxg7rKNLa+XHv4=; b=If+6QPtA9Vi5Yx9wYpcddydAVMUEEMf
	1znlB6VZCxfJvXSetdfGOL5Le9yW8MBV1fG9+5mnEDq0qGQdBcxrXWEQb5Wg0O4C
	0MO62m7e17QgWWqfus1+dqaRSxxqp3I3kkOzI8+9RtO5E4eoc8Hd93rL8DhFMasx
	YuenoVk1bd0VOfUwvRKJAcAuoA4mtyRqXO9qkXtdhaZlQz+tDE7ZpVH5Bp6JrUEL
	MHf0JYiBBvOO1dWUstN1fPS6qqLjrpkZm4XTlyJSjKzG9PR6ckO5ajbeyPTTxDZ/
	DXFDn6LDbs1YtJESSAXXO+CeD+RQpRv1peYK8hHCaS5HqmllhRqsk3g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hft0p5uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 18:56:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46QIdrqZ038919;
	Fri, 26 Jul 2024 18:56:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h26s1m8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 18:56:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLAe+locmCZAyD7SXdqNMYwQs/zmZ3UTDamk8RPaLbnt7kzbzPBKxwNIgzrirqC8uTG/nSHnrj3Yr8xE+sUgmtI3wWV5pjrtLoLXXkFmIN82ep2y0G9qpMoFCQ9eWKrww26lkMyxXjIpZQAVffBciBjPHrda2IxCItOYDnGFhOfrRRU2D9/hQ4+hwTW/Z64D8BY2KnxM+O0QfNn/rw69JNy0gvO7AUyUz+QaHqmIqTevPu0xuc0wlb2VO250d/NNRTA0ObeRuEWcbJg+QaZhSHlRRAorMocTkJNK1P1/vb4LRR2LBt/YTuaKMGEKeYKNIOztmM6Zvy794t8cAIXC9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxFG3d7RG0L6tueVE7TZxLRf2ipSNhxg7rKNLa+XHv4=;
 b=o9Xh72DBiTD6Enr0fa8pT+H69v9UZxfjWYYeuhpfc3YrRrG/A3oOK19wNM7iZtcDJAU9oiuwOkWTTwYwiKeZS4okAHV8trkKuaJkiXoNMimsRdfXnnhAR//Lw31q0SDGWQKcDNq4UP8cboADsAIKFUG1f6PyeZUEHNPznhiABP0GEoxKno4znYC+VMkLZJPeZXCPHXcBeslqmUiBBOwGWfC1D3bRrt8u9v+kKEAWUr3y1Oqy3RpRCRErCJCsiQSAZVW1KrA5uLXlnk8r0WJQbcVBHS+/Z0bQLJ0xShHfTYgk7nkPRAqNxwqLsxEI2L3LJ7eHWnLicnhICPqtuVP3OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxFG3d7RG0L6tueVE7TZxLRf2ipSNhxg7rKNLa+XHv4=;
 b=GlGCmjbeGGe8HfApteQHnNmcFTHGy6g1UWUvye0nWnrsD6PfF29bs18pwg1mhYXKciNPsx+y2Uyzi650PbMByqGyoZcA+jJPid0dgWR0OXnlRI3bQmmV+vZO67qFqJWhMU1X9phwt6RlZv0vbLBRAS9QUPJU+6tLgvYKOoc5ags=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB6270.namprd10.prod.outlook.com (2603:10b6:8:d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Fri, 26 Jul
 2024 18:56:34 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7784.017; Fri, 26 Jul 2024
 18:56:34 +0000
Date: Fri, 26 Jul 2024 19:56:31 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, "Jason@zx2c4.com" <Jason@zx2c4.com>,
        "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>,
        Mateusz Guzik <mjguzik@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
Message-ID: <137646a7-7017-490d-be78-5bd5627609c3@lucifer.local>
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <902a9bf3-9404-44e8-9063-03da3168146a@lucifer.local>
 <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
 <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local>
 <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0324.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::8) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: 9223a8a4-8062-4755-b18b-08dcada4abc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yyv+cxa+4hMWvkKVSyqTmhmok7dRkdTG38OWFauXXghtdcIbZ6TDFU+scA0m?=
 =?us-ascii?Q?hyMJr3XABQBk3f8e2xN34ajmDpUuh1ME6odDw8cVQP2i/48SG/q4EOmr5rdI?=
 =?us-ascii?Q?CN+rxvkpDcjL3AbBkNiQ2MEMHJS7uCkVQibgTnnV3BGPGWgDEQodu12kv3Hg?=
 =?us-ascii?Q?yhYCRU3VM7LjW0PVgngubu1dhu0U7UiLOpdtNz9GSVURGiwbJHpPFyHEJT+0?=
 =?us-ascii?Q?Ve4Ao7wR+Zl4LM6vawZkWzN2nFZaIL57wLftc+CTTHBFv0uQOlv6kvLftDoU?=
 =?us-ascii?Q?43uM5dXEvBQcZVWuwCG/Brc4NrvPqm4eRkkNM3+pS1Z6jRtnZZCGfy2IXLiR?=
 =?us-ascii?Q?Oikw3c8aCF9K7QGsnbDGIyHIM1/4FzxEc1qSMrW/JlJqwcztCRieVuNz0PQn?=
 =?us-ascii?Q?4i3xDFoAQ1p1p5SKrh+3P9Wl0D5t56uuNQ55JZULcf+FCxasvtvEYJUX77HJ?=
 =?us-ascii?Q?RR0Y4Hx8UsV+5i7lyI0nCCwrWVNSnRJSnBLfk97d1Jycx033CSTZjfc5D/+9?=
 =?us-ascii?Q?iImXTmPl9CfCYx283EbNOg7kBp38KFNHTOV8cWUqQxON/N0UGJ5Z4fbIEBbA?=
 =?us-ascii?Q?ojxi7zX0D4F9E2l2F13RI6ssqIqhWhGtHyWIURbs9lcaRmmaOtSH+NjGGTg/?=
 =?us-ascii?Q?SPXULEC1f/jr3Q0FLGLmDYt9ZG5YNf7zehOVEqWu6e/dCKiJ37kocUP7BjoK?=
 =?us-ascii?Q?2jvX9iReFfhtT1IEJg7wYNZZwe3bk6SrwWEuRzSzFmJ/CMzFc/gu3cPBzh9E?=
 =?us-ascii?Q?34COOuHnrhAlhRwJFMVg4hBAKqZnI5GePz2GiOF4Q96Am9qRpykqLiVObsYi?=
 =?us-ascii?Q?CNwxWhs4ejCsEIIKFwNR9HdXJlGQVvU+9GQphG66X+OUtcuZ5O6cE2Vy2/CN?=
 =?us-ascii?Q?F7fF3MvRVXZs0r9ZhN/Y2Q/+ezrTHhTuYwfnxMkUQG8QZMiOsKVxBjlgT7BR?=
 =?us-ascii?Q?NsbIKqiML2rjz2tL4M/BTzlJeU7BOHqbOoDs9wLXuBwvMYzUiiTNrNroaMjX?=
 =?us-ascii?Q?Sv7zAz36cLSZZ+GmPtRcr/cKDBr71Rr0hGek3XUVbtuPoqjZ5gYXJT/bSsbQ?=
 =?us-ascii?Q?7PpjuDKfvWnxK4/63QQh3Wmc9uIFYIpmg8zH3llHwXCjFNUpD1cHPezMRVif?=
 =?us-ascii?Q?4mAk0VlETLmZiYondo7ww2Z6E431TXe3GS+OXUPHXMJ0twPuyozBC3j8268Z?=
 =?us-ascii?Q?TiJ4ZiHbtbc6KUqZoJcnxWruvXW82oI+jb7LsXUa/BQq4lCroTpjqT5Gf0Sj?=
 =?us-ascii?Q?lZJET0cQUEv4eBkUX7KES6anN3CqGgZ88XNCFR9ccfIj8TVdpB4ZbSX+oTW4?=
 =?us-ascii?Q?0cQP6W5RWroCIwCciKxrLPEUwUJAXS7yGVV67cxNO52C+w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ArPFaO1VV1Vj76Ebb/hWPXJVlKR/YEYupysJ7dsIjwId3N59X6NaXE+sm5h+?=
 =?us-ascii?Q?HBV7ZcIQ4g/kybmwDZcsz69CZACWIV+qTdBbbTX5e46v5Kd6/o2xsQRxec4A?=
 =?us-ascii?Q?DH6jYaOoWrTVxW6Y/vrCrg70nGnF+jLcRmL8+bX449y+o9MSdtjy/M7cDKAk?=
 =?us-ascii?Q?ZHi5nB5NGTttkCFcsrJmB1PyyhFrySv4joRO9uKJlq/S4/oYBgf2bfw96l8S?=
 =?us-ascii?Q?/1OgxESBWYvAsJqaDRFe45JjUt06u4erqf9nTCeb6iarYulDVumTQdtF/ITQ?=
 =?us-ascii?Q?gWyZt3qJQZqrJnFv8weTt6jOR8+75PtrbCtkXs/lIxet5UVO3ZTfrr5UZ/1E?=
 =?us-ascii?Q?fJzI5flahvG+gU5afgFQ5uHIMVJDZpMu8GgIl0tfYWhFMIk6K6sJeX+k6zam?=
 =?us-ascii?Q?1DjyGOpZDf/gSR4skNPbSbBxi0v7I6aK8Ket8TcDQkavEKXZ8ZgYdOFoOESe?=
 =?us-ascii?Q?+Xu6YJj4vzIFUga3VAHcE+oSeOVGuBbGtPXaFWwrtoboeUdZ/Uhfq3RM3xyr?=
 =?us-ascii?Q?vNRHjMR5Tiki5jkkneCBD9tsHaUNQ2hBxlruS4Tu78+eQHFmRdFpa9wIWtNZ?=
 =?us-ascii?Q?f/HUixE4J89GiJOPnfQ7UPkKxdKGfhZgoz8LZd5dx7OR/cF5EDPBduM4nCa/?=
 =?us-ascii?Q?Poo5UTs5RBrU/JisSPFmPYmiRm0gQ1e0ui3raXNml7occI8qi7Dxq9+Lb/3X?=
 =?us-ascii?Q?k75kXL067U4z3sxknVyu7oefF0sJvlNS59Pw7lyC50AfByM/VIw3kCj7qBeV?=
 =?us-ascii?Q?nezkJ8a9hGOOBRfsK47QP+CYmUy8NQMDRCXdD7Hpt14mOSmf48HvsFlf7B/G?=
 =?us-ascii?Q?Px6SATCxZgKTZUtxRUkJKZQlvhagyFrrVQw1vxjazi1n4C8FctHeCTQ/uT1Q?=
 =?us-ascii?Q?NeT9/d/jQmuaAD2MGM72Ji2m0SkhwGUK69VYcjIhxvd4lSRCsIwsXKc7BurQ?=
 =?us-ascii?Q?34CFANZIleCrnbMBA4mojjsotAXCA5JAiYmBy2LMGI0Yb9+H2hI46JXBclgE?=
 =?us-ascii?Q?AK/JkLNNjwdSZqugBlmGdIPynno2OjSeggFIcd0bQ1jfIB2hxenpELjyHEcx?=
 =?us-ascii?Q?RRRNndH7CHI7CmOB3CM2HpiWf4DGEPS319YBcNmFXTcvMGtim5Bz57ViEDb9?=
 =?us-ascii?Q?UbvzjShqhu47G8g2bNEzQ/A59DxFRe+Fp9/P5fl31l9NsaZF84mhoOM31WX4?=
 =?us-ascii?Q?IsoXlDBt9f49ksa5otzNaipNFYNHWw3TegLBicTatSfoImiu0yDOWtQPfbZ3?=
 =?us-ascii?Q?aXtX9zzILVCDG9YW15IRP4n0fv5OLXu7aOK9wseTyb0d2LSsREhEcziiONFo?=
 =?us-ascii?Q?s+ZoP9fne8dT4MlI3heV/F9UyPzb3PzZTjc6Ch3tfxjA26pXShmt3WzEyfYo?=
 =?us-ascii?Q?s+detjqr22ZpchSnx5dcf8VelBeq4xLe4+fI8AIue36ZahEgGTI7ya+c6fmL?=
 =?us-ascii?Q?v87tyG0vMIPZXHojsUGG4vAUi1nko3uTBRTzRq84f+t8yB3o/XlIjaEgq7z9?=
 =?us-ascii?Q?/6rkpTrdZFPMqCZKsfKS+Gxa8g097zr8mwyPKD1ETJ+ldn/Jcy2VVhWloSWf?=
 =?us-ascii?Q?mdxMIdKFkea5S8EKkVdb1oDWD9dMx+vXcKsB+1c5M+9v+iuq/AElLbSyMXxb?=
 =?us-ascii?Q?dhGw8g3p4RzraNyT+yulJCOeBkfQfNAn3ff1k6vSpxVETJPoEez5ZwDHcvWW?=
 =?us-ascii?Q?PZM+OA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5qrOPaZ/gP1aLzX0E4nyB4rXrHxjmsh5j6UkMwXVrZXEkY4yvrqI+0cuJKOSMRH/EoTysdXsJaEzhzuTZpz/tMJ7/X8xnlx1nPVjrZRmUaZ9cSTJs0oiytC/4s/tjFTGu923bHJsqOUBgcTh1xkMALGPVMw8SkGiVXBN7oE9Tw2tzuxBsYM/uM5PQRlQAKIoLlOrKm0uCDnSQRE5ciYWXoudKmPi3fgjF9Vre1U2J2B3NrjM27jjsp3T0jZXOzRswproS+LnQ4HREZfwlXEj2R8u7BLl8UV7dMXQRrmVhrAT7WnMzZ4iNZmiztbe4NtwmCPb2nM3DJrZGFGF/k38u4LlC0E+xDyAB/69IfoI1ftQt3fIKgPUG608jmE7VLT0w0//rjsv9r2GXN8kIb68PPCcxlrJh6WjjZSRogdRtQGJC69nliYqZ68hoFisNF90AZ1ChaV9Lc9NjA4Dyp8ifBPonx2aMyYXjyfOxv4Q3n2VbrRt3a/9FdW0hPpgm0h6DwNsccZN+8Tre10vo05CRNHoQl36bLc9XKLcu+zVKqLNSdZ1qqyWgppwv0oc2zHqJmhaXtFzsnaSN6LnC6xzxPHwg6rC0fwqo+MyCRv9VcU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9223a8a4-8062-4755-b18b-08dcada4abc0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 18:56:34.8431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yw6WLtGFefTE+ZB3vtMOJiYFf11w1OxW2kskwjSez83w6AdK/+yTr1RhzyWptjTmvm/t48hAXl6+MMpxQbV+QcKzv6Y/bQShOTE2d9TWKXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6270
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407260128
X-Proofpoint-GUID: V8FElzscbJWKsnfdQRzNVqW5YsRerugD
X-Proofpoint-ORIG-GUID: V8FElzscbJWKsnfdQRzNVqW5YsRerugD

On Fri, Jul 26, 2024 at 11:24:09AM GMT, Linus Torvalds wrote:
> On Fri, 26 Jul 2024 at 11:13, Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > 5,447,539       ./arch/x86/xen/setup.o.pre
>
> Can you perhaps do some kind of "max expansion" on all the
> preprocessor files (you seem to have done it by changing the ".c.o"
> rule to just spit it out as "o.pre", which sounds fine).

Yeah I simply hacked in a gcc -E, ugly but effective, e.g. prepending
cmd_cc_o_c in scripts/Makefile.build with:

cmd_cc_o_c = $(CC) $(c_flags) -E $< > $@.pre; \

(with credit to Arnd, who came up with a timing patch using a similar
technique, I just super trivially adapted to do this instead).

I therefore generate a bunch of .pre files, + run this to get total
numbers:

find . -iname '*.pre' -exec du -cb {} + | grep total$ | cut -f1 | paste -sd+ - | bc

So I have the numbers for all of the files. Did you want me to post the
numbers somewhere, or were you after someting cleverer, not sure what you
mean by "max expansion"?

>
> For example, this trivial patch seems to fix the setup.c expansion by
> about an order of magnitude (ie 50M -> 5M).
>
> Entirely untested, but looks ObviouslyCorrect(tm) to me.
>
>                      Linus
>
>                 Linus

Yeah this has a big impact, with just this patch we go from 51,407,944 to
4,351,747 locally for me, so match your results.

Patch looks obviously correct to me, I wonder if we should just apply that
now and take out one of the worst offenders while we figure out how to fix
the broader problem?

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> fwiw on that :)

