Return-Path: <linux-kernel+bounces-299598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303E495D75C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984F51F25026
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931C7194A45;
	Fri, 23 Aug 2024 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IgCzZROw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MAqwsMaA"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA07194136
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443659; cv=fail; b=gTUzD8xqU1F/ghOQ67T6RQ6l4yLJ1V7a0SyN2RvsSQajn+tZfH4YVoskLwyAwR89IF9vzyzQEqqMtFflly/zZAZDKa1Ft0GpLaoqvT5sNogCRini+wntId70RQnVhCo5casq0Bd94IGZElIIaRvtupu6RlpizRQYgAWM2WX3LzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443659; c=relaxed/simple;
	bh=9255371KZ2sHJHf4CbdK16c5/Y6l8JP95waxT65TEgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DqnPaAnFGX10AwR1sFGcLF5r+Q4Z0TQOy0yxNp6yF3gR0kdh7KJZyIaALcPPAKSE1wyKLYasbVPJ2fAzK5kRnPl8qBwVUO10Uly/grKzX/Blm34s/GRlCA7lqnCmVIw3BvZGdGSIanDC9yJsBfU1Rp2/6X1YnifMCfRoI0mA4/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IgCzZROw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MAqwsMaA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NH0VJR002318;
	Fri, 23 Aug 2024 20:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=3xTjVIqKqveTebbEp0Zxm5DICHh70p8Rc7Hp9qiX/R4=; b=
	IgCzZROwgOBSH3GwRLNnOgtJLAkBXZPLFLRfgE1Blg8fmiQgJ9sjiTXXtT+DSn9x
	XMRzOY3+kKXnv2ZLOwo/bNs8wp1QHDc2+gaoJBaGZKNgawzzljX0ZG/HL40Qoo1c
	JwnMdazAVO+DcLRDHghn8yiCA9DkfNFXoOEq0J+z0YK9l3r0H3+toK37K0zLE9Gd
	JFvenU5TTV45DWqDpLVWA1w+CAFyoFphh7/olRJZF7r0WTj52T+xbglpgQzXD83k
	Edto4zq07iy0JivyfqCFPSeD2vNCzlF5ffv5j5dzyb/Lx0hEg3whBeWK/HSfkOCn
	ksX+Suta4+SqdVsDnEyDrw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m67n1fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 20:07:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47NJdFFf007123;
	Fri, 23 Aug 2024 20:07:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4170s610wk-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 20:07:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCQa2xxtj/AVGnfmBRJGsbOMejKd20TvdC8z3LB0CzV9vYICNqcJG9Nb6sIytsLzmjF9h1qQrDnPzS1OGsMCwzCdPS2U7O1L39vzAssG6OxJ/S2D1bqMQEdzPC2ZUwUhf8arkDKjGtu5kw7pAhGb4jIyS5P3e/KxrQz7jFHTE9V1d09qmT9v4n9QESX24RJ5EHP2W5rKIj14BGBoVWCuKXhZX+y8hJm+d6FdRz23p8mFRtkC0LDnH16FT/Sk3qPWUpQ/zxJZeVpsV4jcyoOpklLCPRd8pbvHGx6UvfsGSkmh/XsAJMOwj+sYI9EgA8VLBTj0MrTvCevC6O/puGmzNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xTjVIqKqveTebbEp0Zxm5DICHh70p8Rc7Hp9qiX/R4=;
 b=yb5CwtencIvl8qIqlS7Ey2BA0AMxd70IiFY3QG9u09umYejVMNEdLWc/a8Us7QGpAZd0Q1BN65drmHjZbO3jOU9MLrc3vQEZ3o5CvvJ9pI8R3GvWG5k0ZGG9izyp/7FDkRUGq+bymvuJM/XnUvxgeTvR74CsMe1XfVuvYRlvAjlvZQQhHLRjwhjiH1VoaDDTkEcGcgTePdpdWmWlmqvNiapl3yBSEIVR70iDa4rO0Etql/Ff/m7X8v6hECg6tM189IZUGP7XtuzgoGydHgntf0zNw08iiiGAZPmzhdWeritPzyL6yvmEWHOOyrY+hGbUw5lMOGpCNAkD+kGFxzoWnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xTjVIqKqveTebbEp0Zxm5DICHh70p8Rc7Hp9qiX/R4=;
 b=MAqwsMaAhucagrtkUhA4qwdeC39SLkJGxfqC73vIAu+oKmfqOUN2z5BlmllEXPTVp8jT7S9rEdh60GegQhYoBUvimvqw17XvdLJfKyO+2rQH/qt3q+VVnfxVg9oYEEVEnuY1cMuA6rslD4l0U1hSZjdLUzmjnP/4HXUnZVTUxIo=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BL3PR10MB6187.namprd10.prod.outlook.com (2603:10b6:208:3be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Fri, 23 Aug
 2024 20:07:19 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 20:07:19 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 04/10] mm: remove duplicated open-coded VMA policy check
