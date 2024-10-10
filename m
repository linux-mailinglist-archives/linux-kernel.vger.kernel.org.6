Return-Path: <linux-kernel+bounces-359619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D90EA998E27
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B127BB224A2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90B019AA6B;
	Thu, 10 Oct 2024 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m+lUB/KH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CGsAaaBH"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D13313634C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728580613; cv=fail; b=too0eafqibSJU6SPcVjB8wuMbWSNfqXq+yY02VNwONkMzYdVywzrhgl8UdnagHzfzK9YtPeVqhERw0oawe9Q/wVfmL8DDVzobRrJcmwMMOpY5dXwb/Xy8WQVNetsbnyIkIxMgaYLN9LaF6/eOrVsMYJ/HSri5xCPLOGlDBxJkwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728580613; c=relaxed/simple;
	bh=XlJ4gEh3fHQb/yb4yMZ8HVuzVMPU7zd2AXDHTbFVxMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pVKDDvxxl2LDsCc8m6O6VCD16K9E27xgQ+BhOaX0jqi/k1D9Y0cR0Sn5ynM6XYziYQMP+Q7E16xv407oMgyofTdNnSGEjYcNpRITs6OjFf0WR3/EokF+mmKpPEPK922sC0K2OyblJLc1socXvJ0UW+Q/HxVOqNSBuzpXDlikpF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m+lUB/KH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CGsAaaBH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ABMZe7024973;
	Thu, 10 Oct 2024 17:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=7jbQsFPkfMWBlYZCER
	UwhAgV5AgnyvVonExKaC858WA=; b=m+lUB/KHB/syPe4sYBUwoB8QNr5BtkS1x6
	q4OvA8Y4CwXWw8z2MzpTTrYY1BebzyYZPkbvbjvdeMavwSQSaHheNyX7OA5UtNt5
	w85GbH8QMUMH/hwUlFR5/5ude7YnLBg1A6Kt9GKKdbI5tMmpF8EFPeqLYRv2RfrU
	9qreuZLkvkFZvzhlnoyNv0wV0gR+9ZEp8z4ElFiHuwPPBksm/iv+0w1A3z0/qlp1
	MLQQ/uG23okFLsZd9mo6m9x2oEnk2I3ZCHxpjQlSyDtN/PQC5iBGnDUD0Zpge81w
	ToUYPnb2YHvSBe02iHK4OXjLpEs2vf4T+UKff3NR3C8rpVjg+Nlw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423034untf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 17:16:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49AFnNgB034282;
	Thu, 10 Oct 2024 17:16:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwab322-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 17:16:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDZXU8PbppLIxyxo/67hOFIv0NGLRWWpj+8g9aZjMmoYlR6GfZFaOrnZct8gRJMfRSMWnm5ln28EvPWFfFbpcEVloOQwhf7REzX+j0CdfVFP3dQh2d70meoNOe+RumgFR43+Tkg787YlASJFQyfSJ4Mtzf2fjTCNwhCmkQl6m5qqG2UMEuscZ5GexRqXYnMMktHPhS1QK8GntdhkS/RpiL2nAkU4tPe1i5V/lpCUlJHyONghPxo/I7d8kgaabVsoCmQw6MEgpdFUVYLDC3zcggERZAII3aurojVRBqROFX6UbTSzTqJkKlmbt0q0oiIzTNP6caunQCfErD+7vVkqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jbQsFPkfMWBlYZCERUwhAgV5AgnyvVonExKaC858WA=;
 b=E/8uJuvmE51NvCr6Ay1SiU/AYIma57WfwQd2wgtinoUcN7deaoVJWmN+zTnJxys4DhmjCXEyzXQ+cppC9csIN0aMqDfw7Cjhm+QkF3goQsAvGJXeCoC0a6Ytfnk3If6oauv2iT37CIVODQ8Bh5YRrHuKmO1/80qYSs/fFTR4ibB5txVnqIjK15YTfqMC7EE+X6rcGOosN9BkNiMdPmiBWlVrwe8FN0KlKPgf4r8OguQI9QuTHNStcyeb59LgQrYqnvmo4X6y9SVPPgkwmEgkEQL8Ajf01lb6qFUzthnr6+b8v3XbNNdy8KkIZEcbNLsXbgtQjcsKPNJ78tW9pKcYsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jbQsFPkfMWBlYZCERUwhAgV5AgnyvVonExKaC858WA=;
 b=CGsAaaBHcpXNx3erMpSEqa+QqD9vVfFMay0NY6sO2bEVguYzx+4UDVZQjvy+qNm8EylGtkD7LAXRHegatAcfEF5Cp61ylaOgBmaLqowmyXrbxv8Rgddlmz7crsNhhXJkUCyR43qMh/9+33glGbfSr/IUu7og8C4ZZle3nP33AMs=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DM4PR10MB6743.namprd10.prod.outlook.com (2603:10b6:8:10d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 17:16:34 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.8026.020; Thu, 10 Oct 2024
 17:16:34 +0000
Date: Thu, 10 Oct 2024 13:16:32 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, willy@infradead.org
Subject: Re: [PATCH] maple_tree: remove conditionals to detect wr_node_store
Message-ID: <otdtppzuwgxfs6c23nsrwsogqie2krhuacyrocbovunnayv7p7@qrqpcy2sovv2>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Wei Yang <richard.weiyang@gmail.com>, Sidhartha Kumar <sidhartha.kumar@oracle.com>, 
	linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, willy@infradead.org
References: <20241009152007.2096-1-sidhartha.kumar@oracle.com>
 <20241010062844.vf4pyrd6isfddwo4@master>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010062844.vf4pyrd6isfddwo4@master>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0350.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::20) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DM4PR10MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: bf7e3016-ae7d-4315-f301-08dce94f4a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t3PXi+m9gZBdm26dXy3HUZ1Bf9/FShwG//gppWmkooNX+Z44TQnRqJzunuD3?=
 =?us-ascii?Q?IwVygKR241Z32kbuZ5UKYNXxjH/i06D/rhv0sHws5hbrtUVSaB+5+XYWWZIF?=
 =?us-ascii?Q?Gq6GoO50UkW63kIj7aAd29VkqkPWlMnd44EF78pZkWxsLBLxjhgInvFnen8O?=
 =?us-ascii?Q?xsgk/IJS00PCXdYHtrHUQJ2fRrMHp6G8gsN0I8vr8/MtKwO2oFCy7iS8SG6u?=
 =?us-ascii?Q?cDp+aFZvHW++XJBSKoHH1RNK5NcDNFIEsuCaEYKHbHVfRwzfJkBST5nkJ/kg?=
 =?us-ascii?Q?kOeNlYRzpz/LNh/jLC/HHyBkxBWwW0Y6qZAKynNuZLqFbRw9SZHAOMgsI+YT?=
 =?us-ascii?Q?kcfOONW+44b5zJELMmeh9U85fNNtIlVrJWH0viWgK7lHi8YSVh3Lv9z7RkkL?=
 =?us-ascii?Q?89QSCW+Xx2BejmPv+f+Tbtlvpx34Nl2pg3zu6Mnl+cu+yilUxrKwMcp3kYMR?=
 =?us-ascii?Q?jDVzssl2DnmG5ChOPSuGQ+c4Yeem7XoDj03tZ79CZopjHb2bfUY3buGjpEWD?=
 =?us-ascii?Q?0T+DNEY67Y+ca97jfhfzMl56nBO0wyVfysTbKcGyT98OZx+ChI5qt+x4ehyS?=
 =?us-ascii?Q?BqR1iCfgCZ1S+1of58wyQKVukRqTG4Ek6qk+q2+TzLYN0hbDfhPWlMcYbvgJ?=
 =?us-ascii?Q?p9Ertt7gEmh+0IQA36/lVuM89d2aj0loYpxM1rRplZ1+vsPEaxp7RQJLVcCH?=
 =?us-ascii?Q?sUj5hvm5XMk0TlZIhtn+HcTwjGOSyJmv4s7VsRObty/9+v2GNZaWybBpKdvQ?=
 =?us-ascii?Q?ypsZLZHeW3RFZ+JImYE6hUNhcKW6XLrhRds/KbbT+lXNFg9Iqm/iN3gp3yXx?=
 =?us-ascii?Q?EQy0JFZmnml8d0sMOqRr8u6EA6qSTXb6tyMSKSzrXU5kuusN7UWsMDQJqMJ/?=
 =?us-ascii?Q?DKK2X0z6UZSd5YwJ40Y8DdW00yGYgiubxihzWhjKQCpPKVcXQcD7B1Wgd6Ij?=
 =?us-ascii?Q?HDKtorsodd0O9hPUiUL9krEG85JeOh+SU3MILKXdtk4E9MiMz6r7SmBmMU3D?=
 =?us-ascii?Q?P++Kl31VvoonHlkTELHeoMrJ2Gnh8BgCfiRgvgqv6M5uiCDKoBNW32knivlY?=
 =?us-ascii?Q?IU7YKrsUxI71C7qcat0dBkYtRI1cTpEsxDZp0kJf3jq6/dEwMvMkfEwx5TV0?=
 =?us-ascii?Q?2ZxAu4q79/knzVNgjsWSumiOG1ZmmoDaYt6yBJj7a6+En0tDIrdZix11Tg+E?=
 =?us-ascii?Q?fGPvylTT9Ye9UXlXJW5F88wSSo0qamviaHPfkqhF0n6XZVEyzYB+sghtQ9IT?=
 =?us-ascii?Q?tBJ6eKsOhV0oEnv0QzM0WK+EXzk9hKdQ32j4+El5Qg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OdcsyXqLpc14qBJC9+oSZh/Au4RMsSaevSrd1jIcmPJ55oabpSV2UWKjraGT?=
 =?us-ascii?Q?EpFPhb1gFdvw7KOjrJvfv4zj2uuqZO3gf4SDt09ASpX+JDpQmeHaxlPyGAFJ?=
 =?us-ascii?Q?FvXEmZKRsTCGozg9WKtfMn4ha4O4PjWfH1k9uFr22LmhaKMGYOIhH+vIREG2?=
 =?us-ascii?Q?xwn4OtTDwpWjucJsAjW+1ygLsjc5Uv1n8vS3jm1Xk9r34Jyy6G/lT2N9rJsa?=
 =?us-ascii?Q?mj4pCmk+HzZi+Yk1ypbyDqi+vepP1VCcJI/91N3JhZ2cPaUa+OjEbqaqebIY?=
 =?us-ascii?Q?xMJaj2Ejnx5Wl+AxfViHArDCkIpYxl9nUoOzVYordF7+5jhWd20/kj6Q2TPA?=
 =?us-ascii?Q?26tvjW7vjrcY8OyqZD1d5H5shh01ta7xYNpr5+YK1Vc20PfYOkaaLHtb53eg?=
 =?us-ascii?Q?/rMn1tde9RTSJkpbXofJoXHAi+Njr6aMwOQWD6rsdAVOAqqU/izjeViioYtf?=
 =?us-ascii?Q?PFDAnpYrdZ+RKS4Xbo+s4BNL4ne14pbj/vPQ5KhU630yDDX1ruPtkgw2XXfo?=
 =?us-ascii?Q?gt9vjKxhrzwlgL0K1dtnhcfXtMBmOJXfuHpJc5Ci48sDpmHDUA2ZAA3IfAm2?=
 =?us-ascii?Q?sObRlNsiUnW9/Q0du65xOVT/PUWqQ4SbZD/9lR7rJnX4e4vnqv4gDgAJGp7Y?=
 =?us-ascii?Q?3bEi0N6yWdDttK8k3NllI2hGIKPZl6uLhWjdQf/7j6N20QQvzorJD8t5xzRH?=
 =?us-ascii?Q?fxazpXZ0momPWZwa15pjPgLIKP3O1DayFvuLoNJjCNaqMSDckmIl/nzpRi15?=
 =?us-ascii?Q?QuN5pz4ywWc9xZ4FQET8fSoeWHTcaoj3DOL0wiQe8TJ9cmyGaEuIcloUXqDk?=
 =?us-ascii?Q?fvICO+p/N88XhiCOT9BbAYoo0ozVJTFTy1ST0EyI8Jexgi0xqv6+K6F8UvNk?=
 =?us-ascii?Q?Tl9bAKUhTZwO3JCtkbdgtD8/r6h9ptl6v3il1jTuf0wCl4zludXsi7Hv+2Il?=
 =?us-ascii?Q?TjtJiAPtyzPshKYQ9j3TRZxj+eTxfm1eCydR2cFqa2rzADkZSuqACxbLgzE7?=
 =?us-ascii?Q?19a3/+DzQWvgBObFC8KBK2I8EFup9wndpCPs0AWmefjE8rj6dbceIkqZ3ph4?=
 =?us-ascii?Q?f176sumpeLZiVeiQC9/l0t9lITMMEBw524hrs6ZDEVH0vsLh8/SIBymn8FIK?=
 =?us-ascii?Q?ZDECEe6q0qPUdRVkNfh/hkNnmshVeWj+FQcYt0RBxdjHKrjkKVBKUNQ2qP7G?=
 =?us-ascii?Q?Y72YeKrIwucEj9lg+CA4ODQ1WaToDDoPd79qbIUWp45TI+IO70ke0WMH4/b9?=
 =?us-ascii?Q?ZCZzkWCvd8FqdDBxhZ8K/MFZZW0Yp5S/R+2qGBWA4LxVFum7JwBUyK1hZHVD?=
 =?us-ascii?Q?n6HvfCi5vc/7/S9CGwXe/1OCD21FWqnu3uVS7B96j1ZB23KTmr2pW2nPa3YD?=
 =?us-ascii?Q?waonbMtHOtSUO61kIPgt38n6bNQJRi7KxG3LnwQxB9t1JsEeRHLnWDaMvye6?=
 =?us-ascii?Q?WMXv5J+BoesImm4s1cAOdfG0b5M+kOcBv+6FJeBdd24fBtDk/7MsUETcdxj/?=
 =?us-ascii?Q?qa9XmVjJNFZ8+Yh+aka12rFy2behzQxlUkh/70He+kQmdDycNWEuzu+W5pFC?=
 =?us-ascii?Q?XTvUqONpg4K1McxRAgiV+o9NK7gordUV9KBqd1pL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qfh81wQTLqPQJooWjtVtDYv3+wezF/zvk5r01WCmDJfT6pnxQtQ4PxVagqQGTogt5kVrVhVGysbzs1vupIP55gTmiKq8TiyHXJfMj9H/ojotOh5qeHuzb1kAX2FwqE4rtBDRw7+kEMtgq2MYFoy+CcbUewEZAVlJ5U/ZpPJWEez43Kq0x/eiHyepPY0laGgScHORKNmhQZ2IyaIeYq6gwZFczGyTxfpQoCC9h6ibXPgWZe0d/I92PldPf5PWIDIhPT6GlaKgVWzNeB2uJkMNraTI+0u0R0FP7fFG9i6VW2KIXlPfAqwOZcNwbcqhFoK/g8GF8XnLK9yBqgA7s0fzvMLmRi6TbtipKtKVgU46cQ2/NY1w3PKJKvis+cREkkYREb2VNpcFo46MFry0gBQ3L+z1Azt+oHEMYvbWPbG82DriiortJvBCW/v1Bw7SRAfri0eBAm1/C0BwqQWIRw1InGRbu20Jgh6QBv/TfFHNjDidngmgUhMbMpfrGJ31mJJBDdfEUEg5vQD5rTHfBPWSw0TDWbpaey8AUqtmfqgFtgGHTns9PwrYQPv2WNrR6wwRBhnmM8mfbIM5TP4fFj9TKP2uz5my3vi7R+FNL8JILHY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7e3016-ae7d-4315-f301-08dce94f4a9e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 17:16:34.5169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrkRq/jf3oUO0YzmVLDrR9PVIAv1CfPJCwmldRNxqQAUSFEL5+iubeUpYA2/BSdI+t/Y1CVjb0OtUNW+7tVSHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6743
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_12,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410100113
X-Proofpoint-GUID: wHc6SSIJqCfiZUCeHZJV_3f37YmLy7VQ
X-Proofpoint-ORIG-GUID: wHc6SSIJqCfiZUCeHZJV_3f37YmLy7VQ

