Return-Path: <linux-kernel+bounces-387301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2645E9B4F30
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F66286810
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D463B1993BA;
	Tue, 29 Oct 2024 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aYPF7c6J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PbUPMyR4"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB66D198A36
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730218917; cv=fail; b=goJK3GAzUVjdupM4s709XW0VoWPCvapM68YFcCq/NTvS1NvPzAW7Iyji43SROTRc5w26h5Qh3r7uTsG6gxr1Mn5O2Cuq8M7UJgsQCi5nreJOZqszxAzZ7++fU7YbaJQ9OJZUyHBMr39BL2vIbpZaVnpiaPbesEk/cM5qh4II178=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730218917; c=relaxed/simple;
	bh=Mp4rNHzmaJ/rPMKBfeYEp7hVnC6NHe1l3mmOuiposvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a/QKIvzgzV4oxo2p9OVzJ6J8DXOBI6rNjvdIYa0fplPXh54qA+jX+miPqTh23UG4vGu9alC6DaZVjnkmQZ2/Hq0U0KmhGLhCteMUObqQ45BuJGTb+NkMfVOq6MTOyX/lQXDxwcCHZVjw615w3cI/Rm4lMfX7UnDiwT6ujkUQXcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aYPF7c6J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PbUPMyR4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TEtcvb014350;
	Tue, 29 Oct 2024 16:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Mp4rNHzmaJ/rPMKBfeYEp7hVnC6NHe1l3mmOuiposvY=; b=
	aYPF7c6Jt/zHi1L0H47Rct8Vp3v6DUbuAalgJnMMMkChS/mVhpvitnPCr5Hb9Wqp
	E1XtLPkm6pBdYbE+kTB1Kt5QR3VlrwM6VPutYtq/qIqLnrd0fMC5ScqJD0vzzWal
	FV74V1pQsko2Ao520xaNPmF9+aed8aR9BTfCfbYuBVBL8UJ/Hsx2S8sO5/R+I++6
	SA0wqRqkZGnAye6ROC3Qg1T0hsT+zjZoJKrRVjhkzP92+tcxtDVy/HQFXb/WzEcu
	4bLO7jV1ud1Tkcd8T469nTt8OL4ARfM4/evm7gwyMcq1ZnEu4Phm70zrQHJl9ULa
	UX+XzBLrgF0jNoX3MHEmCA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdp5ybh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 16:21:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TFxkjI040263;
	Tue, 29 Oct 2024 16:21:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hnapcbrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 16:21:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSvt9p/VInBqP3qxHiE7CsoVwCqhIFNwsdS1iObo9UQ9pv3hy2kSoruFmyHQaKy44Udgemve/gkvHLbEKCjrnB43YJH5oAP2Ej92uCNN6n0DhOVP2J/7zZfsRLlIQjZhtyczyhnBniRjP5hRfj3y7Qgme/ecezIRrq9/a7LdthEZj14opsDc5Z/FptqYN19qzbJ41no0g567N9NtQOLFwpkiXI0YD+frGhaKUIP52Lx5FUI9gZ6eetsnzjQmlKk+WYFQFI9c9/Atz2RAI0TOmUbRYLu+AYsOUgmmH2s6FAl12Z30i/1qtbDgSCHnL67qWcMZ1rSjULhoQN6Fj2O93w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mp4rNHzmaJ/rPMKBfeYEp7hVnC6NHe1l3mmOuiposvY=;
 b=m3ITTsMBRG+dpJY7+agjh0yw3POo9XZw+F+/rA3juedGPBtdZsehzKORUXqeTODZpOBRjvoHFaspesm91d3jW7urNWO8vmBC1thVmUioLuU3rSjVFjT2qYbTsqaUgrFa7fMZTDfEvXYcv9xxCHhBaVP8IKTrvqX24HhZl7EEFBSUNWo6Dxp9kR8b6pF7i43VlVGpVZEAhQLWxKGPhA44DIN+GuwzAQp4aHEOUgKPMh7g13AYyDgzNHw9Vfm4+1lM9J0kV9XX+NkxFQytV0WjW1rD+rg96JyWiWDkcOBw+R4InyPw60DGEm9XXJvTS3+RxyFQOnaOLiPZ1dhcxM+HOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mp4rNHzmaJ/rPMKBfeYEp7hVnC6NHe1l3mmOuiposvY=;
 b=PbUPMyR4E3y6LC8Bo2V2Vs72wj+oMIpcDQ+o/e/XGYY4io2LktjKnxa4KbjOf3QHGWBhEkDZuTmT0VurDzQBRo3Z6Esiyg9BnSP520N9XOYdUQzV2nFItXoUXA3NVcqqC5od/FuhP9MxjkQUDQCRkv+fsoYoSn+33BzctcGU8Oo=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MN6PR10MB8192.namprd10.prod.outlook.com (2603:10b6:208:4fd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 16:21:25 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 16:21:25 +0000
Date: Tue, 29 Oct 2024 16:21:22 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yang Shi <shy828301@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH hotfix 6.12 v3 4/5] mm: refactor arch_validate_flags()
 and arm64 MTE handling
