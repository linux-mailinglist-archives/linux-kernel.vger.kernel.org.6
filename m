Return-Path: <linux-kernel+bounces-354818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A95B59942F3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19F31F28A62
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEAF17F4FF;
	Tue,  8 Oct 2024 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VQKf5m7e";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O8rTi/46"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F25838DF2
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 08:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377096; cv=fail; b=GuxzquaOQx295CzstsvEHoZhs/qvq13oRnM5CtrOd7cSzNZmy4qvHtQHQNjDgNqk2krhr7hdi1LvyeD/0CUf2iOoEGtZDMFBHFZYfTh+j/GMMYgGeg04I0SIQOptItc7bLVQTrsIyTbmQJzEzY5YzJvu95BfHX58LhBElh3XlQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377096; c=relaxed/simple;
	bh=+/vEaRpxZhzI3x95QZg2xTABPES39k/kzooefWtFcF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cz25aeqxu/YQj5djOK+BQvhX6niw757xDWgfXiSzpisEWCtZ0Se/Ffqrmk8F/K8CZsh5gV1vd5UdlMExnjeCazJzUVNt22MP9DE7njY2gZNBnkFbLR+Vap6Jqttv0ZXJbP/Sjaz1dDJ5CODK+Bk56yr0Al68xINnS9toUXEq2GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VQKf5m7e; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O8rTi/46 reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4985uY0W024397;
	Tue, 8 Oct 2024 08:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=zUGBKTkiey0py1ixoUWP0t/3laPprYuGna6hB2AliRw=; b=
	VQKf5m7eQ4PzN7voA5ltLOYQ4LzQCAxVwaeZAvBmwaGjWC/59cla3Uft5xc1n9Yl
	rGgQarqFZV2GUH5U2A+qE70Pn6FzSXI0VmysO4QExwYJ1Odb9wVlGziB3ejLDdhE
	OEljGGVCCXVqFgjye3lr/InHdhNC86CtjcEPdKJ0S/3JBfKLW4tD7Mow/a264inH
	wXifN3FgCko71jUV0KxQgLK2Aq9kJgC6zC/xOHxaGL4YDBhQPXbtLzHIWLU1ZgLY
	hlouIECNG5FCAgUGCprmmH59LnrnwED8FUPOeHrFPUf6HLP05Gcozxaia+ueI/67
	TPsIMaSBS5nrsFd0LxNmLQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422yyv59tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 08:44:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4988G6DU011494;
	Tue, 8 Oct 2024 08:44:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw6vewb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 08:44:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+IG0VpdtMlFi5AzCV1MW1vYF98Ymp2qPCEk3NRu30T5Vr8t+H71YtydQXyH342VX8CFFzfKwCXiObfgpf31ifvfhtbsJ6ap7+usKOkmJEdrPMCUGllP0jrpY+spSyCqv689V1uHr0euDPlERLiHk7n238cv5YjtOZYOUgf+0/iL8FDy1HRfMgEJpcDdT5p/IA3kDrFsE9LT8bXrUrfAe0mYhmdEHt7KfMUiaBrbC2u38yITU/IY9Tota6YXhdSjC2OdjFKFE2r0g6UbcLBUiEc/dSKuTmMKXBSNLfEpAapJ+ofLNd8Gh8XHOHgSETyKBHF7pxkOznz7wWINe0GIAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bP3AewCKI7hsAArZ0iZbcATiGADWoJ3lGePlM+T4EY=;
 b=GMoG8Rkp5Tt47LrsvFtIgxNLB7j0GZSjJN/899fGsmbg5+zXsQIhsMW3ft5VKSl/PV1+lyEK3n6gTrKTTk66xpS9jrkaOib6AtZOgrB7Rn9GeSei0RbjpVhtgOg7tS12T6+idOkLB+ERpedGRl6Lr9XvKNNCy1MdRzvflGMKLytQQqOoWGfuMipIRtiE2ex3cwzFKIkY8I64mB2bKvl4gI+YOU/fNmc6A8RId7WaUnb9IIAwfzfWKd/J8q2ahuHms0psUg0ip0/xDGFelE0r5rIjkJLZHjmMRml5jJdvDkCPzhIYtH5ZIXsWQcGvsmFzJT/5+ttzCCjPYf6hvIGXWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bP3AewCKI7hsAArZ0iZbcATiGADWoJ3lGePlM+T4EY=;
 b=O8rTi/46Z0DKT9orkV74D3F3xK8vrauFl1e7GzjrSDPqatX3HflP0+OggdyfQl3KtUmiWkwtSJRDVN+TbRgNCHQHulQZDSUsUZVZUnDRHFcCYzIiWX9QUO4Jbp8evtMz5Lp+mixMGy9e8lrv4rbV4ZNWX5XJhWaSvOLHWFRgoV8=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA1PR10MB7753.namprd10.prod.outlook.com (2603:10b6:806:3a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 08:44:27 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 08:44:27 +0000
Date: Tue, 8 Oct 2024 09:44:24 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Bert Karwatzki <spasswolf@web.de>,
        Jeff Xu <jeffxu@chromium.org>, Jiri Olsa <olsajiri@gmail.com>,
        Kees Cook <kees@kernel.org>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [mm]  cacded5e42:  aim9.brk_test.ops_per_sec
 -5.0% regression
Message-ID: <8f5e8ae0-dfaf-4b33-ae79-ca6065dc96ec@lucifer.local>
References: <202409301043.629bea78-oliver.sang@intel.com>
 <77321196-5812-4e5b-be4c-20930e6f22bc@lucifer.local>
 <ZwTt/wB/mmszSXc3@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwTt/wB/mmszSXc3@xsang-OptiPlex-9020>
X-ClientProxiedBy: LO3P123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA1PR10MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: 08751721-d72c-4730-266b-08dce7756b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?YAvGoIAsHU/2KJnbQRCAmOY0Mo0nVeQjn87y3HzDY56UEml6WYFj3h1DAC?=
 =?iso-8859-1?Q?rLgBLvPEfubAQ1oD3eIICWnmkrUF9k0jSYCN44Opgb2KJV9E6tkazFFYvh?=
 =?iso-8859-1?Q?OKFmlhvIzqchTkuhvPvq03WlzlOuvFfna7cs3Ir460G17jLn940CPiXsMX?=
 =?iso-8859-1?Q?qjYQ+Ve8zAWEMAUb4fMlkNr9ES9jDI0XjcBbvAFv3QHTJomzg/54qN674k?=
 =?iso-8859-1?Q?9oVLucWPeJbSusW+QFnNa6KM8Ddz514N1ywbW1MmJqdDIBiX3HkYWlmFIW?=
 =?iso-8859-1?Q?9jwLsDMkfMKj0Usozjd5kGmCOrk7tGGA068Whvl2vJcKPtzzjKooxnH2nv?=
 =?iso-8859-1?Q?orJQ2FlrY1z9QXahY+4/9B568g7qCNY8GSDhK4ErvVHD8O/+TJmnRVY6tY?=
 =?iso-8859-1?Q?Gx3lHAlcKRF+nPkb5aCGPwnFAmCT4wI8UjcMWbgovVXbmw6TnyUjBPS5DB?=
 =?iso-8859-1?Q?G/Z+JbWFfVTpwAm9kfAkPn8/gLMkdr+f0W45octYG4Fp4A35W89h0J+3HK?=
 =?iso-8859-1?Q?/PcGJY75IFz8R7u9wdqgDXreYZ21vgHVd027H4CL6cf6A5UydmyYTNYAPr?=
 =?iso-8859-1?Q?M4sa5DWTDgIAAnAYDqG+i932xal7hMpV09I+um0jF/tDg4xdpm7vZ3bYX2?=
 =?iso-8859-1?Q?dGO5B8c5yPXrD0fzEd+IFHE5SVn9jv2cYxWNe9dV7tuYZFyQDX01dO1/lj?=
 =?iso-8859-1?Q?gAwc1ME3ZajbPBrHVwtssAzD24czBcic+nX/FNKVN8IJL0NvpvO5Ykwp9f?=
 =?iso-8859-1?Q?lEeb4TN+XppxBrNAbZVYRSN7yNl65pB+uCXAhkSlVDmtdmmV5hOOpqzVy3?=
 =?iso-8859-1?Q?SFIgx7fLEWtcX+HLRr0TOPQeDUfyFa0cprHYWlI65uwlG68JUZuaBbWk5K?=
 =?iso-8859-1?Q?gecRHxNDFrIpqTVKzihPYZXRFbiJwGZmjCDAHSZzgECUiRHSCjvmmb4QtI?=
 =?iso-8859-1?Q?nFzA3eLA5KrwOYBhPpvcRjoI9l9MMM6Ejm4ITkVnxeIfmkL4H+U6JbeOag?=
 =?iso-8859-1?Q?4ezaZGw1Md8UxWy0jMmEi1UZ5b5nbhOulCrXESCn7lNz7xKrI7xfNUTNHf?=
 =?iso-8859-1?Q?QjJDUeGtJZbxfUvJR6CYldhug0Q15JL/QRFqYKCI43AHKdLvh8ZUVv+5Mk?=
 =?iso-8859-1?Q?3/rXNAWrrRqItnk2pyprXe378r/4BtW266xIbBfY4UVKI/mYvbm4ekTJHy?=
 =?iso-8859-1?Q?MA5KdRSqlOei1njA+Qc2IdTeXybySxkfeDPp4ITmv3gKlNOa45enPAo1u0?=
 =?iso-8859-1?Q?BiWLOrZ7NuxoMHla9DSEtu02TaBVjUvGljpDZEZpqMdHVJ47H7CGShp/Hj?=
 =?iso-8859-1?Q?YPj/qjmohDb/MTdaOEPDCPrPCKsZvF4YIIAwqtgM0a/eOQQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Eixpmy/kFPwRVdk77/L6PI+jhsTsgDlD7P/SSyRkG+Vr8ed9byErIb8KLI?=
 =?iso-8859-1?Q?GvL4iI0TJGDrqNjJGvlLdX4KIEmlROk16T2j55cAcDmpu0s3d2nmErmI9d?=
 =?iso-8859-1?Q?XejpbynLnk5vDggAAhD/YZOoHcGv/nL4oxWyRNijrMJOCulljLO0vYQtSf?=
 =?iso-8859-1?Q?Ojfvu+ll525bbBAHd57raTg6TJbnwY7ZC46iDVNtdSp06RbYkkFfkZJuhy?=
 =?iso-8859-1?Q?viJOy9uf3EzDCet+/K362bvOskowrKlv94wslWi6dtLje2ibIcSIAjeDnW?=
 =?iso-8859-1?Q?wTs9WTwg52iXIQqDUZMEtbuNh++fOIMHrRw0cE8UN5FZf4eloe1W9oclXH?=
 =?iso-8859-1?Q?6Jjuh7truReMiCOfz7tDduImIIS3ioYf0dPXod9a27b+smPyDgn2Wp0e3B?=
 =?iso-8859-1?Q?xIDpFy4+kI2GCkI2aneg3Kdi3qcC5/Sgp9PXEjVuVuyGhI7+02wsdE3Iy6?=
 =?iso-8859-1?Q?I7MqMNhBeb9w7192bGz8L3wWvml3ygxBuL/Ku0DMGkbP51eLDsFIJK+aH1?=
 =?iso-8859-1?Q?XnAlu+9dEsWDSk0iygKxrxaSuZ+LR2q94RuwD4zLY+0/PNm6eFXDiukXEP?=
 =?iso-8859-1?Q?swzipIZI6kupY89uSx9fa2PEFuG/cNiiFGnHXd42q+WJMZrt9XvsVLS7hI?=
 =?iso-8859-1?Q?+jjb1mQ3elkx7oXNd6r2sBxCfHXYPwKUG2Ot3k2pbHRNaybDccZyOzROVL?=
 =?iso-8859-1?Q?x+J5e8hqb1AKijhTzH9YTaxmsAHprlYjVfCmhTs1LA6nMhut92KBgQA5ld?=
 =?iso-8859-1?Q?d9rRKGi0+IUxk9vbGP7gi7ERPqr7I3CxuFbrDGwYAqL+xEbzECQkoOJuzA?=
 =?iso-8859-1?Q?iQUzTWI5hNqHN63ELx0BEF8t3ALi1xscx5cJFm1FA1nslpqL1v6MtG8aHt?=
 =?iso-8859-1?Q?a4yypd6UYH+pyGIEbwwHNdsZ5WktzEYu8vLMGQEoyRPN9/QXV7HTp6nGYY?=
 =?iso-8859-1?Q?7MIDlkSoN3jl3oS0x8n1cR7F4pSJWJsEJdcsYyiwtdZLJULdnJiCXoMEea?=
 =?iso-8859-1?Q?kQWvq9VmUevhvIuZFsglAfpodrNLYs0uiaxVvuTwjRBhCVmFlnGjzTIJ2J?=
 =?iso-8859-1?Q?k8XUmnh2dV2JKgKB3ETtFcIVrCdAtM23ZYSAqoRHQx6AYZ1GbSGhyWdpB3?=
 =?iso-8859-1?Q?G1WR0Tuq3Vv/MhbIKocJx3o9KzdBihPNIdjMgZD8hDs2mbAtdliYoPd+2+?=
 =?iso-8859-1?Q?0UmbmTFXwa8SFHvuE4dVeB/aHu/v7z7Ax/sKSDdLqAPjwea7Cq5Lc6aN45?=
 =?iso-8859-1?Q?yFws88L9LF2cfTJx7uyU95v453rYXJ44Hi7DypWvkPgQuTNUQcbb2zD7/e?=
 =?iso-8859-1?Q?gCEPJytzH76PpG6AkstV4qlAmsepaINzw3uWaSorkewPxCK9r5ayzVyWAj?=
 =?iso-8859-1?Q?lSwPXLTiRRpnVZXSptG/VIaY25G+2pn21OnKIDHwJAkMYtgXdHxyZG5PbD?=
 =?iso-8859-1?Q?PPcJFTu9Uu+o15gUIdGbH965OM5mcj4MLAhVpvoOtoK7pZpD5AL23ZFA1P?=
 =?iso-8859-1?Q?wf+tSWuRPRqy16dclN0b8xsNUbd5Lp/7yLoChR/SIHCYtosQLy6dXX02Zo?=
 =?iso-8859-1?Q?/sz+4gFxSVW9BO4b0Rc9dfbKOisU+Xh3k6qrESw3TAeCFNH7o99NE0AHbG?=
 =?iso-8859-1?Q?pRGTkh2vx78TtMcK+19u+F+B8GQT74K1TBGx/XkF4MMSHUtMNAfou+u6nF?=
 =?iso-8859-1?Q?YLhIfMsnKoif6T4zwdta/nmQACgpqJ4MNZLvKgNr3lSYEsZ0en386Mr/FU?=
 =?iso-8859-1?Q?x/YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GbH/b7SZMOOJfRA9ued+IpiIgbOTHh8viguLrI8pUIb70t8t3nyOdxYvo1S6zFCYgryXGwb7gzY+wPNhCAmTMQWhK+rzAUIdw2zX6E72PFhQ8jVVdm7B6BPsh9MzSoKz8lZE93XUClGNkbLlMoAjh90Hmg5E2pxqrqfsGQ4UTrQRtqpgM/1UaR6JlJB7sIemHp+0E+8QCxk7FQofdBDD3Nv7/wZ9S5iKx6sXauijbmzbbH9ZTIydIN7w//Czf1ZnGebzav4ypE+dmE3efOcVl9HBUlVz0A99ssTKZMo/cNCEWF6qR1utzlL1MeeMuUf3kike0owpmTzLo9O4JoHlzLjEwwtkTQ0q8+aB2igxT5QXJjOGjrSljvaEZz6s4T5pwLDE28gKs5Is6KmkvPfD8DO2CU3LhZ+tWFgofEsYIpqlqAlHgniBPQzhvDVO9lZlcBk9CX48cFPdbS24cI7dbYX/mDnO55KawFhotlDrtbHdK+LshDznPqqAasLQFxvJFfYbD/wwcYStbebz4N1zR8+1D1QNkxH1uu7DQqXJU9zJ57Nf8gVvm7FGj4fzzPO8/WbGR4h2vIhQTHW54rnujk2F4v2EDKbhJHIjGQJvIPo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08751721-d72c-4730-266b-08dce7756b24
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 08:44:27.6711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxStEQ18+T4zmJGQPd72681W1kl6y4E0RnjlmBgtxmWWfZuNbJPsjlvpQaRuaRHKXOqd/Rqx5RlStY81tHTJZ0wARWYsz9erZI96HMObdeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7753
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_06,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410080056
X-Proofpoint-GUID: 1iSC_9WnU9w2PHPeuNB2QaneRnLtE3K1
X-Proofpoint-ORIG-GUID: 1iSC_9WnU9w2PHPeuNB2QaneRnLtE3K1

On Tue, Oct 08, 2024 at 04:31:59PM +0800, Oliver Sang wrote:
> hi, Lorenzo Stoakes,
>
> sorry for late, we are in holidays last week.
>
> On Mon, Sep 30, 2024 at 09:21:52AM +0100, Lorenzo Stoakes wrote:
> > On Mon, Sep 30, 2024 at 10:21:27AM GMT, kernel test robot wrote:
> > >
> > >
> > > Hello,
> > >
> > > kernel test robot noticed a -5.0% regression of aim9.brk_test.ops_per_sec on:
> > >
> > >
> > > commit: cacded5e42b9609b07b22d80c10f0076d439f7d1 ("mm: avoid using vma_merge() for new VMAs")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > >
> > > testcase: aim9
> > > test machine: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory
> >
> > Hm, quite an old microarchitecture no?
> >
> > Would it be possible to try this on a range of uarch's, especially more
> > recent noes, with some repeated runs to rule out statistical noise? Much
> > appreciated!
>
> we run this test on below platforms, and observed similar regression.
> one thing I want to mention is for performance tests, we run one commit at least
> 6 times. for this aim9 test, the data is quite stable, so there is no %stddev
> value in our table. we won't show this value if it's <2%

Thanks, though I do suggest going forward it's worth adding the number even
if it's <2% or highlighting that, I found that quite misleading.

Also might I suggest reporting the most recent uarch first? As this seeming
to be ivy bridge only delayed my responding to this (not to sound
ungrateful for the report, which is very useful, but it'd be great if you
guys could test in -next, as this was there for weeks with no apparent
issues).

I will look into this now, if I provide patches would you be able to test
them using the same boxes? It'd be much appreciated!

Thanks, Lorenzo

>
> (1)
>
> model: Granite Rapids
> nr_node: 1
> nr_cpu: 240
> memory: 192G
>
> =========================================================================================
> compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
>   gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-gnr-1ap1/brk_test/aim9/300s
>
> fc21959f74bc1138 cacded5e42b9609b07b22d80c10
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>    3220697            -6.0%    3028867        aim9.brk_test.ops_per_sec
>
>
> (2)
>
> model: Emerald Rapids
> nr_node: 4
> nr_cpu: 256
> memory: 256G
> brand: INTEL(R) XEON(R) PLATINUM 8592+
>
> =========================================================================================
> compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
>   gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-emr-2sp1/brk_test/aim9/300s
>
> fc21959f74bc1138 cacded5e42b9609b07b22d80c10
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>    3669298            -6.5%    3430070        aim9.brk_test.ops_per_sec
>
>
> (3)
>
> model: Sapphire Rapids
> nr_node: 2
> nr_cpu: 224
> memory: 512G
> brand: Intel(R) Xeon(R) Platinum 8480CTDX
>
> =========================================================================================
> compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
>   gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/brk_test/aim9/300s
>
> fc21959f74bc1138 cacded5e42b9609b07b22d80c10
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>    3540976            -6.4%    3314159        aim9.brk_test.ops_per_sec
>
>
> (4)
>
> model: Ice Lake
> nr_node: 2
> nr_cpu: 64
> memory: 256G
> brand: Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz
>
> =========================================================================================
> compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
>   gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-icl-2sp9/brk_test/aim9/300s
>
> fc21959f74bc1138 cacded5e42b9609b07b22d80c10
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>    2667734            -5.6%    2518021        aim9.brk_test.ops_per_sec
>
>
> >
> > > parameters:
> > >
> > > 	testtime: 300s
> > > 	test: brk_test
> > > 	cpufreq_governor: performance
> > >
> > >
> > >
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > | Closes: https://lore.kernel.org/oe-lkp/202409301043.629bea78-oliver.sang@intel.com
> > >
> > >
> > > Details are as below:
> > > -------------------------------------------------------------------------------------------------->
> > >
> > >
> > > The kernel config and materials to reproduce are available at:
> > > https://download.01.org/0day-ci/archive/20240930/202409301043.629bea78-oliver.sang@intel.com
> > >
> > > =========================================================================================
> > > compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
> > >   gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-ivb-2ep2/brk_test/aim9/300s
> > >
> > > commit:
> > >   fc21959f74 ("mm: abstract vma_expand() to use vma_merge_struct")
> > >   cacded5e42 ("mm: avoid using vma_merge() for new VMAs")
> >
> > Yup this results in a different code path for brk(), but local testing
> > indicated no regression (a prior revision of the series had encountered
> > one, so I carefully assessed this, found the bug, and noted no clear
> > regression after this - but a lot of variance in the numbers).
> >
> > >
> > > fc21959f74bc1138 cacded5e42b9609b07b22d80c10
> > > ---------------- ---------------------------
> > >          %stddev     %change         %stddev
> > >              \          |                \
> > >    1322908            -5.0%    1256536        aim9.brk_test.ops_per_sec
> >
> > Unfortunate there's no stddev figure here, and 5% feels borderline on noise
> > - as above it'd be great to get some multiple runs going to rule out
> > noise. Thanks!
>
> as above mentioned, the reason there is no %stddev here is it's <2%
>
> just list raw data FYI.
>
> for cacded5e42b9609b07b22d80c10
>
>   "aim9.brk_test.ops_per_sec": [
>     1268030.0,
>     1277110.76,
>     1226452.45,
>     1275850.0,
>     1249628.35,
>     1242148.6
>   ],
>
>
> for fc21959f74bc1138
>
>   "aim9.brk_test.ops_per_sec": [
>     1351624.95,
>     1316322.79,
>     1330363.33,
>     1289563.33,
>     1314100.0,
>     1335475.48
>   ],
>
>
> >
> > >     201.54            +2.9%     207.44        aim9.time.system_time
> > >      97.58            -6.0%      91.75        aim9.time.user_time
> > >       0.04 ± 82%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
> > >       0.10 ± 60%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
> > >       0.04 ± 82%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
> > >       0.10 ± 60%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
> > >   8.33e+08            +3.9%  8.654e+08        perf-stat.i.branch-instructions
> > >       1.15            -0.1        1.09        perf-stat.i.branch-miss-rate%
> > >   12964626            -1.9%   12711922        perf-stat.i.branch-misses
> > >       1.11            -7.4%       1.03        perf-stat.i.cpi
> > >  3.943e+09            +6.0%   4.18e+09        perf-stat.i.instructions
> > >       0.91            +7.9%       0.98        perf-stat.i.ipc
> > >       0.29 ±  2%      -9.1%       0.27 ±  4%  perf-stat.overall.MPKI
> > >       1.56            -0.1        1.47        perf-stat.overall.branch-miss-rate%
> > >       1.08            -6.8%       1.01        perf-stat.overall.cpi
> > >       0.92            +7.2%       0.99        perf-stat.overall.ipc
> > >  8.303e+08            +3.9%  8.627e+08        perf-stat.ps.branch-instructions
> > >   12931205            -2.0%   12678170        perf-stat.ps.branch-misses
> > >   3.93e+09            +6.0%  4.167e+09        perf-stat.ps.instructions
> > >  1.184e+12            +6.1%  1.256e+12        perf-stat.total.instructions
> > >       7.16 ±  2%      -0.4        6.76 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.brk
> > >       5.72 ±  2%      -0.4        5.35 ±  3%  perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64
> > >       6.13 ±  2%      -0.3        5.84 ±  3%  perf-profile.calltrace.cycles-pp.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >       0.83 ± 11%      -0.1        0.71 ±  5%  perf-profile.calltrace.cycles-pp.__vm_enough_memory.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >       0.00            +0.6        0.58 ±  5%  perf-profile.calltrace.cycles-pp.mas_leaf_max_gap.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range
> > >      16.73 ±  2%      +0.6       17.34        perf-profile.calltrace.cycles-pp.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
> > >       0.00            +0.7        0.66 ±  6%  perf-profile.calltrace.cycles-pp.mas_wr_store_type.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags
> > >      24.21            +0.7       24.90        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
> > >      23.33            +0.7       24.05 ±  2%  perf-profile.calltrace.cycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
> > >       0.00            +0.8        0.82 ±  4%  perf-profile.calltrace.cycles-pp.vma_complete.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
> > >       0.00            +0.9        0.87 ±  5%  perf-profile.calltrace.cycles-pp.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags
> > >       0.00            +1.1        1.07 ±  9%  perf-profile.calltrace.cycles-pp.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
> > >       0.00            +1.1        1.10 ±  6%  perf-profile.calltrace.cycles-pp.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
> > >       0.00            +2.3        2.26 ±  5%  perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
> > >       0.00            +7.6        7.56 ±  3%  perf-profile.calltrace.cycles-pp.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
> > >       0.00            +8.6        8.62 ±  4%  perf-profile.calltrace.cycles-pp.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >       7.74 ±  2%      -0.4        7.30 ±  4%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
> > >       5.81 ±  2%      -0.4        5.43 ±  3%  perf-profile.children.cycles-pp.perf_event_mmap_event
> > >       6.18 ±  2%      -0.3        5.88 ±  3%  perf-profile.children.cycles-pp.perf_event_mmap
> > >       3.93            -0.2        3.73 ±  3%  perf-profile.children.cycles-pp.perf_iterate_sb
> > >       0.22 ± 29%      -0.1        0.08 ± 17%  perf-profile.children.cycles-pp.may_expand_vm
> > >       0.96 ±  3%      -0.1        0.83 ±  4%  perf-profile.children.cycles-pp.vma_complete
> > >       0.61 ± 14%      -0.1        0.52 ±  7%  perf-profile.children.cycles-pp.percpu_counter_add_batch
> > >       0.15 ±  7%      -0.1        0.08 ± 20%  perf-profile.children.cycles-pp.brk_test
> > >       0.08 ± 11%      +0.0        0.12 ± 14%  perf-profile.children.cycles-pp.mas_prev_setup
> > >       0.17 ± 12%      +0.1        0.27 ± 10%  perf-profile.children.cycles-pp.mas_wr_store_entry
> > >       0.00            +0.2        0.15 ± 11%  perf-profile.children.cycles-pp.mas_next_range
> > >       0.19 ±  8%      +0.2        0.38 ± 10%  perf-profile.children.cycles-pp.mas_next_slot
> > >       0.34 ± 17%      +0.3        0.64 ±  6%  perf-profile.children.cycles-pp.mas_prev_slot
> > >      23.40            +0.7       24.12 ±  2%  perf-profile.children.cycles-pp.__do_sys_brk
> > >       0.00            +7.6        7.59 ±  3%  perf-profile.children.cycles-pp.vma_expand
> > >       0.00            +8.7        8.66 ±  4%  perf-profile.children.cycles-pp.vma_merge_new_range
> > >       1.61 ± 10%      -0.9        0.69 ±  8%  perf-profile.self.cycles-pp.do_brk_flags
> > >       7.64 ±  2%      -0.4        7.20 ±  4%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
> > >       0.22 ± 30%      -0.1        0.08 ± 17%  perf-profile.self.cycles-pp.may_expand_vm
> > >       0.57 ± 15%      -0.1        0.46 ±  6%  perf-profile.self.cycles-pp.percpu_counter_add_batch
> > >       0.15 ±  7%      -0.1        0.08 ± 20%  perf-profile.self.cycles-pp.brk_test
> > >       0.20 ±  5%      -0.0        0.18 ±  4%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
> > >       0.07 ± 18%      +0.0        0.10 ± 18%  perf-profile.self.cycles-pp.mas_prev_setup
> > >       0.00            +0.1        0.09 ± 12%  perf-profile.self.cycles-pp.mas_next_range
> > >       0.36 ±  8%      +0.1        0.45 ±  6%  perf-profile.self.cycles-pp.perf_event_mmap
> > >       0.15 ± 13%      +0.1        0.25 ± 14%  perf-profile.self.cycles-pp.mas_wr_store_entry
> > >       0.17 ± 11%      +0.2        0.37 ± 11%  perf-profile.self.cycles-pp.mas_next_slot
> > >       0.34 ± 17%      +0.3        0.64 ±  6%  perf-profile.self.cycles-pp.mas_prev_slot
> > >       0.00            +0.3        0.33 ±  5%  perf-profile.self.cycles-pp.vma_merge_new_range
> > >       0.00            +0.8        0.81 ±  9%  perf-profile.self.cycles-pp.vma_expand
> > >
> > >
> > >
> > >
> > > Disclaimer:
> > > Results have been estimated based on internal Intel analysis and are provided
> > > for informational purposes only. Any difference in system hardware or software
> > > design or configuration may affect actual performance.
> > >
> > >
> > > --
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests/wiki
> > >
> >
> > Overall, previously we special-cased brk() to avoid regression, but the
> > special-casing is horribly duplicative and bug-prone so, while we can
> > revert to doing that again, I'd really, really like to avoid it if we
> > possibly can :)

