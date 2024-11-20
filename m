Return-Path: <linux-kernel+bounces-416237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B50049D425B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471C31F228F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9461BBBC5;
	Wed, 20 Nov 2024 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DB+KnQwU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n2WIITyc"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6772B13AA35;
	Wed, 20 Nov 2024 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732129672; cv=fail; b=j8oQXihSCuaEGmA99PAW0BfvW1Y2WdMTchDGFkyyg84Vt8ASY2EC3PQ1vgRDmIBglECSLA2gdj4HAQuq8Q+WjzE++bzZ6mK5dVnYBjK6z3Bit7InILM4BpbZmGe37qLkVlNAkOgvs1sYlQnp/tHCrXEYf30K1w+A4GfnQ06sVhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732129672; c=relaxed/simple;
	bh=uecHXSNtb1Z/EZmOFNSxASW82mLlcEy6sxak8J6Esn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RUEHEkxknPxW2ElAJigg0lRYPsUqIFVxCcq81+4G1ZCUNg08LMgqxPvbg+GsKe2sB+zU9RDjZ7yjHVc6pV5eHUA0S1UC8s6h9M48LzJuAlCYNWLb4ZYlUV8Q6PnRQqK2JUTDLZvJcpwSj8BtvgxOLHFT9vlsbzvnuTpUvtVk21I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DB+KnQwU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n2WIITyc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKFtnKK001664;
	Wed, 20 Nov 2024 19:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=SMqpEWnA8+5kxQQHT3
	9eppEshRl2rcjygDh75vn+/M4=; b=DB+KnQwUVFq64jfj32VUVbIufGqYol//6h
	HysIw6lZTGZXjl/5/qdMlf0qVndlfpXFXZFFM1/d7xO4kBNOx/9fVwUzcRYnU5Qg
	x/Tk6ZKhha7FJGX+OekdYJBc4g/xkRQvwRK4+maBgOACdQfdaMG8BqRcU/7LhEso
	hQlL752gPOPbLL6SJcDHPhodRSgToZffbwVNGfor/BpwalAgHw73SBQoO1q2l2tp
	s9rAlR+U7KpZ8Vv0lqAftjWShjMaJyvirCq4hnTcBGSCSbk0tBpDdD9RPxHWj9pS
	kvblST+iIhStWNJw+4U0q8vPutDKgy0J+AKvvwhaqD+my6j1TopA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xkec070c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 19:07:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKHngg0037101;
	Wed, 20 Nov 2024 19:07:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhuakt78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 19:07:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2U5OJd2nnJ8atHuq0LYNXRndwDVhQuCNKre2r8l3KF1uIc3F1CeuFb/jr76/FAs358lBgNv+OL7LAAuR3mZYPHW2Nx9PKvg45+V09M4wCVKxFeoVgZbYIGXAtLdjyxbmOPKEfMMUKSTTyCn8S7vzSdAHYmMazeg9hCkW2ExvcuBfE/EnbY6UjcYBtYlyd68uIwF6SZMmVeTQS63FDRPIgg1WbvTl8szw1xdMnJflz07svRyXIvqW1H9PrmBp/BGWs5TfnMOwX9935ETVz10yZsY/75VBL2Y+agQnlLA5EcZuVAGiyc2Hv42ceMrXQW7zfzgR+YFUdKO3q0qcSYJ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMqpEWnA8+5kxQQHT39eppEshRl2rcjygDh75vn+/M4=;
 b=bDXEGxYC6ge/AEwvoteu58ym14nm9tO+HnMy0HdA2HZly/1Fy8+ybddeH2Rj5ymPb6UBsALQVAfjpZPL29mLFibq3d97iOdrMCsiZSD9TZCXmU2XKBxkvGOI/8Q4fogWw3mnEmTHNRXL6wx2vSbPyHs3CJdArdeIfYPmQJWI+AAhTL5+wP0yeHLdEd2rTUYIhffJuT6YnNcCJ6j4B9IR7No4PajDleHxAsXllxThxAmBm4tRW0SfLtgu+YW4zB+mbXwE3VyxdUbporlHDQpBe6th1Z5hS0KUo0BLcivKS3cls2f9gvoIt9Yx5/rtO5VSrnGalL1hAsD1UO1HwVMT5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMqpEWnA8+5kxQQHT39eppEshRl2rcjygDh75vn+/M4=;
 b=n2WIITycCUclQtpOR2v3EwtcCTIT2RFQUsUfjOKXvWpyxakJ9thozo5zPTe+ZKK5QSDQRvIu8r0HhUikeuIQQz0LeDXPh6QIWUOnHESLI11p1hngrYLW5HzAwdpM5wf8Pv+4ymmZXWRypK21FBprS457p+bXZluVEjF6JFWANps=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB4766.namprd10.prod.outlook.com (2603:10b6:a03:2ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Wed, 20 Nov
 2024 19:07:20 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 19:07:19 +0000
Date: Wed, 20 Nov 2024 19:07:16 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v8 2/7] mm: rust: add vm_area_struct methods that require
 read access
