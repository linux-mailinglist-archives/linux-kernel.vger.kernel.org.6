Return-Path: <linux-kernel+bounces-433006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 770F19E52DA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E0D11641B3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7488B1DB362;
	Thu,  5 Dec 2024 10:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lpvbNInr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DWpUB25q"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F511D5CDE;
	Thu,  5 Dec 2024 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395575; cv=fail; b=pGjzJtmmgm1TdocnArFHtgqMgfMuY1Sax8akbHasz2rfGMIljjze3QSinNDGgFPFRamsynMExY2Lv0UucjJ9CLgq6KFFxz+fKSXfKUP5b0j8Ys/SssYEpmYjvxdkK3pI4GubnXVDoIWodlXBI/kAJnheeufq74Cy9tj/49bI+gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395575; c=relaxed/simple;
	bh=niGElkeGG7remf4KNNtO5ER6+Yes7fGaXkQYoxLOOaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ipwfiNsxNOaA2UyehvMqZCXOE7AIoW6mgvVqXDGDfMN/WLaKXU4s5zKRJzi6m1HhYgeCvswsWoylcrN9WMBJ1ZglCC0ifREB1jwdmvzAp8Xhf4qSImEef/sKz8GFlLRVau74OqN7mgwxB9H6pqzkPlpMPaf3I2NOnJjl6RlPRPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lpvbNInr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DWpUB25q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B57Mm2j008503;
	Thu, 5 Dec 2024 10:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=niGElkeGG7remf4KNNtO5ER6+Yes7fGaXkQYoxLOOaY=; b=
	lpvbNInrqlVHUUGT2qDg5ZoU1njKKVn+wYVRXjyWiv1m+xVyHGo2wZURShIUIE5X
	Y+07izv5SzyA7Y/wryZT72HwGWOflpTZkLDw0Xh1mv5mWHDBRqUy0+QReZln/40g
	AMYxKNypInFoHGbt+MHj0gpb74uoHTfLtz5cjHJ5iai6c7YZ87wmT7KqQ9YUy1j0
	eht8KYw9rBMAm7Y/AOY26TwPDFk+PLIffZHolmOz9PAo6qIjEXgHeKzrwD81I6gr
	a59qPTm8gZchf7FzjIPgSI5mau9BocvNMKms8ptfiJPcSgBFUz7qyadCs+5+lMKT
	7dbOyK193agCOUsvKB9BmQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s4caj8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 10:45:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5AL37r036790;
	Thu, 5 Dec 2024 10:45:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s5b788k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 10:45:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxrTudM24ZuwyqqrO6G1tO1imUubP3FvgbTpe4KQ0YGwEaxq1yHH3SKOHDg0GxA/Sv7iYfrxwxAbO6u55r4zwKwb70HxygsJ/nnoBuBFpp5AS36gRjV7Tzk0Lxyr5Mf9K+5UrS0jN1FrIh+iqGPB5Kw2Ep6sxtrdq6XuIOhmyvdLqZ0qIaSYrjj9ju0ugtETviTjuyd4vSZ70nUs3yANkmO2BL5p0FDyxIJCv6bHoOoMjL/Ozyo+umyH8KJa86t5vZLMAQZM1BBkofxPXfLhm2kHvP11AwFAS4bpPSNfkhGJ3KcnbbYR7Poj2j5oC1sMWWtOEpEM3ANhBENjgAw1Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niGElkeGG7remf4KNNtO5ER6+Yes7fGaXkQYoxLOOaY=;
 b=kWG1UT5Vp1psAkr/1DreOquI732BAFoIvNlVPG3Blj206aDJL5GFQVOA9zOr280xxzf3ZdOVjfEdghgAWwHXCke7RbgYLB8piqiQRwpuuf/90pmhGgxmBoqrlVtvUTPchw/jNrMypmMU8pJy+ufdjWr57kTQRt114BSCx0r79HuFQyJJ9FaynUNz0V4yuibU76x4gt6iAolMIeMQUpRJzWCF+XCm9Z/S6jOiUnq2YmZST4cxlQlC75vAW0C8BJ3k+dmNGBls5pZ7oybtVKHB2LKFBKOmDn2VpyY1YQu+XTBnpdqAM/a15/3vTtLgC1OEtxODdVZWTJOI4OACCg1G/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niGElkeGG7remf4KNNtO5ER6+Yes7fGaXkQYoxLOOaY=;
 b=DWpUB25qDksCtwq0WlT5AvVlQE5WYlrRQz6NLLUz35W0zlPP6C2Uy7QtSw/I5nHEf6QKtY6/m4cGhnLoiiDqxFVTGZwH2uZkdGg91zFI+bQQgROcO/HIwhK8VNX9dVjqLXswh6XtXPW/VO3PBvd52rYRs+PuE8D6y5rT+e36PDE=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB5745.namprd10.prod.outlook.com (2603:10b6:510:125::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 10:45:30 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 10:45:30 +0000
Date: Thu, 5 Dec 2024 10:45:27 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        Jann Horn <jannh@google.com>, Suren Baghdasaryan <surenb@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v10 2/8] mm: rust: add vm_area_struct methods that
 require read access
