Return-Path: <linux-kernel+bounces-319428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 013EE96FC7F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79971F26942
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620B31D5CDB;
	Fri,  6 Sep 2024 20:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="otof/pmd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JMCuCkAp"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD7C2BCF5;
	Fri,  6 Sep 2024 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725653174; cv=fail; b=Yl3S1qzjZXK+YKEOOX12N0kVOiecBueDBzM3LdWNb1hNECvN56wdXCCdTEd+UzFPhMXR8FuNTsHy6ZYFO2bASuNK9P+RQZjCkQ55DVLkvCAv7gYgF9nnLb/CBeaSKVlDSWyFSl//3KRW0ONbzR2hUpyUJm/LM8qaW3kTanOb6mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725653174; c=relaxed/simple;
	bh=TllP0DxgofKwfS+HUVtt3IRcgpn3jKxfU/gksQJ9H+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H+AJT+XMl2SZ11g+wyny23r/9x3GQR6yBzCwq20O+3LuCOdJJ7omUM4zRbq1E+vMLF+VWLiBJ4phvVZ/qpEkZN0bpD2kOiKVl8uf8YCTcBQPzZH4W56MEUiADzYc6V31eDJG5ktqPRrbgkqszrsoqByO+CH4TvNbNi+l1NhWL8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=otof/pmd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JMCuCkAp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 486FtXKe001858;
	Fri, 6 Sep 2024 20:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=NTDZfWxJQpVS7qi
	0U0bY/8vWScdiAFl02+/R/caF/L4=; b=otof/pmdfYWtTKjvJ9rofE99QHygFFw
	/KT7ihJhNXwE07/UcufnaTZFusRPsBc4lYbxQOawfx+68tIoNcDPs669laHGJth8
	xephEUVtADrbod74S2k9JbwACsrwV2S0vV5YWjeHiHDTJqwv+qABtaEl3Zd1UZf4
	9VoyKEYX/dHFhowbQPhwhUdr05/srJRVjJV3Vs/hX0QdsOwJ+EQ7eIxW8AtCpr3e
	5QPY0/IPnG36R89EzyvtJO38oekySPIaSZD6i94rSpMvexQMrL5OvO5suLqHYdWP
	4HpE/AB+RLKqK9mvFSFl55QMN2iF0iwhDrmQRx2aCmrK+XZ+rBpnMoA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41fhwkafqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Sep 2024 20:05:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 486J5lmn036929;
	Fri, 6 Sep 2024 20:05:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41fhygce81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Sep 2024 20:05:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0Cs1KaXNq4EEPAy1NuPCZb2gU9aKJ7ptgvSPKqWTHLIIzpv0Sx2shY/4sdTlxgmJecNKhPzjfydC35KMzytPjtXh8dDwtPjVq1i0I4WP27G1qi4HcOCP3e3zmpNdA1ya5eh2a9IWF/zdU9o5M8NAFfwfnApBbhk7dTd14QJWJIEsechHuKEC/F6opszyYGzf9GLF4UvguydSWPyPM38C4V0QAfawWMb0MIYhOyMdk0EulP47jcHZZJpRGL2qbdlM/pYZbHkdoVsLkPm+mZgtN8DuUxpZTLuTHmlr3cVvjsvVaO4gwQhuMKA2sqf2tiEWq54SuIpbGTR/cXRB+cjHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTDZfWxJQpVS7qi0U0bY/8vWScdiAFl02+/R/caF/L4=;
 b=cnRoJQAMrXsj+prdFbw9QVJEpsAU5Yv814o3tztEpZMEwpQ6Zo70cwbn7wFX8q/tpzV5106l5gzKeUm3D/QFQtjxMQ0r/2pmBSTLzfJbMhqG6EGPSnPysLG1+dg8KNbZ6VAT5y8aXpUR9R34+E7dRMvHqM65uRErQfRzlJmmnK42UmTzCI/2SQPp1zmsPxUAIKIvpm4GTRXzFuUjh+wmOgqIlRNErnudh+U76I3Bz5yuRYV4ZQkrSYNLV9aeOddHk0ba2YQTIwVJpttjvxa+z8d+w/yCkyL/pntHNQF4XoKoSc8OJVN34gq2jRS41bPfi4sEoSd1AXzoD87K7fnEAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTDZfWxJQpVS7qi0U0bY/8vWScdiAFl02+/R/caF/L4=;
 b=JMCuCkAp8ymxbwJ4M51f9mgk72auuJ3S/d+iz1PLFDGS7TnEKIGeMOTT5cTDPt4zauNHwk5CU0sjm4BjidyOTTH/JPY9wehcR8dZPmtmftsSjvuCLYRjE1nJ/vdj9RI9itWtZlzPRScKGug5DJCBVKg5p6gViIvDXrt5L1kewpM=
