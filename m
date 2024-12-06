Return-Path: <linux-kernel+bounces-435481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 999689E7861
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D0318856D2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5D81D61A5;
	Fri,  6 Dec 2024 18:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EbxsmoWJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YWWoEZK5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754C9194A63
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733511183; cv=fail; b=pl1KEzH2y+z7U46yUPtPchNTEMdSyMMBlHZaV8Vc0s77pYLcZJ8jsEx+w1gDK1yVK883ep80DGVrJuzXCj+F8NCC35hsKtQXd3bOkGJMLNcrrzcAPC2qRGrGdC3z+k2NdMDd2oAWNWRxCYJfyR+VDkFvlR8PPKgwsWhxIL6lAX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733511183; c=relaxed/simple;
	bh=wc5yCepyzn+4Sp25OJCwz4+WcB2EgngEbmGErqNiPvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RFjeRvDxC+KWe/A7o5luHCFB7ocSl2H60AJLmlCL/lSZDaFafREvxeUUWxd/m3ZtBVwE9aervtL7fKZEpC7q3RZorUnrdDYJ5PBIelT7S0ZAqAbjRlT35ZGHFYEXuX5MV5g7S0AhkGpmaY3ivJYzFHCBK3n/5Xwl4ANC75/zaJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EbxsmoWJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YWWoEZK5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6Hts2M016515;
	Fri, 6 Dec 2024 18:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=wc5yCepyzn+4Sp25OJCwz4+WcB2EgngEbmGErqNiPvw=; b=
	EbxsmoWJ0UNrGPTRCbpDAw4CtxFBCrXOKPDBAdHqz71z7gv3IAN1s1ZqtKxMecpb
	n04AvpnFCnD059DoKjf3z0EzuZV1yUq8pU9L6AiZvIrzxYgy97Xj2XQSDYNITnkp
	VC46SkPVLYM1YJUHG6sC3Grf4xvLqFIZmrSFyfpyCFs/GW+VYJ1tkwegQ8nIyXPi
	pHet7qVrSLtu0qKZsXcIJlRBstj22E/4Lcqp+1pF4hXPdN8sOxnyoH5WQSB0UTdH
	p/w6eV6SjBTsbIcubDrcsApEmB6fRSjpTLgGaBBo79H5PQ/rnivFvRlnekgdRUc6
	9o8cv05MpdcRHL3oeFbxDw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437trbx6dr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 18:52:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6IiDef011691;
	Fri, 6 Dec 2024 18:52:52 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s5cn1vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 18:52:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXDzdFa9Jk5xi+RichcDt7dQFvgOrqmcgYEV4hpf7BGV6fJHJvnEpW7JzebAB8bw9K5KLO2eUFHaQsfa7ndu7/fFMj2qJYtiIsyQvhxbcIaB0RFvWpDf6uOBWhWcYaOU7TTP3HnbhBnStQh/uTZS8PYn2PCVmHIc590tOGwWoHZF9iDfMi0HL/StDeVtNjrSUn4Ugx0A6TdAha6Zt6j13NN3fTg1FwNfDF9NZ3jVWMG+zLmTBEVwHjaWxofIWA4GezB8iylKFZMGgEChvt+Lv4tuJrUeqTlxfv/xWHbo13Uv16V0HJg80zKgVXIioLoaeLlZbL0pGt9Jnb15ayH0gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wc5yCepyzn+4Sp25OJCwz4+WcB2EgngEbmGErqNiPvw=;
 b=DTqj+Pf+9H+SmSOD4NHziWZ8FsFyrCCKC8uA/GCZJgrlsdW/medaHAUe0bxSquz3nDpA2avWmHPh+1GQN6q8IkiuVuOqye5VWrhPQlBHcsNExHE7NkzZFsgNy68nAquYB0WaspSbGGzOZiYonAFgt7HczL/BUOtBuNq3W/UrGeyWtN87xnoLx/u8X4wmOehBPZXzuL5Awj7S/HIE/JMkSQPa4ZQxeQ4QJjB1FGi6jD535SBwoQg6kaXtnmTXpojyTXqXESy1c3JfMKz32DRHJOW3jQ3DstGAMVNsJRV0nKpvJxAmPnct7d95qR25w30I5bj4B2nnq++7FCC+rwy3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wc5yCepyzn+4Sp25OJCwz4+WcB2EgngEbmGErqNiPvw=;
 b=YWWoEZK5p+/TmI7NiqlNaPFCd9XawKyI58F+ujMfvPFiBsa5sbiB8uyWOj7tGTU3jy1XvTy51oIw8Fh3r2TXWIoMtCjzciwDzCkfrMLQ0RoAO1gVo2dxy8l8nBpaiqeB5WNCkZj39MBW9ljKeIoakgkAA59up/mw7O8hBpYvxLw=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CYYPR10MB7652.namprd10.prod.outlook.com (2603:10b6:930:bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 6 Dec
 2024 18:52:45 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 18:52:44 +0000
Date: Fri, 6 Dec 2024 18:52:36 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Brian Geffon <bgeffon@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Marco Vanotti <mvanotti@google.com>
Subject: Re: [PATCH 0/2] mremap: Fix newaddr hint with MREMAP_DONTUNMAP
Message-ID: <04b1f6c2-32be-4bc0-af0a-919c9c1ee33f@lucifer.local>
References: <20241206152032.1222067-1-bgeffon@google.com>
 <CAG48ez0siYGB8GP5+Szgj2ovBZAkL6Zi4n6GUAjzzjFV9LTkRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0siYGB8GP5+Szgj2ovBZAkL6Zi4n6GUAjzzjFV9LTkRQ@mail.gmail.com>
X-ClientProxiedBy: LO0P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::6) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CYYPR10MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: bde86469-a064-4f75-dbb4-08dd16272ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0hIQ2NjTlVOZ3g0ZnQ2OWpCRnUwRUxOUHQxQS8wTU85aFVRVVBiRmtHZVhs?=
 =?utf-8?B?MXdnK3FycVNSTkt2US9ObzJvSFl6aWdmMkdkbnIzWFRDWThYMys4QmFyalFh?=
 =?utf-8?B?Q0R3SVVyZjNVdUJ6eTFCRDBlK0E0N3JSUmZTNHVRdHJqSkxoYUJJOWlUbDBw?=
 =?utf-8?B?aVA3VjIrdDlZTWo2WklaK0F3dm9JS09LMkNvdzU5eG5WZmhuWmFsYUx1RHNS?=
 =?utf-8?B?akxPZ3BmVGdud2ZzbUliVnhuSmwzem9vSVFIVFVibVIybVlrYUE4Smp5cVFw?=
 =?utf-8?B?YTl1Unp3VzlRUUltMXVycVZxOGVUaHBPNWtpb1ExZkdIYXh2clNZSWpVR0sz?=
 =?utf-8?B?TXlCY085dGdkcHVQSEpORHdmZXBrL0p6QWlFNFJ5WStUMFFqTFNLTlQvU09C?=
 =?utf-8?B?V2tYQWw4aSszQzJuajhVQWdNNFZXbFdoK2pYaStma0xNa1hyZGxLSTd6UEJM?=
 =?utf-8?B?ZWVBMUxqeEw2WEtteVhNVitvZkp1dlV4dlRrQi9ieDE2a25XMmo2TVM1RTBE?=
 =?utf-8?B?akFjajdpRW90aDhQMEFMVkFDcVpNSWcyY1ZHd0lZTFA5Q1M0ek9LeXNHWEht?=
 =?utf-8?B?SEVBWDF2b0Vucm1RK3V0MEh4a2xNWm16Vk9mbzMzSXQ2MUhSVDdmMWhKMXly?=
 =?utf-8?B?a3U0bW9CUjkwQUJTZEpTSjN4cGVSNlpJNGVFREMzWnFCcEc5QVh4STU3eUxh?=
 =?utf-8?B?V1JiQjB0NlJUMG9RMTByYlM1YVZydjhJYU5YQ0ZUYXlieWFCM3YwZ3VHd2Ew?=
 =?utf-8?B?L0d0Mmd0c1B3T2FjaXNkbE1KSzJYZWdmbjhjVXZRdU9zS0lkMWtkaCtUVmlT?=
 =?utf-8?B?d2hyNnhDVllUNWp4VnoxV2tlVUZoQmpHWUpPT3dTbGpOMXU4aDFYTnlWNUxW?=
 =?utf-8?B?U05SRU9YN0RrUDdteHdMc0RPbnZmenk0RzNZVTlEbjV3UVlwai9DRk1NdlEx?=
 =?utf-8?B?bW5EL3YwaFliOUtJMkl2T042L1B6WGwvMHZzcXA4S3BicW1YQnFwVmR0cjFG?=
 =?utf-8?B?VXZRZTZXZWxONXQ4U1cwZXE3ajMwUmUvZGxMdkZLMmJtejZMZFNzY2V3c215?=
 =?utf-8?B?Q2w5QUphdmtrOXF6cXZQNTBuYW5TWG1KNFBmSnpURnZLR0N0ajJwOSt5aU81?=
 =?utf-8?B?azlqb2xCdi9sK3cxZkE3aVhoTXZtOFhQY2k3blliYWZ5K3FJSUtldHBjRGxD?=
 =?utf-8?B?MU5sMHkvZlZvS3NDZE9jUXpoWE5xcG9NR2pPTGh3Vzg1U1NpUC9UdmxHRDJE?=
 =?utf-8?B?NUdyN2hkZitnbFlxUGtqZXZZN29jVlJxRjhaMFRGVlZucm9NR01jMyt3Y2Rl?=
 =?utf-8?B?RDVyRTdrVElXR3JRanVIa1UwYkhsNmYyVUFHQ2hCMmRjMS9Dai9qUThWVnY3?=
 =?utf-8?B?Mk5COTdEWWlhQk9mcnprRFp2M01IZGcyRUlXQ3VCWjZ6S2pQaFRKR0oyTGdq?=
 =?utf-8?B?VlgrVy9QYzNOVS9WeXgxWG0rb3g3RDdrYlN1ckNKQU1LTThrNkkxL205RWxR?=
 =?utf-8?B?NWg4RVRLTzdsTk9lanFzK0xTWDE5MGhNbFdWelJ1a2Y0emlDc0RCVms2amVD?=
 =?utf-8?B?N3M2Z3pmZ2ljMWVUTGt2WnNnb3NaVTk4VWdaQUp2Vzhjci85NDRDMGNhd3Vx?=
 =?utf-8?B?S2g0Sk82KzV3VVR3elpORkhhL21nd2FlUUxXUmhLMG1SalZFV0x3Lzh0Tll5?=
 =?utf-8?B?dU4xYmtvTTVYakRwdFRwZHVad2VsNlFEeXlwV09nQnRPaDc1ZS8xMjdYemRt?=
 =?utf-8?Q?tZNvWUEtEESe9jaXx4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVdhaW44ZlRNVGVwSFZYMVhsTnVrR1lRS09saTdkekFYOWhNWTZUbWlQM3Vo?=
 =?utf-8?B?UVFSU0Vja1dLSWNtYkZWemc2bDQ3ZFpNQ1pDb3lVWEtQdmpvZGlrK1BINU0w?=
 =?utf-8?B?dXRHUTU5SXFGWlh0aEU3S0lSY0hGSllFdHd0QitxYnhGaHFFb3M2L25NZldK?=
 =?utf-8?B?c3F6RXZyOWNpTkxraGR1TzBnc2ErSFZ2RGppVDJuTWpLa2ltTGY3V2w1T2py?=
 =?utf-8?B?YlJJMlVMRHIwbC8yZFN6N3QvOENQMkdmdGpOYkc2NWhhcklndGZiK282eDl3?=
 =?utf-8?B?a0R5dzlyRlV6MHhGM1hiUlZQMnMrczNEWjFaU3pkT3plMWhxNm1JRklDMmgr?=
 =?utf-8?B?QVlSTlI5ZFVHTVpFY1VzTHlvam5wYW8yNnNCbEhDQURnQ3NtYVVGeWFRM1px?=
 =?utf-8?B?MUs1RlZlUE02ZElKWEVRbWI2bmZpdXBZblVXY29Va01Obmc2K2hZdHlMOExv?=
 =?utf-8?B?djU5c2RaNWpVeEo2bzdCWFhONFpsNEFpaGJWK1AzU1pOc28rUDVnNjRxREdZ?=
 =?utf-8?B?aUQzTGJGNytJTlFTZ1lQeEc2SkJLclBXZFU0QWtWMjAwQU1vdzFiTnhPNFNB?=
 =?utf-8?B?RjYzV3V3TjJZT2t4UWN3QXBBL3NKemZXT1JCc3NwWlp4NkZXN0lpTGp4TkFl?=
 =?utf-8?B?bHdkK0RSQmwvblgrbG1jaVZNOVB1Q0x3c0k2OHUxeWVQanBLMCs4WjdGVGhE?=
 =?utf-8?B?L1ZEclhQQmZqN2g2d2J2K2pxcVIydkdiMndVRmdZVDZhWHFZRDZmdktya1Vx?=
 =?utf-8?B?dHBGaXlBM2FQSDNXL1NGOG9BblRvcVlsWUNsQVg2MnFFK2xRK3JEVmlVNUl5?=
 =?utf-8?B?Y2xRZkU5WXNUTW1RdEE3b2lQV3lEWkx3c3IwRmVQU0d1SFJmczh5TldNZGdo?=
 =?utf-8?B?bmVyU3pBdkpQS1VpOHZPMnFpTW5Ka1hkdW00cnlzZWVoYU9BWW1KdkwyMXlU?=
 =?utf-8?B?V2dKTWZ3TEEzTGtDODZGRDc3dWFkZndRdmVDQTNZTDFqeGd2Unh6UCtockNj?=
 =?utf-8?B?M0c5dGJqWEtoOTI5Q0kzcVhIRXozcmI5NXc4cnBSdC9ld1ZJcXFVSTRRcjVj?=
 =?utf-8?B?bGJoT1ZIa3RJS0tFajFVQlhoUEVwcEFMVDRDUUMyMFpVeGx6K2xub255Ymgr?=
 =?utf-8?B?aG10eDVtdDZPMjRtYUZkV1ZQeHJkN2NZd0ZmRjVZSE52ejd0VXhSWHB6cWYv?=
 =?utf-8?B?cFBmVmJsWWZiYWhEQmR1Nks2OEtyUERNZzhjYmVjMUcwUnFHb2ZndW9qUFFH?=
 =?utf-8?B?S1N6d0tLbXhyTktkVlRGSUhkSzV1RUR5SmdLNks5Nlg4S2U5TlljWHRzY1BB?=
 =?utf-8?B?TnFSMFA5ZTkzQktUQ1NTbm9NVnF6cFdzTjEyblZGNTl3VmVueGFLaXZJM2Vq?=
 =?utf-8?B?UG1BVlJiYVNsVElERkN1eVUwZ3JGbk56bm9KeFAvVWU2TkliY0RZaWxNcjBX?=
 =?utf-8?B?OTNPRWppcW9zTmhTdm5WT2R6cW51ZzVpSXloZ0Q2dGdURlhrSmhXeFNvZ1RY?=
 =?utf-8?B?MENLRy94dk1pM05WZU9sVlZYWWp1enRtTVkyN1FkcWFhbU5TRklMZVN0WmV0?=
 =?utf-8?B?WGhSbkhGV1VhQ3J4MTBZMVhEWGFYelV0WFdCTkNwbzROanBjU2Zud1V3akkw?=
 =?utf-8?B?SjhZM1hydm9tS1FXdGVtZk1PbDVOdmtzWU5ZbjhKejRrenNJeXpVamI2YmRi?=
 =?utf-8?B?N1V3MWZpSFRtUlZxUTlRa01nVVJiaXdBVjNlN2lhQWYvM0pIcEZwS0orOFkw?=
 =?utf-8?B?TGtpbHhTbmVjWjBKTHl3dmErSmIvMExKT2RETU5NT3RqaHVtWEF4aXpUNzJM?=
 =?utf-8?B?c00wdHBCSjFHcnBBcE5MMFlvajVFTnN0dlU1SVFBUGV2ZExJWGZTZWY2Tjc2?=
 =?utf-8?B?M2ZrY1JOOURZQ2VWa0JMb28ySk91d0JEU1Rha3pESFo2Umlnam5lZnFEK01Z?=
 =?utf-8?B?c04xNEowb2dFdVdnZVdKdUtKbm5ldlF2Q1RTMTRicnJQSm1NNUpXUEsrYjIy?=
 =?utf-8?B?WVA4VlBtMy9ZWkdvWGZMOWRVV2cvblVGSitKOG00OUpvTjM0REM0Q1EzVzVl?=
 =?utf-8?B?WjNDZ3Q0L1ZKVzRUdTNyS2VmQUtIN3p1cXE3dzdBejd4UFpTdVl3azdrSFBC?=
 =?utf-8?B?THFlTjFsREJIQTRHZlRTSHRFWDBGbU40ZHp5YkpPSU9xMVc2S292cVptck5s?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mLGyqCNyE11ylnx5P9hiW64Lw6dO2IkdfEbcSXdWQdlDDbwcwuLRlKVSuPJAmiUR/TCwfdfiD9KiKQ/aU93FmctaRc+lnK9b9ReTTlgMCQJyOsC6edJINwCRTGbH4//NGdw8E8I0XJ/vMC0cKpU3qS8FYSGvTLHClx0zexLNG6IJd0PtGNIdESGZ/KkrlV7ZanF8+3ya4eVC5Cc+iAb9oBE0A0bvpb5kgXukIa3NkSZ8JJ2dBLaQwbBytBRdIXOM9Estyw31aDzYHUoM1uBDxfOy5zUHD5ercaaowIHLkT6SeK6iuCRfHgC7gvKj2pAGqfHZ7DFonww++ZnYkDIncQHUdacUCC9fZyGhwDbZt9uacKmJiMtmhD+4nOxNBNH2uLtrzVFoyiXz6e+iIi5wB3HOCM+5YqoaWWbAcsFCSWNLL1XOyaIQHV/Nmobvhkan4L1+5o5qMDzonYOPcpHZ1M1Fzsi8KGitiM3VP373mEyQY39qVFlUAl5bIrRYyPy0Jm3oBzYd6DFXr3xULPrhc8AveWP4Vj/LMcEZiWo/5nW0zMa7STwHI2eccm+tLurwIxNb7Cf8y/cU6iQTvjaeVC+PXCFzdaM31k1z4cwTwFE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde86469-a064-4f75-dbb4-08dd16272ba6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 18:52:44.9390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfkNA49txJEt5htrl6rbjSC2v4h0pYrg0bs0VmUvGOmEAEu+greuful09dWKqtwdahKHCanvrH5G/t4ADEb8Gal582FJiOkg0BGEnU1u0BI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7652
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-06_12,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412060142
X-Proofpoint-GUID: IBqA-8w0F4M23O5cVkw502qQhoNlevhc
X-Proofpoint-ORIG-GUID: IBqA-8w0F4M23O5cVkw502qQhoNlevhc