Message-ID: <ab86d283-7393-4b11-b08b-ced744de7f82@lucifer.local>
References: <20241129-vma-v10-0-4dfff05ba927@google.com>
 <20241129-vma-v10-2-4dfff05ba927@google.com>
 <CAH5fLgjxmpcLJwj5k85O39R00+vRRixA6i3xeK1STe_LQLHkTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjxmpcLJwj5k85O39R00+vRRixA6i3xeK1STe_LQLHkTA@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0425.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::16) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d74e13-8735-4c68-7403-08dd1519f007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXVhVCttK0Nmb1N1V0xNV1kvaVAza2xNVWZUU3ErYmRXWkpNVE9Yc0lqWEJX?=
 =?utf-8?B?ZnF6a2FGcXF1MTlua2pxYkRGTXVrdUUzd09FWk9KZ1VDSTVvbWdRcGxjZWJ2?=
 =?utf-8?B?ZUFtZGh0V0VVYW9pckNRdnpCNXA2NWk0WkRjQ2pYQjVqTEd6dDFKa3NtcXpo?=
 =?utf-8?B?ZG9hYTVvL3RDTittcWV4RWtRQXpRSVE4R2JROUM1Ukdrbnp1KzgyTWpBTnVM?=
 =?utf-8?B?Um1DbVRlZXhoWVQrSEZMeURFajg2S2czMFpLWFdCTzhDZmhTYUdhWVVFVkw2?=
 =?utf-8?B?LzJCS3lvVEd0ckhvYmVLZU5rOExIdW5MbFl5ajZTeUE0MnlZU2JmV2hTY3E2?=
 =?utf-8?B?N0dPQXRtOUxQRjEzWVZkQk9KaStXeTdUVXRHM0NUb0d3NEpaYWw5WEI3d3Rx?=
 =?utf-8?B?WlduMXV5dmNaenRZK1l1OWZRSFZWZ0ZYKzJieVR5L05HYldISGwzdmx1c3kv?=
 =?utf-8?B?WlF4UkpjeFg3Q20rdkJJRkt4RTZLTnpjUkJNOHZ5R2F1L2YwNThMcFp2d0c3?=
 =?utf-8?B?Tm5wL2tMblJqYS8yeHVOUzFpajBKblJXTTZ6U3l6d21rZ05pR0FYaXdSaFVU?=
 =?utf-8?B?OU9TR2JCS01IRWlhbTBNeVgrVDdYSmJYL1QvWDBSbnpxemhvWURKZ2xpeHND?=
 =?utf-8?B?QjdGSkZSK1BVRUJuR3g5LzBBZmY3YW9vemdLdEdtb2FDUEVOejhWYnd2YnNR?=
 =?utf-8?B?azFSSmY2VWhaS0ZaOFJnbnNtbkNBOFNFMDVDM0FWR2E5dTJaaWE0SlZUR0Vu?=
 =?utf-8?B?Rjk0UnhEQm40dHF3VFd4NCsyM3c0WWs4OGpRWHBWR2JFWmtCS0I4WE5PNmVu?=
 =?utf-8?B?czEwZ29NRm9zOUM4dGdERHNuZUZMVVBCQWYyZjBkREgySGV4QUltUW42ajJ1?=
 =?utf-8?B?Vlhra01qM1c0TDF3U1Bpd3lkQ0FLbm14QTc2NlkrRUVMUXErTFIwQ2FvdCtL?=
 =?utf-8?B?cWwyMHN1TStJeFdmT0JmYkFHb25SaEdxYWpZSE40Q0dybklvcnU4TWxsRktY?=
 =?utf-8?B?a0kzYnd1bXlmem9EWGVSaXhzTHlNVVNDWW8vVFZsS1kxcmZSZGtqbzdYOVZW?=
 =?utf-8?B?cjhsQjhOeWRVcjQ5VXNpbWJkUlhpVkFRMVRaS292TmZXSXBaU1k3TjdUVnpp?=
 =?utf-8?B?WmZNQ1JDb21RcFM1S2ZTNkR0NzRSOGxCQ0JUMUZnOTJHem9jbVkwaHJ1VmFO?=
 =?utf-8?B?cU9wU0JSbXBtSVprRDBNSEppdzNLVmt5dWdnMVJwWDltdW90TFByTUZBakEx?=
 =?utf-8?B?S3RoZ0VvdHlCTGNXS09VTWFlNG9saUxmazVXUFRqOXZSN0hRTThNekR1VTkw?=
 =?utf-8?B?SnZWRWNmNDBMcHZaQzNUeW9pZUdmdHdCQ0N0Q2FseG5qV0FxV1dlRXUzQVE3?=
 =?utf-8?B?ZWFEVnY4MDBacXFId09nM0ljc09kMkt0ZnUrZXJzYXFCOG5IK0dUenhmMmxW?=
 =?utf-8?B?YnNoODRuT2ZHczc2eFJGRXRuWUMrNXhCOUlicyt3a1daSDZjREhLUGhWK09O?=
 =?utf-8?B?OG5sZ0N6RUFxalNlVEtKNktuZFJaQkFiaHFCdWU1dzdzdU94WEtaUEptNEZ2?=
 =?utf-8?B?KzNWTWc2S1dlQ0N5bTgxQUN0dEhTeExDNE5HZUhuelp5UC96K1V1eDlBUHdC?=
 =?utf-8?B?eFYzSEh1MWN5RXh3azRhbC9JVTB5SFZaS0k2TG9VaTEwajdQSWtteXBZZTNT?=
 =?utf-8?B?aS9Ta3BLN0VBdHUxYUdCb3Y2TWxzN2U1Y1VlZGRpN0prVE8zQmVMS3FNK09D?=
 =?utf-8?B?UURrdjlCT2EwSCsyWjE1amdzVXJHTVplN3Y0L2tuU0ZJa3Yzd25BdFlVL3JE?=
 =?utf-8?B?UFl0cTZhM1JlcWtHaUFUdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHRDZTZOSEVWN09wZlFmbDg2aXozK3JaS3BGNUM3bjBGVmg3NVdQOWtJWTFo?=
 =?utf-8?B?TW1kVUxWZ2ZZcUVLZFliMUVIZVFuclFLUFF4VzgrTlV0VkkyUCtnMEZzQXdC?=
 =?utf-8?B?eGZ2RkVydTJGZjlIQ1VyYXcxeVRvMDd2RGxzVXZVVmRaQzFNbGpzd2tsZm54?=
 =?utf-8?B?S1hmakh3NGd6T25IME1pV1RIQnROeThGUnR4SzRtR29tc3VrM0RqWjVPUFl0?=
 =?utf-8?B?aGxTQ3R6eDJiWlJsS3BHd3hmZ0gxMzIrNWxYY2E0aFYxOUEydFJvSzhLNFVv?=
 =?utf-8?B?TThZWExwOGFnTERRRzNwRXlkUTdZZnJhRllJaENIL1R6ck11d2NzaGU5SjZP?=
 =?utf-8?B?Mm1hdENDZVJKN2pqL2ZiMndzbDQvRkxiVUlKVFZOWGF4a0pOQUhkbFJNWEQ0?=
 =?utf-8?B?R3JDTWJ3dXRrTVBQMkxhWUhSM2FmWitUT2hZUXpiMkhBc0ZoMWo3UHRscE1Q?=
 =?utf-8?B?U1Y5dTZMK1FsT1RCL0ZlajlXemFoUlBQWHhDbC9vT3JVVjQ3V0FIZzYrTURR?=
 =?utf-8?B?NHlENmRjUkx0QW5IbXdUNUlZekE4ckx5RE82OUZsSkJXRExMR0ZJN0IxVUox?=
 =?utf-8?B?RHZibVY3SUdLVDVuMnpUbTVDUU93WlowUnpkVzNpTjNkNFRJU0hzZ2EyTmFl?=
 =?utf-8?B?dytQYndiWFBKcFFVaWxBUXZjbkI0Tm15c2M1TGdSbVptSzV4Z2gvT3ZtK0t6?=
 =?utf-8?B?SUtWZlpNOTBSVldhdkJJOVAxVnc4dW9zMDZ2dXZyaFhiQTJOdWxGNFB3bVZF?=
 =?utf-8?B?V3RUbVNVNDBlcHorRzdpYUNEdmJhaTR1cUpteHJyQnlvanlzMDZXd2JWVU45?=
 =?utf-8?B?U0RjRkhZc2dLWUluOE1YekxINCtGOFZnYXFYN0ovekxUZ21sOWxTZjNJMCtp?=
 =?utf-8?B?cnRIcmZEVGwrNnZMdE5Hay9nUWs4VG8wMUlIOXpxZitDVWNha2UrR3NYTU5X?=
 =?utf-8?B?OEhERGJpVXZ3UWk3dWNMZ1BMY1Zja0ZtRHJwNkFoRENWWkdERFUwWTdHYk13?=
 =?utf-8?B?NFRuWjFJTkZtS05iaWdaZnowcmtWQ2p5Vys5MUdRVHU5WHRJTnFKVlZwdzlw?=
 =?utf-8?B?Wit4QUNhU2R4OWI2TC9Hd1hMS0ltMVBOSkhWNVZ1aWNmemlxTi9lMldaRFcw?=
 =?utf-8?B?dHRBSFNQYStocTFuSkpIb3lzRUFuQU9Bc0tZTHVsdXZ1KzlRVzVQZGVVaFZ1?=
 =?utf-8?B?OEZwMXpKcXM5Vm50cy9mcGcvOStCdUJGWExQY0kvVDVJTXNaa3FLYUpidTVS?=
 =?utf-8?B?VW01L3doZE9GeTlwclEwNHJLaTN4MHFoUU9XT2N4Zko3THEyc0YzanBDMjdT?=
 =?utf-8?B?T3Z2Zkt3NHhkNzFkb3ZHQ1NPQ01tUi8wRzZuZlEybVFvUjV6VWNseGRxZ05O?=
 =?utf-8?B?V3hUN0lkYlJET3BpdERrT3hZalA0aGRnMVdqem8rR2hxUFVveHh4TGZ2MG8w?=
 =?utf-8?B?VFc5QTlZbVRBQjRpQSs0Z29lbE9SZ1hhRU9XeGRYUHVrRmVKVjd3V1lOZURh?=
 =?utf-8?B?bGppSXNscEFyR3ZpcmYzWmN2dWpWakE4NzU0cTF6WDRXb2VtWEFxWkU0bXhY?=
 =?utf-8?B?bVZGL0tsU2xuMGFQUjBmaytnakt2VllSMW1BQWM3cGNrM21Eek8vOWVqZjhU?=
 =?utf-8?B?ZE9jeS9rZUx1aittWEdUMDJQMzRQWjdneHRDQk9MMW5UMnJxMmtrMCtHS2Rq?=
 =?utf-8?B?clMyRjRpdXpieW10SnlKWk4zSVpHQVJjSXpYMmlDK1pRdXBpdkxoaXVXRkov?=
 =?utf-8?B?eE9EUG85NDdBSXVsR1FPYlJaTE02OGd3TEdacURkUlZGUzVjYXBYVDBFR0Mw?=
 =?utf-8?B?WVByZkhrTUdSL3Z0a1lwelM1cVNRd0RSTEpxWTRNNDVKTWtLa2hrK1RvRnJO?=
 =?utf-8?B?U1FoSWU4MWJTS0p3emF4ZjJqSEE1Vzd0eDFDTWM1OW04dFRBeGk4WG8wK1NK?=
 =?utf-8?B?dDc3c1ZTN1V3cjFNb2V0ZTFlYTFSOWpqVW9mNWx1bjU1akwvdjRFSzY3OHFS?=
 =?utf-8?B?QUlXYm96MXdUeTdxVEhQVEFNemNWNVBVQWdGY1IvWUE5OUFMbVNHL0VTSnNU?=
 =?utf-8?B?aFdXVkQ0Qm1VTkdhNXQ3Nm9uRG1vdjdtc3B6c2d5RWNvN0RBSHdLMTJqNi9n?=
 =?utf-8?B?MkZkSVZ4YnNWK1pBVWE5V3NzTFF0TlBVS2V6b1JKUFhNa05QRkpHUXBSaU16?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EQJZu7MKj3Pj/pZ046Sa4e90GD36H+udhHNsAr7y9b0wuy9d6vyWrzRXeu7XPY3tFHNRohiPRZ50dVaqfEKiZGBGHE4BB7UwsQfdjaKbQ9RJh33NAioS6VYPOVyXVrVz8BKSSV//auaFkHxcdHo+RIaPVhqIqSFCqfDZ7ngqPZYcu2xsBolIw5nJRDNH78e5JSFG/SbaJhJ9QJ2MHonPHiELkPA5YydEQUloI2ffTpRUwqIJfYWSFo5g3aOB+/0UWbImWgrnUOzViW/l62iIzUtd4b6nljCAD8UTnlLQ6HMQwJh7z/kySScCt1pbHYLr715l/2By0nuE++5SoBPEAYcYuvk4t/Orw32PjQnF7bfaLZXICJ9aHMDZH/cyyP352ePfdpEytE9CgHXCJweUMa/O5iGJI4bW3rJ1fQ0v+C6DYmhFoqY+17eFu2/EviZviIqeVTg4kxFtSfzrcFWlWXEJAPj/hNLeyXzdei0Dqmsley0jXFNFFT020s6oGTae/wkbvLapBi91GSWBPfhY4fQfg21NKXLs1Lt2uCygWFoSze/SARHMIcPB6wHQNk2GzQrj0zOCejigJm8K/10m1KoT875RnQ3FVLkS/HOXKng=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d74e13-8735-4c68-7403-08dd1519f007
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 10:45:30.3220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLYKlsCsGvIV9zHlf2DCWyueYHKWdZ85LsjKQQEHOISXu/ytvJIQn9ck9SGh33rxzvaJ1sdIwOGydt1uRIrsWmvEIcV9MYlTsjIasMosfxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_08,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=805 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412050076
X-Proofpoint-ORIG-GUID: QQFoCvB8NpGiPy0UgU5i20lxfzJ4g8A-
X-Proofpoint-GUID: QQFoCvB8NpGiPy0UgU5i20lxfzJ4g8A-

