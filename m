Return-Path: <linux-kernel+bounces-418632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF4E9D63A3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD4B2832F0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7B71DF755;
	Fri, 22 Nov 2024 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XYYeuirH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZjNtwYnl"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF46F1DE8B0;
	Fri, 22 Nov 2024 17:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732298130; cv=fail; b=FBc2/PBPc8TtAWjCPlBTUlqAA63IX03D30IFwIuBj6m0G/zg32kJLrfxbgf5/42xPt9t63vAML5PCohVe4hmf5GASflPPHuvD6jtiO70M3ZtwdSf9VQeVAF8716joVyQ0HxOAXv79GWV84u9udgokuqcjvgpSI/87F6gydpTTlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732298130; c=relaxed/simple;
	bh=xlKnk0b+Muo+9lf/e8ROjBZDR4hImnN4ql5ecIrkpwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YHviaTGZ+lSupJlZ1/F1VbHaRej/kE4j4ujJ7fNvcvgcgn+LWn9oe+tWRoTR6wrlCudPzEnPbdhmXOcHzkfRBQHc+5W5C6UV67uYbt1+TPEkr7Zphdh4wcGDn92K/YIZORh3u6HPLjlB/fNuaREXDtxyg/RBpdV3sG0cGPmPBvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XYYeuirH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZjNtwYnl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMGBYNP031324;
	Fri, 22 Nov 2024 17:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=6k0OWNaojRZdTt55Pb
	vmQjlXynN7OYBb0gWgTg2CWmg=; b=XYYeuirHU5IdrIH7tY9IRh5BUkjkKc6uLW
	9wJvCxUSqJKYks/jWu2WzDMuDwQRDve3S0J4X7hPqpCBfC1Q0yAIJCP+hkrClZ5N
	Y3tLaG9jXcL19ycSNUNMnH5K7+yoQh+UMk8JWMUBfI93lQ/MFn8jGOLjhG1nAbyH
	AVJ2MTmqLMLRF5FUR1Tl2RvyB6iPil+VryfudFeu1ZDcuBGxnVD3nUzvF2dagzYW
	lldJCQvfVchf4+D9OhUDavK+jmg9agQqVfY7ETtklLpnPTygt23Jpr2DPwhX7DJi
	WRTZ9vnmWsekPeB505VAfweWZZHo7sA55+o6ZKFRxZgqBwwdTswQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 430rs5g76g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 17:55:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMGRAxx037329;
	Fri, 22 Nov 2024 17:55:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhudnj7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 17:55:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDizpynzbfpN43pdzw5WUnIDqZCEdVMHmt/IU+3JRl3qvwBycZOuC2scu8+t+Jo00EGlQKLPfGXIvNx7ZOu8BNJgFO2FKBgj7o2czYOqkuYCUNKedFtNPY8zb9JEM4gC13+oRZW9ti8KNR6sqwMk7cBa0NHJceVPNBxKj7NlaMsHV1dV8s8kCt4Xbm8NJzy0j7zv3BPT9/wllgjvcVJHeFm5Uhfq/9SfTHsw7BDEsk76rFsDSJ6IqdRGUpjxQB63jxkIfIDbjqo1pSK9jhSrCxZv8E/4jMj241CnBs/SFB6U6Z+WUkdx6/JQtXP4A8OXeQQVRCVVeQRN04OrIeHeDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6k0OWNaojRZdTt55PbvmQjlXynN7OYBb0gWgTg2CWmg=;
 b=VUwGiUNWO8FNo7TDflw1hxR8JTg9uHfWUku0abwm3scyo1mYCcRZdDu6Pi6NW4ijopwOe+yLZYrzvuTQKoEBwhJC/6Wpbr74+T0AlcBbRBAUAuHxh+PmlhdjoBqGTrO3M8jrXnfiSXz9+/rZPF6ZGXdYii7TiFVcFkVSZb0Zbx1W/83A44uO0jv97hOCU/tx0BMMcPAvWEGGnSC5o6O1ED4dIPYS4lOnLmgxC77CydZ9QmYX9g6yXDALEfD8UdLt43SKUHCFXFn8y4tkNXnFHW9sdxKtM7iNLuMvhCH52uRQtv1GbV/PaqRYemtEsYxSCILCG5JvOkjKdldkTuteNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6k0OWNaojRZdTt55PbvmQjlXynN7OYBb0gWgTg2CWmg=;
 b=ZjNtwYnloqWmFK/+CkIQrE7BXG6zONDfcxcyORTdyrGbguxZCt0ZJMYxtmaNRM/6fV+EXjb+Bzx7DJehm6lGlHeKheypaxqz8eP9Nqnq6mw41mh3plrIpDTc48d6bJ1D5SufAOsBgWtgOxvo4gNtUuiDP08IkvfinUabVTqPGIg=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Fri, 22 Nov
 2024 17:54:55 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Fri, 22 Nov 2024
 17:54:55 +0000
