Return-Path: <linux-kernel+bounces-512891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2F7A33EE5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E00197A0230
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A5C221556;
	Thu, 13 Feb 2025 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E+uAuI0a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DeKBnG3O"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09F8227EB4;
	Thu, 13 Feb 2025 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739449012; cv=fail; b=R8DhlADguB76wzqzC0vRJx3LHdZ9CFNqejFqsIWLia7FkWWhWcnHVGiDg0rt8WIJp3yRzC9T+KAzQqceBJUjWVp1IQjt7yDWHHcmkhrodms+EkcZz2DoirHcuvydFTTzTOEmj6pw1N+nJZUbBoTLchXlFywty1vhZj72pLfisS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739449012; c=relaxed/simple;
	bh=IhqiUMqlGYgBNBXT/MGt5ixJQLfylEbdyRk4Xq+lmHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZU0Dnmcmk7P1FxmmD8lsNnOvWX7pcxDCZ0F3i7IQHohZdXEIt7ohPOAomUDoIAjRnkhLe9uv7DiL7hnQyd9oETfbdAF8cWcymM7UsluPS4BoKzkeM1j/N5uy4e8q/P8oO7/SrO7hLhg8lXmTjicBcNjNoGD9Q7mufpHQDylkTPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E+uAuI0a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DeKBnG3O; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8fVpY022159;
	Thu, 13 Feb 2025 12:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=W7wlSfG+bzB3jUnt2+zzRhbAxAch3RhYWUou5dSXXAw=; b=
	E+uAuI0aInewl64fwiMRoBU3isWU5mQ9V5F2dLBlUoIRNE8aQLttYVe3ZVi0m48h
	oTU9kR+AACFKSfLrVds+8L2EB0fmGFWIgttnPRrl/EIvsUByAVUczL/RQ0oYGged
	JFMnKk1wu1OxCb+Ch9cH/1Y4M9tmgcGrBSa/vKcj5FNV3vExEOGyKotcL50EyOzi
	BrkiayomyoAWjEQ+Y5wRBQEdEuWZoDNje56sUPBKjiUqk3mqq6wPsMWbsxIKRld3
	BKfxKPiQNLNaTrFM9wf8L2MykeXaURPRU4jTwpPAgpqGn/f/Mvc0p5F3yJMq/UgI
	anuGOtPggUuRzllSm6KyGQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0sq9mbf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 12:16:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DBSdIh002378;
	Thu, 13 Feb 2025 12:16:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqj5ue5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 12:16:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C38XNs7FDZrjTvWOaW7/XpO23+GGyvgA6NP5JylsxIP9gxcFSS19OpLpHmS1zeAHvJ9HJ3wA3QYvokJfYZ+NWzDi7eEg5PqcKwPJSpTQ+Z8Z/b/I9ZclxgBfzF32Lq0cKkDrJJ/JHtY3T/Jbx9d4PjfaSXoUq88fSIB/WKt3lG07VrlReQTvTOp3LbxjGwauIJxRkGQy/xk/dcziCdn4rcuhi/aLi50Uq12IF7VXyQFpP1C8SoZTUWmZLT9M+0dMyNwJalciYba/MCs8CS4duI9165FSAQRmEEhYXJNkuf+6BraNkVwe0tmkxVaskZeGf8MHGEIjMPC3XRXon3EFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7wlSfG+bzB3jUnt2+zzRhbAxAch3RhYWUou5dSXXAw=;
 b=eTreyfoDtMsIXhndo95p2Zpgtky23cwjRjryvOFkTKrRqPqkWU513ApIth5HW/kWGrLzUofCiBxxtWhqB5S2N7/qy7VcDRrOQNq24b+HPNws6fmsWk4wrpZSr/zCZKD+P+DMO8vf0ejF2uQqAaaeLZjiUWz61mOpi4tKLDMBQu3aSSCsa2jBckwkeIEngkPuCq05qpKg/Ic+pByyiV2i5VRcYE7Lk4OO09zlJ8ZpTeDRxMByjLycxvEVQsbj1kHgb/lL992mPpvlvu0pTQGp94gZXiFFspLRMfQcqfMrZhuVqEGMbrAoQOKVnjb5EFazvJ1T/mP2m8T5t3saMxNmQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7wlSfG+bzB3jUnt2+zzRhbAxAch3RhYWUou5dSXXAw=;
 b=DeKBnG3OkedbsF+2BhvEwlQ5kAsBDRklsBLBFvaWlyjmVUFwFTlnS/sG70NT6eFVxPXp9XYOq09+5OVA6kG9LB82Z+G5w90feC3NqtLJjE/qE75g0jg4BkbaA2+K/o2hHTN+Z1t1y18M+nSKSKj9ene9G3FeQTK+DCr+Kf1xdG0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH0PR10MB4857.namprd10.prod.outlook.com (2603:10b6:610:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 12:16:11 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8398.025; Thu, 13 Feb 2025
 12:16:11 +0000
Date: Thu, 13 Feb 2025 12:16:08 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Balbir Singh <balbirs@nvidia.com>
Subject: Re: [PATCH v14 0/8] Rust support for mm_struct, vm_area_struct, and
 mmap
Message-ID: <2d132129-fdf7-404d-b1f1-8ee87b838dcf@lucifer.local>
References: <20250213-vma-v14-0-b29c47ab21f5@google.com>
 <8130a6d5-a7e5-402b-b05c-2d0703ac1ed2@lucifer.local>
 <CANiq72nBx3cRTUC9HWVR8K64Jbq3GCVMss5wuABzra3OLhRUQw@mail.gmail.com>
 <c8e78762-1429-4ab6-9398-ce52370eec08@lucifer.local>
 <CANiq72mKyvoyk_tgbMKUdzs-sJOoyEH7f1M9ipiET+XYgwCqRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mKyvoyk_tgbMKUdzs-sJOoyEH7f1M9ipiET+XYgwCqRw@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0623.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH0PR10MB4857:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f4ad42f-c700-43a1-f4a4-08dd4c283416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDU4ZFBVYURMVEFQZ3lZQjE4SGlvcHJ4MGJKTnc3QWUzYXNnTTllL0FEV01t?=
 =?utf-8?B?ZjloUk9RMWxxZkNETWtKSTBFWFhld2RGdkFnejM0VmR3NnJNZk5ESXhMcmJL?=
 =?utf-8?B?bWQ5Yk9IZXJFVFVNR0xVYjE5MXZJeUFyOURmeFlqTTMrdk9mUnBOckVqWC9w?=
 =?utf-8?B?UW8yaGkvRUxJQlRwREdjRUxKZ2h5cUVXc2luaEtuL2Z2bFZ3Yy9STlNNYmcz?=
 =?utf-8?B?SVAvRitVZUlYWnBNamRYbkIvTlNzajYxcGROK0dpeDJvTDhrNXp6ekhlbnhY?=
 =?utf-8?B?YlVhcmNtV1dEZWI3aHhJaEFzQ3h2cG82Y0x5ZWJQemM3NEdIcEJRNUpncERz?=
 =?utf-8?B?NHZaSHZZTWt3YlBtd2t3U0JCYWpxT3BmYkJlczJVL2tFRFBoRkZjcEViano0?=
 =?utf-8?B?YTUwclkyQXROWlJFelQ3V3A4N0RSQnQyMXZmTWdmNUEvY1hFWi81UFI2b2l2?=
 =?utf-8?B?d2NnQlFmb05iVnllVU1rb1VLeW56ek1zci93REhhckdoVkJreTFMSExodFc0?=
 =?utf-8?B?MEtNTmVQdXVORklNanZHSGgycmovcjJWenBQbVMxc1B1VloyYjBDRWZsejVY?=
 =?utf-8?B?ejZsVkx1d2V1S0dVU0Z3R2pIQUk0Wm5LZmlFczh1VVhtV2xjRjZobVdWOWJ0?=
 =?utf-8?B?M2RFN1QvRWhZV2VwY3Z3V0FIZWVhNVFvQStxWkhJV3lNamVtSHQyaE5XNlhQ?=
 =?utf-8?B?OUdML2gzZkpSK0pKbDlCQ2w0MUplKzhUOE4vcFg5cm8yWHpieUVGZHUvbjVt?=
 =?utf-8?B?em05N25IU3hQSFZXL3FIUnRZemNVTk1hd2dnMU1BeWFqbk5Lem1ZZC8zWEdp?=
 =?utf-8?B?RGh1RmhYT1BxT0Q4Zkc4VnJBWUFxM3pDN3hUL1k3UENHTXhnUlBKYlN2c1pR?=
 =?utf-8?B?VDhrY3FBNUx3L3JDcWdlV1laNVF0Mm0yeklDOG1iNHpXTE5EOFF1YTNKSUVl?=
 =?utf-8?B?Vk9sU0ZyN0ZBY1RMa3FqcnA2QXVxc0xUV1RSbXNoNVdrOTNRNEdEOWVRR2dB?=
 =?utf-8?B?STRKb3BsckNyR3BwVDZKOUM0ODFOc3ZkQnBPaC83M0E2MFFYZVVFYXdJSUpG?=
 =?utf-8?B?Z3B5Z2NZejdkQWU0dXFPalJ1a0tzdk9HK1RCaXE1MXJtd2ZnemlLcGFoMlJR?=
 =?utf-8?B?cW5obXV3N0N3NHdIaVV5MExzODFjcXd2QWhJTXlxeEh2M0tNQUxPc3dQeTh1?=
 =?utf-8?B?NHprMm5hUDE2NHdSRFZYSUFpbFFsL0Y3aS9jWXdUYXRvcGg5eHZLOXdUSTBq?=
 =?utf-8?B?Wis0VkYrOFpSYzA5dDJsUDJpMGxKNm9LT3EzRDRhalMzQlpGMHlUeHl3MkxP?=
 =?utf-8?B?d0twQjJMMjR6VGFBbzlhUm9CellGNTVPT205aEd2by9vRFF2UXg5LzBhbU9r?=
 =?utf-8?B?cGNLSVVtb3ZjYWZGenhUYXFSVjhJeW9NclpzVFlXRy9VN0RLMkNUb0FDY3Ez?=
 =?utf-8?B?dkZrSFZ5SmM4OHlock5Yb292Wm41TFZSYnpIMTkxRGtWNFZWWjBEYWg1Z0tw?=
 =?utf-8?B?VFVCdEorT0dKbDd2b2NuRFBFQ1dzWHI5c3IyaWZPMzN6eFpOTjBnVlN5RE5T?=
 =?utf-8?B?RHJ1cjk4WGlaSGJmSFc0VUpVVkgySGdRWnh6bXZqR2Y1UGR1TzhrVU1ETTVy?=
 =?utf-8?B?SWkyOWs4eGp0bldaQXlVQy9wYnQ5TDRvcjFsUEhQMjdiOGtvVWVGUVg5QzA5?=
 =?utf-8?B?QjR0Uk1Vd1pOaklPV2JBb0tMS0pXQ3BNd3BpYjlqMTcyT0twQklaNUw4eFlZ?=
 =?utf-8?B?elh0cHdTVmY2YnkvZGFVdHJTdEFnVXYwcHZKb00vVUthR3l2Z09hMmFibjNO?=
 =?utf-8?B?dURDMnBVdDFkV1k3SXFkZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHBYSWFVSU9iQWhIbW1yNGNjUE12U21DaXl3ajBQZlBNaU9XdE9WSTBkbE5v?=
 =?utf-8?B?TEFqa2JLaCt6clZXRlZPTzZwR1lxYjFqNTdnclJHRXMwWHpEWkdkT1g0NVdv?=
 =?utf-8?B?bWxRcnlKUVFHV3BoUXpWTSt0aThzcEVORUNlbkdBaVhEd0ZFSktOeW9va0Yx?=
 =?utf-8?B?UTd5VUxPNzVzRjJqNkhad0VrOFpOZlpvR2o3WVI0RGJWZlpUaEx5NGZHTkZT?=
 =?utf-8?B?N2JIVjJ5cWpYYTRRYzhtaWlGa3RCdlVjbUp5TEM4eTZ1MitPMk1ZSkNkUE5D?=
 =?utf-8?B?R0NtZGpNbldvTzNGaXQ1NThlRnh5cTFvdnNSOUxoSnNxVW51MCtpbUJIN0xV?=
 =?utf-8?B?eXNwenhQMFZQejF1ajlCMGdTWEhWT2x6THFvNy9mWGovU2wxUy9JWmtPMEJj?=
 =?utf-8?B?bERPdGFldHpqOFdjdG1QdmhiSURuZkxVYkNRcm8yTWp5cEhyYi9yajIvYXk3?=
 =?utf-8?B?Uityd0lKRWVIZTNQSEp5RG02YlkzRTZMeWMzcHFyTEt0R3ZuTWVPQU55OVQx?=
 =?utf-8?B?cnVDY0RTNjV1TS82dGtsRFhISnAzN0ZhY2dJR1p1MERNM2lEMlAxaDlFRzZC?=
 =?utf-8?B?K0h3SVhmR2xVRWxvSzJjbzA3Z096NGYxOVVNTVN6S1BVQlVuMGYyS3RBWFdM?=
 =?utf-8?B?ZVkrYjBOaG1xZ0dLWGt2WEF0NWpTUTFwcFhXM240TEtOcGx2WU9laHJldGdx?=
 =?utf-8?B?ZHVack9nakExbm1QTll4NVQrYW1yMjljbUUrN2dFQWwzb3RDMTNTdDdmRjRO?=
 =?utf-8?B?N3IxSHRTVHl0WXpzdVBGUjRKR0RLTVQxQ2szc2xHaWRYVzBncGI2dGk5U252?=
 =?utf-8?B?TjJITzBramZHVnpUdnBkRVl2OHdEaEs4YTYwR244WDNPNkozeW0yZW9QSWNo?=
 =?utf-8?B?S0c3UXAxWW9JSmpzRDM5UnozWnduTlg2QWhkNjZyMlVaVkFjeENJTUlrM093?=
 =?utf-8?B?SFFJQytpd2ljaGhJaFBSSTNkeGUyYXprQ2U1WVN0VzkxZmxLOHByZng3eUg2?=
 =?utf-8?B?dUM2NjZyb0MrbDMwdDRJMUJSZU1sMGNaR1FTenQwaGkrR0NZa0xHVWtnVXJK?=
 =?utf-8?B?S0pLcEUrb1A1bnZLUEFBU2dlQzNXWDlHQVNRVGVmMW4xWk0rVE9oMzBzLzR2?=
 =?utf-8?B?c0lSUUwzdlVwaFJrcDdiSmNYMFQwQUEvZXlVWndNUUdOdkM0Y0xWZlFmSkYr?=
 =?utf-8?B?V3VXK29LdGxoTWEzb3NTTC9XRHVuNmZ4VitaKzRpRm16QjVPdzFOSGFBaXlD?=
 =?utf-8?B?amsrY21QU0RJRmp6bC9tMTZtUHhWejIvWTZHbVNsUHRIRCtNMDBOL2FRR2po?=
 =?utf-8?B?WXhqRzU4N3lUU3lJbmdQUEd4amI0dHJaa3FxMWo3aG1abjRQMjhka3NicjZO?=
 =?utf-8?B?MDBDSkNZRnBIUDJ1dXMwdnBGRzdQTGhOYnhaWnFWQXg3VDNNU3ZESVV4THpq?=
 =?utf-8?B?ZG8yVm8zZVQyTlRzOWZRS1I1cCtUM0lrSmVuUEs0SU1CS0p1RFRmWm9tUXE3?=
 =?utf-8?B?MFQxTUhaVFNBRExGOGdXVzJBRVo0ZTJwaVpDejFDYklMMlFSd2NteGpad1RU?=
 =?utf-8?B?NFdnVHRQaDhCcmxUL1B5VWdQK0NFblRFVklJa1N5WnFSeTg0U3ExVXkwNWJM?=
 =?utf-8?B?UnFTUG1XY3M2aVFnRlRQc0JabWh4dFZYNU5FUzFMSjROUVNwdXBpdzczb2Z3?=
 =?utf-8?B?TkdheDBSaitKdTB4UXl2SUQ4RWlaMGJJNVh2UWxBd015c3h0V2ZOM0dscTVy?=
 =?utf-8?B?QU1WK2Jpb3B2ZVo5Z04rUVdlVmJyYnJ0L3RzOVZ3SWpSYkEwa3Z2eWd3TE10?=
 =?utf-8?B?V0R5eXJWNnkxZHZ1czBjZmNOQ1BKMUt3WEx1d2J5c0Z5ZVNhTFphazh4QVNZ?=
 =?utf-8?B?ditOZE54eENxQ2RTelk3VWxxN0FOMk5oNHRMTU0vUmI3aE5uckZPZXJTeFdR?=
 =?utf-8?B?YUJ5UHJHWlB3bHVDVkhtQTlEM2FNKzBQSktjSkR1MUVhUFJFUFEyMWlrQ2Ra?=
 =?utf-8?B?enVrWThjWmdTc1NodFBFU2N0Vnp3M0pmQThDWlJSWHUwS2FlWmY2dGZ0bk1I?=
 =?utf-8?B?QlZMYityUXAxU2NZeGs4a0NYa0Y3M1cweGw3akxOWnBkcFBJQ2NoSCtFTXhq?=
 =?utf-8?B?bmhOUGxab3Z3bUtvWThBYkJ2Vmk4bWFyb1MvRGdXTUluRWkvdlJXOWpaYXNM?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uShkLhVOqg9C1mjM9w9F7N1821wGghF9NdURO+vGi2pCPBS2nFzvSY6AM0GSqjL+SKLcqnhDUto8zRrWbJtDTJy/wH4nFIHIDODBMZDh5iMws2SDgZDyvEK/81Ty3S1HRltsUx6GP1NJxohaaw390aSTEr8ozJdfGFkQ+CmHPKkdzlNlxNSUff8AtbzF68cP5dhVw+a+KDMufoXeZWbKMVTFDZCfVlfhQPxAMO2qpqc0/+F6QAbep73YlSdH+0Eac45fnpAxF6aL61ZEHz7ZWS0sHNq/VmJkF+2dsDb0DSe8Kz971M397peeKB5EqhkmbHiYGLNKOEKN5+gr9T07k1zquuUTDyGsjXNkFG68XOMDGnH9Lf31BAkTDFmM6c+Yq6tPUwt7XfOXApMeb8zEcFApWOuKAGFhlewf9Y8oxWyrJyqLrPY65d9Qe+QuNuLoArUi1FDdH7uxNdyuCsuFy7vNiagcBvdzf0ePaSVcDh8/d0E6ppnIGoJzlXdGCD1vrTFPNxU9w1CHrM5roSBpL1UCmxe26GyqdQQkCM6nqKefUB8bv8BANra3GfP10xgAH1Cy2HIN0ow/BMG3fI95IkxQwVGgZQMkoWjo4RjCqik=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4ad42f-c700-43a1-f4a4-08dd4c283416
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 12:16:11.4084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODcf8l/hvJm3MiQwCLNWZHYTfUUkFE0fhSvHgAQPP9kmqcTsqFEkDkYHEWajz0ICsy5b/kz9FDmS+G2MftW/4/ax723tRaXM+j9R7monV3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4857
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130094
X-Proofpoint-ORIG-GUID: XXZqlNZvkjDcwM4Qpvb0fhX02wdr08B9
X-Proofpoint-GUID: XXZqlNZvkjDcwM4Qpvb0fhX02wdr08B9

On Thu, Feb 13, 2025 at 01:03:04PM +0100, Miguel Ojeda wrote:
> On Thu, Feb 13, 2025 at 12:50 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > Right, I don't mean the rust subsystem, I mean designated rust
> > maintainers. The point being that this won't add workload to Andrew, nor
> > require him nor other mm C people to understand rust.
>
> Sounds good, and apologies for being pedantic, but given the recent
> discussions, I thought I should clarify just in case others read it
> differently.
>
> In the same vein, one more quick thing (that you probably didn't mean
> in this way, but still, I think it is better I add the note, sorry): I
> don't think it is true that it will not add workload to Andrew or MM
> in general. It always adds some workload, even if the maintainers
> don't handle the patches at all, since they may still need to perform
> a small change in something Rust related due to another change they
> need to do, or perhaps at least contact the Rust sub-maintainer to do
> it for them, etc.
>
>     https://rust-for-linux.com/rust-kernel-policy#didnt-you-promise-rust-wouldnt-be-extra-work-for-maintainers
>
> Cheers,
> Miguel

Ack, for the record I'm happy to help with any work that might come up.