Message-ID: <c26a63a3-0f1e-467d-b24f-3963e5e4e13d@lucifer.local>
References: <20241120-vma-v8-0-eb31425da66b@google.com>
 <20241120-vma-v8-2-eb31425da66b@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120-vma-v8-2-eb31425da66b@google.com>
X-ClientProxiedBy: LO2P265CA0340.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::16) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB4766:EE_
X-MS-Office365-Filtering-Correlation-Id: 369509cd-f427-41cd-b1d8-08dd09968e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tfK7M3AGX5oxutSbm09OT8bLxh8u3/n4k48znMHBSoMi0w4qTtQxZXgCsUcj?=
 =?us-ascii?Q?eR3c1UulRsAeh+bD6aaRJCs0bew3Tw18l/tR0AJ2AB8LYtECcYsWfV12C7vY?=
 =?us-ascii?Q?onF7z1RGsun7nm6pWvL6NQqH5d0OoB5Asuqall7/4yDLR94ScH4Kw6ku3Kz7?=
 =?us-ascii?Q?GXy+kU0FU4mqB2bLDGkEgngBKhjQ25HzBeYt1uq6phZpkJSc16UsSwb9GsWq?=
 =?us-ascii?Q?CQDCxAzlv9MKYgMirrgMA47fDNcGJT23OnKEcvwVBQh4p1NFhbTz/Z7Oi3JP?=
 =?us-ascii?Q?Mt+en3MIkaTqd0VN9qreh4KaLRqVXJ9zvJQTI51crHCc843/3/q1eid3Au1O?=
 =?us-ascii?Q?9VMfkHJxRi5XKCF72lO6HN31uGaZOLHekKrPrJgbhkwMu1/J3GS00NL8t3/2?=
 =?us-ascii?Q?QEzcbDNWykR4qXqwJMvIvIllRBZFYu0NHbfN6W77Y7KhviQjDDKhVwNWJdW4?=
 =?us-ascii?Q?HiMrM8/99FgMzHuLGwUi379mEHXXyRwZGXnHSpidihMtiCt2c3YxA71d3RDO?=
 =?us-ascii?Q?jEFDfHoysy7qJ6GsPS7ppfYFbdlFc/Wj2epThZCZLESvf9YMRsCMuFM3SXLJ?=
 =?us-ascii?Q?1lhInceyHnYG6sO+8pWK24w56qkEDZlQlBcZYXDtJBmMnHhxAfWWAnpRIwBS?=
 =?us-ascii?Q?JW9HcTSuQF+VkrmtyCLGIibpy240/4CAgYE1SLcQk1qILt00fbwNbaVC5GbV?=
 =?us-ascii?Q?II5AwaLyqWIUGJOPGG1Op2iqV+eEP7Xoj3dQd/ymeLJGacD0EZocqGpuSUEg?=
 =?us-ascii?Q?tuLDKYKvpo+InuPq1pdnuYSJLK77KD1bEL6HCg8G9tabuQqWvVxSWEgowK6P?=
 =?us-ascii?Q?lilKfc1xpIFg130Wjy9pUtGISueWGup20IvlZNNffFRHfcrxEh7tgIUnoNLd?=
 =?us-ascii?Q?80i22H4Xdt1C3r2PNryrORYIlHoDEpx1OsX3r3EsbS4FWeuNMgdu7N1mR7ju?=
 =?us-ascii?Q?nLAa2lkspxj3Ornh08lMx8FsGsJ8TbSoGBJRVDzhBuwMJfA9vZZ+n9y1DTkL?=
 =?us-ascii?Q?DozN+Z2CZRcBWBeAAYbDtzvnGvRGf20s1itGYL5dC7VWbhk+k1BmA9HHTRw9?=
 =?us-ascii?Q?Rf8bC3miVOWlLSniXMWbbmu2W0trvH0PdNMvmCd+oql8xqg6akd9x6Kj1HA3?=
 =?us-ascii?Q?acEUqvHW3rXdjivfKBdk+kkwF5DsOyW4G1RGV8PNK4sVyl7NhfykbecfoDNy?=
 =?us-ascii?Q?tgt7iID/KhwfrVVGSJEmIx4wG9qgyOfG3d6lauRD5BSXPWRhl59w6apRv4Ue?=
 =?us-ascii?Q?zfjRszc30FagKOrZ+gKANG3/7Fy3+xU0RT3Dm4Kz2KMqI4EZTiPfazH+I4Qt?=
 =?us-ascii?Q?zhDyI83FUFqqViU+IdkRSmR0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QFoAdDzDfegtXCfLQJWW4xCJWrRWaZy5F5rlmM72q5+XTAdr5I/0bjqxYg8X?=
 =?us-ascii?Q?d72GSuaTiHvhYd8Azgrxtdvfr08YcuEA31TMDvEwoTg8pZmC1TjA2rd4hq9J?=
 =?us-ascii?Q?1wm3rLkw0PQKKpZIzUglrXnxbF+CxP3a9CFy/ew8faXfJjE8z2JygGeTKQ+V?=
 =?us-ascii?Q?IMTrFWKp6h5Pl7Z3/OGRHHQbKEcSLF4EtvvOaIek7PMWM7QcjInvNQusp4Md?=
 =?us-ascii?Q?pS3RD+WjjPg8h++sfma6KqWHyBfQ1kAQDEfwz86C+2gSp5ZnqCquTqmL2TZ+?=
 =?us-ascii?Q?tLCI1NwnnI4QdPB55/3kMjRjQg9PlX573F0N3PM8LcMexPgXaxqIICSyfT5k?=
 =?us-ascii?Q?LdAgt2/l9vGv2/RMMfKTYmLkZeW3BfwE8FUFGQQ46kf4YQZIlQiOYGxEpvrj?=
 =?us-ascii?Q?EvJQAiqeA7x28BMZqDuO/l1xYKyc0jz2t9l7whEfD6npK2eZMeZlqftvesQw?=
 =?us-ascii?Q?AoK/LGhwiJNXbyhVr3wHo0LWPQHBcYgM0kbjFtc4d0QIzbreHrB3gsllx0gv?=
 =?us-ascii?Q?wA6gqxrajJ9GAjonwDOgYSoa65SGEh/dmeG74bbHN1MvT13X3JXmYZcGB09W?=
 =?us-ascii?Q?r48aGsFcgWxjnyylwRaXJXzinP64hF0fxPbeJ//DmPcW1MLn6K18L5ZL87Ry?=
 =?us-ascii?Q?akfY1ZCfnT+FGhNTsDV7Gk+AH7B45o59paAbtM6zAiCv6cu1689+fYOBZwnx?=
 =?us-ascii?Q?+p24+wyAS1H4a8moDkOlvMouXeTqIl/KLNRSSKFPDMf9jdZG3da53SoEKep5?=
 =?us-ascii?Q?PYPc7Onc5MUS2qRwi9wb8X+PH+hOf7pM6xKw2zbbHX/t2q9Kp+9ryJC8G+fW?=
 =?us-ascii?Q?dCQPMygNbxB/d6iLhdh7JG72Q0pJXWhhUL+h3tnIwTw/BXR01cmDdJVINtC9?=
 =?us-ascii?Q?8qjvR6tqc9J5FTKNeG5JlYmK0zODork25BGTdHs3uJUCXJjk0ZJsj3KbB7qQ?=
 =?us-ascii?Q?fhVYHUitEiqe2nY06GUetbC6FXNl5mVgBczlRk/hgietdZ5mfECxDo9L3lh4?=
 =?us-ascii?Q?4YBp3yy0Jsgd4YRHU+0EeX32T8szeV4sObyNCmd+yjY/VboTxSr2gRYrSNcv?=
 =?us-ascii?Q?wV8sfzCcIUPzSJMjCs5BdiW5twBM6onC2Hiukl1v1LmKka4FaVf2pROeaetl?=
 =?us-ascii?Q?V8N5Kfx2fS6yXxRk1ZPFA6sVEA9HpOhPVaUmJX0YfF9grf/HqnUTCq18CiKo?=
 =?us-ascii?Q?3D9t8zI/4H1lP6yhK/FDBkYqU0/fL2IL3e8Xgz1txrbyskW33a9LKp80oCkR?=
 =?us-ascii?Q?CFoWRspfbuOsylE/e8TDjjqmULw6qb5dCZLCcGqjQKc9Wfo5Ddve3s29yMiI?=
 =?us-ascii?Q?5eXDPuPdH8rc9104Rps9WPBkAewUJzpgHLB44iVZZYjr8hdl/tgVroE51jOS?=
 =?us-ascii?Q?JhpYXnmqgrC4pGNKQ33kY6LvP/ip+JmnJcTYD+6nWByALZ4UBbOiNMyHISAj?=
 =?us-ascii?Q?MmmAW4iN6MNsc+OlGijWCa0KU2kzYhym2zQNhJcsOu35jtw4VttM9fQ3BGgL?=
 =?us-ascii?Q?oPgUwxcK6jz2AUB34/A6oRC+imZ/TFKhHUtXtxp4SdsBhVrLuo6XTtxzd5aS?=
 =?us-ascii?Q?ayNf1z5nVRGxC3yNDLKOE579cRjiItiH/LW9o9VxUtPs/ioxRbszPUDme0Vr?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QLdnt3rentj5rTHpXfU5ybDDbPoODGoxCVz3WxHyvE2L9yhSm/d003SaGEkC4jwE+PPl+5NmO+MRkt94qa5XUqSqSDHdqc9aYUJ/ytY4HZ6n+Qpb8sCZO/38e2k/PH4aiQOvP7yeDoDxCcIfAu0FW31lDyqmuij0y5sAGlqPR97x4nSudJmafYotjLdxRU17iYGyk0hH+qiPJ3k9r9xQvrqJjJgbRc2qQFEc7JvGnS746SxnSKQO0j6KA86hhPs/WYNdbKkU6H1Ul7sI0Lhv8njrW3cKtUe0u7HIGH871aIwCrZ22VziDzy+SFiCmuGr4VwnWd+LI5bpnzbcaL/y9+7+rt/OQQ5KanYvZ03R9zqqEmOMaoPA/CMo6aq0fKZL+M6fodPO8dQoL79jEUacZZQi/vgUghz9gD3MKBrywimTMnx1lz0GJp60GC15T8rZrXZANL9a75+E3CIwKw2y68VSUou0uUJHHzVjyaUVa6TjBwOkdwSh0XzBnEQ6QVl0CeJT0dad9/A2DDPQv23I8Ujk0DOG6gBFSi8VZeaf5wVbKMM4TBBGHbzvDySXMEHDefMxLK/MJLgtKmjkfIg1IoE9C6jBGV8me4GQwsQEwGw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 369509cd-f427-41cd-b1d8-08dd09968e2c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 19:07:19.2996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BknDld57IuehVjoX0m20+U84dha0Rn6TfTw1vYljaUwa9Oig4HAzeD6hZ/UGUdNyXvemW9Qn/vLjOlEjy7EYq3gMlkR4HikX1/V8Z6zsJtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4766
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-20_16,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411200132
X-Proofpoint-GUID: a1_yvFyFKyaxJrVf5Swsx7so4f6c3NZV
X-Proofpoint-ORIG-GUID: a1_yvFyFKyaxJrVf5Swsx7so4f6c3NZV

