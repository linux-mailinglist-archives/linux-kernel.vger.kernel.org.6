Return-Path: <linux-kernel+bounces-536335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D42A47E54
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8805C7A4F09
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E27522DF8F;
	Thu, 27 Feb 2025 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="moQBfJvL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lOwi+xHH"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D6122D781
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740660950; cv=fail; b=hYiEZFMvUPUDpd+NtH2HyZJElsx9i7nJf771VOKlHGbLo4bEUO9VOtFyqfmSJGktqVKf8xSxzxAG1IccuitEVNgp/vuLdQHDEfoNOiJjS2apNirXUhh24ewgGZo03eT66RKOWXRXT0NgeLkg8D1jDHl2B+msg/WXIL4+9Xu12Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740660950; c=relaxed/simple;
	bh=/J+Uef0Es90nSdXj1rU6QapzNqKM/+wKFpOwNyBSPHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mh3rcjzi2rNUvdpSCVnD83QhF6D9ueI1obznMJH82SYEOl7+c5sYgw6KeNz3H/6PWuYkP/ELKKZHi0y6XX//x8nOeywMUcuGYNj3u4MPs102VntHN5JTXvFSsQtilusNOzZ5Il0tC9uCIuUb1cOtuslNX6P0Xj4Tvu4sMhtXtYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=moQBfJvL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lOwi+xHH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RBR5Tm020362;
	Thu, 27 Feb 2025 12:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=J2Ioxwx4ikNs/Kyu2i
	1qT3BR2AwJyd78UCzFsRRLx5w=; b=moQBfJvLo3SXDFsjlYISAsMOGdzp6uWRRy
	nyr8VZK1UWfNw9SexCqEA0nLoBzuSRsrQ1w+RX8/eGSgvzLSwyLSl9r8QkGpki9E
	JV/d+hduydRURqJn7gVl62na4ERa6r95+/R+QeFVF+M639BE9v6FMhCmUE5pVWFI
	em9fVVuf9KKaC10F8RHLBQYkdrkgqu4FPw8Anf/KGV/LjbrbFuHLod91SQ7jCcwO
	D6jKC5Z+TMMLw4pKlcDYi43Is5OIZn6Raf4MZibpM2COPINPG5oAdOJ8kwxg6Rch
	uAOAEiJNGIjgql02Yx9lfL9WxK3GptEH4Cl1/oPuqQfhsVTn0O3w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pseb965-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 12:55:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RBhhMM024327;
	Thu, 27 Feb 2025 12:55:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51c4y8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 12:55:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mT4lWDwrAybAeBvaNbgAqHL7Edw3o6Jebi/si15YxJ2kXF3mR23phicJmmH8+grzLHicm5o9ff3ZSUNSeRo6v1SfazHR1mP1s3DDAxuthRu4hEuRBA8gCJqo18sRkcgSvdWBkpT4AzXpuugOTUlfhs2hKBkfjQXdfa90lzhqKbRUvgNxWYknveXdLx5XMcRr1W8HrQTQ0gDyp5w9wI5ZVO6f/N2nFbUfKdAT1t2bCletwRCXZZclLctSVF9r/H8J0sEyNCvhG5Bvlokm430X/0AvYVy4Z7i+4oxjem1YcgtkFy1b5jh1mlrQxcfc/nyJRx/WRK2eFa+dG4IvPvXVzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2Ioxwx4ikNs/Kyu2i1qT3BR2AwJyd78UCzFsRRLx5w=;
 b=bHSBAAedNptLAd6Ta5GoDZf7zjvmYiAaMaBBH9wfCcSfDFxHRdWG2D5caaIwngnbhjp2Ak6dHvsdUJgwAaXD1HPkxu4taMstOROL8p5vfFzRlY3MDiG/YpZDfFxTDlwBxrsZPF3pFpAbSUYRjbvHNG9FvmZ2xzWdnsI+H3lLTzlgnu+KHXvvSOienwdcAtmHC0pPCcDTny/1Bg1xpNRfSEDMojs9iKhzgY3W8nb295VyNDoVe8Gl7q7g9A4lVI9AstXVksbAbFCIrUzmgMdqOy2KaUshk4ajk61U7EfbLuAjA745jSICbh5kLpg9VBYLiuZ9G5zcwWbyTPHj4+KYjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2Ioxwx4ikNs/Kyu2i1qT3BR2AwJyd78UCzFsRRLx5w=;
 b=lOwi+xHHkyt7c7fi0c5qJzgkPOwtroH/NWEc4JtSpDabU27cSW/fhMY+88+IIWhsSPZYAiWyHDarmOt5C2+FEuwyoK0abFAuN8TJhvuj9yhSngua89pfua2npYDdvLC6W1VgxmCfmMIW0wYJ0ftBnUeprrrmfks4a1eBsQ+XzYk=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CY8PR10MB6825.namprd10.prod.outlook.com (2603:10b6:930:9c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 12:55:22 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 12:55:21 +0000
Date: Thu, 27 Feb 2025 21:55:13 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Hyesoo Yu <hyesoo.yu@samsung.com>
Cc: janghyuck.kim@samsung.com, vbabka@suse.cz,
        Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] mm: slub: call WARN() when the slab detect an
 error