Date: Fri, 22 Nov 2024 17:54:52 +0000
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
        Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v9 8/8] task: rust: rework how current is accessed
Message-ID: <44ef7154-0f38-46c0-b87d-e598b146f4a4@lucifer.local>
References: <20241122-vma-v9-0-7127bfcdd54e@google.com>
 <20241122-vma-v9-8-7127bfcdd54e@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122-vma-v9-8-7127bfcdd54e@google.com>
X-ClientProxiedBy: LO2P265CA0254.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::26) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB4542:EE_
X-MS-Office365-Filtering-Correlation-Id: f4e7defd-0d3e-4616-1435-08dd0b1ec5ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wSHUqFGvAP1xV/ZLo/WjvBolMukzRoKkvELeVO8fh9ASP8ErxEj+zFEBJXxe?=
 =?us-ascii?Q?GEnqQt9O4GHgLm4Tz0JoJWFpo55PytiExzarrWoDw+XXe41hoAq1bLYVdfjc?=
 =?us-ascii?Q?oGIk5DeoOAgY8ARUGCx4Qqu/z8hJXqlusvoXWkhsdFL2AkETVh7jCeASTDkJ?=
 =?us-ascii?Q?PeEZ/WjYnCk9EcjmEytCY8GgO8l5Ptd9zQq6EDjkYs9l7pm03xh8/qFXmYpl?=
 =?us-ascii?Q?FfFL5jFazlDl37F5BTgwn/HpCXadsCSNuA3Im2+XSv99JOPqGTef4cvD+LYv?=
 =?us-ascii?Q?kndYMQ9LDsd/PVBAAyWJ/jTkENjReiSHmyz2ReahGZQqcqlqzEvFweKLblsT?=
 =?us-ascii?Q?e3kDAO9J5bLW6nDe4Ta7f7acoAE2NwXC9S71mYhRjaXwdy0DIFnEFXgKmeeE?=
 =?us-ascii?Q?Vx/OrNmAsSnY+hiWNYoxJatV1DxOq/fNOlfxDLVK1nftK7BhmavtxjUy7oIF?=
 =?us-ascii?Q?LTgneCIkFYicjImdgRKWF6JUC6lPqM15zPs3muVspI0lnWFdv6zK8Qs7wqV1?=
 =?us-ascii?Q?2VhafpqQPnaTPrq2j+V6A74YocUaolioorToznBFU/TUrrvTh2boA06aYRy4?=
 =?us-ascii?Q?zkTipKqy6eHPSSOHWGSf2goHZJJzzqPTEuzQvgaY162kYyfJH2uMigAV6hmA?=
 =?us-ascii?Q?IEdfUq0KOa2Wm6TjC0uFPFHPWLRmRHM4LZauSN7GTAdGa5CIfaPmIsxWy1As?=
 =?us-ascii?Q?CbmbDq9dv0bHz/ff5YcXvS/E8zXjNDUXmBsTOW671iduzNqextaIHd49Qz8A?=
 =?us-ascii?Q?+nZFzHBFC0YmfgoPbSmf2kyW/7zKeuVBZYcn52gDZqDcyjxIdpNFgWZltYh+?=
 =?us-ascii?Q?jjnHBJkAKE9WDp+m3bq+15smczVfC4SKsnTAbsdxducg1UQ2KAtWKwrSJFs3?=
 =?us-ascii?Q?VZYWO/IoAoNgRSdJuj+7Uv2nHlKaTjaTqeiLjlIFnftIZlEk3BtJ5Prmte2H?=
 =?us-ascii?Q?OBh5IG7wUOQCJZzGO7CZaskdxHQHQ1W/7lHjp4bqnQjqRfe2qrQOo5lbZ7aD?=
 =?us-ascii?Q?zQSeItGJWFcZ8JtvPvgG1l/lSuof6H/I1/0ICxItCqM37WZ4qs9EEQm2EY5G?=
 =?us-ascii?Q?8oSGx+C/wFp/LAOW3a+vqDZyaxYS9FVKJMPfdcAdtj7t86EexgoBE3GnX0lH?=
 =?us-ascii?Q?RSc5KPCHqX4/BT8xXjH6J6o61AFuwMtyWU0XSfOCE+Dw1zWq3nQm/G+UBE6S?=
 =?us-ascii?Q?iy2sjDdvd1VdALJkZXoR1ztDvQ4NaXcbr7QotY6GaMTliztXosK+FJ1bFQ5A?=
 =?us-ascii?Q?rg87mTZgrT6BU/nKjW6D2eazKDk3pMH3II2AcswmrKc43cAdaNjsW4R5mEHu?=
 =?us-ascii?Q?nweywl+j/bO54uvVTgTWDcgH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f6w5Hx7cL3cy1RJgtWIHqecrUEA82jLd9CzJKhHpyslJ4V1La93mXS1N26KL?=
 =?us-ascii?Q?bqJNg+m8yTVI/byLAVZA9ktcEOgLuD89seROxtpZEHNJ52UikQtaj5giO1Vh?=
 =?us-ascii?Q?zFiZ1m+Kth3H0SgVFsA6FE2iKc2fo2I0JFuirum9Uk4zVL5O6EO/Q5kUehic?=
 =?us-ascii?Q?WLQmzSHkUDbI5hBv/t/lxuzYyJDkpi2nSdDXD2AzBrbTn1GMS/U+A3H0Auxm?=
 =?us-ascii?Q?Tqf/3vK8QtW/tv81V16QYMCpCLNtT+TU3n4ktCctmIcT52B7U5tgG94JZ/VE?=
 =?us-ascii?Q?sXr7o7r3YyM1eMtVdmA1/YGQDpUZR8F0MqxACeD+8r7jYTN2UkB7G9mBv8bo?=
 =?us-ascii?Q?dGcNJ4sSdNd6xp+MS0jJfiLxlif4jnVHoUjLp7Sxk0RSZvcwDUu5wa7pQESF?=
 =?us-ascii?Q?FGy2jA5FWOxe7Hr4KMMWPNHofcGXN8i8ERVeuikty9/F4+3m9gEjdhAN3gTd?=
 =?us-ascii?Q?TkFmso1t2Yi/NHb5ZP2WATQjTo52RicRahUEBxwGzO/3i8RDwtHHaQqe9FDO?=
 =?us-ascii?Q?2ygPU8QHBo1Ay7KkggOyv267UyugkUO2H5juF49xHP8O2Qnt1geVGs7L2Rmn?=
 =?us-ascii?Q?c1kDQTgIRT2Id3dkIjc0NHkP3+L/tvIYmJIyPt4MvCAof7qFOLhcn095xUbu?=
 =?us-ascii?Q?DGM/hJFcZN+qNKDzqrvDgL7Gqxi8TLI8rsrDJlNsUpc1tTxZreHudnimUVVP?=
 =?us-ascii?Q?7ZqN1DcBs3O2sMEvSFEKMbTjQndq/y6VCmy2RxobXp5jZSzvH+d+92/8K+Wu?=
 =?us-ascii?Q?/UvaHsL7WV8Bq3/BnUFgN85uEpQKzWgs+vFxEqmwwxDzp1kY3kzfSA0KitrX?=
 =?us-ascii?Q?+myoAn17p5S8eRIhVnA0pQLXawj8KHf2zXMbtubwSehTc9RjT+xpOyNFqPK6?=
 =?us-ascii?Q?HXZVEyEi4hEd4VJNwEC1tZ1ZYu/EDwFQSl9VezJGyDA9e2FZECAq/AyNawmF?=
 =?us-ascii?Q?Iw6Gjz04Xkn1TZOhEtBSD8NBvyR+QyoNgUZfqlZf464ULDxkkl0jCO3sXZNp?=
 =?us-ascii?Q?OTjBj0BpiEn615i8uhvUmk7DAFytgjB28tTJSQjzqy2ypiS1Kuw/nxnwlFFK?=
 =?us-ascii?Q?+AUcha0M2lS2FqWs0/LySmyVqRcReo4hGtuw7CNeRNHhbZ+3BK4pCeq2YULv?=
 =?us-ascii?Q?ltKdACsEyQDF+xQTWxZ4asb5aL/jdur2ro91d7uZTgLFAkS7PF5A6jH5Ah8u?=
 =?us-ascii?Q?tgBmQjY+BP+ZmpiUnG+fW46Ymda5HADPCiP7normdjs+G2iy+UmEX7YDdpDD?=
 =?us-ascii?Q?6XAykGkhCAjuJKQ5vg8hIu8P4fsjEf6t2zDqFpWwtX0S6fLf/WCqHarlrxIc?=
 =?us-ascii?Q?vlEhD/X8yoWgSs6ARGjdpW/0lSnOR2nMcgbbPOFjrPOPrsBQDbiDoKjlglot?=
 =?us-ascii?Q?8Dk2N/vFNxKe/W+Ypz72CkUPCI7XsF+9JwyB4R/ME3026Jc++ZcSZcjDT+gX?=
 =?us-ascii?Q?YxB2bGQ5aiAHMtzi6Py4Mpr5lTC01z1ySsZWuOFtC4PTl+M/biwudPiAclEr?=
 =?us-ascii?Q?3+5pv+uH4ST415TJn+7gIMAWz7uHD16IoCR4UAJfVenLlV2fTfF8eHxP2rJw?=
 =?us-ascii?Q?jRFdQSTJ0NJlK4Sts3XQxfFTsjvD0xvpiwAf8kPf/IUFtbrapNUYm2f+pHRj?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FcpUgDQftr3BATmjkCGRcuU/W1iLnFnNXANgZVwllVkRK49nu11c8WOxrGfbSkd5up5LqiUI57AQgn1W7FaXs9ndEZQ0xV5UJDtJ4dRSB8+IjaPwXlpG6g/9mGmtxisECJhHXytOtGVhnXaDo4OcgWF0DDz0wlwu2/oRt0pH54qWZmcjzywEhQyspfy8ksUOOn8z9e9R8G//NQWjj1903kV2gfHXPixz9DWwVZ6BZR/b0uOS8zoJ0+hJTQL4dipyZOOzHzcImj6BxmtqZTjRWqDMgtikypjoVl9wbfBa8y4BUSuoW8uSVlbUkNAm8meSAH96OPSDDQF/ksNpbR6i00ag+UA/c+UP6B6GG0mBaw12IFzFRLvRX81ZIweIdMGx4gHdQJQJSfmR3A6nuuq+bxLknC7foHWvNE5qgDMQXlzpDulmHRj5fQu+9usee+YRzXGaUJrpIrLsPZi/AizCHu6y6ZQyew4Ta4lFX4eiH9Sp1dEsyT4Jl/5O34Huv76zFX2QECyD4tj2x8vqeSWRtGXLI/urbXMBUZtAG4XVSk0WzBAhJw5bTY1IVZOh6bvjbZwhbyXlrOIkoIQRPHd0ADXcuowkY+y42U9T4JIxhAQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e7defd-0d3e-4616-1435-08dd0b1ec5ff
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 17:54:55.8148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXISpHQMhpgZXsTvGaBYIVE45dThxl7oJIQu2gnMI0fIprUlkmA4XISRVEeD/XocmVj9N5GJUqUmxzr0ETcS57UlIClsnyIR1BnRBL7n2I4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4542
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-22_09,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411220150
X-Proofpoint-GUID: f0vlmAWu22zGVkYUcqIQ5bkiXjL0NswP
X-Proofpoint-ORIG-GUID: f0vlmAWu22zGVkYUcqIQ5bkiXjL0NswP

