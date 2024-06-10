Return-Path: <linux-kernel+bounces-208246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B52DB9022CE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 224C7B208FE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D371A824BB;
	Mon, 10 Jun 2024 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TPdR94zO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dZWcmoXr"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB78D15A8
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718026889; cv=fail; b=NArt/b2qOGmontyViQwemVJxM+SWnTCYbgg3UdlTrkFg+48At9xiXimxECjGruWcnuPdmNsDY31VThdL5IHURi9AypV1/JhJQn5lLSOcjdQ9Nbyco/xDxReS2/OQbn5xCbqTvQrdLuAx/TCsxhrHiJI33HYwn1aRqiuj5dlg/Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718026889; c=relaxed/simple;
	bh=/FCP2H9ru8WrFnGjv4Jv5CEnDPcTOP/3P49WMut7nCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WukybwY4/dRXjv4D3ntjgk2fQJT5DD34qLoWbtK6wPNQf/R+Axk4nDiEo3CFkklG4dI7OvYVxUPT4sDokj3F6RYZbnNY2G0lpGLEavAMMhYTi4okdmpkD8HtyyONFrxxc/jGnZDhVZo2LblXUGli8DwIYrvZbfMP2QqRe1mP5kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TPdR94zO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dZWcmoXr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45A4BR4q011405;
	Mon, 10 Jun 2024 13:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=0qVAq7bkTKcgdPg
	Qb1YGeOqTO7hhtnfwlaUJHLMaoJQ=; b=TPdR94zOGqS3SULtASFlWGAowRXxc8z
	VLjgcpoeR8hJD0s+Dtg7roU7JWNFGYrs71zGzu+N6YC41bQwz2/CuUqTOfL46mZS
	CSSRYu7PHPx0mWOMjsMNZjgEd1WNU2mAfXPWhZ8A8pNBy1dX+cuKIfSYJLFQMKfm
	WnB+BGvzbaDA5WF4yBkAx+ih7MIOpAPZWzKJucHAn2TIbhKSUAJjhxgNR1GY7EDx
	Q3FRJfOsJzzc2flm5Yp6Wh01UHD5qEtAuOLzqT5zJPCizvUiNUnRFoh56n7G40ZJ
	+hyC9yL/MBSExUlLpLeZq9rg2K6R6xNQMVQUAuhE0rbPhgLtsdbFr3Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh3p2jt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Jun 2024 13:41:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45AC42vv036460;
	Mon, 10 Jun 2024 13:41:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncdustwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Jun 2024 13:41:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhoCS3GbZV4WvX3qFSdBtA2Rm8tOiESQHdKdtBUZMQzNBa+HhLdfk7EcSs1DRd36cUp+4GvYihCo8p3uT8/+K2WkcI4rwIoDnkdQ1BZBIpy5kBT9lD9sGzrGCT3kz0oG52KTtibcoDw6jA2X9+1djRYEHRvJBKaXuEav3fabiUU/7RkgN6cACmiOl314AVy7aHbBWjhD0o07UZa6/IzR7hcOnjDIpiIBgKDl5sisi0M8SlPoLI2h8DP1UdaTXUOOQyIKFBr4xg/6RnFBtaEnmicl+ZKXp32ZfHSSjLwBe6m66jY/rhI05m+5GJev7ARdpeC2OQhkuJ9PlovCqYzazA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qVAq7bkTKcgdPgQb1YGeOqTO7hhtnfwlaUJHLMaoJQ=;
 b=crEGUThRQ4oA4YyzTBTG5ZPI9cZIlpbZnAOe4FbJJdjDZFCjVWC36KGA0ihTTCLcljMm0x4ps5q8CWuiQ9JgFKq2otA8F2N6bWE6NrXYzsrOHm7F918zkBicv8SCXWUChCs3mQNVdh0zimXNQDq12wC7gmgHl6Eitj3zgQutTFLAuJdktsUrOZvDjUHLEhrqLALzB94zOwc/uxFYislvr0w0gppTeJ5FmzITXkfKr4wae/qN+iEz3QcNxbCXm4VDkwZEp+gjEe7WmSkQw+ESPi7V/Y+M48SCb1kwqjYPG1Bdle5PKWQZ18EhaW6LYPnPwavGiiCktMUPeDzKxChRAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qVAq7bkTKcgdPgQb1YGeOqTO7hhtnfwlaUJHLMaoJQ=;
 b=dZWcmoXrgRagdaleUETo6tXqDEaDo2ezsEUB+eSM9xxozZS5p/yq/1BvmFbS6eV8qezrDzAe5s5uzsNo1P1DIW2LTYliKED3AVdORjpZ7sK8n/vGFl6DhP23LsxaY+ZGRs8j0KGOn3+5FoBA06OsLqzs/Yske6b1WyG1/TbG4A8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5803.namprd10.prod.outlook.com (2603:10b6:a03:427::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 13:41:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 13:41:22 +0000
Date: Mon, 10 Jun 2024 09:41:19 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        allison.henderson@oracle.com
Subject: Re: [PATCH] gcov: add support for GCC 14
Message-ID: <ZmcCfzJfsKoVvDpA@tissot.1015granger.net>
References: <20240610092743.1609845-1-oberpar@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610092743.1609845-1-oberpar@linux.ibm.com>
X-ClientProxiedBy: CH0PR03CA0368.namprd03.prod.outlook.com
 (2603:10b6:610:119::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b3388f-989f-4a42-d5b6-08dc895303d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?b28FfN+IRDGO52Lsz54kZgUu0E3nDk35hnsiz2ubIvJPEeFKkLPqjHHCG1ak?=
 =?us-ascii?Q?DsHzBgFOOCrGRruy8z5kyL6uB3irqR3Y4an5lgRDJRxkVddrL7kvLilcEFvR?=
 =?us-ascii?Q?QDQXfSfRSYeZc8+g22wtjCp+tlxrZIF5layqkuzi0pmilq6sOlMA6wi21A9E?=
 =?us-ascii?Q?BxxfJoNpkLt8ExJ3ZWAFzoJh7ta2SfgJ+tavNM2IUZZSgeS2B7YftP1spQRQ?=
 =?us-ascii?Q?1pDxBD0Td0e4upQyK1GB8AwAEbxJfPPL/snnsKI3y8s6dqccKuTUWXteZehM?=
 =?us-ascii?Q?BCrMQB7rThe2ThzKoZLzSUQdD6g6If7wn//idPWATHoyZTjBvzjxUgj1YGom?=
 =?us-ascii?Q?iN2huOEcZndPgA1KXupp1Gj2IE3g4oQ35tuq4fslpKgiv835jaTbwNeRajLL?=
 =?us-ascii?Q?He9fht9UtxJe6hhMMB7B2YI/TXI8dokuPUwScKsTZACf+mc6KwhxT9h/YzIH?=
 =?us-ascii?Q?i3Z5JR31+uuc2jgkRKPk/1qVle076mkPQCpRSQ23ieVW0SwTl6XuulU7tjyi?=
 =?us-ascii?Q?SuhlGXJ0v+QWJHo5OZDS0KRg3I7p66nlp8TK82pK1mKShayswEBMc23KBdTT?=
 =?us-ascii?Q?IfBU1RQPHj/eMKXijXdU7hPkdffSv0GHCv7ctovwcgJtv/ILcATq4r69GTsU?=
 =?us-ascii?Q?ZwEwSB1bK2cgJSE+wWZsdyUFaXzFCo02qS75cN2EHz+IKg3AWiWTa4eOjoAo?=
 =?us-ascii?Q?hrv8Wq324vQW1vAHd7byzxWidrKfIRSGuy/WtJd8ztIll0vI3bVIdsKfo1Rf?=
 =?us-ascii?Q?v45nxIJm6tagoMObmgSHRc3tl5NlBiJomBEIiG3i5ndUxRXCSoU26J+fuzD4?=
 =?us-ascii?Q?BSGcqdgbFUpN3Hlo5x8mmeGCNWRvFqMB9Yp10TD9BzFgjkXBnN5iRofWRjaC?=
 =?us-ascii?Q?4g57d+D/0Zr/BTgekg+k/70XF7uuy6UdEnyER5L8DZ3oj7p1aoh4Qo6L8VPk?=
 =?us-ascii?Q?9UKf7ZTe/uypUak9CToKXJ/ADPmcyHOxti2DBI6Z2mpcrzR4b/bKLzmN1WTV?=
 =?us-ascii?Q?OoS8/5ZoE6udKhVIXXuDYyG2byCW/WwySr/vlJNmbr/g8xxHuHjG8BEA3Kp8?=
 =?us-ascii?Q?wNG7+ISRc/IqMGPePkQtTXJ4fcgfc5SqfFcYT0YYZp9iRwtfY6BuUCR928v0?=
 =?us-ascii?Q?9XVAuZLyCROl6IL1VK5ZskBpARRSnWZvYkidfYPPRLFR7BwNo3dFmh/cdWIm?=
 =?us-ascii?Q?Vfl70ljy7pFNH/AAXmSbLXuWxxdu+Vv82e9iZrJh69r3pr4Np8717gNXuaRd?=
 =?us-ascii?Q?0xdR7qgVanfx1T4xhT1b8XT/0PZltvmcAvDVDlFipbi9RJGGinD4NblRSURB?=
 =?us-ascii?Q?tUN6cgmY9UA3aRVF2Q6L84AH?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Z0pMvo4TrfJKsAftPGNOhkB8pJSYBkYeiLEQ7/EaS6bsYem6rUEiLKFy7bCq?=
 =?us-ascii?Q?b4Vc+97UQhF5C20nGB2G/AWkSSA5WewTbwJKajlwo7D1qWzrRnIBVOhqoTPx?=
 =?us-ascii?Q?KWvCQoLqr9bc/IPTRyrhhpjKRZaDn4lcEd1oaCLgQPjXRR3fl3SjFfIbG5L6?=
 =?us-ascii?Q?aA/GRSqHczLPZeOKHAymDG766vEmvhqxVxd6wYuwIOPbB0c04cS9mqXga8K4?=
 =?us-ascii?Q?+HmlNAKRvPGjBkIj+faROUHezzahRKeE6QZhoRroMNj3VemE4sFdlm4nPKzr?=
 =?us-ascii?Q?7yT5mPnorutp2NFSHk78CMcEXi9dEosyO3Snq4N8CwOU+a4e+sKjgcvDNaUb?=
 =?us-ascii?Q?ji2S9hu0X6aAr6dA4PNZmj2VnfWLeDadILijCwGimnMzfAHJLLV35rK8Qi68?=
 =?us-ascii?Q?9bk9F2jrj9UNdHkyUY5AbXwXfhShYrBse8rLzv7DqNsDcZBolXAN+o2U8Su7?=
 =?us-ascii?Q?toQf/mY5eEmpXOJuGTX1bGRylF8rt/oSjjsQWQgAmTTX5qfGbYBIZNvl7vLv?=
 =?us-ascii?Q?TD9W9GAvxBv6LJ/ZHZYhrz6/F519mhb/2LVI//I9PteOCLMhULDZ71LeJ1Wq?=
 =?us-ascii?Q?ubOXwFaqItfN2W9q7jE+sO+IkSyBKmaIfpL+LNBorucNVy/lc4/6+L5duXGo?=
 =?us-ascii?Q?nc/RFGp79IgT9XcM8+TePv/WfxcgxUHxynH+yw6akk0Wye1l/EDZRB8b94AM?=
 =?us-ascii?Q?WsjzEiWR1W/L6HhC5ylJajHxzU7mlBlkLRthzTQRJtDf+KfyBjp+AHK5jZ+j?=
 =?us-ascii?Q?srjz1D1JtD6O2MhyJlzoOOZCwDQkZra3+uUzAUmgwMP3bU3XYvSLze1gz/Ph?=
 =?us-ascii?Q?++oZCjk7d6FYuZe81jFWXAg2dSgDSG+vNDal0jnc31CnLA4zCop2tXf5vlRl?=
 =?us-ascii?Q?JYOmgZehZJLVGorHDVZonXemWzqgT2X4gFJpnJecWy80gvbe7+HeAISv023Y?=
 =?us-ascii?Q?Wv3jW67MOplLz3NQrtiDoFcuoF8nN8UDQwaTEGjR3fVdAurfJA3Suw/129lF?=
 =?us-ascii?Q?WDbiE+LBruzQkkZ9uEkVri98E12jNDQw4UVwcMDwEbXb9MgL9pG1N1CJ4ObS?=
 =?us-ascii?Q?dQhJ/A4+4R6twZFbrhexahXUEt6dO01IHeJwBGLEmlxXdAI+FhWJph+JpYXo?=
 =?us-ascii?Q?cwm5L0ghNVqtbYyc6BlrMyiiXcataqQtMxEOiiuSGPgRqNrme4pLADJGZ2ld?=
 =?us-ascii?Q?Ee8WUqPcl3j+GC4VeTFDH57BQCdBXruyNT/bWQ5wyXVeIpow2y14jTRRoSKr?=
 =?us-ascii?Q?gLYBdScYmbHdkslaCADPBkqz+vktpk8ncSn8qkHk2SHWFGuHeJHnZ13lhOpm?=
 =?us-ascii?Q?W1pskyA7J0lAa9U853s5zdLFwKmp9DMOayst/D9/3ovql6taXKAfyyRCQLJS?=
 =?us-ascii?Q?nlfe66mLMU6iVxEjlHaLu0rikaVOehIQKYkiYC5KLLbOcVXO1n6yqC3CDqU+?=
 =?us-ascii?Q?AOzNlNIW7X3W7QR1EgECIDo4Lq2vWauRIYP5Iz0/kG52TYfZ1jcZlAUX8huT?=
 =?us-ascii?Q?DsEuOFdro2wP5F1c1XtlFS+KBzhBp8hhqCDxaHD84aUAjF1GIvfSVy8ABO5Y?=
 =?us-ascii?Q?S8v27movVm8EpXtgyJ9pMrcHACEyGXdFC3lta1at1KSQJwhaoHw6aQn13vGf?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	s75FEla8gwzpRTB/SLXkfymwwUz6c1woEe4QMcxmek+FG0/pznuhZq1M+0ForJci8Uu9ajhzrQhW+x20G6snQg8z2cDWyccDkLSz+fh2jc0S7PJFMOL1c1XEmFPC72FWTORMjGcf5gb7XTW5gxlXbKXg0E4ulo5deYZYGh2jX+czMGuSwfGk3tn8pXgdoaZh9QZnOIxeHjMiY4viFcHp0cSDTKYiPlEdyk0e3Q2onxkkcEdD6tmbfb5P0+Nq9eCS3n7eHVKCcM9loeiqZUL6s03WwiPGVu8CTvoi1fAWWz6ItX5SIrYMkyLx85+HuigIktP+4P6pMyWfvqhtt15MB/I72bvgvgskKfUVffkmzwMiFpNoLJuA6KFoCKqefBBL6SF+eXPTRIKORX5BRBnvHgfl/hTfSVTln9eCY32S520QhC5IfNVLHPYlXHPYskZEUahgnL3EXPjJvXRuqOvaQ8vQH6k8IWkWVLj6zDd9XyA1f96YdhdU71lWAD0rloMqsLgmHK+Bgioq+j0dA+SFDfqkKYiN/QID9m/3UDz7zJDI+b/0gsbB5Ppc51Z96OhmHqkEc4kfCE2V4YfKnhyyIKce3264zBmXC5kn/JJnP7E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b3388f-989f-4a42-d5b6-08dc895303d2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 13:41:22.0086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQoIkqQWfK0oLXl91G9yk8WxGgb1Pfb5xk5Q3EQIbuhEpN2A9lTSI/mAQb5e2Bt8NlSdIrxsoVimklYoafKlWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5803
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406100103
X-Proofpoint-GUID: 6-jOvDPKsFY7uL4wP3DoGvsTDwGz4grI
X-Proofpoint-ORIG-GUID: 6-jOvDPKsFY7uL4wP3DoGvsTDwGz4grI

On Mon, Jun 10, 2024 at 11:27:43AM +0200, Peter Oberparleiter wrote:
> Using gcov on kernels compiled with GCC 14 results in truncated 16-byte
> long .gcda files with no usable data. To fix this, update GCOV_COUNTERS
> to match the value defined by GCC 14.
> 
> Tested with GCC versions 14.1.0 and 13.2.0.
> 
> Reported-by: Allison Henderson <allison.henderson@oracle.com>
> Reported-by: Chuck Lever III <chuck.lever@oracle.com>
> Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> ---
>  kernel/gcov/gcc_4_7.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
> index 74a4ef1da9ad..fd75b4a484d7 100644
> --- a/kernel/gcov/gcc_4_7.c
> +++ b/kernel/gcov/gcc_4_7.c
> @@ -18,7 +18,9 @@
>  #include <linux/mm.h>
>  #include "gcov.h"
>  
> -#if (__GNUC__ >= 10)
> +#if (__GNUC__ >= 14)
> +#define GCOV_COUNTERS			9
> +#elif (__GNUC__ >= 10)
>  #define GCOV_COUNTERS			8
>  #elif (__GNUC__ >= 7)
>  #define GCOV_COUNTERS			9
> -- 
> 2.40.1
> 

With "gcc (GCC) 14.1.1 20240522 (Red Hat 14.1.1-4)" on Fedora 40:

lines: 58.2% (2350 out of 4036)
functions: 72.2% (197 out of 273)
branches: 35.5% (1037 out of 2923)
calls: 0.0% (0 out of 0)

All were 0% previously.

Tested-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

