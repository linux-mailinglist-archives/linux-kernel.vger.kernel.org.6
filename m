Return-Path: <linux-kernel+bounces-281306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD9B94D554
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20350282A2D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C045E482E9;
	Fri,  9 Aug 2024 17:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oW8Psv8w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Hpg6HIEN"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B37B17C7C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 17:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224066; cv=fail; b=QX1lWSgbGswsM00mSodf+j1NYNnQzaADfMjkcSldf0UK7LaNuT7IHNoBn4UKkHgCtomq5UbBWlLW0bukLqZwwScNWCypg4YySTv7BhFE+oHzCLKMm7fpfyCkDt6utLVsl+xK4wjU1+xl61mnaJwDowWm5bx0jD2URD31MaEz7Kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224066; c=relaxed/simple;
	bh=O2yxsaCtsHTWdfNxvSW/nABSAdKI3bzb7GFi+KuQUig=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KPg5RBX4v5pvB0utOmc4txevLdpmsWKwtmm9Drl747y6r1v4HbfCQMeMQ4cVNX6I2CIalrc4FxRQslnNLLfqkYUaqP5As+7kp4UgVCH/2+Hpy5XVtIWk3MKmr6JhKj+VdYynrr5yAoEFzRTyLL1mdQUvCNZhySXgwvxUTfPXaB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oW8Psv8w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Hpg6HIEN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479FMUM3032095;
	Fri, 9 Aug 2024 17:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=T3DRKjTIgYa+CTC
	I5pZDYS0qB5tr795Pxnka+H1Tgds=; b=oW8Psv8wJErbhJmWDkMBhFP3OTpO8BP
	csVqzSwsHFPSOTn8QgvmfNiolUZjP4u1BTj93Atg0btf1LluCswFwKeTej+53kbb
	8YHNDD405f810ihYB4QC0tBgY/FcA8ITtNQFGDYHUIGnzIcM/4FP3QE3qhtran3O
	82tEFsX6k7bjKvzfsqwMsKtGAJJWkPbx5yB4aiZF/AdnHQ73LzVREmBsES7oDkrg
	Kuo9niMMy5DTei+pAX2/oE0P00o6rFf2BK9L0Y9vDsM060nDW4/VS+XB7g5KbcGP
	CPUOAg/gNQrbSIiAfuiSulc/DrW6IvXgzL75PSkDZku168pfXks1I3Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sb51mgwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 17:20:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 479GwFoJ037228;
	Fri, 9 Aug 2024 17:20:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0csp01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 17:20:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9BtutW38EMU8HLOuM50rkJQ+oHYwfUBRcbBCuPqbfQM5o+Xza+CxKnqWNfMyjH0+f49zMtzcxm/WM/7Few7HexKsWVKGqDTrGMIwdv9g8kJShOuejkjNEkR2BXb/hvGtRp3acWA7Clx8X+sP8XcSaMNjOoJbMM79ClFIqtSZ7dZzDpaFeD2C7+K3TBLPV9snnaG3lu6ZsuquKsIMrBGIh3Nm1XERsNz3aOefe3ujGH9CUT5AU2XQVZP1/y65mBoKI35T4/NOCmaXetEQpZbQJ29AnE/vvUuAA5yQZeH9+2iK4EH2P5qsZ8xiB4kq+GhswVQ/LBeSv9rgttiA/kCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3DRKjTIgYa+CTCI5pZDYS0qB5tr795Pxnka+H1Tgds=;
 b=wCnOLim8zMmKhBSahdwmjYlGXHngzLdFuvvBZ0CWMFKlSEUyYEk7y+g8lfEin36H43tMnd05oJwskoD8uZeK12XyjEN7dCb675x92mdI9BaV/sO7vx9Rqmn6kabnUbX4M9NemD0QnkjHmNm4IW94OFw38CX5qJUJURhbmz1GZtNans1ziMiE0/jdXpTH/ldVFMXGpX4O2kbu9oEknwNEtZ9QDf8QgN6eqGw1SizeTjeB6yvV+AEcEa9AR+tA9wwr76VBsF5RZovEZC6s+uhwPfM2A1/WCgH71R9yXOcRYP1q1qf4dOXFQtVCcPHDshVIuKOO62tUBkJdPvxn0laJ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3DRKjTIgYa+CTCI5pZDYS0qB5tr795Pxnka+H1Tgds=;
 b=Hpg6HIEN2L4rOxUq30AnXRBIohC0sqpkBvcqNPJw84wBW6bERIjHIBbE8olo/gm8et3kmZ/FRTh1wY30idESl+EchcnWW5aeSmUvQUWkm4hkFdj5oAnYw0qO0GRiWJjTHti9GweQVH6MOZ1Q2mDYYnlP9c5twKBi/WEwKs0U60w=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DM4PR10MB5944.namprd10.prod.outlook.com (2603:10b6:8:aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.10; Fri, 9 Aug
 2024 17:20:47 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 17:20:47 +0000
Date: Fri, 9 Aug 2024 18:20:42 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 07/10] mm: avoid using vma_merge() for new VMAs
Message-ID: <8f1f86df-f3b9-4e6d-832c-5c4578c68285@lucifer.local>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <cf40652a2c3f6b987623f8f11a514618718546f7.1722849860.git.lorenzo.stoakes@oracle.com>
 <f57e65yhvflctpfcsrh75qga2oej4rrqwtu7vcsnacfsowrmss@i6cfuibxmmdl>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f57e65yhvflctpfcsrh75qga2oej4rrqwtu7vcsnacfsowrmss@i6cfuibxmmdl>