On Fri, Nov 22, 2024 at 03:40:33PM +0000, Alice Ryhl wrote:
> Introduce a new type called `CurrentTask` that lets you perform various
> operations that are only safe on the `current` task. Use the new type to
> provide a way to access the current mm without incrementing its
> refcount.

Nice!

>
> With this change, you can write stuff such as
>
> 	let vma = current!().mm().lock_vma_under_rcu(addr);
>
> without incrementing any refcounts.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

On assumption that the problem you reference with the rust imports is
corrected in v10, and that what you are doing with current_raw() is
sensible, then:

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks!

> ---
> Reviewers: Does accessing task->mm on a non-current task require rcu
> protection?

Hm I am not actually sure, but it seems like you probably do, and I would say
you need the task lock right?

Looking at find_lock_task_mm() as used by the oomk for instance suggests as much.

>
> Christian: If you submit the PidNamespace abstractions this cycle, I'll
> update this to also apply to PidNamespace.
> ---
>  rust/kernel/mm.rs   | 22 ------------------
>  rust/kernel/task.rs | 64 ++++++++++++++++++++++++++++++++++++++++++-----------
>  2 files changed, 51 insertions(+), 35 deletions(-)
>
> diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> index 50f4861ae4b9..f7d1079391ef 100644
> --- a/rust/kernel/mm.rs
> +++ b/rust/kernel/mm.rs
> @@ -142,28 +142,6 @@ fn deref(&self) -> &MmWithUser {
>
>  // These methods are safe to call even if `mm_users` is zero.
>  impl Mm {
> -    /// Call `mmgrab` on `current.mm`.
> -    #[inline]
> -    pub fn mmgrab_current() -> Option<ARef<Mm>> {
> -        // SAFETY: It's safe to get the `mm` field from current.
> -        let mm = unsafe {
> -            let current = bindings::get_current();
> -            (*current).mm
> -        };
> -
> -        if mm.is_null() {
> -            return None;
> -        }
> -
> -        // SAFETY: The value of `current->mm` is guaranteed to be null or a valid `mm_struct`. We
> -        // just checked that it's not null. Furthermore, the returned `&Mm` is valid only for the
> -        // duration of this function, and `current->mm` will stay valid for that long.
> -        let mm = unsafe { Mm::from_raw(mm) };
> -
> -        // This increments the refcount using `mmgrab`.
> -        Some(ARef::from(mm))
> -    }
> -

It's nice to drop this to discourage the unusual thing of grabbing current's mm
and incrementing reference count.

>      /// Returns a raw pointer to the inner `mm_struct`.
>      #[inline]
>      pub fn as_raw(&self) -> *mut bindings::mm_struct {
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index 9e59d86da42d..103d235eb844 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -94,6 +94,26 @@ unsafe impl Send for Task {}
>  // synchronised by C code (e.g., `signal_pending`).
>  unsafe impl Sync for Task {}
>
> +/// Represents a [`Task`] obtained from the `current` global.
> +///
> +/// This type exists to provide more efficient operations that are only valid on the current task.
> +/// For example, to retrieve the pid-namespace of a task, you must use rcu protection unless it is
> +/// the current task.
> +///
> +/// # Invariants
> +///
> +/// Must be equal to `current` of some thread that is currently running somewhere.
> +pub struct CurrentTask(Task);

Nice, I do like the ability to express abstractions like this...

> +
> +// Make all `Task` methods available on `CurrentTask`.
> +impl Deref for CurrentTask {
> +    type Target = Task;
> +    #[inline]
> +    fn deref(&self) -> &Task {
> +        &self.0
> +    }
> +}
> +

It's nice to be able to 'alias' types like this too (ok I'm sure that's not
quite the write way of describing but you know what I mean), so you can abstract
something, then very simply create variants that have the same methods but
different attributes otherwise.

>  /// The type of process identifiers (PIDs).
>  type Pid = bindings::pid_t;
>
> @@ -121,27 +141,25 @@ pub fn current_raw() -> *mut bindings::task_struct {
>      /// # Safety
>      ///
>      /// Callers must ensure that the returned object doesn't outlive the current task/thread.
> -    pub unsafe fn current() -> impl Deref<Target = Task> {
> -        struct TaskRef<'a> {
> -            task: &'a Task,
> -            _not_send: NotThreadSafe,
> +    pub unsafe fn current() -> impl Deref<Target = CurrentTask> {
> +        struct TaskRef {
> +            task: *const CurrentTask,
>          }

Why do we drop the NotThreadSafe bit here? And it seems like the 'a lifetime
stuff has gone too?

I'm guessing the lifetime stuff is because of the SAFETY comment below about
assumptions about lifetime?

>
> -        impl Deref for TaskRef<'_> {
> -            type Target = Task;
> +        impl Deref for TaskRef {
> +            type Target = CurrentTask;
>
>              fn deref(&self) -> &Self::Target {
> -                self.task
> +                // SAFETY: The returned reference borrows from this `TaskRef`, so it cannot outlive
> +                // the `TaskRef`, which the caller of `Task::current()` has promised will not
> +                // outlive the task/thread for which `self.task` is the `current` pointer. Thus, it
> +                // is okay to return a `CurrentTask` reference here.
> +                unsafe { &*self.task }
>              }
>          }
>
> -        let current = Task::current_raw();
>          TaskRef {
> -            // SAFETY: If the current thread is still running, the current task is valid. Given
> -            // that `TaskRef` is not `Send`, we know it cannot be transferred to another thread
> -            // (where it could potentially outlive the caller).
> -            task: unsafe { &*current.cast() },
> -            _not_send: NotThreadSafe,
> +            task: Task::current_raw().cast(),
>          }

I guess these changes align with the changes above?

>      }
>
> @@ -203,6 +221,26 @@ pub fn wake_up(&self) {
>      }
>  }
>
> +impl CurrentTask {
> +    /// Access the address space of this task.
> +    ///
> +    /// To increment the refcount of the referenced `mm`, you can use `ARef::from`.
> +    #[inline]
> +    pub fn mm(&self) -> Option<&MmWithUser> {
> +        let mm = unsafe { (*self.as_ptr()).mm };
> +
> +        if mm.is_null() {
> +            None
> +        } else {
> +            // SAFETY: If `current->mm` is non-null, then it references a valid mm with a non-zero
> +            // value of `mm_users`. The returned `&MmWithUser` borrows from `CurrentTask`, so the
> +            // `&MmWithUser` cannot escape the current task, meaning `mm_users` can't reach zero
> +            // while the reference is still live.
> +            Some(unsafe { MmWithUser::from_raw(mm) })
> +        }
> +    }
> +}

Nice!

> +
>  // SAFETY: The type invariants guarantee that `Task` is always refcounted.
>  unsafe impl crate::types::AlwaysRefCounted for Task {
>      fn inc_ref(&self) {
>
> --
> 2.47.0.371.ga323438b13-goog
>

