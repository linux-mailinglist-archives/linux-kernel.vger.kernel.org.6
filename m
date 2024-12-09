Return-Path: <linux-kernel+bounces-437158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0589E8FC9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9E028292C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E756216609;
	Mon,  9 Dec 2024 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aeJ4pxCw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="La2F8N4S"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5339512CD8B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733739091; cv=fail; b=O/QHCyTfaoHcCiODLKGxbnzRthx3y3zUSSc++sBWaR8Gk/RlgK08hwmYho49/YcGjNY5O0BbLiFTvFDTc5hKf8TkB53MNTfZgSTulPg15lR2VbntHCu6Dl17nOSHgMKLjyCgkC5R4qvneSuJWmVWL02B3ylZ6ibMBe5EYidKsdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733739091; c=relaxed/simple;
	bh=jrjofpur8iOWiA3kIUu5gi6nZ2HpoM6vD8XpSXKlXbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FjkutoezGgol0p/Mg6TwNOLgEKu60cJiC+ce+UZnpK4cvCsSxTHXQrvEyu5pyo2lbixGvafrhmSI17B6HNdeCTQiSHPsTIMsp5vVVtlTXXTRGcI4EAyB0cQfUivuZgzm2qCh+zWhVX/ma8SXJk3sza6yp1X2iL8Bp/Nd7KUisJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aeJ4pxCw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=La2F8N4S; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B98g3r1011388;
	Mon, 9 Dec 2024 10:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=JSNF9flUrJjQ1HKXJJ
	y76KRV/3De4Qa0T0RM2cX1muw=; b=aeJ4pxCwH3NyGeLzTkck9pZiggUIEegQuU
	08qpuXZAFNvGKHVsjgjFm3zXRgbTbsqUIuMSks0Qcm7iCK04UtQZvDwIyOLtiW/j
	EXL06rNnViG7tsPyLd07OLXaI0bvbfpUSQQeKkG/uCsaTJBeWs8CwsbnK20vPK5G
	QDTs5umErxQlGLCcbzRZ2UeIHQzqcJc1QWwJFbV9163xtTp3/bLnsr/at2TbPZkn
	zN6SDRT3isCSJ3dL5VeTurO4RZ0zScxjUUR6pdgLEkoe3oUiH+JKgu9FchedMOoe
	elsXhhK/KXqzKRly4UQQ5dyz1s8lzkkajZ5T1RJ48ZdM8hShV7zQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ccy02wqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 10:11:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B99o2UN008634;
	Mon, 9 Dec 2024 10:11:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct6u7g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 10:11:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxxOXjVUiY8UEPI53KHh4KM1fuoywWGHMHlq1es00M94iCFc2va5MVpORuBXws2s8lQLJEcF/QRExGvgGzRhk8tsP7XU7kj3wpq9nHebBbeAPJ2ABzvhV8U9BaPij1w67P9D7D5VgSEKExfFp7Cf5gly2PTN+X8FVrW/ago5AcyTu33AAsZqdg1iWgB+JLx+YqPJM/WEcGK6UaX/C8OT6Dx7NRcSh69ZwhnOhrcovgVbD4VOLj212KFjXH5PX2hnCT54kMRqe31ZGFzWL9yS9lZ154ccH8522Dc9ixdLB/QRbM3O8mDB6srym2arMglndbE5mB4EnTAfOSCotGVtgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSNF9flUrJjQ1HKXJJy76KRV/3De4Qa0T0RM2cX1muw=;
 b=Sq1pNznUHW4tD3QVanzWhtfL3ZTHAu7FeqUeARD61px/SNMFVVNL5tCTiJHkqCRko2J1bg6GLnk2mLQzRzx135x6M1SgS5vRhm8S9PbgVwPudXLWWXSCEcbGVjHVRVRR1q2OY/pgWKpcQutrjhdWNEpnyWmZGYQOVjy39ccBVageZW0EMtuViJCwjd8xAKjp2/1VBWUwUML95+e8koWkZOZ2tbCVMNF4g7ftOUxdHG3Wlz1d8OLW64gReSofCA2PP3svEUrkEOvVCbV8Ngv1JD5O1+4Y4mgVOt4flOA/Dcphe1c12yCfG6Ff5c2l1jFzgJrR3lykYAspuz9dkTPH4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSNF9flUrJjQ1HKXJJy76KRV/3De4Qa0T0RM2cX1muw=;
 b=La2F8N4S/CwWkW7fONErARKa+R9DbhsqbjaxG8Sc7UcbTkpRujuE2m9L1vAuZuDLQ1zRDWRJgHSwaeblREMg69xU87xmAC+utXb9nlr5OEWBRy+n8QkjDD+vym+vC2mp7FHXvC0B68wCeYZ/elnnBcKhiScDaq4q55lMU7Z7OGg=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MN6PR10MB7544.namprd10.prod.outlook.com (2603:10b6:208:46c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 10:10:58 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 10:10:57 +0000
Date: Mon, 9 Dec 2024 10:10:52 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Hugh Dickins <hughd@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Isaac Manjarres <isaacmanjarres@google.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH] mm: perform all memfd seal checks in a single place
Message-ID: <962d6a22-1944-4e35-9a37-8e846bb213da@lucifer.local>
References: <20241206212846.210835-1-lorenzo.stoakes@oracle.com>
 <20241207192251.204814-1-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207192251.204814-1-sj@kernel.org>
