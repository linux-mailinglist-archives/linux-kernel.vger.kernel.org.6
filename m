Return-Path: <linux-kernel+bounces-418611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E217D9D6372
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D2E1612BE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F82618452E;
	Fri, 22 Nov 2024 17:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QfYWmwfM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VBCL6qXT"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECBF2FC23;
	Fri, 22 Nov 2024 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297353; cv=fail; b=HScwAqR459It7/IE7ROQ2txKM99FxWgZbM5GmXEa3BptrgnyN8raPbs9IeBAFkOvPb8cy0vqFo1a4dl9x/+oL3auMbtrAOCqPfs3aw31eYOuWBhMepCT7VdZcypcZnKRAn6EuLfGPGx144mHh3RSmHn57LJL1ZVyiqih3xPRvXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297353; c=relaxed/simple;
	bh=FthxiFUKvMTMJvob7wdXaWDiot0jzhv9OH1DNBz+OkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OddB4EN4o+SDHiP1oPorqzFpYDZlgg9dcRQ8H5vmZfupiTV3UlnITzZmwPmXBC9wsNR8r6f5KJfgTTpcK64QKZxWBFg9IPvG3oIbaLjUu7MnOxeok6bseEMLI6tFUBt+/EOboyBgKRh/As0WtFXphppFW8W80786QEZcjxzSM8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QfYWmwfM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VBCL6qXT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMGBX9k009390;
	Fri, 22 Nov 2024 17:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=bW6XmS69AluhRzqupS
	9HpDf+VxD5kiHKFE+lDkKLobo=; b=QfYWmwfMdTuonfhaYboSnwgtvxIDjUaLVP
	m7vWlSMeSM5FP2jtcF4QFiHCO2FTn5uNbFBeI072ejjXElOLjECCAZ9KNKotkf7y
	viPNoOo7hcWjt7hEDiuP4b9cBhbFXhiLQUs7Xvr5p7dHGZ7puwOZ0ms9aL9X33kw
	h7xs0yBmjnDPuU2KGEO6zCjjv49U7K3rf+pc9vfBuApmHIChxS4lMiCbnBk5krUR
	RTm71kB01x5QJ2ihYyHIlHMO34toByx44klbEEcTk5O2uWj5v956/Bgz9/VHWKo9
	9xk85N3T5S2gLoQ4vcR8Bx7OxAOzu6JZcwQg4PzaViZCFm2zqe8Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtcckad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 17:42:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMH1Whd037426;
	Fri, 22 Nov 2024 17:42:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhudn26u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 17:42:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voFRoK+1U5BJn28GAcbyLGwG28DCDarwC3Bcj6bFv9XNfSI4DrWjSONe8Rn0bbPBu0NZ1szZppquNbTNjAKZiZHzYqflgLLSIsK80fzGB9XauTvVdI3uDZ7KunSOkZ2D15QDSHB4PZjjVhNIZ7ZR9jltk+vMKsqXZrr8ulOE7fKRoc7xoEgvTKKps6MhpjoY09LOvQBYb3FWB2FxlNgMzswxQJIjYEBbM/Ym795hMRC4QUKFGQEZHOz2vlkNoDLkj9XD5eimxQweUbf/CY/OC98TuFi+p0N4rh3YklPcro8mIJ1i7rqx/s/NLDtgIEdSJLm/AYLUPwuktRXc3P0Q/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bW6XmS69AluhRzqupS9HpDf+VxD5kiHKFE+lDkKLobo=;
 b=WhRT563rC1HUmqIFUUlAuqGt/sb0+awVpw4MJr6/rAS+pZln/ED6jQ2aTqZAK6fUhd+OCkk5UpaEQ3IhYVb5bDWgy0A9LC+A7a92e/6PkKZBKS2xu4ulFKVS5xWi4BQZFqtXw0rUpWs0PprQZwm2gRHqYECxfyHXDbG5PHY8SKH9V8LGyNnLPQWAnsuFKMZkQPX5qTi43y1n7mE2TYR7P5J9yRmUG5HBchPs+Sh5W2DfX1rcUQqO/bKlxtzt7xd2bH05ZtXSskuvdgxs71b/bXIsCiEK1VsA30mW7LIxg4pReCenHJuQ3K3IEe4D4QfsncQ7O42NosVVW+hs25CQ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bW6XmS69AluhRzqupS9HpDf+VxD5kiHKFE+lDkKLobo=;
 b=VBCL6qXTgPIE04XrpkSUDzYVPe1k9JvtXCKrvu9vx1o87VexZ2P/hRAZehVaWlnovqEskPCsWS5zVmGoiuYQ/+ahUjVtvt74HzH3ZpOPaYLxltADEPjbfun3h2svu+NChdFdXdriQFM6IQWAdAYlJdG/CBEYrStomwPgm2nIo3U=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CYYPR10MB7676.namprd10.prod.outlook.com (2603:10b6:930:bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Fri, 22 Nov
 2024 17:42:02 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Fri, 22 Nov 2024
 17:42:02 +0000
Date: Fri, 22 Nov 2024 17:41:59 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
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
Subject: Re: [PATCH v8 1/7] mm: rust: add abstraction for struct mm_struct
Message-ID: <aeb87437-6706-46d9-8c5d-2a67cbb44f8a@lucifer.local>
References: <20241120-vma-v8-0-eb31425da66b@google.com>
 <20241120-vma-v8-1-eb31425da66b@google.com>
 <0c6f4dbb-ff09-439c-b736-35568c1450cc@lucifer.local>
 <d24e6a07-eff2-403c-ad4d-f52d55fffe2f@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d24e6a07-eff2-403c-ad4d-f52d55fffe2f@redhat.com>
X-ClientProxiedBy: LO4P123CA0385.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::12) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CYYPR10MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: f675f13d-1974-4180-7de3-08dd0b1cf8ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nSSH18JqrzVh67TxApwLp771yE2oiAeOGHyQ7T6jqNqCs5VHS8l6r5A1q5HD?=
 =?us-ascii?Q?Xgwa4mJ95TBpJIb/pJn4p1Nv2L/uqQmkfOD/cw3tho93Me5maJ7SPFbjEj11?=
 =?us-ascii?Q?1HuPAmTcKA0Lgvsw6DAJKsf4cf8obJqMaGa7zU0XUSFGUbPAlnUX1ZPsayNh?=
 =?us-ascii?Q?T2n7Ad1Ags3gW10WPjkUAtszwZXW5WEV//LH9Fz1oX8uOeip+EWh4uNmJNkP?=
 =?us-ascii?Q?00KbI+34LEamvIhtqbZ0s6tN+eZVSOvsaUXeXOcNAQX6SaQycx0hr1k3Jhuh?=
 =?us-ascii?Q?bjN8E7nhUTc6pEH/DJcMET7Xr4mSShRkUQ7z+BqLwO7Cehl2PkJ2IftqIrPu?=
 =?us-ascii?Q?fBlmOU+UDXgtwOX7fTJQuDIQI8xEKvep2Eqn8DjStSUaLAbiRZzdJfAG1aP2?=
 =?us-ascii?Q?aMLKPCehWczEAifmLRotdaNQRZEIGl5honf3EaE43CDR0gIUt1rbNEqvoTXt?=
 =?us-ascii?Q?mK8UX3L9fMTIBVBdpAg5W4CcHsXiH3NaUDQU7KZz0bORorNm+kNdLbc8TDUQ?=
 =?us-ascii?Q?5kRySQX1/0RIzZcTMjwdDsUiY+1LUdTDe3Sf6GeVMwAP2C3v0tRM/f8/8U/q?=
 =?us-ascii?Q?hR3dLliAFB69x2D6QBFcMmTAhbxg4tPKAhpG6fwCBMeV9Buwq/m3Cru7bo3J?=
 =?us-ascii?Q?uymJwW2sOwuguSu9TOpNTefm5hi2LxAikQYpfMcaJaAnt8j7EuPHRRXX1nWd?=
 =?us-ascii?Q?DGHEYY1zFZjePQolvtZG0ibMCiTndxpVZoImqLUUkmvZtKw9/inoAudjDuSZ?=
 =?us-ascii?Q?jkD+ZiPve+gbagfBuX3DlkjEsmjqW6j/jqF49382J1jlH4/xs3e6LnVOdumD?=
 =?us-ascii?Q?IG+V0D4jMP4NucS23FXlQnq4AoTHGMG3+z5KF+KzqM2fGYdOswSteV10pO9K?=
 =?us-ascii?Q?mSrn+XgXhKD49regXkoIN0dkZA/RRLc25fj8w+0q/zNgqrl0+L/qZI1GF2KZ?=
 =?us-ascii?Q?SbEdhGAcMb2aQoHnkwxACwwCTl+UUXJce18Jis4H7py6wBkbbIWkVahOP8cN?=
 =?us-ascii?Q?nsFWm7pbRurkRVMqpTCzMxvZsueWfoOaMFI6F/xxO1IfVqeOAJSoiS/jXdjj?=
 =?us-ascii?Q?5P/cgT8BZc8R9syhJutraQTVYIvK0J0gwsef8tpaGHsV630I1SMslPPqrws1?=
 =?us-ascii?Q?sM5NCNfoQ36AQx+taBjzC01y0CAaGQHqSAENTxG030VDtcUbAGityLN+kV8e?=
 =?us-ascii?Q?9eV6bhsv1iDWg4qPdY7yNB7KilhSyitDXURpYvTnk7wZIzEdDjSK4PcgrgeD?=
 =?us-ascii?Q?XqcFqW16ihzHa8BVaAhPNoFhVIRPEzPhksb2dQXoT8ScICiZsoRKjj9UFEnm?=
 =?us-ascii?Q?5Sxa+V43oqMNxCU9L4AVoxP8hGacE0CZ9tJW9s3sG23cwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gn/VPfKbHVA3ZCuwDt26GD/khorEXn77+ylNMqqqTLvZQ68G23L/HyFdX9VO?=
 =?us-ascii?Q?H8+hIE8t2laOUpnuEQVyVZ07MzTVIbMQHSdLXwB/hrhjHNhRDV52LlsdPsL/?=
 =?us-ascii?Q?hXIO0tQ7Vf8QhXdB7S1kzaWEjMV8h+2/ro8DB4vtb1rFeRavJxhGZKYsTOs2?=
 =?us-ascii?Q?vMisH97XpQoEPzJ2t/d7pknOPegogu5AHHM+PNH+IfAeZeFPS8uuyirOQnDr?=
 =?us-ascii?Q?B57j0zsXK17vxfHBaagfxAWWRSHcRBmehAz0UIKg7F6k88MzVElb0STY5Jj9?=
 =?us-ascii?Q?w/zU2fpajdAb1wyA6H/hMcl+LEBzs8w2K1OTeX1Ozwc5hJN+jwPN49XxXmgq?=
 =?us-ascii?Q?3SRsBTh3tmFASbVcM1vAXinSbQVTWSKKETHRtoSxb/5cet5ea0Z+Ve6vn9bC?=
 =?us-ascii?Q?Omb+2SGV6tifJwNRrIOdU4me5XQbuJppghzNoX+ojMB6PyQiS+7iWKvZ1jbt?=
 =?us-ascii?Q?6H4jIv71pmCVo+TEnhLXJeQGmAt6TCPTAQXSqmg0jyQ4f+zsFNT7GRSgm+gI?=
 =?us-ascii?Q?YfHFoCVCiXupejSSwvbKNzyOE0kwvjlIXi9LjE631/ram0KTT72vIt/WBH9/?=
 =?us-ascii?Q?YdQTvqO8sl0DeCCNbhXNvDNbX6yPghmLaOWgQoDPZm+qnerPBc42cSn0bTfS?=
 =?us-ascii?Q?YrnivOMAtuCrAboW/6ZsI9D7IrqPJaYbJlkWZBbdZbmQmkxw27lx7YnQ+gJR?=
 =?us-ascii?Q?49CqtxcnxFsfXNOAQhP53EZePYuRs0gcCuME6yXeLeJtBdizeTQSC2q4Snm7?=
 =?us-ascii?Q?9pZrDtIN7aCl9hQOLzqJwFBi10kqIFm/yih2AIsDEC+vlbJ1u9KnE+4aQ/8q?=
 =?us-ascii?Q?RBXwe4D660dFl60lteNd/u8lVHjmnzGLritRxSGG4kPZz+Cn9L4NxlCaE9G7?=
 =?us-ascii?Q?RSm/JG+ijAqRXPG7exbUQPO22Ud9znNkzwtsiSlnWgu9hz2xUD57R0qum9QJ?=
 =?us-ascii?Q?dG2McQRnkpHHmUtdO717d7HuRRL+JOZICcGzbU+Vd8XQ9vddA6ppupxBGVpx?=
 =?us-ascii?Q?uz7pnq009fh5Vloxr5Ukw5QY9xBSRQo5kjUsWYKSMxlBfdT6r5uvBt+07dSQ?=
 =?us-ascii?Q?bG4AgkKU1y31O8OlxUprFb1w7ns1cCRBO7RdgJGeeoHjZojKGhdzlUfdNCGG?=
 =?us-ascii?Q?RuqT3HBxxqP8T4oHzxAslTel/SNrzbxcGe/kmtdE0Cs3xD68XX6ZZowxn9MI?=
 =?us-ascii?Q?LqJadPDxk/RLh6yQ9HXgHdlwmG22WCtTsSRrklcwkJBV83YR3rX0wtvou42H?=
 =?us-ascii?Q?nzN+INEkbDWohry6/5GE2W/DBJvbsIjS4kJamProm2EGMSQ/Le1VXbRJIYVq?=
 =?us-ascii?Q?DHPW83ytiQ96UasZd3CEKGD3btEE6eX5Dt/pLWoPRII8WGyJcQhfZFw8SLF1?=
 =?us-ascii?Q?nMOJK/I8opfmQUtpvw3Gl0C34TeiEOwFbS4R+/Xu0GAFIOU9H+VDypHLXUpM?=
 =?us-ascii?Q?FaRfQGEaAyxpNIpT4FFAkyPkqlsrIcrVM3yPilYqvF9xSgqcR76U2XH8nKCU?=
 =?us-ascii?Q?xaAAuptRbArjH3UIvY2cOYbzKyojq5Unj6tXiMcN9Nwa7ZNR47XXEDwShJAN?=
 =?us-ascii?Q?CAGsdJ/3Y8y4p7oSGmJwj5mGsjYT/cPPr8N+JNdwb/V4MStsvhws6JQn1ryt?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GAujiX/3oNwfTq8GA5HfLOJ4hdLxSCu5TKu7yN0efwTFp2lryEAkwCsGHfLQzmmEtRRP0GoiGbSH+Dp9bnUIJHywE1M5yATPaqUN7NgoNcTwXblmMsgKRdaQB01BVFhFrwucXiEWoiCDhntNOXsMHgZ0aaFWVrD8geeyIe/UMpOss6xgvcH/L3giz3w8AU2uZSwlsy93ENiA578L0T3/zII2BV0aYHCUWWwZb8FYDY/7/oomGz4rG96jd3fvkbCpzxiPkp7+7dOLS7wd+LEtys4Co2u6pmYP+PKUgEb3WkEtclEDUmbRH8EgX80SS/sP/lyzdHdmxMEfY7riozS2ieI7qsSGtOksOhfknI9HPfoggmYpohjFIwG8b+Xbh1wsb0nwh6d0g/vCVrSO2W0YZjIjxVDY/khHr3udcqTUiM7JZxXwVArM/zofEkky4ttUb9uqilcScM5bJxfNFXgLkH+ihII8iRMGN4rpZwzUEuYPLbiPOdjP2A/Hh2aXSCmSB96zBb1PNAVDBR7YCniAeht4XcUbDlzIB9WObt06gRYgXuXSG4G3XoljRDg9DIeXlj/W8VFCrIO8gLuwmPx8lo6Gt4ft0HdrpURADF9Yi6c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f675f13d-1974-4180-7de3-08dd0b1cf8ee
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 17:42:02.1206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rXrJyqp+mogNcL+qFsH8PjMaCmK4AwtWUSvUYnLkPiXZ/jyl/1uYe9poHdJxeDUhSMiIPiwlUc7Tw7MnWZ1qfPZVD9RZ2kOW505U3crs4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7676
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-22_09,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=709 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411220148
X-Proofpoint-GUID: x5_ofxgPhO2SLZ5dzSwQd6O-IQTHflLV
X-Proofpoint-ORIG-GUID: x5_ofxgPhO2SLZ5dzSwQd6O-IQTHflLV

On Fri, Nov 22, 2024 at 08:42:57AM +0100, Paolo Bonzini wrote:
> On 11/20/24 19:13, Lorenzo Stoakes wrote:
> > I will obviously inevitably ask a TON of questions as a result of not being
> > a rust person so, bear with me...
>
> I'm just a lurker on the rust-for-linux mailing list but... thanks *so much*
> Lorenzo and Alice for this thread.  It's the best introduction to Rust
> idioms for kernel programmers I've ever seen.
>
> Paolo
>

Thanks :) I am merely asking questions from mm side, so all credit goes to
Alice for her patient and detailed explanations! :)