X-ClientProxiedBy: LO2P265CA0136.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::28) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DM4PR10MB5944:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aa03b8b-2aaf-4dca-cfff-08dcb8979b91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uchfeRqDmqTvOJLuwjZCTB85VfVVMFbzKv9kD4jR6iKE/UYfxpDVmiJF39nv?=
 =?us-ascii?Q?vSp5DWeJ9jPOAtFLKvbGWtY3zU+PjkSI0DAXZN+puquBiWHTow4EVl6BqUPh?=
 =?us-ascii?Q?lpTmohQuAf0Sf3PBs3glwUlEuxGFs27PRAEKeoFG9TSg0EHb7Cfe+bAnrs0g?=
 =?us-ascii?Q?bntF7Ir7NHEESnZHx34JqK/Kn8Wbpt7C3bYQ3w8MiFSzjnxwBq7V2JoayYdz?=
 =?us-ascii?Q?oNe//aznzfranGMpb6P1sTqt+gPNHvY3AJAARc53NN0fiSBHsK6HNTIdEJ3p?=
 =?us-ascii?Q?p1cMvPNiOFRDeOnmAld5lDVHCIn0xGT7nNymTwxMvnHemGtgDsXqXO8DfDa8?=
 =?us-ascii?Q?/1J0u+1lFqO/riP3VOO4lsmf7hi58M2b+URxxJP0b2VwWcVxvGOAyJEYfRzN?=
 =?us-ascii?Q?U/DPyKNS2UoywsQbBdvdfQcZ4yQ2QcFGOpvCeEw8AOi/8QKiiSW+R/JuGAet?=
 =?us-ascii?Q?s2Bf0Z7CkgjxoPHFMCqA6rgAOyAtdtWfa5ZfP4BPNzGzyU35p/Vd80eR0W//?=
 =?us-ascii?Q?N9HNKNEzjxXCu9OEHy/VRl9pgK6wa7P9Ax7/DbC+q989rvuCwv6Mj27AB6DY?=
 =?us-ascii?Q?PtxUPz1+uz2sS0FuFDAZunM3l9eiW42LdH71UXDF/EPrHoVXJSAX+fybNcM+?=
 =?us-ascii?Q?qrAjCoQTtvYAlIfMxa7diyq8E70agbpjLTw2v0EKvZKSx9WC0d/1ii4TE6CT?=
 =?us-ascii?Q?H2jvhP3VsACSPudrDxjdSruBeDJWUktQ8MXvzoZvjA3IwUdxy9K3Zc+l9ZKp?=
 =?us-ascii?Q?2hVkf3OMf+M8//YbIGkgxsFLmH3K7zZoXMJ7pspw9HkKsl0Za4Ct6xRNGDLg?=
 =?us-ascii?Q?mL0Sx3tetiGjM/zIg1Al+h69Qa+6axayXylCFUZCKpNXkctxTENxQ+GZqPw0?=
 =?us-ascii?Q?wvszmM9T23+8v1qLYyjBGFm7NtmpgroxjaFKSte9ck1n+vCFDqopyoJdvMen?=
 =?us-ascii?Q?/F33QSg5NZDScpX7Pn93lZD2OU5oGCv7iE/AqX84T6GiFNWz2JvBBrRUrz/Q?=
 =?us-ascii?Q?F0a9aHJctS/OOOxoXL+hNpzYUzHVUN44oe/SeIoAg8/P/oqusih8tGcU0COp?=
 =?us-ascii?Q?r8DpphemCadGb+SLkHvV6mt50IzhWkUiAvzjqCHmZPntg8yzUp+zcAano4MC?=
 =?us-ascii?Q?fdviHCL/gaKIanULT75Z5MKrB+BETH6308Ka2Z7ZGVZun73wY58sSLA4xSeX?=
 =?us-ascii?Q?aBx+XOba7GPRUOdRQnxwkM6TuQyPejuAtyiR7PBw57S5N1spUnoMCLbQFRAb?=
 =?us-ascii?Q?K/9SF61nH9KNA5ztbbNYdLGhALT0CK8EuD8NfQ88QQdng94vf5R6iKEYhRvB?=
 =?us-ascii?Q?Y+U1V/cDBHxfDt6yrH+LA1lJFxA7GZACull92pUQlzYWuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6i7cjxNl48QV9QhfJhg8g/F1Y/sVaeqRTVG8f/MsumPUcTcOKAAoYlBkVKkV?=
 =?us-ascii?Q?hGL+q0TkWl/PccSpKmKcJj/ers4fJXCbWD53jcFJdEIkWKjM3Xx0HX5an9hZ?=
 =?us-ascii?Q?/AxOKmUMlRapURJndbp2CM/J/7pWjlZp/HkK4pEwTTmlg7WHphjbGkGMLdG5?=
 =?us-ascii?Q?jYKLYsDA3ybLCalBEbg70Jdc5mBE21fSd4qr5+cXC189QqEe8n9kZo7r/+3f?=
 =?us-ascii?Q?5UMrn5rFsO0ZjLF18htaGqbaXF4UQ/wdyz/wfUeMUDCfT3l65zFcdVu7kT21?=
 =?us-ascii?Q?mRBAEuwF0+9PJwA+ykgVirnle9OFEUIEzH/e8ZpKV6h4/PRv2YOPKySv+h6b?=
 =?us-ascii?Q?GZRwjFs9ZboetLm9sYumVv2zBhLPxBu5HuVW7mNKGFIJ+VItzXCag+NWSV4P?=
 =?us-ascii?Q?YPUWI/o/v/i6lpkxYaF/0J65mwuJznvrxog6Byi0ZJrqG/xhNLLirLEQGm6g?=
 =?us-ascii?Q?+zLkSpK1oC1U5sEzslvCCHW9XaXlX5M3CaV9pVx1GGp4r+YHxIH/ZIhti9My?=
 =?us-ascii?Q?qj5QToS0oW27omdhWHfERA6rc1EBwhbmMQaR25oxXsoJA3DxoLKVLQZAB+NN?=
 =?us-ascii?Q?h1Qm55e5FpXxmSOed3HpOCexGp5uRDyHV3XmTyz5J0x207JR93asvTLS04Un?=
 =?us-ascii?Q?15tOek89LYI4RoeRRGfUGuwBsP8ptiGTA7Zll3UmLJpXi7eJ6z0iP5wSfY1u?=
 =?us-ascii?Q?nMV70VzxjkPfFwEUJzCjDkfRKaGzbP52ywGrLfOLRCc4lC3nhdBe2/wypioL?=
 =?us-ascii?Q?cYiObZJWZGHV4JrnyJRPNm7YbNnwSJB3OwiG+PMxOxjMS3V0XaFBZncrmHfj?=
 =?us-ascii?Q?zrR/aribW19kiy+pDRQOJmXlig1vV8BEfny8rs2lBGFovd4GcFS7MazKqPur?=
 =?us-ascii?Q?8SgHQ9Louk0aMQpL9NwGlo55QZl/XIgG/KFYfaghN0msRPrFdmdQoCUuDNlN?=
 =?us-ascii?Q?7DtxuhUZMerLhaUVlAhTEkOUsWc2TqiefEi0cbrn53S4g50ZZHoT+3gZg8IZ?=
 =?us-ascii?Q?lsL72Idm99y4bVVAL/Gzgi8DXP8vvzQJ6nEw8pW3JDFlsbU+6IXBPa/puLXB?=
 =?us-ascii?Q?xb33lo8lxP75pDfb0FY7BxhHi/YtyTVxfYXO1XzMUKcEw0OedGY3LZz8ZLcF?=
 =?us-ascii?Q?fW9ZSfCaE0ETVFBRiFffheTvgnFdXnt18uXgQMcFVMOg/2DIcsKiLl/mc9yL?=
 =?us-ascii?Q?c+mboKzKwhLdqQBHAu3k7bQmp4BHqDQEA/bW09XH8J6h/ec//j5ABwSecl7S?=
 =?us-ascii?Q?nzQ3jqBW4iihPtcJdiWvRPdOsPgwcA7izulvzezjXDdI3ffsg6fadlWP1Q+z?=
 =?us-ascii?Q?wBaji7i5Yx0aOdI5+vBWYs6VpngMj2og4nLe6mHFXapTroo10Z1DXS7MIkNJ?=
 =?us-ascii?Q?uWSYawUezbk40CZtElSk3TmwLdxbEwiEn09f6pOdlgI2PF0U/LQOtRox6N2V?=
 =?us-ascii?Q?KrNCbCRBVzqGo2S+yhIAmILjbPkES0QXmlamp7jn9ruYIuC1dSTJZZlh8r3o?=
 =?us-ascii?Q?tBjR3jU58RhaFuDZ4Z+MD5HXR+ZfZwO8FxjVNJsNl2cjDeTXyc1UxKKRxVyd?=
 =?us-ascii?Q?YHq7M1d4s7Mjev84GUdrRtq28kz8UyDLGV0zGbzOUEsqVrk3wr0Blhgc5Rqh?=
 =?us-ascii?Q?fxO93oahhiO+ELiJpLCYZSGAv3/8/kSyqfP7QrNVkYejUA493Vh3V5J6Ydzi?=
 =?us-ascii?Q?4xrfXA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tWCY6YCNTtGNz9Y77ivzAyUAyVermlE4HHjjb4ooB7pDtOk8HKsyOMp0m4fkjotO43sL+/JLvb2vvQ8pc2kBop+5t0h4TlzG0UyXJ+PYWGr/OCtjkpN9NfJpL7Ztd/dxg+JQJ1A7uN/FGYlpskb8rTiOgL4mNiFhPzaXFFaR7uTkMufEiox3CUYKsgqkycCRd/dqU/I3DOj9O0gzgb7SFp8Wwl0whMvTrAaGQuOmUoH0/Ual5HZoLt6QdsOGsUUh8kROZKZAIz0crcgYlmsh6Bh+2q86wJMjhvGqR3Pc37pEYGMgctMYrbpu5fOsopbtM4PjliqI+QJEDzhwsOsSKqs9IOAAF9Mmb8Ogwu6ZJaKHTDZWNWfg2d6BJRElz+52zB6TwPwD5+JsbCXIbA9KkT+BIwgnPAVKjLH3PM9Beqg/QDBIXwWJerzhiF32Qcrmkl5is9+1oPCEqjNe5ttrNgr417JeBFzVmq4fi/BJaLOtKwxdXmnKFVCBbLYbdGmsLf+yo9nxRbhEPeQOrlN+ta6bgZz5RfgrcC1Ctztz/9EkCgLs0xFWEyuErkR6hva0T3x24Bjp8JfE/We0IqsAA1pZ1rz0zaaRRJQtOXRljd0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa03b8b-2aaf-4dca-cfff-08dcb8979b91
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 17:20:47.2054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yk0AO5WSSocyXASe2JOY4KWScXe5lJmRjU8JBPld5MRPAQP/OybOToR5nnaPDi7mQ3VFOKQAv5fKBEI5AnOCXww3OwgOX0DbgM5BAlT+8sQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5944
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_14,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408090124
X-Proofpoint-ORIG-GUID: t2GBtBFm3falBWN7CSwKoBE_DtyLVBep
X-Proofpoint-GUID: t2GBtBFm3falBWN7CSwKoBE_DtyLVBep