X-ClientProxiedBy: LO0P265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::16) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MN6PR10MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: ef9688f1-cb58-48e6-fd04-08dd1839c5b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?25op+oeuDe/tGWpKmQCikl93kMR9jM3c4y2vFwBosKIc/nnJi7kywdqcWe1Z?=
 =?us-ascii?Q?4Szpvg3l1BCyx9ry+rUMCfSgzyWmT+ONAIgNjVZcDQDVxFs9awhkglYTe+Ln?=
 =?us-ascii?Q?zwG27e8t77KyNMoquFHRi2/CEPJ2yB3SMuEwlCLa515nqIsTjrI6KzDEeWah?=
 =?us-ascii?Q?VMXiGOyqG1CfbxwMpTDWBNgZk+/qKH0p+zM0VORUWQZdFMABRSg9cKnfx4A9?=
 =?us-ascii?Q?shKmuP+TOsBB2KgtPGMuD9tKgNlOxZhExAgz1CWshN97I4bdD5ep6uu1YSj4?=
 =?us-ascii?Q?EVk0pd8oe88O5KLs1SeeQlXv3qtZauuTnhxCj4Ax1Jtkn1hVM1eo8HREsWc8?=
 =?us-ascii?Q?cBGlG/gazDYmijh5uXBNdF0QwpJn3bzRUUfpPLe4xaiUmk1ZycF9lYtq+b8b?=
 =?us-ascii?Q?PkYg91iUPwee70TXu9H0xOwV9zgMKIoGPOhdaapTUkMg7FsN5IjVlvjQfOsP?=
 =?us-ascii?Q?bhkfX2H39QU5PnDk+KwhpoY7uonxXn6viqeUHu9hygezWHsTNiwjsfBH+KGE?=
 =?us-ascii?Q?UVkfAostVbHPuEcyN9R1S43LrmC+ihWrKV9iSFPKvjYNcZprBZaLlmHBx6Vv?=
 =?us-ascii?Q?i9qHsu07eJuHjVwDZc68nRXkIicadwb5AgdGX94PpQL4YAFLpw5ok/lIj1pd?=
 =?us-ascii?Q?xsadcnh7xVpTEq45Hf0SXtoxQrWsZ893p4rboEhp4NAarwvVAEOlQI5dhgUO?=
 =?us-ascii?Q?RWVfcWyydSOmURe837908vQVbe2QfTGgE5aXrXUr11T6ZbMQg/ZWz3D9Je2Y?=
 =?us-ascii?Q?QCiEYq7rzx9/weuwUzstW/g7Fja+UxMEWfPthIerMR2+kjfczZPOog3NBXcK?=
 =?us-ascii?Q?whyscsMMv9zFrSG3snmKLeK6RdUr19wyAXZQ7e4BGhqHl+hkzP7J052muTqd?=
 =?us-ascii?Q?BZjaGPdKg52dhuwkSmeo5gMx7gWAIIUo1hkswNepVKanvHQvzc3ZGrRjoY7I?=
 =?us-ascii?Q?+cSWI6CfrALwBKq4m7Dh/B7GcROYIms487UwyyD8SFzzrsDwEo9ngf+dprdA?=
 =?us-ascii?Q?DiOoh4cbjQrdeJ7i35ANpPqnI7XSElvge9VVRL/Upxb2dthE7Gaubj2esM/t?=
 =?us-ascii?Q?JJBVqnNwYZmXdWKbg87E7UdHgboEWjPp8uRizxVqNt7mvpdHhMwQcnsHLoDw?=
 =?us-ascii?Q?A4By8IjnJQV3VWdbpN1c7cPEhDfZoDyGmDEQ2xpxbZz8H0x9TvbyVASwX2Zr?=
 =?us-ascii?Q?FPeZoprrJRRs4DfMf3PZhdwMnSgCx/3U1+aBYw1xJZV1Ujuit+CrOZvYTF+9?=
 =?us-ascii?Q?lYggNQ+Rnfaku2qCxJU1VpJfkoYvzzKiabE1kQhqiplLbmfgx261ihYekw+d?=
 =?us-ascii?Q?8k2SN/NKsZXbWMIUwWDR+hANXw247K1MsNATmYZDju+EOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LPwaV67Zmeeq0o3hAm8l4WDu16xIBmkwxOyrSLY5UG4ChhBErfXfFJJpL67s?=
 =?us-ascii?Q?opK026zzftVdKpVPNgb6URATkhZZeMfl+JeOuZNxpWOWqz5FAVP+mbDwTiBQ?=
 =?us-ascii?Q?tluigpojHVrBApXFBBBcJNJj8IEpMYORgy66b5HalKXFJj/WS5I+fOltgYlx?=
 =?us-ascii?Q?wUPH38wB49GIbARpoS7duD1uZleVIoodRSvtjNkftEIOYOouSsw4Q45geTsP?=
 =?us-ascii?Q?KgoqQkTpi/yNJFAIN3sdPJTluqqcaPYLDpjLfcqwlEUHe6Jw/M0iB3oZX5Y0?=
 =?us-ascii?Q?U5eNniEObbpvb+pKqkNtG2eN05RN+NQxoyZA7IywO0XDELwB1jBcwdW+1AsH?=
 =?us-ascii?Q?MlehFkpcVyzJbJRDOJxQkx6AMntOi4miibRvdBldunRPI7ilj/Gmyv1z9spY?=
 =?us-ascii?Q?a1ccomImYYy+P9fR3yqrPlRvtfdQSRDkaGodPr05dOGy/vH8gB3En+oDlIcq?=
 =?us-ascii?Q?zYtod2Eojre/Q5QH19yXkOXnGhk0YqIe4l9IRyXM5R97j+N698qGh2xgDM8o?=
 =?us-ascii?Q?CdpMYujU6IDifA9+UaTU9WDCiMoCmfj6xWCVk/N0GgzXgRQggnwpty23yl6N?=
 =?us-ascii?Q?pRO+bpK+MdgLQuumitBjsrXTltCUAUNaCsxm+Od++RJp9iqplMh3t9tJLB6b?=
 =?us-ascii?Q?JLKZ81wxMMhcE+lElCvqI/4OYaHMBeNk8lQd7tAEJ7/us+RbbUDcT4zKy0I5?=
 =?us-ascii?Q?A2psLrBJ0LEWw+eaPT9iR1RE0sNn5sPzv8xyPNVFJ5TAiMxMjKgNGKZ8CFZr?=
 =?us-ascii?Q?MsnK8RPtBUMVuoq0JcaB9YhMbgcqEGgUiqhkq3LuML1Mb0MZV5OnIOokLl6f?=
 =?us-ascii?Q?urtQjdgYDk1DSXYPQXv6TgqxjUbi1s56mp3gE78Fc8PKy8tCohXJDhnjvdMz?=
 =?us-ascii?Q?WIYWq62E+QSnFp1P2lM/42LEjYcez9wtFDoHP5kno9jNl5rzTWtz8SF27gR0?=
 =?us-ascii?Q?O82Nf0Mp9XehykLPX3+AUmjvu33pW4KzZ3+1+j+dpKK70o+CuMh3M9KGnlFJ?=
 =?us-ascii?Q?sykGhzRJD5cRkfAOyHA/76cBxFSjFkUG3qPZAQUkgGTrH32bor2nGktR7e3F?=
 =?us-ascii?Q?26cM8ChoZSaWrsixGue7v+YuV+eBifkjg8/qV50F/6KdGuEhW0DEEOvwjLWm?=
 =?us-ascii?Q?4PYAk3IcJ4HrNMYmzgKCD6Pg62PZNTvKD2kh17A1PfzQZNGTfnhKQbBu+AdA?=
 =?us-ascii?Q?hiwbLDtDjxzJklqp2VrVNnAOCWPooX8COsvuIheaOjLDQu1fVBd+Bh3Pv44F?=
 =?us-ascii?Q?NpykRs4uYkT1XuVAcPq/BfVSsol4+9dhJLorLsYpNXAsJwmbORaIUgua1daE?=
 =?us-ascii?Q?lYgoXG005/nK/PX4ioPi89TzcD3olI4VhCijqkIEeWjf2PL1REPkOi1KHlCh?=
 =?us-ascii?Q?aICOfXdwowSdoXhOqO1rcs4KGUTJnPUOj5WE5TxFxlmdVmTEXBVYjGVDiFxr?=
 =?us-ascii?Q?tECNp6OS6308tfymZXLG75vPjTsdpumx1NJUZBfKl+BjqeosyZvahA6P4pSV?=
 =?us-ascii?Q?XN3u/cqgos5RBQyIDij9RJTpSQpFh5QR83mr4DCb8gsWQeH8No8DgrLT7Q+3?=
 =?us-ascii?Q?KUgThydJtNqFH9elNJfyF7XY34TH0iBVF2Z0JtaNWDIPXAAqXpak4vUFEfc1?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vANG/nkrNtEM6hK1yvgrFK39I5cI4bXMAeHMWFMT+frn0bQSuGZUysQITuaWkAnL0pxdXDeQV1DIjh/4XqmBaVZTl+pCscNdks+FhPBnYpnhEpgZk9epmkoNlycbXjaGLaeOWXAOJmQ2nPbpBUOIpU0myCwzeiwIMWe7NQH4yAhC/telNcriEQwbDpBFXPnHiw6mrOAUmstIYPZsi2kA4uxD69ofdk9O3qjpfu8LuH4Ry5gi1CyHaQWCDeG33Ck9Q2sxef58X8zFh7GZI/cboR7hd1opKK2IgrZj4UAK/sHZgMRVvseQ/WtpDKobSZJ1DxOltEXzbrOtH4Az0GquM/BtV8QoIA2KTvMcFMepBF6+b0NELmU18bMYaWKLTd/p0Yjzp80fLEVnIxkhzP2l6djqNpQIypjZhMyVkpQ2IpqWZiV0CVw8kCAIh6NfUIX1SZtEC3bpmyTFIrz/YeFcjUqXEEArkOdGrKunPR2xeadDaRpl8KTqGQ1lkY1/7op4uU+wZOLQNd/KlM9XsjS6c3wna5uuQXy2wfO4Fxx6acrq0586HflqAjwYDt5gY706DVz81pXOFfSAFD+tl5lL7IbYijYe+KrkKxIW6CbD6OE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9688f1-cb58-48e6-fd04-08dd1839c5b7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 10:10:57.3018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZuiug9OVKZ+UId9KRl7IClXhDef3gE2nGJxfgZBU+i++LrKI8hg8+ZSYIEOWkqyEhyXv67f0RB8RjdwTbJJD7fgcq+y6F87Ce9i9lXrBsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_06,2024-12-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412090079