Date: Fri, 23 Aug 2024 21:06:59 +0100
Message-ID: <c0b2c70cf5c7a036c560d9ddba7b2904b84ab9ab.1724441678.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
References: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0145.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::13) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BL3PR10MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: d08ec701-ebdb-4c0b-2594-08dcc3af317a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tdj0SCr2QlMnuR1CExpvBR+dWdCsz05BFU9QfcnjPYULUg5WOv41jrQ9zBOb?=
 =?us-ascii?Q?QzLPYBL57ARar1tJy7ofiBWPwj4XLEeaTRyl9/HcEKLoG9rm/cpPc+gGa7lx?=
 =?us-ascii?Q?jhBdkvZxRbqZ8S0k7YXdO1GhKoJvC6f1yLFUQ7p++zA2BizdM9FZDv9wOGlL?=
 =?us-ascii?Q?x6ijR9XI/x2lQnY48NojElU77A1zpaSe5NtbS1g++eQGl+8LcUSyRWkqIx5x?=
 =?us-ascii?Q?rurYj5QgET8XKTBCzflpDAS0AjbO/fsNPcnZKAFVUIisknzbpMxIpH6ePfUv?=
 =?us-ascii?Q?CNneXiyErmorqwbAyAeEzlQwp6O+O3OuD5ey/7gQ0SOTuyTMvVCKFHd4vQhg?=
 =?us-ascii?Q?vDTL4dplVZzglRDZSSDIPDsqlDHrtEF5Rc0QVKgtfphtFSMVAVAasR3XDwCZ?=
 =?us-ascii?Q?CqwCQWg0wwvLUyPR9SmbzGQQ77ygludBS4ENVYbDdbXidkMX0brmGNZEvj0S?=
 =?us-ascii?Q?hr1WTtWL+bFJh1z/OWmmivdW3O1nGOqnlvNPxFgJ2lVEqwVCCLpN0GtPOYCG?=
 =?us-ascii?Q?DHdf0UXhJB9BwQE2CXAhSBMsNJXbI8hJlIYCXPr5qLNf40eAkhwetX9bb7rJ?=
 =?us-ascii?Q?KI0JvPW4MSOH2E2F8ttArLlnujbTY1ADfytXg6F0rQYMMnR+5nmVoNvhrBZY?=
 =?us-ascii?Q?B5B2ca9ddv8BoSzt4plD/yuWk+kIkRF/Vn5F5fRS4uoqjRfFqNLn/WWEHDxh?=
 =?us-ascii?Q?24km7bOnt8XwBU6Sb8OuoBFmtyqHQdNVEh9ToXa/URDzvBVKl5uXb2yUky4R?=
 =?us-ascii?Q?7Pgas3QHFSAw8VmXbHDUCbyKjULFOmcUp9VV3Ct6uPGvrcU24U1QH1FBqi7R?=
 =?us-ascii?Q?Xvsku1TZeQd+Znak+44JJgVwDaPRT3ldN0G1PgF9MfkHptpInAYTdXTUZWpx?=
 =?us-ascii?Q?VSW3ixNHwJ+4WA3ii54v6NcTbM+Yy50V43dmeDyyD0HvfR7YJTYEIhU4ToeE?=
 =?us-ascii?Q?VJgmeOGe47LMVwMNbIrnA3WGh5fiNHsDT/ZGHevxqcQ8v8LBGUi7p2G4dNvH?=
 =?us-ascii?Q?AeyP7CAzN2sSeyytsfZ9yC0AgH1ar9QQQjaX2/OD2kGu3lUHsc5eoXYL2dDH?=
 =?us-ascii?Q?jeuBcxgWGWQfTK0/JQ92mIvHGA5aQOt7l0DQGQOC5GkvyHdFbIJ7Ybf5VWTn?=
 =?us-ascii?Q?MqbmCaPVXiyWOVxt2NHuhf062LzxpinxWnFQBqBMEW/ZWClPVktWaIgkq2dx?=
 =?us-ascii?Q?S/ByFQ54JkwJuA8aLtAfcP22IxvkhcHlKJ5VPOjNDJVnAShfuGBAB7bZ6skU?=
 =?us-ascii?Q?bdDKvUfRDJjeUZaI4RuFzD1lrKTLkMDtMgHF6H+0LpY9ysgW4wJ7mzMBvALP?=
 =?us-ascii?Q?YB6cU+EXZyoGqzIxkoxaUJCrA9V2Caq7Y4AnWWW41891Kw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9D/bvyY/rgRV62UIsQeBRqGm2R0IDMPgeyOR7X7V/gnUSAfPVm8FBdrz2URu?=
 =?us-ascii?Q?3e1Q6DiiPpaENb1KxifnsAHBFvyRG2id1TASihNQ7EzICY6wc9lPyHx7ycT0?=
 =?us-ascii?Q?YMROlHxqICIcdt0WJ43tzGShhygB4UQXiS1xcz2mDR50F7F2ot/U6HaO/tvN?=
 =?us-ascii?Q?Mn34pFtkDCBOj+iJIR4XLWWOsF6/2dLLDnOPdeTDhpLgzZ0YMrvJTOqa7U6g?=
 =?us-ascii?Q?OOgE9gBpkyy9oibYFuzfc01HzkZ9L2+SD1BPFCL3QxEQGgMT7rM41zmmOL0H?=
 =?us-ascii?Q?q26PxyIcl6yBIQ9Bc4Vb4HAhY7mcHDXvRC873nHdiO13BjcmJEyATxJYfL5/?=
 =?us-ascii?Q?nnRnXz1KYgyMrWdTU0uujI7LlOHz0jsti18LZ3YJyHtcSURbLeXMD4SSw+vv?=
 =?us-ascii?Q?FuovNNa2lYm7LSqGvU923048JAAAzkmZp+xkREP6Q127EmsfvOMbkurLMWx6?=
 =?us-ascii?Q?xfRJHJ9QJdyP6heROhfOjmUvovaqtT6L8pJi1Pb8V/w6159GfIiVaNheC/sN?=
 =?us-ascii?Q?fg+wDYdCD7HU+p427yAMawm8UTs41R+c0wImBSBO7PqldeeDru2vC7UwlTuu?=
 =?us-ascii?Q?ssYId2e7snZm5LlhnEjQPP7y2bBqXItgrZZFLzis3CpdFKEPT2i9eV7v/pJo?=
 =?us-ascii?Q?CrtfrxupCf2O22xC8AiuKxF77U4sKAv/JUFTYDFEpgqfTqYhE4JNG+D4xS3V?=
 =?us-ascii?Q?7/SfwVLOTuo61zKMQAlcjvwGXsEaZHzJ8Tm50KEmagk/3KcbuMVYhktbcpLp?=
 =?us-ascii?Q?Uxy8g5LSofN8EiPxCe+1d5OdFcNc2uqur222VkJ+p2j5L3E+OiMXrgNqfjT0?=
 =?us-ascii?Q?Ax4MFpNMSMFkQLBjDJhPgHeDbmcD8xml7CRVCsjrAA5DOwoG2NNfAefx43Ki?=
 =?us-ascii?Q?bTTZfYbOvFbw6HHdm1EkRasEUq7VIQ9BeAdqOCB7VEkcLDA3Gsa12SzKkdqU?=
 =?us-ascii?Q?7Sd4clzl5A35i/A5wbMeJyNyMVfN1czONeXOtzZsrMVDZNnxhtObRhHcTl8P?=
 =?us-ascii?Q?bXdB1qAAut/T12iniNPnSdDUV8m1LrBL6RqPwJWLxRkO8lJWCI2FIn/II5r1?=
 =?us-ascii?Q?xcmbBlwfR34SUtIP3xqv3fRZ9rvx5yPUYXpIwhRZGYMRX+k7Umsb5Gw+fZZb?=
 =?us-ascii?Q?/OYHSOAn7BZ6zQl7cNjSYPnquJqwh8J9Vvv5KUq5ITFVO/ophjTtPcSCuhbO?=
 =?us-ascii?Q?ZV7bEVC008xYq7bIQ1EpfTgIsZWw7GFvbgWmDLhOqCXTG4qWBtoS6HbQbBfZ?=
 =?us-ascii?Q?KAFA42g5fgMdZNKQ+AkTHA2C37GL/WI2yo7R8pQ8RFNZ3jQvabHdMeeti/Y/?=
 =?us-ascii?Q?IyPQxpvtfSvDOJkHJ+nDoCp5ATc66VbsybS4CXgVIaEYnLiIb25Y7n6fM5Kj?=
 =?us-ascii?Q?F5S8p1x3iDGDiZYXT5uNhaECryoS82fQIbeP7G5E5MHcmPbUyyQ2zfcyIKuy?=
 =?us-ascii?Q?E4bPlraoIWJmmB+4yc2tGYhJEsWnhsmId15tvZapBX2HAtm0uN0i40kaeiJN?=
 =?us-ascii?Q?QwAKVhsO90T72NFh0OGFFQcXU3pqjH9fXv9kuMg7V9qCMXjW/1/Vqijpgm9M?=
 =?us-ascii?Q?l9HP35aAyZRMnckP0RsbeC10nYn9Sw3/zwyONi6HS//bCcf05DbTqS2zZslk?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pZjgYP93ZJACCb0oogFGFeyYnFjy/F9h4Mxygf8rvZ3lv2bbv2WzhvlSxMxocQiKhZBiCDBQFNrCvMx80GO+3RkGG0CYBAXiXlpIszbIwadOsgpAxOlOy9f11hTHvul6gjr0oJrDJwbN5FV39ezLOtFGtAC7I0qVOceqUaRba4fyjP8vF5XUb95nmPzM2Wg++SC83YyGfWdZxS75VIDe4wMc6QaqFhHXd+4Qok27qzDttFlx0nem1RRXSp/AMn8nZuZiGVKd1hyhN+0JA+vJgMDSZNX1fOrN5/m4zAeLrAkZ9F6b2ABXErCY6ntR/1X6+syL2FuI3eAubd2c0F+che/t31r8ItLVWXm3tP8HGUc8fMnl0KTmxnWyo35+tIL8KPTjzd0UbStAJMZ51sjpVNgX8qiNos8Tgde1i64a9k8g+oBpBMeyhTjf+65CxAFsMYlhEnZSKRjFh0VSLh+209Mfw8qt2xGrrc88/C830ngwJrLclF4y5E5LlygkHPhYh7MKLo0SoEpY5DJVutgW9ESc2G6vM3zyKuo6wfZG+HaH4edAw3ZPrrzNj2vDCeTl3Y/wgfGFuFGHqmwDsc2kIgQfeL7RlDgmc+vpWZ/SkdQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08ec701-ebdb-4c0b-2594-08dcc3af317a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 20:07:19.7516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dy2mVjtMxB88KNrK7fA+AMg5KI56TO9x7bqzuLonqsYR1FAZEsEB0MZ6PODeOn31XtieQMx2DrALcy1AfLgImL9/2dbzJmRcqgca9vkM4q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_16,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxlogscore=983 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408230148