On Wed, Nov 20, 2024 at 02:49:56PM +0000, Alice Ryhl wrote:
> This adds a type called VmAreaRef which is used when referencing a vma
> that you have read access to. Here, read access means that you hold
> either the mmap read lock or the vma read lock (or stronger).

This is pure nit and not important but...

I know we screwed up naming in mm, with the god awful vm_area_struct (we
abbreviate, for 2 letters, get bored, stop abbreviating, but throw in a
struct for a laugh) or 'VMA', but I wonder if this would be better as
VmaRef? Then again that's kinda terrible too.

Sorry about that. I mean this isn't hugely important + ultimately _our
fault_.

VirtualMemoryAreaRef is worse... VirtMemAreaRef? OK. Maybe VMAreaRef is the
least bad...

>
> Additionally, a vma_lookup method is added to the mmap read guard, which
> enables you to obtain a &VmAreaRef in safe Rust code.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/helpers/mm.c      |   6 ++
>  rust/kernel/mm.rs      |  21 ++++++
>  rust/kernel/mm/virt.rs | 171 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 198 insertions(+)
>
> diff --git a/rust/helpers/mm.c b/rust/helpers/mm.c
> index 7201747a5d31..7b72eb065a3e 100644
> --- a/rust/helpers/mm.c
> +++ b/rust/helpers/mm.c
> @@ -37,3 +37,9 @@ void rust_helper_mmap_read_unlock(struct mm_struct *mm)
>  {
>  	mmap_read_unlock(mm);
>  }
> +
> +struct vm_area_struct *rust_helper_vma_lookup(struct mm_struct *mm,
> +					      unsigned long addr)
> +{
> +	return vma_lookup(mm, addr);
> +}