On Fri, Dec 06, 2024 at 07:42:51PM +0100, Jann Horn wrote:
> +mmap maintainers (maybe mm/mremap.c should be added to the file
> pattern for "MEMORY MAPPING" in "MAINTAINERS"? I'm not sure)

Yeah I think it's actually right to group together _all_ VMA-related operations
under the VMA entry, because we have interaction between them all mprotect,
mlock, etc. etc. etc.

I will send a patch in a second for this, because we do keep getting bitten by
this.

>
> On Fri, Dec 6, 2024 at 4:20 PM Brian Geffon <bgeffon@google.com> wrote:
> > mmap(2) allows for a destination address to be specified without
> > MAP_FIXED and in this situation it's a hint to get_unmapped_area().
> > This address need not be page aligned because get_unmapped_area() will
> > align the hint.
> >
> > In the case of mremap(2) with MREMAP_DONTUNMAP it shares a code path
> > with MREMAP_FIXED in mremap_to(), which means this function can be
> > called in 3 different scenarios: MREMAP_FIXED only, MREMAP_DONTUNMAP
> > only, or MREMAP_FIXED | MREMAP_DONTUNMAP. In the second case when only
> > MREMAP_DONTUNMAP is specified we don't need to do alignment or size
> > checks on newaddr because they will be passed to get_unmapped_area() and
> > dealt with appropriately.
> >
> > This patch corrects that behavior to match what non-MREMAP_DONTUNMAP
> > mremap(2) and mmap(2) do. This odd behavioral difference was reported by
> > Marco Vanotti. Additionally, I've included a self test to validate this
> > behavior.

Yeah if this is user-facing - I don't think we can change this. Can we do any v2
as an RFC for now until we can get a chance to look at this? And please cc- the
VMA/mmap maintainers on future revisions (sorry this wasn't at all clear, we
need to update MAINTAINERS here).

Thanks!

>
> Marco pointed me to this; I had no idea mremap() had this undocumented
> behavior where it takes a hint address. The mremap() manpage is
> currently wrong about this, it sort of implies that the new_address
> argument is only used if MREMAP_FIXED is set.
>
> Marco also noticed that upstream glibc now assumes this behavior:
> https://sourceware.org/git/?p=glibc.git;a=commit;h=6c40cb0e9f893d49dc7caee580a055de53562206
>
> Debian also has a test that explicitly checks for this behavior:
> https://sources.debian.org/src/glibc/2.40-4/debian/patches/git-updates.diff/?hl=22820#L22818
>
> I guess it's too late to remove that behavior at this point, and the
> right thing to do is to update the manpage?

Yeah, if user-facing we can't fundamentally change behaviour even if it's
strange I'd say.