X-Proofpoint-ORIG-GUID: Nj41znAtbQ8N4fq2PKCihWPceeOwYBRA
X-Proofpoint-GUID: Nj41znAtbQ8N4fq2PKCihWPceeOwYBRA

Both can_vma_merge_before() and can_vma_merge_after() are invoked after
checking for compatible VMA NUMA policy, we can simply move this to
is_mergeable_vma() and abstract this altogether.

In mmap_region() we set vmg->policy to NULL, so the policy comparisons
checked in can_vma_merge_before() and can_vma_merge_after() are exactly
equivalent to !vma_policy(vmg.next) and !vma_policy(vmg.prev).

Equally, in do_brk_flags(), vmg->policy is NULL, so the
can_vma_merge_after() is checking !vma_policy(vma), as we set vmg.prev to
vma.

In vma_merge(), we compare prev and next policies with vmg->policy before
checking can_vma_merge_after() and can_vma_merge_before() respectively,
which this patch causes to be checked in precisely the same way.

This therefore maintains precisely the same logic as before, only now
abstracted into is_mergeable_vma().

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 8 +++-----
 mm/vma.c  | 9 ++++-----
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 4066c0444495..c72f50feb98a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1423,8 +1423,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	/* Attempt to expand an old mapping */
 	/* Check next */