Message-ID: <Z8BgsapZtIC9VyRf@harry>
References: <20250226081206.680495-1-hyesoo.yu@samsung.com>
 <CGME20250226081359epcas2p2a6a1f3f92540660129164734fa6eaa64@epcas2p2.samsung.com>
 <20250226081206.680495-3-hyesoo.yu@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226081206.680495-3-hyesoo.yu@samsung.com>
X-ClientProxiedBy: SL2P216CA0124.KORP216.PROD.OUTLOOK.COM (2603:1096:101::21)
 To CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CY8PR10MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: cc0a55e0-043e-4a91-3d45-08dd572dfe5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5pVD++EYvikU/QNgPM8J+gCvSd6lt3uthPn3VmC3A2RovlBdjjzfXT7vFQlA?=
 =?us-ascii?Q?3pxfNbDxpeLLXFO4MPXfGjGa0q5UTWWIih3wRrDl1PiktyYi1oyLwlBteh5G?=
 =?us-ascii?Q?jBRAKDKpM8RbdwY8tVRzolhgxf9uGPfAq3FWYsJRRMR49e5OAgC9XaN3LSEs?=
 =?us-ascii?Q?OZGhweAUuUVPyVKhuQ7RFREqUgQKSwye2nlqZHvqal3dzPGYtBifq6fAUJd2?=
 =?us-ascii?Q?BeoSLoyvIYA3X2li7JF8rqUTm/PppNotUYH3tQ2R+I/KGWjtz/XzWuSZoESm?=
 =?us-ascii?Q?V8xBfFaJFutreN/o4sz8nyuPfc12LuFcBGczbkMlpKxyuaJqNXVbNLTDczDu?=
 =?us-ascii?Q?Y7IdOdvSV7LvZdSne+6t288l+rQPXDAcb2eEkz3u/k2PO/WBXBk/fBXj9Eib?=
 =?us-ascii?Q?0IBd8o1etDPysxxefYlYR00DxJ9dG0B5LTev+xkYoJ6izlY4fgnYUmk69caY?=
 =?us-ascii?Q?vlU97k8ydPcSjFaFLFRxHdO8oPrWjl7IJlGEuKxWTr+tK5po6dXocCpFk9ad?=
 =?us-ascii?Q?buazk3ixd7azDyAFWc4Q/zKqTMck6c1J7U4qmPoIxjzy19u3nMkpiMUIa42n?=
 =?us-ascii?Q?vlUiyJj7Qxw9SMxQqpVNsrvtW1HgUrSxeTUINQr1dwPoF9jENv2aSMsm7q7p?=
 =?us-ascii?Q?c6Ey9x+rZrBKrkofHPZg0mLwTTaQ2HFkudQxisolKGe57lRhydl76J9OIQWP?=
 =?us-ascii?Q?AXkObpNFMTrqd29I/4kObZR8h37uVo8DOv3yN91bnRQl3yHkYiMC1i0TgbWy?=
 =?us-ascii?Q?HQDxtpnAtKGgllUyiWD1u94t9aHbhSvjtlX63BkrXBD2knVvNpB7GJ21BPVM?=
 =?us-ascii?Q?XCBE190ZwlKPg1K2gBzCj+JeFm+Zpo9DENyBIniRCNsNqVrVcvojRtwOrLQr?=
 =?us-ascii?Q?YvZGHacFEBMc8XzH9FZ2yP9ppLwhnNjU7VDQRqB4edH30C2gpDUPA2958Dpz?=
 =?us-ascii?Q?qH7nTKXamaC8NtdWAm6YJ38x0jEnMAT9U7o8V8HfjU1rn3mmojb0nfKVs74z?=
 =?us-ascii?Q?HiPxteqRFQlQOLcGgCkJoGJFthch0yvQB9v9JwU0jekriJiaNJjKPC1eJqMC?=
 =?us-ascii?Q?TTHPpq8ME6jbuzJSvfiEvlZsQCoeYj+w/TafT5z+WVBzlMEpsD525EDE01zi?=
 =?us-ascii?Q?N0BtMyhDcVn12mFqvenLl3FwrRM/5Z7jXCB1mLeOWr0DEEZjdtyNPhduNOY0?=
 =?us-ascii?Q?S7R3EP4MOdp9MNXzMOtW1/eqUkgqTKSm+izHiXf2RTn/PjuXLgomdAQxcoT1?=
 =?us-ascii?Q?TTRceP7w5iAMKY/7eWqzpwN+WtL4YeUJWUmL+gZfOiGVMNlpVDn52t5qDUd3?=
 =?us-ascii?Q?g4roi6Wi86a1kGcBAcn0XsquWQDq4tTTkDx7q45b722Ce4CaEbIGptAxMkQE?=
 =?us-ascii?Q?ut2HfuGGR2zXusQMa3X4TGeyW4yo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rWIOWweDYKDy0vj30da3cQDS12ObIBkvU7IUuh/jFO0vBHawNYMXhN4YcD/3?=
 =?us-ascii?Q?e16+4AcEA4kOYHLUVOYGSyc1biEMUrnIctvL3lSijBqLc26MZ1/aU9Kb1fOj?=
 =?us-ascii?Q?be2a8b6uo3iICC3f8RHkGO2eunDMp/O3aCSl+SeEnP2KjPYgfoe08FxeQNSv?=
 =?us-ascii?Q?jlLpo4eW3dIxjVFaNDOYSMHvOpDvPuPCIRZfN8uj0GO7QLf8TiOTmyZZXfEE?=
 =?us-ascii?Q?RcXKW2OAmb1IbX8No8ExU3u9ZhtOlK2rCyx+UqOmJkPYB3R1rhMqEOnyZSXG?=
 =?us-ascii?Q?Q3jGaPNSZ1xWhKQQFzR4+KSn9Eu9JUoLZUo+LNip0YyDlXDzVANZ6zzoylfR?=
 =?us-ascii?Q?cdCQh3wCqMq/mEhoJesFDmnZWw+6jP1KJiEokWiu6EBuU24rTrCwf4lyDE4F?=
 =?us-ascii?Q?dzXTPl70pwrjP/QRG8UrNX2cOZYLHH4ulwFlPh8WL4Q0T6r/2+vq3V3iRPYa?=
 =?us-ascii?Q?qpQccJmxfOheDuQ44nlqy409rAhUFBAmB7JIMsRpEhFDBpvxMLT/pdFjzS+I?=
 =?us-ascii?Q?LRgcfqst3zItkiIgr4NRGz20KmUO5RFwllC11ltN0My2VjIIbQIx76dxtk/R?=
 =?us-ascii?Q?5wXgM03LYqQGiGZWWl6EBnnuaEt47UYqJ2VdZ21h4YRSL5AcKSouGuku2RCS?=
 =?us-ascii?Q?HZslPlytmDBQy7+VkXocQEIRbvsrcwtb+zwA6+vzK2siJ7joO0WP3u0jKDs/?=
 =?us-ascii?Q?hM8KxCvpR/GUJb5AGsQrDqKpY+3CN2iV9RNfUkLhwcNdjU35+6tet+HkqR/V?=
 =?us-ascii?Q?H0wJj41OEQQsgBbVPorjXcY+L0SIf636TQ8Pi163U6VLbP8Qt4G4N+oPODrf?=
 =?us-ascii?Q?euz9ZbWMCAT05GioEqwNtBp5kqXlX6NUsEaIXSmL7ExeBAxcfNGMV4Jjg7be?=
 =?us-ascii?Q?b+8KjiJ2RRGxF7DH3TfMhzIWnCAg8Qn1/ELEMLSp6G3p40MXZ+vNtShXGJfI?=
 =?us-ascii?Q?ydAYlW/dZObvYHb8Yhfc3qiEReWeHLCnyx3NESZVW1x+S+Gb3nXTZ3qphWZW?=
 =?us-ascii?Q?sBbG7I+IIloDcr79OszAm5cUoZjCGXBO6VJ44lvyi8fRGocPLLMLAJ/8XtRp?=
 =?us-ascii?Q?WdD6QsqZfleiMQoMQEVxdN+FmzNW6KAGwXjawcJ5+Vq9YhSQaAdvoP2ZoE5R?=
 =?us-ascii?Q?CdF7OHwscf2SO71goWpvY4G7Up2LK9amrPy/mw6FupAMBegetI1QefHlsOjM?=
 =?us-ascii?Q?SN7hHMYB3q+ku/cz/+JP1ujtuNGzr3XMtrw+INu7f32PsD17XIsQ4euK/IFq?=
 =?us-ascii?Q?/u75OKQfP1cYad7FiJl9EnVPhqziXtpTleHaloGNNtMn5bZD14yJXIXrRFPm?=
 =?us-ascii?Q?d3rHRRypWh1QNhd2xxMWhwyBu5dz+EhExRGWMrVRpv6wZmKsg6/khJqQVCNe?=
 =?us-ascii?Q?GlZMfUdgEmvcTUAkgspc6DtiXJQ34pjqjlfOv7PKS+giAm7VIH9dF6tcATUe?=
 =?us-ascii?Q?Wab+GyXD/fdgo5rpbZMxm+ewnuT71ggonrxtzyTAUbnVkgl4KEwQczIr7Z5p?=
 =?us-ascii?Q?H26LDBsTtYei5OGT0GL6W/NbGa9QsF1sICYoNFVAZCQvnTyVU3ZEUqMxjIFP?=
 =?us-ascii?Q?jPnL1XydTXUe8jT6P/9nJiutq5aHUFYEROrJTsof?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8LZocW6cyryoGca3X6XaboOpLhtWMRJEzMfqHpgmOUccnorIRj7D93UiQ6ExteSCY+uWk42SK/ptyZMdSdcvAxj0CR3a4h9EcnIRaWVv746uIyolScUI2gyqh7hgk8Vey8K9PmtvLgzTIc6/UBQI3+nndLHuORdLXmIpSJ3NsGBc7nnAABGg82JuclyJeV2F3nTJF6D3StQ54YfIFyI+v5UMkr333mWsLCHwf82YlIBbNhuDlV7tzmjwtue2XCmoLvTvy/eklT1GL5xslJ5WFuiuB4Gw3RxOWLsqY3jLwCUqWCbrfa+XySpFnJGw29lXmJzmxc7A2i/Drkr73ApqVTW5iF2Qkt5kWig62n1gy8ufsgH9o7yGqBOoEV55si31P7/nmCdk5/AA0AkKAQ/LBbRuma9VUKAoyQf52ghXsC+H2A77H6s5SVa6++eyuLJa24NgerrCYeNpwn0OS6FMvxvS+5dlhL084H+o8xv/3MN7WutHnkHSpqW+bJG96O1jT5KzsPWLu6vgQYEtEimZw+37yIb926Bak/9SDQbrABW3TBQfc/vuZS6XBGIxCz5sbVv1rLU+0WHQAGUPtNv8SqzoY8sOF3ut+US0bzHbd+c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0a55e0-043e-4a91-3d45-08dd572dfe5b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 12:55:21.2690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKtF9t4DEEgG6m+bhFjyPcKVRseMShhjNbKojyktXx4TukNTOS0+jFtnAyc3QBEMImmSeI3o5tMHpXzJoZHMrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502270098