I wonder whether we want to abstract some of the VMA iterator stuff,
because it's inefficient to look up VMAs by doing this each time if you are
looking at, for instance, adjacent VMAs.

But perhaps reasonable to defer doing that to later work?

> diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> index 84cba581edaa..ace8e7d57afe 100644
> --- a/rust/kernel/mm.rs
> +++ b/rust/kernel/mm.rs
> @@ -12,6 +12,8 @@
>  };
>  use core::{ops::Deref, ptr::NonNull};
>
> +pub mod virt;
> +
>  /// A wrapper for the kernel's `struct mm_struct`.
>  ///
>  /// Since `mm_users` may be zero, the associated address space may not exist anymore. You can use
> @@ -210,6 +212,25 @@ pub struct MmapReadGuard<'a> {
>      _nts: NotThreadSafe,
>  }
>
> +impl<'a> MmapReadGuard<'a> {
> +    /// Look up a vma at the given address.
> +    #[inline]
> +    pub fn vma_lookup(&self, vma_addr: usize) -> Option<&virt::VmAreaRef> {

Kind of lovely to have functions under the read guard and then knowing that
hey - we must hold the read lock to be able to do this.

Imagine, a programming language with actual types... :P

> +        // SAFETY: We hold a reference to the mm, so the pointer must be valid. Any value is okay
> +        // for `vma_addr`.
> +        let vma = unsafe { bindings::vma_lookup(self.mm.as_raw(), vma_addr as _) };

Why do we say 'as _' here?

> +
> +        if vma.is_null() {
> +            None
> +        } else {
> +            // SAFETY: We just checked that a vma was found, so the pointer is valid. Furthermore,
> +            // the returned area will borrow from this read lock guard, so it can only be used
> +            // while the mmap read lock is still held.

Lovely!

> +            unsafe { Some(virt::VmAreaRef::from_raw(vma)) }
> +        }
> +    }
> +}
> +
>  impl Drop for MmapReadGuard<'_> {
>      #[inline]
>      fn drop(&mut self) {
> diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> new file mode 100644
> index 000000000000..1e755dca46dd
> --- /dev/null
> +++ b/rust/kernel/mm/virt.rs
> @@ -0,0 +1,171 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Virtual memory.

Trivial rust q again but does this result in a heading in generated docs or
something?

> +
> +use crate::{bindings, types::Opaque};
> +
> +/// A wrapper for the kernel's `struct vm_area_struct` with read access.
> +///
> +/// It represents an area of virtual memory.
> +///
> +/// # Invariants
> +///
> +/// The caller must hold the mmap read lock or the vma read lock.

Might be worth mentioning here that you have yet to abstract the vma lock?

> +#[repr(transparent)]
> +pub struct VmAreaRef {
> +    vma: Opaque<bindings::vm_area_struct>,
> +}
> +
> +// Methods you can call when holding the mmap or vma read lock (or strong). They must be usable no
> +// matter what the vma flags are.

typo: 'or strong' -> 'or stronger'.

Nitty, but perhaps say 'Methods must be usable' rather than 'they' to be
totally clear.

> +impl VmAreaRef {
> +    /// Access a virtual memory area given a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `vma` is valid for the duration of 'a, and that the mmap read lock
> +    /// (or stronger) is held for at least the duration of 'a.

Well, VMA locks make this more complicated, in that we can just hold a VMA
lock. But again, perhaps worth doing this incrementally and just talk about
mmap locks to start with.

However since we reference VMA locks elsewhere, we should reference them
here (and probably worth mentioning that they are not yet abstracted).

> +    #[inline]
> +    pub unsafe fn from_raw<'a>(vma: *const bindings::vm_area_struct) -> &'a Self {
> +        // SAFETY: The caller ensures that the invariants are satisfied for the duration of 'a.
> +        unsafe { &*vma.cast() }
> +    }
> +
> +    /// Returns a raw pointer to this area.
> +    #[inline]
> +    pub fn as_ptr(&self) -> *mut bindings::vm_area_struct {
> +        self.vma.get()
> +    }
> +
> +    /// Returns the flags associated with the virtual memory area.
> +    ///
> +    /// The possible flags are a combination of the constants in [`flags`].
> +    #[inline]
> +    pub fn flags(&self) -> vm_flags_t {
> +        // SAFETY: By the type invariants, the caller holds at least the mmap read lock, so this
> +        // access is not a data race.
> +        unsafe { (*self.as_ptr()).__bindgen_anon_2.vm_flags as _ }

Hm what's up with this __bindgen_anon_N stuff?

> +    }
> +
> +    /// Returns the start address of the virtual memory area.
> +    #[inline]
> +    pub fn start(&self) -> usize {

Is usize guranteed to be equivalent to unsigned long?

> +        // SAFETY: By the type invariants, the caller holds at least the mmap read lock, so this
> +        // access is not a data race.
> +        unsafe { (*self.as_ptr()).__bindgen_anon_1.__bindgen_anon_1.vm_start as _ }
> +    }
> +
> +    /// Returns the end address of the virtual memory area.

Worth mentioning that it's an _exclusive_ end.

> +    #[inline]
> +    pub fn end(&self) -> usize {
> +        // SAFETY: By the type invariants, the caller holds at least the mmap read lock, so this
> +        // access is not a data race.
> +        unsafe { (*self.as_ptr()).__bindgen_anon_1.__bindgen_anon_1.vm_end as _ }
> +    }
> +
> +    /// Unmap pages in the given page range.

This needs some more description, as 'unmapping' pages is unfortunately an
overloaded term in the kernel and this very much might confuse people as
opposed to e.g. munmap()'ing a range.

I'd say something like 'clear page table mappings for the range at the leaf
level, leaving all other page tables intact, freeing any memory referenced
by the VMA in this range (anonymous memory is completely freed, file-backed
memory has its reference count on page cache folio's dropped, any dirty
data will still be written back to disk as usual)'.

> +    #[inline]
> +    pub fn zap_page_range_single(&self, address: usize, size: usize) {
> +        // SAFETY: By the type invariants, the caller has read access to this VMA, which is
> +        // sufficient for this method call. This method has no requirements on the vma flags. Any
> +        // value of `address` and `size` is allowed.
> +        unsafe {
> +            bindings::zap_page_range_single(

Hm weirdly I see this in rust/bindings/bindings_generated.rs but not in
rust/helpers/mm.c is this intended?

Is this meant to be generated _from_ somewhere? Is something missing for
that?

> +                self.as_ptr(),
> +                address as _,
> +                size as _,
> +                core::ptr::null_mut(),
> +            )
> +        };
> +    }
> +}
> +
> +/// The integer type used for vma flags.
> +#[doc(inline)]
> +pub use bindings::vm_flags_t;

Where do you declare this type?

> +
> +/// All possible flags for [`VmAreaRef`].

Well you've not specified all as they're some speciailist ones and ones
that depend on config flags, so maybe worth just saying 'core' flags?

> +pub mod flags {

Pure rust noobie question (again...) but what is a 'mod'?

> +    use super::vm_flags_t;
> +    use crate::bindings;
> +
> +    /// No flags are set.
> +    pub const NONE: vm_flags_t = bindings::VM_NONE as _;

This is strictly not a flag, as is the 0 value (and is used 'cleverly' in
kernel code when we have flags that are defined under some circumstances
but not others, where we can then assign these values to VM_NONE if not
available, ensuring all |= ... operations are no-ops and all &
... expressions evaluate to false) but I guess it doesn't matter all too
much right?

> +
> +    /// Mapping allows reads.
> +    pub const READ: vm_flags_t = bindings::VM_READ as _;
> +
> +    /// Mapping allows writes.
> +    pub const WRITE: vm_flags_t = bindings::VM_WRITE as _;
> +
> +    /// Mapping allows execution.
> +    pub const EXEC: vm_flags_t = bindings::VM_EXEC as _;
> +
> +    /// Mapping is shared.
> +    pub const SHARED: vm_flags_t = bindings::VM_SHARED as _;
> +
> +    /// Mapping may be updated to allow reads.
> +    pub const MAYREAD: vm_flags_t = bindings::VM_MAYREAD as _;
> +
> +    /// Mapping may be updated to allow writes.
> +    pub const MAYWRITE: vm_flags_t = bindings::VM_MAYWRITE as _;
> +
> +    /// Mapping may be updated to allow execution.
> +    pub const MAYEXEC: vm_flags_t = bindings::VM_MAYEXEC as _;
> +
> +    /// Mapping may be updated to be shared.
> +    pub const MAYSHARE: vm_flags_t = bindings::VM_MAYSHARE as _;
> +
> +    /// Page-ranges managed without `struct page`, just pure PFN.
> +    pub const PFNMAP: vm_flags_t = bindings::VM_PFNMAP as _;
> +
> +    /// Memory mapped I/O or similar.
> +    pub const IO: vm_flags_t = bindings::VM_IO as _;
> +
> +    /// Do not copy this vma on fork.
> +    pub const DONTCOPY: vm_flags_t = bindings::VM_DONTCOPY as _;
> +
> +    /// Cannot expand with mremap().
> +    pub const DONTEXPAND: vm_flags_t = bindings::VM_DONTEXPAND as _;
> +
> +    /// Lock the pages covered when they are faulted in.
> +    pub const LOCKONFAULT: vm_flags_t = bindings::VM_LOCKONFAULT as _;
> +
> +    /// Is a VM accounted object.
> +    pub const ACCOUNT: vm_flags_t = bindings::VM_ACCOUNT as _;
> +
> +    /// should the VM suppress accounting.
> +    pub const NORESERVE: vm_flags_t = bindings::VM_NORESERVE as _;
> +
> +    /// Huge TLB Page VM.
> +    pub const HUGETLB: vm_flags_t = bindings::VM_HUGETLB as _;
> +
> +    /// Synchronous page faults.

Might be worth mentioning that this is DAX-specific only.

> +    pub const SYNC: vm_flags_t = bindings::VM_SYNC as _;
> +
> +    /// Architecture-specific flag.
> +    pub const ARCH_1: vm_flags_t = bindings::VM_ARCH_1 as _;
> +
> +    /// Wipe VMA contents in child..

Typo '..' - also probably worth saying 'wipe VMA contents in child on
fork'.

> +    pub const WIPEONFORK: vm_flags_t = bindings::VM_WIPEONFORK as _;
> +
> +    /// Do not include in the core dump.
> +    pub const DONTDUMP: vm_flags_t = bindings::VM_DONTDUMP as _;
> +
> +    /// Not soft dirty clean area.
> +    pub const SOFTDIRTY: vm_flags_t = bindings::VM_SOFTDIRTY as _;
> +
> +    /// Can contain `struct page` and pure PFN pages.
> +    pub const MIXEDMAP: vm_flags_t = bindings::VM_MIXEDMAP as _;
> +
> +    /// MADV_HUGEPAGE marked this vma.
> +    pub const HUGEPAGE: vm_flags_t = bindings::VM_HUGEPAGE as _;
> +
> +    /// MADV_NOHUGEPAGE marked this vma.
> +    pub const NOHUGEPAGE: vm_flags_t = bindings::VM_NOHUGEPAGE as _;
> +
> +    /// KSM may merge identical pages.
> +    pub const MERGEABLE: vm_flags_t = bindings::VM_MERGEABLE as _;
> +}
>

I'd say these comments are a bit sparse and need more detail, but they are
literally comments from include/linux/mm.h and therefore,  again, our fault
so this is fine :)

> --
> 2.47.0.371.ga323438b13-goog
>