* Wei Yang <richard.weiyang@gmail.com> [241010 02:28]:
> On Wed, Oct 09, 2024 at 11:20:07AM -0400, Sidhartha Kumar wrote:
> >From: Sidhartha <sidhartha.kumar@oracle.com>
> >
> >In mas_wr_store_type(), we check if new_end < mt_slots[wr_mas->type]. If
> >this check fails, we know that ,after this, new_end is >= mt_min_slots.
> >Checking this again when we detect a wr_node_store later in the function
> >is reduntant. Because this check is part of an OR statement, the statement
> >will always evaluate to true, therefore we can just get rid of it.
> >
> >Suggested-by; Wei Yang <richard.weiyang@gmail.com>
> >Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> >---
> > lib/maple_tree.c | 9 +--------
> > 1 file changed, 1 insertion(+), 8 deletions(-)
> >
> >diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> >index 4b423330d83c..f5a12d37b352 100644
> >--- a/lib/maple_tree.c
> >+++ b/lib/maple_tree.c
> >@@ -4252,14 +4252,7 @@ static inline void mas_wr_store_type(struct ma_wr_state *wr_mas)
> > 		return;
> > 	}
> > 
> >-	if (mte_is_root(mas->node) || (new_end >= mt_min_slots[wr_mas->type]) ||
> >-		(mas->mas_flags & MA_STATE_BULK)) {
> >-		mas->store_type = wr_node_store;
> >-		return;
> >-	}
> >-
> >-	mas->store_type = wr_invalid;
> >-	MAS_WARN_ON(mas, 1);
> 
> If my understanding is correct, here is the only place we assign wr_invalid.
> 
> So maybe we can remove this definition?

No.  This needs to exist to catch incorrect uses of the API, at the very
least.  I am not pleased that we aren't able to fall through to setting
this to catch missed settings with this code today.

We are now just assuming we got things right.  Any mistakes will show up
as an out-of-memory issues with writes to the tree.  It will be much
harder to track down what went wrong.

Currently it is set in the header as the default store type and should
remain for that use, at the very least.

> 
> >+	mas->store_type = wr_node_store;
> > }
> > 
> > /**
> >-- 
> >2.43.0
> 
> -- 
> Wei Yang
> Help you, Help me