X-Proofpoint-GUID: 8iz_kJ4s_0SDx4XmM92XJqlcwWdcyv2l
X-Proofpoint-ORIG-GUID: 8iz_kJ4s_0SDx4XmM92XJqlcwWdcyv2l

On Wed, Feb 26, 2025 at 05:12:01PM +0900, Hyesoo Yu wrote:
> If a slab object is corrupted or an error occurs in its internal
> value, continuing after restoration may cause other side effects.
> At this point, it is difficult to debug because the problem occurred
> in the past. It is useful to use WARN() to catch errors at the point
> of issue because WARN() could trigger panic for system debugging when
> panic_on_warn is enabled. WARN() is added where to detect the error
> on slab_err and object_err.
> 
> It makes sense to only do the WARN() after printing the logs. slab_err
> is splited to __slab_err that calls the WARN() and it is called after
> printing logs.
> 
> Changes in v4:
> - Remove WARN() in kmem_cache_destroy to remove redundant warning.
> 
> Changes in v3:
> - move the WARN from slab_fix to slab_err, object_err and check_obj to
> use WARN on all error reporting paths.
> 
> Changes in v2:
> - Replace direct calling with BUG_ON with the use of WARN in slab_fix.

Same here, please rephrase the changelog without "Changes in vN" in the
changelog, and move the patch version changes below "---" line.