Received: from LV8PR10MB7943.namprd10.prod.outlook.com (2603:10b6:408:1f9::22)
 by SA2PR10MB4634.namprd10.prod.outlook.com (2603:10b6:806:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Fri, 6 Sep
 2024 20:05:51 +0000
Received: from LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d]) by LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d%7]) with mapi id 15.20.7918.020; Fri, 6 Sep 2024
 20:05:49 +0000
Date: Fri, 6 Sep 2024 16:05:47 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] maple_tree: Drop unused functions to fix the build
Message-ID: <3murs2k4mouy5gkzyav4ttrqanhsc7v4hpghmuutkokvah2o2v@pkddt5ziu33o>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
References: <20240906150533.568994-1-andriy.shevchenko@linux.intel.com>
 <krsjmi43ziyojqicc4pxzwfwbffqrnk5npbuoq6l2cnq5eovkd@afofyteb5wo3>
 <ZtsjJoGKRxszp-m6@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtsjJoGKRxszp-m6@smile.fi.intel.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::10) To LV8PR10MB7943.namprd10.prod.outlook.com
 (2603:10b6:408:1f9::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7943:EE_|SA2PR10MB4634:EE_
X-MS-Office365-Filtering-Correlation-Id: aba18d18-26c6-46a6-b7d6-08dcceaf4d73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tV18gtzQzOoIDB461Zwmlt2TOZ3lBLMUycr2zfoxyOb41WZWhtjaZfWR8L1Q?=
 =?us-ascii?Q?BbSsGdmO6A6ahy5j9p53AiLANjxPAtzJdq+WJB6YXzh/lBJApO/YWwrXHteD?=
 =?us-ascii?Q?FXo8uiKdJ8k3Yua+538WWghHoUUpjo1i5hQ/SLH2nB1V6nPbzWFMEMAn/ez6?=
 =?us-ascii?Q?GHrN0oCPXmqFsboUSZtejKqK9FqIAh9qc+L0bXoOpaOBmlP1U+rbmGR7IcKf?=
 =?us-ascii?Q?N4fBlAwuJUvhSH6ZrZgaq5Q7XAS2ECL7ZsdzqXvaSXLcx1FculWFLPr7i2M+?=
 =?us-ascii?Q?Jw/VKZHBfnuQPLwrXGkmDs+x5JfknFsk2SeVVDFe+8y+p0WAiy5ZYO09o/Zp?=
 =?us-ascii?Q?KB5524IoBbf3quXmgE4AXnMFpdbhrYh9xOJTL00niQ93keT+6wLS0aEXbd34?=
 =?us-ascii?Q?umrx7HmAlbJpuIQJlRcdJpTeEdjVXzSFMN9spvnHMussT1h2SQbwfS//ZZYs?=
 =?us-ascii?Q?AHGTXZviOsVtw0uFoMJDn6smrGEYhiNeXwyuekZMPihNOz3mBqehpPVhf7DH?=
 =?us-ascii?Q?LUNQ4dQx2jiK20Ybu23eSb6/3jCLTc1ofA/7DPuKmeUr0+N1ouJpL7kQ5b4w?=
 =?us-ascii?Q?FJLP7CcqTosMACcFiTq1rXVuQF8zE7SyFKE0HylxskfZQ5GV7HYlj2txl4ay?=
 =?us-ascii?Q?D9BX1oUx+itRSl0QY8CeV6rFgfALiu1ehwtB4A3NBAyj3270XfZ6iS+Ft2RG?=
 =?us-ascii?Q?cTva0Y8iC2dpR/7E1stLi9kDMYa2nQHealVI2bvHaSXvla/xqyn/LxQLvfR5?=
 =?us-ascii?Q?3ohxl5sn7WE20pAcBLuvfATNTv+AhhnVAhWDPoRoV5AXGJP/5+k6txWqnm6N?=
 =?us-ascii?Q?a+dH+u7sX743g1XiR63Te8iYTKC3EcQL0OopGueRrn0LrDRckXzsYiDRtT6o?=
 =?us-ascii?Q?bWAwIiqx7r2b4ajiJYurKrFnz37ptOQKI4IBc8benqrWqJysSKrGQCthxd1z?=
 =?us-ascii?Q?p3KiwAsCHYRP/QrTOgIpI+HIRx8GmbjyUpVl862mHcxmOa7SoKt26Qn6eFi0?=
 =?us-ascii?Q?+fqnJQdA8F0IqCn4T11MzCMuPZK6tpBl5cgGEzbfcONdPEwt19t8X8sFoKJt?=
 =?us-ascii?Q?FS0zaGLv4mwlJZPlqq4dbAwOrFs/5skGAFW9wTGjDWDSarGm9acp/3Bmfkda?=
 =?us-ascii?Q?axk3NBgkYd+W6P+GIQiReXb59i4RUi7msuaobxN2skRz2BAfUA7R89uU41S1?=
 =?us-ascii?Q?rCc0aQeWx4p2gDnldDukQ5SjpOnT72kCaZa6rRDVeqF6jqpcpQAmvfad6tZr?=
 =?us-ascii?Q?eQyjHK/utBtD/u+Pcwu1tsr5X9Em1GUidB8C8duOz5CVPFdU/l7Xno60Hgfd?=
 =?us-ascii?Q?rv8YGeh6+CxVDkOSTs1G1pV7MNGlLujvkvVTyiVV/gApOA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pw/yWUsaAkHXOSECAwkr/uzLdB9fgUhaCO/xoUcKkd3rIqvakOYAJNTktRYb?=
 =?us-ascii?Q?2HjN7fbLQupdEtbC8pX118f7IjHVbBWwnFvkbGJ0VGFstFCCZRPyZ2K9AUWN?=
 =?us-ascii?Q?Vxp020w0ORwipb+nEqn5FaUpDn6EO9vx8V79ssfPPTProqJuOo49h30DCPMa?=
 =?us-ascii?Q?wmByaAEqzx3y5hNp3NF6HzBZx1TMUsN46bt7W8TWZcloFCOkFZH9fdjLBxh/?=
 =?us-ascii?Q?MbyJeBGcRCFRY+Yynn8DxvToY9VO9dPyzpcvlmUnOog3ed0FmNRm03IW9oLc?=
 =?us-ascii?Q?q4gN2tuctVXHFAS6DsdpZyRJl53QPoq5wVVin76KuoaHLyLpDqnzd+2yt5U3?=
 =?us-ascii?Q?rLZkoLtNwEuldPNvayQmnJmQ5L2Ni31okVPpcWCUzh/ZBZj0itm80He063I2?=
 =?us-ascii?Q?3N45xT/pQEy+bvRjRj3S33BeOVpCS0rw3maIA0+hw25rCPqzmpSLFPEheFjT?=
 =?us-ascii?Q?h30k0D9jejf361IBXOzKbKw1AYDZRRbvoyPWII/+CvMhwHgAIbMqyUA7BKag?=
 =?us-ascii?Q?iLrVa/Mok59WVxYkrd1L8py3Lo3Siyr0qn1Sj/GBpSN40jCoiLIQ9adFOQ5N?=
 =?us-ascii?Q?vkN8+pG4TnalWSCL1Unds/3xahtlkYM3XSTAjI4CiVWNU4kKSDs6kqdAJe7y?=
 =?us-ascii?Q?U/9RJptTs0hgWHpWTbH4+VXcw0LDbUU3fSP4ZQUHytxhzzdo8oKH4G26m6X9?=
 =?us-ascii?Q?PtIk2EzAyazMx4iK09Ot6u/FBZTWFeFSS8ru/F+yMSV+hj6raDBhiQm99AZW?=
 =?us-ascii?Q?vS+cPSbd9YquZoD6Q2QzBA2wxXHOz2RD8/NnaZ/vhZjFAFWWIP6KVZuGkZvl?=
 =?us-ascii?Q?Z1TgqSi8Hx+BnzcltJXPRzuCcIivJBpr7/H1iUD+MCd0hY7G0Fkz+yzIExZ7?=
 =?us-ascii?Q?6n0qu2viGCEwy2a0FncCFmMfpGcwgR5OP4797i1v8y1BAsRBjDEVAOdEaWps?=
 =?us-ascii?Q?y3Il+Ax0lC7HUupfVRgo1z3ADTKRcYS7rzfDkn1VdFifvLCi88mEIh54XF/Y?=
 =?us-ascii?Q?rwDyhA3UxkL91/JgCcRU7Iw0vyFI3Ujh0EdmIT1cs4unrPLWZSbBWTO/Ti2z?=
 =?us-ascii?Q?SRHfojLDQlb4S2zeGo2Vwk6duDcJL0Ea947MhUU0HG3rCT9R8uRggQ7lZSvk?=
 =?us-ascii?Q?rh81egM9U2pAANDSEx6YoW4auvQ3uDzPWUMyjZ1KgrGLcbcY6PEDrHz2ENos?=
 =?us-ascii?Q?CTHyqwrInMe7zSILt7eI8lIL3vH0c2grn5h0/6YlQ//vdbitvcxsYNYR9AIo?=
 =?us-ascii?Q?Kkunbu65wq9xQ3qs7+O0rONQLnbnwKyZYEl5CFIn+LbXoacE7cDleMW42lAW?=
 =?us-ascii?Q?mHEmQjCxf7ggv+KZHJt86L9P8pD37+B3zUKhWwlJihcoYlUMz7D93pO4VNHR?=
 =?us-ascii?Q?JodabhvkOiv57oFffnHRk8yUyA3nYidBNZpygFYGDfgLkoUmwWlz94rRqU0w?=
 =?us-ascii?Q?bC0JF+9sWA6O9uFMyD+Y+1dk6/+e2WYVBphsZwBA3kXe9quqthwwn5lRiZev?=
 =?us-ascii?Q?IZ9yJWHlTVMReVVnSLze388ajr+QxRFcU/oZS2t1tVYt0nN9N62WI8xphk+o?=
 =?us-ascii?Q?JQ2xCExzqNE8FTCnSZFxGmjvLMD3iEI1oFi3qAG6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rhLnGtlyxBGtYNBTeEBlZ6XfbfIAlW5EDDslRlVVwvlnnKqqW7PnLOUrVzK0kjBk4N9LB+4k79uHgQ/mGckgKM70RxRagea5slgbSd2ljO1sSvYWGqmH6cq/Ta+/AwyRP/9hbww12sFsfKOHDelJN5tCwDKsX9xmooOF+PopJcMY8RkPO/2EtkDdxxTs9y6dxmMYQsWdMOChEack406oOXew8/PW/yixTX2rWm3BY0AkdQZy9P0HsxDbnW66N6o3z5C4neVDKNK0+nY5g3iKF1z7WOwcnVfZzK2lADfVFeDIOBOWHYwPdobqllUXWAqJZOJm057PyKJhh+Cbm3VPNn2MvRM7ROVysQigrZsKVANcpF8KjRMzGxp7ruy069nL62L++tzSmaPAIRXnCJci89lEVOFl2pn0PBt8xAPK3614Z2RjnVmKLIcB5Vb2Uu4+AjThcte1dQPUC+HF23GNon6RPKnR4sprq1jmL1otptWCd33LA4+4Y6kHt9Y57IJd8pAYydv3LaaB5OTKeBphbjXDKF9HO4QJ8STPcwsmrVNowaTVZqJJ7DVGegbBqe9y3xEROyyer6JXJAsMB/D7xNq0gGvg6oEkJObNV7iOUvk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba18d18-26c6-46a6-b7d6-08dcceaf4d73
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 20:05:49.5337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gX4lY178WVPmbk+/MOGqF3Mgr+uh4Fbblo/1DoPvRSrLeiUKMZyqjDGtHI+tJN4s1owOntj4ftOePyMeH0uaQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4634
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_05,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=867 adultscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409060148
X-Proofpoint-GUID: R3R4LCE12u5dtJ7eb-eHUjwf8p2k7gOU
X-Proofpoint-ORIG-GUID: R3R4LCE12u5dtJ7eb-eHUjwf8p2k7gOU

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [240906 11:43]:
> On Fri, Sep 06, 2024 at 11:26:26AM -0400, Liam R. Howlett wrote:
> > This exists to stop people from using the bits while the feature is in
> > active development.  We had the same patch a few days (weeks?) ago.
> 
> This breaks build. Can you propose better solution, please?

Can you please provide the config file and clang version that fails on
this error?

Thanks,
Liam

> 
> > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [240906 11:05]:
> > > A few functions defined but not used. This, in particular,
> > > prevents kernel builds with clang, `make W=1` and CONFIG_WERROR=y:
> > > 
> > > lib/maple_tree.c:351:21: error: unused function 'mte_set_full' [-Werror,-Wunused-function]
> > >   351 | static inline void *mte_set_full(const struct maple_enode *node)
> > >       |                     ^~~~~~~~~~~~
> > > lib/maple_tree.c:356:21: error: unused function 'mte_clear_full' [-Werror,-Wunused-function]
> > >   356 | static inline void *mte_clear_full(const struct maple_enode *node)
> > >       |                     ^~~~~~~~~~~~~~
> > > lib/maple_tree.c:361:20: error: unused function 'mte_has_null' [-Werror,-Wunused-function]
> > >   361 | static inline bool mte_has_null(const struct maple_enode *node)
> > >       |                    ^~~~~~~~~~~~
> > > 
> > > Fix this by dropping unused functions.
> > > 
> > > See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> > > inline functions for W=1 build").
> > > 
> > > Fixes: 6e7ba8b5e238 ("maple_tree: mte_set_full() and mte_clear_full() clang-analyzer clean up")
> > > Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