Message-ID: <00a06ba2-e9ad-46a8-a3f3-5d4ad9eb1c00@lucifer.local>
References: <cover.1730206735.git.lorenzo.stoakes@oracle.com>
 <ea10a05be83c70cf610d470fe3b4c05513e3859c.1730206735.git.lorenzo.stoakes@oracle.com>
 <CAHbLzkqmDyOb9kwLKyKkThjT41UNCwb6p8XL6rEHVmvEbJEXZw@mail.gmail.com>
 <32e59a00-a174-4fcc-befd-56915cfb01d1@lucifer.local>
 <CAHbLzkrvwXOhjbH9pMoJq_-r9nCbwW=HrTnkA3avP2C=7QaMNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHbLzkrvwXOhjbH9pMoJq_-r9nCbwW=HrTnkA3avP2C=7QaMNg@mail.gmail.com>
X-ClientProxiedBy: LNXP123CA0019.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::31) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MN6PR10MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: 3457b7db-76a9-468d-3a29-08dcf835bc1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGRiNFlPSDBlWmtTb0FtTDUzc2dDZWYrR2xYWXVZeW1nbXJlR3F6UmtReU5z?=
 =?utf-8?B?ZmZNOVk0eVVJNnNOVTc2Sy9xQjBEMktjZGNwVzNLMUlNclV5ZFRJK0tEQVBx?=
 =?utf-8?B?TVZXZSt4cGNENi96S0VZWEpBWUhmUytmcng1eWNPZ1FjVFdTcjE2RUU3T0Jx?=
 =?utf-8?B?a1lPMGY1Z3lydm9zOFNIZlFVc1Z3UEFEVmwycmlZSksxK1JqRVdjK3dWNHRH?=
 =?utf-8?B?eUtaYWdKMDA1OWo3QXhFbksxSGZWbnlyNDhIcUNVWXhCT0lpYjdDQklVZ2FD?=
 =?utf-8?B?TFJWdUltQzNNbklBK1N2YXlGRTduTE4vT0VHN0s2K2w3Z3NDUUdQeFdGc0hC?=
 =?utf-8?B?eEdqVWMvTVNFS3laRVFMaFhIaVFEdkcwWlhRamlOb0Zmd0ZUSmladEhxM25E?=
 =?utf-8?B?eHNiaE5VdFhOSm5JVlFwU205bkRlR1AwVStGTVN6WUJDZ2J3MXRqR2ZLanNU?=
 =?utf-8?B?QmM5dlFBSGI3N0pUODBiVDM5UEdleVNXYm1NeTN1RzNBSmJYeVREWThOQ2k5?=
 =?utf-8?B?a0RqN3dvRk5Sam82RmNya1R1S1NINFRVNUFXejhxSjN2M0JwVDJTeHVzTXVs?=
 =?utf-8?B?bSs3anlRS2RxZEQ3NmJxVFc0citPd2pEMUJTZVJHNk8zNXJlbWZCeG5qWTRY?=
 =?utf-8?B?eGZTTWV2VTV4b3o4cEJML2Q2TUdLTDkvajNwSGlQZjJnbHByVjhwbFB4VHpK?=
 =?utf-8?B?UHQyNEk4c09Wb1U1M1BQOTJEbkpnRzl1aDEzTTNpY2RlNUx6V01sYVg5Yzlk?=
 =?utf-8?B?S0VuaDNhQ1lhM1RZVmh3YWVhcDRWUUxQL3VkT1NsMitQMXRma1RSb1VKMjRu?=
 =?utf-8?B?amZLYW1hOXlQNlhUQkJRbXFsUUZVSkRETWZFWGhkTEw1RzUzL29JZnBjRDJZ?=
 =?utf-8?B?QVR1ZHJBQVdjU1BXZXI4UUgrYk5CbHRqVFFFT2haOHlXeWErcGpoZk54K3li?=
 =?utf-8?B?bHZDUW9KdWdvcHNGOXk3TmFyNk1EVGVOc2JLdWIxMC9IYUlsdjhmNEhySnZU?=
 =?utf-8?B?M3A4ekdhSE1XemEyekZndGJETktBcU05SWM0eG90eGkweTR2YTRMNE91cG8z?=
 =?utf-8?B?dURFbHpSbVM5aldFVzlpNjdLYVV4ZWJHZ0Y0bzhyTXI1RndoUkR4L1EyclU4?=
 =?utf-8?B?cG0zNkUzbExlMmQweXlJL1dXSzQwZmFBWThxcjNKNjFDbVpOaG52cDRENTVx?=
 =?utf-8?B?OEZFZUo3TkNpcjNGS1JKWTJuSS92WHRuMzNlUzZXRlZCUnF2RnR3Y0Nnc2RL?=
 =?utf-8?B?R0c0OWF3dkNqL3l6d1d0cFZOTFBiV012Y2xsTzJUUjRqTko4cmh1MnIwc1Vn?=
 =?utf-8?B?OWlKZHNHQytFeHVPelF6QTRzOTJHdlA2RDg0bUZwZmpTNGZkdWJDWEhoUEVq?=
 =?utf-8?B?U3E3cFlJL09jdkdNTDF0UHpnMkwxcFhtUUNGMzlJY2RlVjY4S1R2Y2M5V2dj?=
 =?utf-8?B?M0lpMjJJeEo3SFEwYi9EQ2lObEVEODF2S1prSGI5OUZ4ZXNiTWNPN044SWcz?=
 =?utf-8?B?MGd2dElTOVJlZVA4cDhSZEl4MHFPR3VKVW9RcGxYQzhEYmM3NkljL1g2cTNl?=
 =?utf-8?B?TDVRVTFBL0R1TFpaWENnUEdIS2ZNSmszbS9SWG8vYm5Hb1MxU1dEVGFqNjNw?=
 =?utf-8?B?RzMvS1prMWd4WHFDQVNLLzFoTXRIM0NxOG16Z2pRdkY0OUVXRW9VMVU1aW1B?=
 =?utf-8?B?YkUxeDZoMWgzSERsVzZGU3ZqYmxHSFVNb0xOcTg0UUZyMWFZL29UZU1SSjd6?=
 =?utf-8?Q?6qdzQzL07rNp0Bl0GPyLtrLdmCZTc2QfpsW7rD9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUlCb3E0c1lLWEVKZGl2MXFwQnh2OWdxQ1ByRkxHdC9WRDByMFBuRTN4cmNm?=
 =?utf-8?B?K09PSXB3WUFUUDFIWU96K0FiRldOTTlIUFRRdXhNMDRvRUtsZ2tSK3FKbFdx?=
 =?utf-8?B?VGhmd1hraEVaaFRRWkJBbWpZUFlzVWoyZVppQlkzc01YdmhrN2RDdTNnVG1h?=
 =?utf-8?B?Si9teGVTeGNDc1M0QTlsM2Q1Nk82b3lVNDFaWnJLZFY4UzBqUnlSMjM4QW95?=
 =?utf-8?B?QnZjU3ZHUnRlVFVOYlp5SkkyZ3NMMlNXZ3JOclZsV1h4NmlXQXJrRkpiaEpr?=
 =?utf-8?B?akJiMDJDQjZBdnZFanlXSHA0QTMvbVlzbmFmV0ltUTh2RnRUS241WGR4emVq?=
 =?utf-8?B?YUpxSS9GZXhTWmtQSjd5K2dmNUV0TDdXWndWYU50cy9Pa3krcnhRckJyZ3A3?=
 =?utf-8?B?ZnFjdGpncGh1dktYd25JUWF1dTVCSDZvSXdPaXhrWTNMU3h6Nkh1ZnlBTDFq?=
 =?utf-8?B?Vk0wbm50WHdNSGR3SFpvejFZM2V5TVhnekhBNTBkTFVYY0lXRGlzbDFNUnJw?=
 =?utf-8?B?VzdndXQwQkE2VE9vMDBiMnlwZlE0OGlIUG1UVTNROCtYQkZGdUdkdXRLYitI?=
 =?utf-8?B?V1pRWVVSR0FHdXpxZW5KbmtTY0UwN29lejh1aE1Ec3JabHhNdUxMTHdueHU4?=
 =?utf-8?B?WXdWZGRxQVFSeGxlZUJxT2U0cnNicHg5RTM3QVBsSWxBbUdpeWRNWGc5aUI1?=
 =?utf-8?B?Q0dXdzBKZGcrZXZmV1JzRzE0K0NwcHFYV1E5azJSakxFOHpmcWZtYlNMRzBI?=
 =?utf-8?B?Z2VReTVrUm1XUFFUMjdTYmJDdmEvLzlkTDVHdTFxOFk3RGhnTlpCTGtYbThI?=
 =?utf-8?B?ZUMvK3hnK3REbjdzTFNQc1JHUjBaZGpCWkVtTVZLTDBsMHZ3RnpMZW5ia3Zt?=
 =?utf-8?B?VnpETURuS2ZFeEdJRVhYclBod2c5czRKZWlmZ3A1dnNTUEZZVnVOdEJnS21I?=
 =?utf-8?B?ZnRFTFh3NElyN1BWUXkxMW1DNkhSMldYU1g4SmkyRWV5VWdZanRlSnZUSWtM?=
 =?utf-8?B?Y1MwS2hra0p6Z3FRZnp6cVJSS1ZxRXU5ajZtbzAxMmlMWFl6RW9pYjB2SnJk?=
 =?utf-8?B?ZGRkVVhJTUl1OVVhN3I4cW44dkw0THI1VjYxc1JBV3FUTUNZRnlaam54c1pO?=
 =?utf-8?B?bHVLaFdweGgrU3U1dFZ1L2ZURldEdm8yWjdteUJqenp5RFBjV3A0d3EwalhF?=
 =?utf-8?B?UWthcVpZdGZMQlF2RlFnelhvcUFSR0h0cHc0b3pvUG11VFFYc1ZoOVJsR2xY?=
 =?utf-8?B?SS9idFV3UDdndnVXMStvcHpzNmxJVVA1OGgvR0hhdyt5ZnlBV3p1dFlRZ2lq?=
 =?utf-8?B?c1ZoNm5EOVF2WjZKUDJkaWhjbDhOY3lhQWJrQzVuTW94cm9ycmM2eU1PR0dz?=
 =?utf-8?B?eVFFM1BvN1pkamFYdm5wUjBOZGNzalVuMUVvZ3dTYjV1RVczL29xckVmblZO?=
 =?utf-8?B?TTJNeXBDeHZ5ZUxsZzZhcG1hR2VuL3Y2YnNMdEQ4ODQzRXJCcjNMTDA3bjJh?=
 =?utf-8?B?MVBZMkxoYWdBVmxsWWZXUSs1SGVWQzdwWjFXZ1dBbWx5SkRhLzB1Zk5mTmlN?=
 =?utf-8?B?YTNTOFRLRGxoVWZ4aWxlM1o1YytscHgxTzlFSEpkZG00YzdwYjhSUndWd2NM?=
 =?utf-8?B?SDFpMWdHV1psYU5pNjdsZ2pyQU5GQzFSZmx5Q2RheWYyalIrL1hYWVQvK3VC?=
 =?utf-8?B?UEJld2ppblZ5cnhnUWZJUmpGRlNWYVJPVGhoSU9GWU5LSU1zMEl1aEVsQmFa?=
 =?utf-8?B?RkUvdWlxSjlPOUhQOFpQZGF2cEZKRWtBek9qS3Y0V0Y5Ti9Fd3lrVy9lWWxQ?=
 =?utf-8?B?V0VUZVZaclRLR2FwMDUwMVFucC83WTA3OW05MS9CVkE5TkFaNnIzblNxOG1n?=
 =?utf-8?B?bHJ5eFhvUDMwb2xaNDBjQlAvRHVHYzZ5cjBDNWNzRnIyem9WcGFPSHpVaTBY?=
 =?utf-8?B?eUZmT3dqeUtacTd1ckNyWXAvUjViazAvUCs3RFVmMW91S3pScXRQZlRiQTJP?=
 =?utf-8?B?UithdnFXMzRhdTN1Q1RYdm5pY3lOOG01OGJpWTBRbDZPU2UrZTNGZUdFaE1S?=
 =?utf-8?B?bGVLZ1JkdlVJWno5cFZHdFIxMU1DNGhiVGtyNFRsK241RnFmL0VmUkw4dlV6?=
 =?utf-8?B?S2xQRG9WYmI2YlBqLzE1aWN5VjVRbUpMSnJJbzg0ZDY0TkZZRVhGSXB3d0JR?=
 =?utf-8?B?Ymc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Cu3fdfcQ1Sqn9hwHH+Nx96s45M/EadyXLgaRZLTe994qLvfZtRZLUF7XAXXikx+S8DJqRqxfOFbPx6wKEonXFuHkjUM1rCCdV2oYt55WCtiHHTcbSnU0pHhTqIAEof8gBoD6tr5Lm1ppe6Ps2dkq1UIBE2HYs4TeBWkacdbnrc3nf8y3qFf3AHbIxJAL47bTIfr2YfyYhWwy4mxR7miLJ3iZzFPVzmwu8VZVSJkaWuK4n/DWPvwfAvEzUvvr1RjpCJ9K2Hx9JHn7Okg00cD96nWDsJly3DsoOiW8eqebugbrLhTymODDU6plf2U48jIEbi08XhbiUELnIL0c44fIGxzPrydGJbuxYCvgfdGWmsbMzA/cCi/LmkdWQRmPl3Lf+oZeVVVLLD18tbsRHhS9nupt/CVpdtiLltLKVCvHq1wibkQViZ8IERHqwfHG2oZipyovEoxA9iOnwk0DiwnF38Ia4+bvx3g+7uHxIpRbYZ43wTGuq9hIhsKcJEltNyjCRtxHcxz/QlqG22o9bFdOxpRtQzbsFeaEKt3aPUp9DnIV9U74rMVc2DZrBEN2f9h2U2064hgyUIsxPYWQmVWb2ah+dNquyhCLONNcoJW890I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3457b7db-76a9-468d-3a29-08dcf835bc1d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:21:25.3702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5cw7e4Si+gd3Y5arCEhGeb4kJ5v+NS05MYVP9NZkUYfvQQ+FJQhqcHDIY8o1d6Hjqm1XqrpICxolMtuCDsQgAvmqPKulpSA+n+FQXogxnn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8192
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_11,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290125
X-Proofpoint-ORIG-GUID: vL3o7m17kZzMniZopvz7loDpqT2KMbfW
X-Proofpoint-GUID: vL3o7m17kZzMniZopvz7loDpqT2KMbfW

On Tue, Oct 29, 2024 at 09:08:22AM -0700, Yang Shi wrote:
> On Tue, Oct 29, 2024 at 8:52 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Tue, Oct 29, 2024 at 08:43:04AM -0700, Yang Shi wrote:
> >
> > >
> > > Sorry for chiming in late. This looks problematic IIUC. The patch 5/5
> > > moved arch_validate_flags() before call_mmap() as the commit log said.
> > > But shmem_file() does this check:
> > > mapping->a_ops == &shmem_aops
> > >
> > > But mapping->a_ops is not initialized until shmem_mmap(), which is
> > > called by call_mmap().
> > >
> > > So shmem_file() should always return false here. Did I miss something?
> >
> > Well firstly this is tested and works so you did miss something :)
> >
> > Bu shmem_mmap() is not setting mapping->a_ops, it's setting vma->vm_ops.
> >
> > __shmem_get_inode() and shmem_symlink() set mapping->a_ops.
>
> My bad, stared at "_ops", but missed "vm" prefix. And shmem_mmap()
> can't touch a_ops. Sorry for the disruption.

No worries, the various ops are quite confusing and precisely where what
happens, I had to double check this myself... :)