> Signed-off-by: Hyesoo Yu <hyesoo.yu@samsung.com>
> ---

Otherwise this change in general looks good to me (with a suggestion below).
Please feel free to add:
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

# Suggestion

There's a case where SLUB just calls pr_err() and dump_stack() instead of
slab_err() or object_err() in free_consistency_checks().

I would like to add something like this:

diff --git a/mm/slub.c b/mm/slub.c
index b7660ee85db0..d5609fa63da4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1022,12 +1022,16 @@ static void slab_bug(struct kmem_cache *s, char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
+	const char *name = "<unknown>";
+
+	if (s)
+		name = s->name;
 
 	va_start(args, fmt);
 	vaf.fmt = fmt;
 	vaf.va = &args;
 	pr_err("=============================================================================\n");
-	pr_err("BUG %s (%s): %pV\n", s->name, print_tainted(), &vaf);
+	pr_err("BUG %s (%s): %pV\n", name, print_tainted(), &vaf);
 	pr_err("-----------------------------------------------------------------------------\n\n");
 	va_end(args);
 }
@@ -1628,9 +1632,8 @@ static inline int free_consistency_checks(struct kmem_cache *s,
 			slab_err(s, slab, "Attempt to free object(0x%p) outside of slab",
 				 object);
 		} else if (!slab->slab_cache) {
-			pr_err("SLUB <none>: no slab for object 0x%p.\n",
-			       object);
-			dump_stack();
+			slab_err(NULL, slab, "No slab for object 0x%p",
+				 object);
 		} else
 			object_err(s, slab, object,
 					"page slab pointer corrupt.");