-	if (next && next->vm_start == end && !vma_policy(next) &&
-	    can_vma_merge_before(&vmg)) {
+	if (next && next->vm_start == end && can_vma_merge_before(&vmg)) {
 		merge_end = next->vm_end;
 		vma = next;
 		vmg.pgoff = next->vm_pgoff - pglen;
@@ -1438,8 +1437,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}
 
 	/* Check prev */
-	if (prev && prev->vm_end == addr && !vma_policy(prev) &&
-	    can_vma_merge_after(&vmg)) {
+	if (prev && prev->vm_end == addr && can_vma_merge_after(&vmg)) {
 		merge_start = prev->vm_start;
 		vma = prev;
 		vmg.pgoff = prev->vm_pgoff;
@@ -1778,7 +1776,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * Expand the existing vma if possible; Note that singular lists do not
 	 * occur after forking, so the expand will only happen on new VMAs.
 	 */
-	if (vma && vma->vm_end == addr && !vma_policy(vma)) {
+	if (vma && vma->vm_end == addr) {
 		VMG_STATE(vmg, mm, vmi, addr, addr + len, flags, PHYS_PFN(addr));
 
 		vmg.prev = vma;
diff --git a/mm/vma.c b/mm/vma.c
index 74c627ff0313..b1ec412fac7f 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -19,6 +19,8 @@ static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_nex
 	 */
 	bool may_remove_vma = merge_next;
 
+	if (!mpol_equal(vmg->policy, vma_policy(vma)))
+		return false;
 	/*
 	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
 	 * match the flags but dirty bit -- the caller should mark
@@ -1058,17 +1060,14 @@ static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
 		vma_pgoff = prev->vm_pgoff;
 
 		/* Can we merge the predecessor? */
-		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), vmg->policy)
-		    && can_vma_merge_after(vmg)) {
-
+		if (addr == prev->vm_end && can_vma_merge_after(vmg)) {
 			merge_prev = true;
 			vma_prev(vmg->vmi);
 		}
 	}
 
 	/* Can we merge the successor? */
-	if (next && mpol_equal(vmg->policy, vma_policy(next)) &&
-	    can_vma_merge_before(vmg)) {
+	if (next && can_vma_merge_before(vmg)) {
 		merge_next = true;
 	}
 
-- 
2.46.0