On Thu, Dec 05, 2024 at 11:40:03AM +0100, Alice Ryhl wrote:
> On Fri, Nov 29, 2024 at 5:32 PM Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > This adds a type called VmAreaRef which is used when referencing a vma
> > that you have read access to. Here, read access means that you hold
> > either the mmap read lock or the vma read lock (or stronger).
> >
> > Additionally, a vma_lookup method is added to the mmap read guard, which
> > enables you to obtain a &VmAreaRef in safe Rust code.
> >
> > This patch only provides a way to lock the mmap read lock, but a
> > follow-up patch also provides a way to just lock the vma read lock.
> >
> > Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)
> > Reviewed-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> It looks like binder needs a way to check whether a given vma is
> associated with a given mm. I guess we can do that by adding a method
> to VmAreaRef that returns a &MmWithUser.

Presumably this would be with a lock held to ensure the VMA doesn't
disappear from under us?

I guess that's implied by possessing a VmAreaRef in the first place.

I also suppoes that the mm having users is implied by you having the VMA
that implies a lock held on it :)

So that's probably fine then, as long as you can implement some sensible
means of comparison between a known 'given mm' vs. the &MmWithUser.

>
> This indicates that vma->vm_mm references an mm with non-zero mm_users
> whenever it's legal to have a reference to the vma.
>
> Alice