-- 
Cheers,
Harry

>  mm/slab_common.c |  3 ---
>  mm/slub.c        | 31 +++++++++++++++++++------------
>  2 files changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 477fa471da18..d13f4ffe252b 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -517,9 +517,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
>  	kasan_cache_shutdown(s);
>  
>  	err = __kmem_cache_shutdown(s);
> -	if (!slab_in_kunit_test())
> -		WARN(err, "%s %s: Slab cache still has objects when called from %pS",
> -		     __func__, s->name, (void *)_RET_IP_);
>  
>  	list_del(&s->list);
>  
> diff --git a/mm/slub.c b/mm/slub.c
> index 8c13cd43c0fd..4961eeccf3ad 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1096,8 +1096,6 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
>  		/* Beginning of the filler is the free pointer */
>  		print_section(KERN_ERR, "Padding  ", p + off,
>  			      size_from_object(s) - off);
> -
> -	dump_stack();
>  }
>  
>  static void object_err(struct kmem_cache *s, struct slab *slab,
> @@ -1109,6 +1107,8 @@ static void object_err(struct kmem_cache *s, struct slab *slab,
>  	slab_bug(s, "%s", reason);
>  	print_trailer(s, slab, object);
>  	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
> +
> +	WARN_ON(1);
>  }
>  
>  static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
> @@ -1125,6 +1125,14 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
>  	return false;
>  }
>  
> +static void __slab_err(struct slab *slab)
> +{
> +	print_slab_info(slab);
> +	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
> +
> +	WARN_ON(1);
> +}
> +
>  static __printf(3, 4) void slab_err(struct kmem_cache *s, struct slab *slab,
>  			const char *fmt, ...)
>  {
> @@ -1138,9 +1146,7 @@ static __printf(3, 4) void slab_err(struct kmem_cache *s, struct slab *slab,
>  	vsnprintf(buf, sizeof(buf), fmt, args);
>  	va_end(args);
>  	slab_bug(s, "%s", buf);
> -	print_slab_info(slab);
> -	dump_stack();
> -	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
> +	__slab_err(slab);
>  }
>  
>  static void init_object(struct kmem_cache *s, void *object, u8 val)
> @@ -1313,9 +1319,10 @@ slab_pad_check(struct kmem_cache *s, struct slab *slab)
>  	while (end > fault && end[-1] == POISON_INUSE)
>  		end--;
>  
> -	slab_err(s, slab, "Padding overwritten. 0x%p-0x%p @offset=%tu",
> -			fault, end - 1, fault - start);
> +	slab_bug(s, "Padding overwritten. 0x%p-0x%p @offset=%tu",
> +		 fault, end - 1, fault - start);
>  	print_section(KERN_ERR, "Padding ", pad, remainder);
> +	__slab_err(slab);
>  
>  	restore_bytes(s, "slab padding", POISON_INUSE, fault, end);
>  }
> @@ -5428,14 +5435,13 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
>  	return !!oo_objects(s->oo);
>  }
>  
> -static void list_slab_objects(struct kmem_cache *s, struct slab *slab,
> -			      const char *text)
> +static void list_slab_objects(struct kmem_cache *s, struct slab *slab)
>  {
>  #ifdef CONFIG_SLUB_DEBUG
>  	void *addr = slab_address(slab);
>  	void *p;
>  
> -	slab_err(s, slab, text, s->name);
> +	slab_bug(s, "Objects remaining on __kmem_cache_shutdown()");
>  
>  	spin_lock(&object_map_lock);
>  	__fill_map(object_map, s, slab);
> @@ -5450,6 +5456,8 @@ static void list_slab_objects(struct kmem_cache *s, struct slab *slab,
>  		}
>  	}
>  	spin_unlock(&object_map_lock);
> +
> +	__slab_err(slab);
>  #endif
>  }
>  
> @@ -5470,8 +5478,7 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
>  			remove_partial(n, slab);
>  			list_add(&slab->slab_list, &discard);
>  		} else {
> -			list_slab_objects(s, slab,
> -			  "Objects remaining in %s on __kmem_cache_shutdown()");
> +			list_slab_objects(s, slab);
>  		}
>  	}
>  	spin_unlock_irq(&n->list_lock);
> -- 
> 2.28.0
> 