On Fri, Aug 09, 2024 at 11:23:30AM GMT, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240805 08:14]:
> > In mmap_region() and do_brk_flags() we open code scenarios where we prefer
> > to use vma_expand() rather than invoke a full vma_merge() operation.
> >
> > Abstract this logic and eliminate all of the open-coding, and also use the
> > same logic for all cases where we add new VMAs to, rather than ultimately
> > use vma_merge(), rather use vma_expand().
> >
> > We implement this by replacing vma_merge_new_vma() with this newly
> > abstracted logic.
> >
> > Doing so removes duplication and simplifies VMA merging in all such cases,
> > laying the ground for us to eliminate the merging of new VMAs in
> > vma_merge() altogether.
> >
> > This makes it far easier to understand what is happening in these cases
> > avoiding confusion, bugs and allowing for future optimisation.
> >
> > As a result of this change we are also able to make vma_prepare(),
> > init_vma_prep(), vma_complete(), can_vma_merge_before() and
> > can_vma_merge_after() static and internal to vma.c.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  mm/mmap.c                        |  79 ++---
> >  mm/vma.c                         | 482 +++++++++++++++++++------------
> >  mm/vma.h                         |  51 +---
> >  tools/testing/vma/vma_internal.h |   6 +
> >  4 files changed, 324 insertions(+), 294 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index f6593a81f73d..c03f50f46396 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1363,8 +1363,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  {
> >  	struct mm_struct *mm = current->mm;
> >  	struct vm_area_struct *vma = NULL;
> > -	struct vm_area_struct *next, *prev, *merge;
> > -	pgoff_t pglen = len >> PAGE_SHIFT;
> > +	struct vm_area_struct *merge;
> >  	unsigned long charged = 0;
> >  	unsigned long end = addr + len;
> >  	bool writable_file_mapping = false;
> > @@ -1411,44 +1410,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		vm_flags |= VM_ACCOUNT;
> >  	}
> >
> > -	next = vmg.next = vma_next(&vmi);
> > -	prev = vmg.prev = vma_prev(&vmi);
> > -	if (vm_flags & VM_SPECIAL) {
> > -		if (prev)
> > -			vma_iter_next_range(&vmi);
> > -		goto cannot_expand;
> > -	}
> > -
> > -	/* Attempt to expand an old mapping */
> > -	/* Check next */
> > -	if (next && next->vm_start == end && can_vma_merge_before(&vmg)) {
> > -		/* We can adjust this as can_vma_merge_after() doesn't touch */
> > -		vmg.end = next->vm_end;
> > -		vma = vmg.vma = next;
> > -		vmg.pgoff = next->vm_pgoff - pglen;
> > -
> > -		/* We may merge our NULL anon_vma with non-NULL in next. */
> > -		vmg.anon_vma = vma->anon_vma;
> > -	}
> > -
> > -	/* Check prev */
> > -	if (prev && prev->vm_end == addr && can_vma_merge_after(&vmg)) {
> > -		vmg.start = prev->vm_start;
> > -		vma = vmg.vma = prev;
> > -		vmg.pgoff = prev->vm_pgoff;
> > -	} else if (prev) {
> > -		vma_iter_next_range(&vmi);
> > -	}
> > -
> > -	/* Actually expand, if possible */
> > -	if (vma && !vma_expand(&vmg)) {
> > -		khugepaged_enter_vma(vma, vm_flags);
> > +	vma = vma_merge_new_vma(&vmg);
> > +	if (vma)
> >  		goto expanded;
> > -	}
> > -
> > -	if (vma == prev)
> > -		vma_iter_set(&vmi, addr);
> > -cannot_expand:
> >
> >  	/*
> >  	 * Determine the object being mapped and call the appropriate
> > @@ -1493,10 +1457,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		 * If vm_flags changed after call_mmap(), we should try merge
> >  		 * vma again as we may succeed this time.
> >  		 */
> > -		if (unlikely(vm_flags != vma->vm_flags && prev)) {
> > -			merge = vma_merge_new_vma_wrapper(&vmi, prev, vma,
> > -							  vma->vm_start, vma->vm_end,
> > -							  vma->vm_pgoff);
> > +		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
> > +			merge = vma_merge_new_vma(&vmg);
> > +
> >  			if (merge) {
> >  				/*
> >  				 * ->mmap() can change vma->vm_file and fput
> > @@ -1596,7 +1559,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >
> >  		vma_iter_set(&vmi, vma->vm_end);
> >  		/* Undo any partial mapping done by a device driver. */
> > -		unmap_region(mm, &vmi.mas, vma, prev, next, vma->vm_start,
> > +		unmap_region(mm, &vmi.mas, vma, vmg.prev, vmg.next, vma->vm_start,
> >  			     vma->vm_end, vma->vm_end, true);
> >  	}
> >  	if (writable_file_mapping)
> > @@ -1773,7 +1736,6 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  		unsigned long addr, unsigned long len, unsigned long flags)
> >  {
> >  	struct mm_struct *mm = current->mm;
> > -	struct vma_prepare vp;
> >
> >  	/*
> >  	 * Check against address space limits by the changed size
> > @@ -1795,29 +1757,22 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  	 */
> >  	if (vma && vma->vm_end == addr) {
> >  		struct vma_merge_struct vmg = {
> > +			.vmi = vmi,
> >  			.prev = vma,
> > +			.next = NULL,
> > +			.start = addr,
> > +			.end = addr + len,
> >  			.flags = flags,
> >  			.pgoff = addr >> PAGE_SHIFT,
> > +			.file = vma->vm_file,
> > +			.anon_vma = vma->anon_vma,
> > +			.policy = vma_policy(vma),
> > +			.uffd_ctx = vma->vm_userfaultfd_ctx,
> > +			.anon_name = anon_vma_name(vma),
> >  		};
> >
> > -		if (can_vma_merge_after(&vmg)) {
> > -			vma_iter_config(vmi, vma->vm_start, addr + len);
> > -			if (vma_iter_prealloc(vmi, vma))
> > -				goto unacct_fail;
> > -
> > -			vma_start_write(vma);
> > -
> > -			init_vma_prep(&vp, vma);
> > -			vma_prepare(&vp);
> > -			vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
> > -			vma->vm_end = addr + len;
> > -			vm_flags_set(vma, VM_SOFTDIRTY);
> > -			vma_iter_store(vmi, vma);
> > -
> > -			vma_complete(&vp, vmi, mm);
> > -			khugepaged_enter_vma(vma, flags);
> > +		if (vma_merge_new_vma(&vmg))
> >  			goto out;
>
> This is very convoluted to follow.  It seems vma_merge_new_vma() will do
> what is necessary by finding out that it can merge after, then call
> vma_expand() which calls commit merge(), which sets the iterator to
> vmg->start, but vmg->start isn't set to vma->vm_start, it is set to addr
> here.. it's actually set to prev->vm_start in vma_merge_new_vma().

Sorry, it's kind of hard to make a change like this all that lovely to
follow.

The only extra checks before it checks mergeability are prev - which we set
to vma, so is not NULL (except in the case of first vma, which is wasteful,
but a one-off) and an is_special and next check.

So this isn't _hugely_ terrible.

As to the vmi positioning... I thought there might be some things that we
could improve on this :)

However, we set prev == vma here, so vmg->start = vma->vm_start, vmg->end =
addr + len which is the same as before right?

I do notice that we've incorrectly removed the vm_flags_set(VM_SOFTDIRTY)
though... will add that back in. Ugh.

Again, so frustrating to not have these functions testable. I'd like to
find a way to move things around if possible at some point. But if we're
worried about call stack maybe not feasible.

>
> This is getting really hard to trace what happens.  I'm also concerned
> that the overhead of following all these checks will cost performance on
> the brk system call?

I'll take a look at mm-tests results.

>
> Maybe we can have a way to set up the vmg and call the right function to
> just make the above happen?  We know with the can_vma_merge_after() that
> it is going to work, so could we just call vma_start_write() and
> commit_merge()?

I'm happy to add an enum or something to set a specific mode if we want,
but maybe worth looking at scalability results first to see if there's
really a regression?

I mean from our discussions on irc, it sounds like this is very possible so
we could figure something out.

>
> Also, vma_merge_new_vma() could fail because it's out of memory so it
> should goto unacct_fail.. but we now don't know if it's because the
> merge wasn't allowed or if we are out of memory..

Yes this is a mistake, damn it. Will fix. Grumble about untestability of
these functions x2.

As per your comment below I think simplest way may be to have an error or
outcome field or some such that we can check to see _why_ things failed.

>
> > -		}
> >  	}
> >
> >  	if (vma)
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 55615392e8d2..a404cf718f9e 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -97,8 +97,7 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
> >   *
> >   * We assume the vma may be removed as part of the merge.
> >   */
> > -bool
> > -can_vma_merge_before(struct vma_merge_struct *vmg)
> > +static bool can_vma_merge_before(struct vma_merge_struct *vmg)
> >  {
> >  	pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
> >
> > @@ -120,7 +119,7 @@ can_vma_merge_before(struct vma_merge_struct *vmg)
> >   *
> >   * We assume that vma is not removed as part of the merge.
> >   */
> > -bool can_vma_merge_after(struct vma_merge_struct *vmg)
> > +static bool can_vma_merge_after(struct vma_merge_struct *vmg)
> >  {
> >  	if (is_mergeable_vma(vmg, false) &&
> >  	    is_mergeable_anon_vma(vmg->anon_vma, vmg->prev->anon_vma, vmg->prev)) {
> > @@ -130,6 +129,164 @@ bool can_vma_merge_after(struct vma_merge_struct *vmg)
> >  	return false;
> >  }
> >
> > +static void __vma_link_file(struct vm_area_struct *vma,
> > +			    struct address_space *mapping)
> > +{
> > +	if (vma_is_shared_maywrite(vma))
> > +		mapping_allow_writable(mapping);
> > +
> > +	flush_dcache_mmap_lock(mapping);
> > +	vma_interval_tree_insert(vma, &mapping->i_mmap);
> > +	flush_dcache_mmap_unlock(mapping);
> > +}
> > +
> > +/*
> > + * Requires inode->i_mapping->i_mmap_rwsem
> > + */
> > +static void __remove_shared_vm_struct(struct vm_area_struct *vma,
> > +				      struct address_space *mapping)
> > +{
> > +	if (vma_is_shared_maywrite(vma))
> > +		mapping_unmap_writable(mapping);
> > +
> > +	flush_dcache_mmap_lock(mapping);
> > +	vma_interval_tree_remove(vma, &mapping->i_mmap);
> > +	flush_dcache_mmap_unlock(mapping);
> > +}
> > +
> > +/*
> > + * vma_prepare() - Helper function for handling locking VMAs prior to altering
> > + * @vp: The initialized vma_prepare struct
> > + */
> > +static void vma_prepare(struct vma_prepare *vp)
> > +{
> > +	if (vp->file) {
> > +		uprobe_munmap(vp->vma, vp->vma->vm_start, vp->vma->vm_end);
> > +
> > +		if (vp->adj_next)
> > +			uprobe_munmap(vp->adj_next, vp->adj_next->vm_start,
> > +				      vp->adj_next->vm_end);
> > +
> > +		i_mmap_lock_write(vp->mapping);
> > +		if (vp->insert && vp->insert->vm_file) {
> > +			/*
> > +			 * Put into interval tree now, so instantiated pages
> > +			 * are visible to arm/parisc __flush_dcache_page
> > +			 * throughout; but we cannot insert into address
> > +			 * space until vma start or end is updated.
> > +			 */
> > +			__vma_link_file(vp->insert,
> > +					vp->insert->vm_file->f_mapping);
> > +		}
> > +	}
> > +
> > +	if (vp->anon_vma) {
> > +		anon_vma_lock_write(vp->anon_vma);
> > +		anon_vma_interval_tree_pre_update_vma(vp->vma);
> > +		if (vp->adj_next)
> > +			anon_vma_interval_tree_pre_update_vma(vp->adj_next);
> > +	}
> > +
> > +	if (vp->file) {
> > +		flush_dcache_mmap_lock(vp->mapping);
> > +		vma_interval_tree_remove(vp->vma, &vp->mapping->i_mmap);
> > +		if (vp->adj_next)
> > +			vma_interval_tree_remove(vp->adj_next,
> > +						 &vp->mapping->i_mmap);
> > +	}
> > +
> > +}
> > +
> > +/*
> > + * vma_complete- Helper function for handling the unlocking after altering VMAs,
> > + * or for inserting a VMA.
> > + *
> > + * @vp: The vma_prepare struct
> > + * @vmi: The vma iterator
> > + * @mm: The mm_struct
> > + */
> > +static void vma_complete(struct vma_prepare *vp,
> > +			 struct vma_iterator *vmi, struct mm_struct *mm)
> > +{
> > +	if (vp->file) {
> > +		if (vp->adj_next)
> > +			vma_interval_tree_insert(vp->adj_next,
> > +						 &vp->mapping->i_mmap);
> > +		vma_interval_tree_insert(vp->vma, &vp->mapping->i_mmap);
> > +		flush_dcache_mmap_unlock(vp->mapping);
> > +	}
> > +
> > +	if (vp->remove && vp->file) {
> > +		__remove_shared_vm_struct(vp->remove, vp->mapping);
> > +		if (vp->remove2)
> > +			__remove_shared_vm_struct(vp->remove2, vp->mapping);
> > +	} else if (vp->insert) {
> > +		/*
> > +		 * split_vma has split insert from vma, and needs
> > +		 * us to insert it before dropping the locks
> > +		 * (it may either follow vma or precede it).
> > +		 */
> > +		vma_iter_store(vmi, vp->insert);
> > +		mm->map_count++;
> > +	}
> > +
> > +	if (vp->anon_vma) {
> > +		anon_vma_interval_tree_post_update_vma(vp->vma);
> > +		if (vp->adj_next)
> > +			anon_vma_interval_tree_post_update_vma(vp->adj_next);
> > +		anon_vma_unlock_write(vp->anon_vma);
> > +	}
> > +
> > +	if (vp->file) {
> > +		i_mmap_unlock_write(vp->mapping);
> > +		uprobe_mmap(vp->vma);
> > +
> > +		if (vp->adj_next)
> > +			uprobe_mmap(vp->adj_next);
> > +	}
> > +
> > +	if (vp->remove) {
> > +again:
> > +		vma_mark_detached(vp->remove, true);
> > +		if (vp->file) {
> > +			uprobe_munmap(vp->remove, vp->remove->vm_start,
> > +				      vp->remove->vm_end);
> > +			fput(vp->file);
> > +		}
> > +		if (vp->remove->anon_vma)
> > +			anon_vma_merge(vp->vma, vp->remove);
> > +		mm->map_count--;
> > +		mpol_put(vma_policy(vp->remove));
> > +		if (!vp->remove2)
> > +			WARN_ON_ONCE(vp->vma->vm_end < vp->remove->vm_end);
> > +		vm_area_free(vp->remove);
> > +
> > +		/*
> > +		 * In mprotect's case 6 (see comments on vma_merge),
> > +		 * we are removing both mid and next vmas
> > +		 */
> > +		if (vp->remove2) {
> > +			vp->remove = vp->remove2;
> > +			vp->remove2 = NULL;
> > +			goto again;
> > +		}
> > +	}
> > +	if (vp->insert && vp->file)
> > +		uprobe_mmap(vp->insert);
> > +	validate_mm(mm);
> > +}
> > +
> > +/*
> > + * init_vma_prep() - Initializer wrapper for vma_prepare struct
> > + * @vp: The vma_prepare struct
> > + * @vma: The vma that will be altered once locked
> > + */
> > +static void init_vma_prep(struct vma_prepare *vp,
> > +			  struct vm_area_struct *vma)
> > +{
> > +	init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
> > +}
> > +
> >  /*
> >   * Close a vm structure and free it.
> >   */
> > @@ -292,31 +449,6 @@ static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
> >  	vm_unacct_memory(nr_accounted);
> >  }
> >
> > -/*
> > - * init_vma_prep() - Initializer wrapper for vma_prepare struct
> > - * @vp: The vma_prepare struct
> > - * @vma: The vma that will be altered once locked
> > - */
> > -void init_vma_prep(struct vma_prepare *vp,
> > -		   struct vm_area_struct *vma)
> > -{
> > -	init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
> > -}
> > -
> > -/*
> > - * Requires inode->i_mapping->i_mmap_rwsem
> > - */
> > -static void __remove_shared_vm_struct(struct vm_area_struct *vma,
> > -				      struct address_space *mapping)
> > -{
> > -	if (vma_is_shared_maywrite(vma))
> > -		mapping_unmap_writable(mapping);
> > -
> > -	flush_dcache_mmap_lock(mapping);
> > -	vma_interval_tree_remove(vma, &mapping->i_mmap);
> > -	flush_dcache_mmap_unlock(mapping);
> > -}
> > -
> >  /*
> >   * vma has some anon_vma assigned, and is already inserted on that
> >   * anon_vma's interval trees.
> > @@ -349,60 +481,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
> >  		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
> >  }
> >
> > -static void __vma_link_file(struct vm_area_struct *vma,
> > -			    struct address_space *mapping)
> > -{
> > -	if (vma_is_shared_maywrite(vma))
> > -		mapping_allow_writable(mapping);
> > -
> > -	flush_dcache_mmap_lock(mapping);
> > -	vma_interval_tree_insert(vma, &mapping->i_mmap);
> > -	flush_dcache_mmap_unlock(mapping);
> > -}
> > -
> > -/*
> > - * vma_prepare() - Helper function for handling locking VMAs prior to altering
> > - * @vp: The initialized vma_prepare struct
> > - */
> > -void vma_prepare(struct vma_prepare *vp)
> > -{
> > -	if (vp->file) {
> > -		uprobe_munmap(vp->vma, vp->vma->vm_start, vp->vma->vm_end);
> > -
> > -		if (vp->adj_next)
> > -			uprobe_munmap(vp->adj_next, vp->adj_next->vm_start,
> > -				      vp->adj_next->vm_end);
> > -
> > -		i_mmap_lock_write(vp->mapping);
> > -		if (vp->insert && vp->insert->vm_file) {
> > -			/*
> > -			 * Put into interval tree now, so instantiated pages
> > -			 * are visible to arm/parisc __flush_dcache_page
> > -			 * throughout; but we cannot insert into address
> > -			 * space until vma start or end is updated.
> > -			 */
> > -			__vma_link_file(vp->insert,
> > -					vp->insert->vm_file->f_mapping);
> > -		}
> > -	}
> > -
> > -	if (vp->anon_vma) {
> > -		anon_vma_lock_write(vp->anon_vma);
> > -		anon_vma_interval_tree_pre_update_vma(vp->vma);
> > -		if (vp->adj_next)
> > -			anon_vma_interval_tree_pre_update_vma(vp->adj_next);
> > -	}
> > -
> > -	if (vp->file) {
> > -		flush_dcache_mmap_lock(vp->mapping);
> > -		vma_interval_tree_remove(vp->vma, &vp->mapping->i_mmap);
> > -		if (vp->adj_next)
> > -			vma_interval_tree_remove(vp->adj_next,
> > -						 &vp->mapping->i_mmap);
> > -	}
> > -
> > -}
> > -
> >  /*
> >   * dup_anon_vma() - Helper function to duplicate anon_vma
> >   * @dst: The destination VMA
> > @@ -486,6 +564,120 @@ void validate_mm(struct mm_struct *mm)
> >  }
> >  #endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
> >
> > +/*
> > + * vma_merge_new_vma - Attempt to merge a new VMA into address space
> > + *
> > + * @vmg: Describes the VMA we are adding, in the range @vmg->start to @vmg->end
> > + *       (exclusive), which we try to merge with any adjacent VMAs if possible.
> > + *
> > + * We are about to add a VMA to the address space starting at @vmg->start and
> > + * ending at @vmg->end. There are three different possible scenarios:
> > + *
> > + * 1. There is a VMA with identical properties immediately adjacent to the
> > + *    proposed new VMA [@vmg->start, @vmg->end) either before or after it -
> > + *    EXPAND that VMA:
> > + *
> > + * Proposed:       |-----|  or  |-----|
> > + * Existing:  |----|                  |----|
> > + *
> > + * 2. There are VMAs with identical properties immediately adjacent to the
> > + *    proposed new VMA [@vmg->start, @vmg->end) both before AND after it -
> > + *    EXPAND the former and REMOVE the latter:
> > + *
> > + * Proposed:       |-----|
> > + * Existing:  |----|     |----|
> > + *
> > + * 3. There are no VMAs immediately adjacent to the proposed new VMA or those
> > + *    VMAs do not have identical attributes - NO MERGE POSSIBLE.
>
> We still have diagrams, that's too bad.

But they're cute ones! Upgrade right?

>
> > + *
> > + * In instances where we can merge, this function returns the expanded VMA which
> > + * will have its range adjusted accordingly and the underlying maple tree also
> > + * adjusted.
> > + *
> > + * Returns: In instances where no merge was possible, NULL. Otherwise, a pointer
> > + *          to the VMA we expanded.
> > + *
> > + * This function also adjusts @vmg to provide @vmg->prev and @vmg->next if
> > + * neither already specified, and adjusts [@vmg->start, @vmg->end) to span the
> > + * expanded range.
> > + *
> > + * ASSUMPTIONS:
> > + * - The caller must hold a WRITE lock on the mm_struct->mmap_lock.
> > + * - The caller must have determined that [@vmg->start, @vmg->end) is empty.
> > + */
> > +struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
> > +{
> > +	bool is_special = vmg->flags & VM_SPECIAL;
> > +	struct vm_area_struct *prev = vmg->prev;
> > +	struct vm_area_struct *next = vmg->next;
> > +	unsigned long start = vmg->start;
> > +	unsigned long end = vmg->end;
> > +	pgoff_t pgoff = vmg->pgoff;
> > +	pgoff_t pglen = PHYS_PFN(end - start);
> > +
> > +	VM_WARN_ON(vmg->vma);
> > +
> > +	if (!prev && !next) {
> > +		/*
> > +		 * Since the caller must have determined that the requested
> > +		 * range is empty, vmg->vmi will be left pointing at the VMA
> > +		 * immediately prior.
> > +		 */
> > +		next = vmg->next = vma_next(vmg->vmi);
> > +		prev = vmg->prev = vma_prev(vmg->vmi);
> > +
> > +		/* Avoid maple tree re-walk. */
> > +		if (is_special && prev)
> > +			vma_iter_next_range(vmg->vmi);
> > +	}
> > +
> > +	/* If special mapping or no adjacent VMAs, nothing to merge. */
> > +	if (is_special || (!prev && !next))
> > +		return NULL;
> > +
> > +	/* If we can merge with the following VMA, adjust vmg accordingly. */
> > +	if (next && next->vm_start == end && can_vma_merge_before(vmg)) {
> > +		/*
> > +		 * We can adjust this here as can_vma_merge_after() doesn't
> > +		 * touch vmg->end.
> > +		 */
> > +		vmg->end = next->vm_end;
> > +		vmg->vma = next;
> > +		vmg->pgoff = next->vm_pgoff - pglen;
> > +
> > +		vmg->anon_vma = next->anon_vma;
> > +	}
> > +
> > +	/* If we can merge with the previous VMA, adjust vmg accordingly. */
> > +	if (prev && prev->vm_end == start && can_vma_merge_after(vmg)) {
> > +		vmg->start = prev->vm_start;
> > +		vmg->vma = prev;
> > +		vmg->pgoff = prev->vm_pgoff;
> > +	} else if (prev) {
> > +		vma_iter_next_range(vmg->vmi);
> > +	}
> > +
> > +	/*
> > +	 * Now try to expand adjacent VMA(s). This takes care of removing the
> > +	 * following VMA if we have VMAs on both sides.
> > +	 */
> > +	if (vmg->vma && !vma_expand(vmg)) {
> > +		khugepaged_enter_vma(vmg->vma, vmg->flags);
> > +		return vmg->vma;
> > +	}
> > +
> > +	/* If expansion failed, reset state. Allows us to retry merge later. */
> > +	vmg->vma = NULL;
> > +	vmg->anon_vma = NULL;
> > +	vmg->start = start;
> > +	vmg->end = end;
> > +	vmg->pgoff = pgoff;
> > +	if (vmg->vma == prev)
> > +		vma_iter_set(vmg->vmi, start);
> > +
> > +	return NULL;
> > +}
>
> Can we split this up a bit?  I was thinking that, for the brk() case, we
> need to know if we can merge prev and if that merge fails.  I was
> thinking something that you create a vmg with whatever, then call
> can_merge_prev, and that'd do the block above and change the vmg as
> required.  We could have a can_merge_next that does the same, then we
> need to prepare the change (dup anon vma, preallocate for maple tree,
> locking, whatever), then commit.

Yeah that's not a bad idea, that could actually help really help clarify
what's going on.

Then could have a sort of state machine that indicates that we've already
adjusted vmg parameters for the merge.

I'm thinking though of a vma_merge_new_vma() / vma_merge_modified_vma()
that invokes different code to figure out how to expand.

I will have a fiddle around and see what I can figure out that makes sense.

>
> There could still be the function above, but with smaller widgets to do
> what we need so we gain flexibility in what we decide to check - prev
> only in brk().
>
> I'm not sure if we'd need one for expanding vs existing or if we could
> check !vmg->vma to figure that out..
>
> This would also have the effect of self-documenting what is going on.
> For brk, it would look like this:
>
> if (vmg_expand_prev()) {
> 	if (vmg_prepare())
> 		goto no_mem;
> 	vmg_commit();
> }
>
> I think this would change your exposed interface, at least for brk() -
> or a wrapper for this, but small widgets may gain us some
> self-documented code?
>
> If you really don't like the exposure of the interface, the vmg could
> have a return so we can see if we ran out of memory?

I really don't like can_vma_merge_xxx() being exposed, it's very clearly an
internal interface.

As mentioned above we can have some kind of way of passing back an error
code.

Obviously if testing indicates stack size/perf is a problem we can
begrudgingly accept the interface leak :'(. Will check that.

>
> > +
> >  /*
> >   * vma_expand - Expand an existing VMA
> >   *
> > @@ -496,7 +688,11 @@ void validate_mm(struct mm_struct *mm)
> >   * vmg->next->vm_end.  Checking if the vmg->vma can expand and merge with
> >   * vmg->next needs to be handled by the caller.
> >   *
> > - * Returns: 0 on success
> > + * Returns: 0 on success.
> > + *
> > + * ASSUMPTIONS:
> > + * - The caller must hold a WRITE lock on vmg->vma->mm->mmap_lock.
> > + * - The caller must have set @vmg->prev and @vmg->next.
> >   */
> >  int vma_expand(struct vma_merge_struct *vmg)
> >  {
> > @@ -576,85 +772,6 @@ int vma_shrink(struct vma_merge_struct *vmg)
> >  	return 0;
> >  }
> >
> > -/*
> > - * vma_complete- Helper function for handling the unlocking after altering VMAs,
> > - * or for inserting a VMA.
> > - *
> > - * @vp: The vma_prepare struct
> > - * @vmi: The vma iterator
> > - * @mm: The mm_struct
> > - */
> > -void vma_complete(struct vma_prepare *vp,
> > -		  struct vma_iterator *vmi, struct mm_struct *mm)
> > -{
> > -	if (vp->file) {
> > -		if (vp->adj_next)
> > -			vma_interval_tree_insert(vp->adj_next,
> > -						 &vp->mapping->i_mmap);
> > -		vma_interval_tree_insert(vp->vma, &vp->mapping->i_mmap);
> > -		flush_dcache_mmap_unlock(vp->mapping);
> > -	}
> > -
> > -	if (vp->remove && vp->file) {
> > -		__remove_shared_vm_struct(vp->remove, vp->mapping);
> > -		if (vp->remove2)
> > -			__remove_shared_vm_struct(vp->remove2, vp->mapping);
> > -	} else if (vp->insert) {
> > -		/*
> > -		 * split_vma has split insert from vma, and needs
> > -		 * us to insert it before dropping the locks
> > -		 * (it may either follow vma or precede it).
> > -		 */
> > -		vma_iter_store(vmi, vp->insert);
> > -		mm->map_count++;
> > -	}
> > -
> > -	if (vp->anon_vma) {
> > -		anon_vma_interval_tree_post_update_vma(vp->vma);
> > -		if (vp->adj_next)
> > -			anon_vma_interval_tree_post_update_vma(vp->adj_next);
> > -		anon_vma_unlock_write(vp->anon_vma);
> > -	}
> > -
> > -	if (vp->file) {
> > -		i_mmap_unlock_write(vp->mapping);
> > -		uprobe_mmap(vp->vma);
> > -
> > -		if (vp->adj_next)
> > -			uprobe_mmap(vp->adj_next);
> > -	}
> > -
> > -	if (vp->remove) {
> > -again:
> > -		vma_mark_detached(vp->remove, true);
> > -		if (vp->file) {
> > -			uprobe_munmap(vp->remove, vp->remove->vm_start,
> > -				      vp->remove->vm_end);
> > -			fput(vp->file);
> > -		}
> > -		if (vp->remove->anon_vma)
> > -			anon_vma_merge(vp->vma, vp->remove);
> > -		mm->map_count--;
> > -		mpol_put(vma_policy(vp->remove));
> > -		if (!vp->remove2)
> > -			WARN_ON_ONCE(vp->vma->vm_end < vp->remove->vm_end);
> > -		vm_area_free(vp->remove);
> > -
> > -		/*
> > -		 * In mprotect's case 6 (see comments on vma_merge),
> > -		 * we are removing both mid and next vmas
> > -		 */
> > -		if (vp->remove2) {
> > -			vp->remove = vp->remove2;
> > -			vp->remove2 = NULL;
> > -			goto again;
> > -		}
> > -	}
> > -	if (vp->insert && vp->file)
> > -		uprobe_mmap(vp->insert);
> > -	validate_mm(mm);
> > -}
> > -
> >  /*
> >   * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
> >   * @vmi: The vma iterator
> > @@ -1261,20 +1378,6 @@ struct vm_area_struct
> >  	return vma_modify(&vmg);
> >  }
> >
> > -/*
> > - * Attempt to merge a newly mapped VMA with those adjacent to it. The caller
> > - * must ensure that [start, end) does not overlap any existing VMA.
> > - */
> > -struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
> > -{
> > -	if (!vmg->prev) {
> > -		vmg->prev = vma_prev(vmg->vmi);
> > -		vma_iter_set(vmg->vmi, vmg->start);
> > -	}
> > -
> > -	return vma_merge(vmg);
> > -}
> > -
> >  /*
> >   * Expand vma by delta bytes, potentially merging with an immediately adjacent
> >   * VMA with identical properties.
> > @@ -1297,8 +1400,7 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
> >  		.anon_name = anon_vma_name(vma),
> >  	};
> >
> > -	/* vma is specified as prev, so case 1 or 2 will apply. */
> > -	return vma_merge(&vmg);
> > +	return vma_merge_new_vma(&vmg);
> >  }
> >
> >  void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
> > @@ -1399,24 +1501,40 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
> >  	struct vm_area_struct *vma = *vmap;
> >  	unsigned long vma_start = vma->vm_start;
> >  	struct mm_struct *mm = vma->vm_mm;
> > -	struct vm_area_struct *new_vma, *prev;
> > +	struct vm_area_struct *new_vma;
> >  	bool faulted_in_anon_vma = true;
> >  	VMA_ITERATOR(vmi, mm, addr);
> > +	struct vma_merge_struct vmg = {
> > +		.vmi = &vmi,
> > +		.start = addr,
> > +		.end = addr + len,
> > +		.flags = vma->vm_flags,
> > +		.pgoff = pgoff,
> > +		.file = vma->vm_file,
> > +		.anon_vma = vma->anon_vma,
> > +		.policy = vma_policy(vma),
> > +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> > +		.anon_name = anon_vma_name(vma),
> > +	};
> >
> >  	/*
> >  	 * If anonymous vma has not yet been faulted, update new pgoff
> >  	 * to match new location, to increase its chance of merging.
> >  	 */
> >  	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma)) {
> > -		pgoff = addr >> PAGE_SHIFT;
> > +		pgoff = vmg.pgoff = addr >> PAGE_SHIFT;
> >  		faulted_in_anon_vma = false;
> >  	}
> >
> > -	new_vma = find_vma_prev(mm, addr, &prev);
> > +	new_vma = find_vma_prev(mm, addr, &vmg.prev);
> >  	if (new_vma && new_vma->vm_start < addr + len)
> >  		return NULL;	/* should never get here */
> >
> > -	new_vma = vma_merge_new_vma_wrapper(&vmi, prev, vma, addr, addr + len, pgoff);
> > +	vmg.next = vma_next(&vmi);
> > +	vma_prev(&vmi);
> > +
> > +	new_vma = vma_merge_new_vma(&vmg);
> > +
> >  	if (new_vma) {
> >  		/*
> >  		 * Source vma may have been merged into new_vma
> > diff --git a/mm/vma.h b/mm/vma.h
> > index 50459f9e4c7f..bbb173053f34 100644
> > --- a/mm/vma.h
> > +++ b/mm/vma.h
> > @@ -55,17 +55,6 @@ void anon_vma_interval_tree_pre_update_vma(struct vm_area_struct *vma);
> >  /* Required for expand_downwards(). */
> >  void anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma);
> >
> > -/* Required for do_brk_flags(). */
> > -void vma_prepare(struct vma_prepare *vp);
> > -
> > -/* Required for do_brk_flags(). */
> > -void init_vma_prep(struct vma_prepare *vp,
> > -		   struct vm_area_struct *vma);
> > -
> > -/* Required for do_brk_flags(). */
> > -void vma_complete(struct vma_prepare *vp,
> > -		  struct vma_iterator *vmi, struct mm_struct *mm);
> > -
> >  int vma_expand(struct vma_merge_struct *vmg);
> >  int vma_shrink(struct vma_merge_struct *vmg);
> >
> > @@ -85,20 +74,6 @@ void unmap_region(struct mm_struct *mm, struct ma_state *mas,
> >  		struct vm_area_struct *next, unsigned long start,
> >  		unsigned long end, unsigned long tree_end, bool mm_wr_locked);
> >
> > -/*
> > - * Can we merge the VMA described by vmg into the following VMA vmg->next?
> > - *
> > - * Required by mmap_region().
> > - */
> > -bool can_vma_merge_before(struct vma_merge_struct *vmg);
> > -
> > -/*
> > - * Can we merge the VMA described by vmg into the preceding VMA vmg->prev?
> > - *
> > - * Required by mmap_region() and do_brk_flags().
> > - */
> > -bool can_vma_merge_after(struct vma_merge_struct *vmg);
> > -
> >  /* We are about to modify the VMA's flags. */
> >  struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
> >  					struct vm_area_struct *prev,
> > @@ -133,31 +108,7 @@ struct vm_area_struct
> >  		       unsigned long new_flags,
> >  		       struct vm_userfaultfd_ctx new_ctx);
> >
> > -struct vm_area_struct
> > -*vma_merge_new_vma(struct vma_merge_struct *vmg);
> > -
> > -/* Temporary convenience wrapper. */
> > -static inline struct vm_area_struct
> > -*vma_merge_new_vma_wrapper(struct vma_iterator *vmi, struct vm_area_struct *prev,
> > -			   struct vm_area_struct *vma, unsigned long start,
> > -			   unsigned long end, pgoff_t pgoff)
> > -{
> > -	struct vma_merge_struct vmg = {
> > -		.vmi = vmi,
> > -		.prev = prev,
> > -		.start = start,
> > -		.end = end,
> > -		.flags = vma->vm_flags,
> > -		.file = vma->vm_file,
> > -		.anon_vma = vma->anon_vma,
> > -		.pgoff = pgoff,
> > -		.policy = vma_policy(vma),
> > -		.uffd_ctx = vma->vm_userfaultfd_ctx,
> > -		.anon_name = anon_vma_name(vma),
> > -	};
> > -
> > -	return vma_merge_new_vma(&vmg);
> > -}
> > +struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg);
> >
> >  /*
> >   * Temporary wrapper around vma_merge() so we can have a common interface for
> > diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> > index 40797a819d3d..a39a734282d0 100644
> > --- a/tools/testing/vma/vma_internal.h
> > +++ b/tools/testing/vma/vma_internal.h
> > @@ -709,6 +709,12 @@ static inline void vma_iter_free(struct vma_iterator *vmi)
> >  	mas_destroy(&vmi->mas);
> >  }
> >
> > +static inline
> > +struct vm_area_struct *vma_iter_next_range(struct vma_iterator *vmi)
> > +{
> > +	return mas_next_range(&vmi->mas, ULONG_MAX);
> > +}
> > +
> >  static inline void vm_acct_memory(long pages)
> >  {
> >  }
> > --
> > 2.45.2
> >