X-Proofpoint-GUID: 5KOfjaPrtyeje7AOCX4m0VnGw_Bri3zw
X-Proofpoint-ORIG-GUID: 5KOfjaPrtyeje7AOCX4m0VnGw_Bri3zw

On Sat, Dec 07, 2024 at 11:22:51AM -0800, SeongJae Park wrote:
> Hi Lorenzo,
>
> On Fri, 6 Dec 2024 21:28:46 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > We no longer actually need to perform these checks in the f_op->mmap() hook
> > any longer.
> >
> > We already moved the operation which clears VM_MAYWRITE on a read-only
> > mapping of a write-sealed memfd in order to work around the restrictions
> > imposed by commit 5de195060b2e ("mm: resolve faulty mmap_region() error
> > path behaviour").
> >
> > There is no reason for us not to simply go ahead and additionally check to
> > see if any pre-existing seals are in place here rather than defer this to
> > the f_op->mmap() hook.
> >
> > By doing this we remove more logic from shmem_mmap() which doesn't belong
> > there, as well as doing the same for hugetlbfs_file_mmap(). We also remove
> > dubious shared logic in mm.h which simply does not belong there either.
> >
> > It makes sense to do these checks at the earliest opportunity, we know
> > these are shmem (or hugetlbfs) mappings whose relevant VMA flags will not
> > change from the invoking do_mmap() so there is simply no need to wait.
> >
> > This also means the implementation of further memfd seal flags can be done
> > within mm/memfd.c and also have the opportunity to modify VMA flags as
> > necessary early in the mapping logic.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  fs/hugetlbfs/inode.c  |  5 ----
> >  include/linux/memfd.h | 22 ++++++++---------
> >  include/linux/mm.h    | 55 -------------------------------------------
> >  mm/memfd.c            | 44 +++++++++++++++++++++++++++++++++-
> >  mm/mmap.c             | 12 +++++++---
> >  mm/shmem.c            |  6 -----
> >  6 files changed, 62 insertions(+), 82 deletions(-)
> >
> [...]
> > diff --git a/include/linux/memfd.h b/include/linux/memfd.h
> > index d437e3070850..d53408b0bd31 100644
> > --- a/include/linux/memfd.h
> > +++ b/include/linux/memfd.h
> > @@ -7,7 +7,14 @@
> >  #ifdef CONFIG_MEMFD_CREATE
> >  extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg);
> >  struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx);
> > -unsigned int *memfd_file_seals_ptr(struct file *file);
> > +/*
> > + * Check for any existing seals on mmap, return an error if access is denied due
> > + * to sealing, or 0 otherwise.
> > + *
> > + * We also update VMA flags if appropriate by manipulating the VMA flags pointed
> > + * to by vm_flags_ptr.
> > + */
> > +int memfd_check_seals_mmap(struct file *file, unsigned long *vm_flags_ptr);
> >  #else
> >  static inline long memfd_fcntl(struct file *f, unsigned int c, unsigned int a)
> >  {
> > @@ -17,19 +24,10 @@ static inline struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
> >  {
> >  	return ERR_PTR(-EINVAL);
> >  }
> > -
> > -static inline unsigned int *memfd_file_seals_ptr(struct file *file)
> > +int memfd_check_seals_mmap(struct file *file, unsigned long *vm_flags)
>
> Shouldn't we set this function as 'static inline'?  Otherwise, build fails when
> CONFIG_MEMFD_CREATE is not defined, like below.

Yep thanks, I typo'd this, will send a fix-patch.

>
>     ld: mm/mmap.o: in function `memfd_check_seals_mmap':
>     mmap.c:(.text+0x...): multiple definition of `memfd_check_seals_mmap'; mm/gup.o:gup.c:(.text+0x...): first defined here
>     ld: mm/secretmem.o: in function `memfd_check_seals_mmap':
>     secretmem.c:(.text+0x...): multiple definition of `memfd_check_seals_mmap'; mm/gup.o:gup.c:(.text+0x...): first defined here
>
> Also a trivial nit.  The second argument's name (vm_flags) is different from
> that for CONFIG_MEMFD_CREATE=y (vm_flags_ptr).
>
> >  {
> > -	return NULL;
> > +	return 0;
> >  }
> >  #endif
> >
> > -/* Retrieve memfd seals associated with the file, if any. */
> > -static inline unsigned int memfd_file_seals(struct file *file)
> > -{
> > -	unsigned int *sealsp = memfd_file_seals_ptr(file);
> > -
> > -	return sealsp ? *sealsp : 0;
> > -}
> > -
> >  #endif /* __LINUX_MEMFD_H */
>
>
> Thanks,
> SJ
>
> [...]

