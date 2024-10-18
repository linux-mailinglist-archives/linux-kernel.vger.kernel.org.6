Return-Path: <linux-kernel+bounces-372201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2AE9A4599
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B33A1C22B26
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EA017C7C4;
	Fri, 18 Oct 2024 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FEefyBz3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OT1EdDe6"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CD720E32D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729275350; cv=fail; b=D4OMSyCUvBtlUdNf75Uj6sp3a3NRl2R+UPu5mL8DNYLmG/FAexg4C7SG1e3RNvvlp8ea5UF6XzGIznBDl542CbU0N9Zkx/FaORS5mwdbadaABq2/L3osTDwUt1BLbg40HIghmhkOCnz4NXsjWnARy8hq/Z/6ZhoqJCrptpMUKRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729275350; c=relaxed/simple;
	bh=CF26OOwxkg8gbIdVBR1Fp6TBkBCpAaX41JulwSFGbu4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u2aj6H1ZUUUPuOmxQ2vtvLnpwr3a2REpMTAivdgM5XSr7/BOMlx0NNvuwAIl2XwQ2qlHJ+ECCkrqvmyht+baQLBHyjrjVxmVZtTReBgQR2d+M+NJk+xkTIPKr49D7WGWqjnJS8btjgCrA+tKdnA60j404L3KkuxFqPKpcRWbT0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FEefyBz3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OT1EdDe6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEBecq027525;
	Fri, 18 Oct 2024 18:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=zSVvzz/D3PvaiwP406Hp0Ai9Fhk2/JiCg3VQ7vU5MCw=; b=
	FEefyBz3VShFVsD/tYwvtxfjaKtEHeOqc9rc3mm9pMG+UgYVhptB0Q+1buAQetBR
	k6ev8q8GxKOxinI/cyii9L3QpbvqNLSTqweun4DrrNuL4A0ZuKeRFUk1JKSVKIMU
	MLmVA1rnK+bqfV1wQLaDRgUa29ZbnqYNjYZo180ifTnpCEQXSGMWnnMoDMa1Sgye
	z7wMSb07tq5w9XYx9pYAv4qEIirXKkgRrrI0tKhDGKOD/GM8Sd9wrIaA97QA2zPu
	mu2gRrjqqa1mfNf/djWVW+y4mflWbJWCzs0S1bmMnk6f7mnpIN3nofj3Jf1hMwj7
	5d4zhqDOdVx3zKdUH2tUnA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqt9f95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 18:15:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IHIxlc027154;
	Fri, 18 Oct 2024 18:15:24 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjjhmt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 18:15:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5p+UdsazNNk4Ex7uWMFVrVsGMeepkIzek6a/VfyksE6pyN7vgdkHEd8X+fElFfrvFIAxO5/+E2YXFD1ERJziE3h++qT89SJvmDA38KXuj9apO7XluP6SAKPFOJWDzTE+0QmU1wJgHJJ2pk/xrp8eeGRngzWYu/wCeFQKTtFU/99iFM8gyknBVOAL9rRDV45V0YZakYrAG252809QW9qDty0peL8meUE2zb6WJsJ8/DFAYuctfWy9xTKa12zW9wjDnoF/ZS38mF3neHMkoq0WIt2HlQHZ2nsEgaSRU8DvwqnDy8i2R+f+TPz3tsOJmPlqPyCYVWj2ukwKKEtfR+IzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSVvzz/D3PvaiwP406Hp0Ai9Fhk2/JiCg3VQ7vU5MCw=;
 b=fNsZRN0jD3CDZO1JICugSgfBWXcxdwdRD7OPKJKzh4XszfUH9WgwI2vnHsLhboQ6tPBk23Ht0zvp0750xG+F1rlz8hj5OupdVJNg5gaRnG8lBi3GG6Rj9g1eBXaWEtKyUcu03Kn0AJzdEA9LYK63pmA3QXZAGuCQJ3OKeE7JwtaknsKPHPnzs0HvrKwnBFj/yA/3o/rogFGPeSs4wrEBJnEyJV3/Ipa4FlNyKgwwVRQN69ucjMjFZI64ZpmmYWcOaFbEWk6nadmYfoGrTt4/rwJ9jBBlY30tmX9iDozjQEfzWb5Eicb3dVEWeMOZ2RbISM9g62sQwq5FfyEBr8YJAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSVvzz/D3PvaiwP406Hp0Ai9Fhk2/JiCg3VQ7vU5MCw=;
 b=OT1EdDe62TdZI8/nC7IHp/Bnhwi1/r9ihi/1sF4Xuj+W4p0zkHPhwA1Kb8MdZDeze08WGVcIKPX8+G0PIyOxW80RWtEXieyEw3W7YouAUKhROWKdILKeNVxqFIPYszD30QsPbNsrKq9YOSwDTtZUUmJ6G7z6ZQf4cAb/6wT02zY=
Received: from DM6PR10MB3977.namprd10.prod.outlook.com (2603:10b6:5:1d0::20)
 by BLAPR10MB5042.namprd10.prod.outlook.com (2603:10b6:208:30c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Fri, 18 Oct
 2024 18:15:20 +0000
Received: from DM6PR10MB3977.namprd10.prod.outlook.com
 ([fe80::5748:741f:2230:d6a9]) by DM6PR10MB3977.namprd10.prod.outlook.com
 ([fe80::5748:741f:2230:d6a9%6]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 18:15:20 +0000
Message-ID: <f5baa653-fec1-4f6e-91b0-ed8368d3c725@oracle.com>
Date: Fri, 18 Oct 2024 14:15:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
To: Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Marsden
 <greg.marsden@oracle.com>,
        Ivan Ivanov <ivan.ivanov@suse.com>,
        Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <mbrugger@suse.com>, Miroslav Benes <mbenes@suse.cz>,
        Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
Content-Language: en-US, en-AG
From: Joseph Salisbury <joseph.salisbury@oracle.com>
In-Reply-To: <20241014105514.3206191-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::30)
 To DM6PR10MB3977.namprd10.prod.outlook.com (2603:10b6:5:1d0::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3977:EE_|BLAPR10MB5042:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf526e0-23c6-41f1-ccf6-08dcefa0d372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elE0TjdoZ3NYUkhYNXRSZU9lcnVqdFFoSVpQWHNmNlUxVlNJZVNwUWQ4blhz?=
 =?utf-8?B?K2pHdGxQS1ZBUVRwTzU1T1NYaGRCT0dqVlZ1WUlUdjFJaFZrRUZNODllcmM5?=
 =?utf-8?B?STVtWWZ2cERMd095U04rMXA3WmZPZXdQSG1KOGZ1SXpmd1ltYkhTWEZmUkRh?=
 =?utf-8?B?NHRia0Q3M3hiYmpLZE1iUk8zVm1GTlVwTGM2b1ZCSFBURWFZSGlkL3RoR1JS?=
 =?utf-8?B?RGgzQU9ZVVhibnFxWjczQTQxVzhRM2NxbjRJbEVPbWw3WlRVU0I1bmxWWlZV?=
 =?utf-8?B?ZG5tWTdCTkIrT1lKanczOFBhMnYrTUhWZzl2UTVKa3RBR25yNndqckdlR1ha?=
 =?utf-8?B?RVIrZUdQVFdVSzRlcGY0a0hNU2FqVU1QZUZmT20rcWo1OWczODkrU1JtL3FH?=
 =?utf-8?B?RDM1QTl2ckZGb3dRZ2FSU2xmMWVZWG0yUVpIRzUxNjcwTXgvR2hjYnBmeDlM?=
 =?utf-8?B?cVpCUlpvOGZrT0g3MHZmVkJjMmx4WDBqSEFNT2J5VmJmeVp1dEd5YVg1S3BG?=
 =?utf-8?B?Wk1ZemRLMVEzelRTZmRFZ0pyc0pVSjVmR085bWw2QXNQOWxqOHVPYVZ4T241?=
 =?utf-8?B?TkFxbHBFQTUvemNXNWFZNVJzSkg4UC80K0VNSzdZUUZKenJQMDByWkdjeXJ1?=
 =?utf-8?B?bDhrYnltRWFNVTgwN0RtRDNHS2t5N0J6cGVtemFVdWhTNllzSTZ0RGw2SlV5?=
 =?utf-8?B?cWFENG5Ea3QvdUl4ckI4MU1IYjVVY0s0ZEFIK1kvdnJGdnY4MGQ0RWlVRHlL?=
 =?utf-8?B?K1p1VVpPYmQvZmNqUnJaOTBsamNYQ3MvTGd0a2VSYy9FU21jRC9XbFBkRy8v?=
 =?utf-8?B?OHhucVppUDNIV2Vlak1OemFidTlxbi9pblpndDgrS042WHAzdklkb0lLVmpz?=
 =?utf-8?B?cUx4eDY4QzFKeURTR3VaeS9Bc3QzaDFKbFB1Wk9jYUpJeHg2NDhEMDFXLy9W?=
 =?utf-8?B?UDhvOXV1NUhrM3pKTmJKdzY3VzI1U1R5NUNwVHdOVGExZGpPSEV1eXI5ZlVX?=
 =?utf-8?B?bnFaUy8wMG9waGFVS25uNjVnUVMrNmtXdU14cFkveWNobE1XV0xEKzI1ZU9B?=
 =?utf-8?B?UDFBU0ZXSUErajNMOTRtTWpzemYyYk9pSzFWcGVhd1BFWmpEMjFYdk05MXpB?=
 =?utf-8?B?djBQVlBzWnl2TjBWaUdpOE92aE1lSDQ2UWRVYWpkRnAyaHdsYUduRlI4QUFr?=
 =?utf-8?B?c2RWMTYyYjA3TDFta2RIeFg2eHFaTkg3NE4yUHNVN0h5N25oR3QzT1dHTFVX?=
 =?utf-8?B?UDdZdVdERlEzdENRYXQrN09JQm94eVIwcjNITlVBaUNYL09PZzVqNkVtVTNw?=
 =?utf-8?B?MjZWeU40Vk5KQ1Z5cWlGZDQ1QXRmQUNJYTdvN0piUWJPaFBod0pmRjIxUGJP?=
 =?utf-8?B?V0NCaS84c2hSK2JLeXpYWm5tKzZ2N0RMQlkyMVNDQS9id21GL2tLakxlc0Vo?=
 =?utf-8?B?R0drRkl0Y0t3b0JubDYxOVJKQ0hpazJBYlVOSFpyWjc3VUZQQysrTVJWd3dm?=
 =?utf-8?B?S0oyZ2RReTZOWE5XSXd1TnpEOUh4M2pWTGluS2tGWnF2OTdNSjhQL1RrSXhN?=
 =?utf-8?B?a2FsMzFYSVdkZTcvU1NJZmpPM1QrcldEUVd3YzRKMUtVeFUxbmc2bFk3Y0FZ?=
 =?utf-8?B?UUJuY1hHNFJWNWE5Ny9pQlRTL3hZZnM0S09vZHdZSGZHWDVRejVtZWxUeGRz?=
 =?utf-8?B?QW5pS3F0Umc4UklKbGVPZ0ZYazJSNmNqRktiQWJsaFp2NE1oTSt3U3J2MXYy?=
 =?utf-8?B?V0RiMFNLemgwV1Z2UVkrSW5NTFBXZTQ5bDBFUkpHMFhISE5aV3RnTzZpanRk?=
 =?utf-8?Q?IdSRJbB7OdWpPcbuMwq4KeUff7sXIotXVCuaA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3977.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkZZdUU5Z2dLeEN1cjliUnpUUUp2c1BBb1YzTFp0NTJLWFljd2hTd0tGYUVT?=
 =?utf-8?B?bUhDZkY5TW1tcU8rVVFROUhtdXV6alA3RGxuRnROc3dwQVVQckQ1NnlKYlUy?=
 =?utf-8?B?eklEK0k0QnI4YVdjdDVFNUFZK2RNUm56NnpsSVFQMUhpZlZ4aUNxd0VvenVW?=
 =?utf-8?B?aHlZRFJRc0JjM0tid3B3dnlyZ3JlZHRGbUR5cUFtb2ZHR2QrT3BxclRQYlZ6?=
 =?utf-8?B?cnRPWFBFNTZaZzVaTjRPbi9lUElyRXFvcDRNczdBNGYxMUk0TmdqV2d5cjRJ?=
 =?utf-8?B?VjBEMWdlTFRtLyt3ci9DcVJWQlIydGhSbFZFcFhyUTZOcml2N04wRmFkU2JD?=
 =?utf-8?B?d1M1T3hWMlpIZ0pmRVJNdXZnWEMwWU1xZkdxNjlMSGRHT1IraEpMQnhTMkJO?=
 =?utf-8?B?K1RKYzF0NVRCUTdSTnU5ZHN4cTgzcEhydGtZYWxBSnBDMnJHUnFEZncxNjM5?=
 =?utf-8?B?dFVGYXZ0R2dESlJNRVE2WjRuSk56R3ZzQW5Ga1lFRHQvUmJDTjRkQ1BoUWNL?=
 =?utf-8?B?MzY2RVpyUldmNXRoQWlxSmh6K2ZzV1RaMjk3NlQ5cTN6aDdKUytjMXhOUlVj?=
 =?utf-8?B?VGtDQ0NlUWg3aWN0ZDU3akhOSEZ6YkN0ZzZPSktLeXBCcG9vbkZua2pLYXpO?=
 =?utf-8?B?M3JLWmJUdE5sZ1JuLzFEbFZTYWFwMHlXYmI2a3l5TEhsYXEwem9IRlE2UUtr?=
 =?utf-8?B?MVRuLzZwc3dkMmtPU05obUNpVzlSMnBqeWZ1dFp3c0xTZlE0TWpxZE5vYzdq?=
 =?utf-8?B?RE42YTBuY0pDR2tLZE1NSmFOckhaYWNWMnhoYjBHM004WDl6WGplNjJaOVBZ?=
 =?utf-8?B?RDVVOGoweG1BSGV1N1N0Z3VnNGdDZzBJRTlVQThqYSs3UUY5VkZDTS9rMXMz?=
 =?utf-8?B?WVR1RzNpWWViaW5qWHh1Yzc0LzljL2U1NHNYUlRUelBDL04zdmVFK3F5TDZC?=
 =?utf-8?B?UE1NdUdhSGxoR2k2RFRBWTlDeVM2dS9WUGZoLzRlU2J6b1NHZXA4cFhwc1dP?=
 =?utf-8?B?d0FvWGlOYlBxeUZMdlgvbWlmMmduZnYrS3lDN015OCtNVmgrTWQ0VUJabW9S?=
 =?utf-8?B?aTI4dEp3VEpyem9DV1dmd2FVYnhkaXhvZ3prRDZLNExtd1hVMEFCMyt4TWI5?=
 =?utf-8?B?alV4cVVBc3VabGpGOW84UVF6azV0aEJlQWltUEM0alFxOURnenhHbHNwT2tt?=
 =?utf-8?B?REZFT0FOWnZnN2hVNzN6eklLb3doenVWLzRPeHJic1BlVjVBNlRBSVRmQnN1?=
 =?utf-8?B?RVltQmQ2WHVjMGZUbTgzSDdzSW1NcFR2KzJJeElHYzNSSlN3V0xVZzRTNFJG?=
 =?utf-8?B?dVVLWEc5SWRKYmQrK2pETXFpQkdYMzlPUkpISnFISXAxV0FOMjhDSVlMcUUr?=
 =?utf-8?B?T21YSWpQUDlYUkpYS0owLzlhRTRTRzcydlhlUjNCSFpYSFlCSUc1NjlONHpJ?=
 =?utf-8?B?QmdHaHYyaTdaL29pbmtVVGF5dDJpYlVpOW1iOEIwYjhuTnNyalZXOVRud0JG?=
 =?utf-8?B?K2tnd1hwUTFHK0RyakJycEk4VFhjeWNuQjdYNUVZeTQ2NkZ1TnhaTFB4ODc2?=
 =?utf-8?B?S25QWHN4ZVprMmRGYnIyQ0RXS2xWYVRQRUJzemE2ZWYvdHlEeUo0eVBoMlhV?=
 =?utf-8?B?cFkxWDJJRDVDUDc0OGdNdUxkWTJ5MjBtZXVjWkw0MmhOM1FjWERMMmVwVGtT?=
 =?utf-8?B?andQaDRLOXF5bDFFRGViMW9xR21HMDBoQXdOMVFIVzQ3cW8zc3RoWEQxSXJp?=
 =?utf-8?B?K3NXUnNyVmx6R1FyU0IzeHhKQWsyaDhrT2VtZWVSa1JLdkRkNWIwRTJVMm5y?=
 =?utf-8?B?aHl2ME52WkxGTWhaRTR0WnRrcHdBR2d5Z2FtUlI5QnRxaXBtWnVWZi81OW5L?=
 =?utf-8?B?SkhCcXljZUFubVpEZFhVUGR2OEdhblU5UFV3M2RCUmVTMVYybGI1bFhhc1Q2?=
 =?utf-8?B?ZGpBQUxLWXRvYzlQMm91aitTNUMwY3FQNE5hUnlUbjFRUnNmWmZyNzQ5R2Fw?=
 =?utf-8?B?NlFibGl3UzgzRjBOMFFYMU9CV2xUYmxPMlZnamovdnZYTHRpbktkOTU4TDZq?=
 =?utf-8?B?cllMUU1JaFdTNGM4K1ZwMkozdk5SMUUvMFUxWVNxNWN4K3dzWjNpODFiUldm?=
 =?utf-8?B?RGZSWVVqZHNkTThrOVBmSjJ3Mm5JODh5RVlmSjBoLy9KbHl1QTdUL0hDMlUy?=
 =?utf-8?Q?a9Vx5bbCt/6YtDmSvunca44=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ScEFFZ3Uf0v3avRpyb1AgFyDJbK/ZYbUZ6ph2czYUQhrUycETBscjRn6Btpkt0sza5K1UJdabTbzAPU0QhT8pQJQ0+uPJqsqECbSyxXrR6A8jTUfIyhVUeASFy/0PTqbDLC+Se6COMhKlewSyOeFm5JZ/Tbsc9ySym1+piXjzyzxQjedFtjyzXZFL0OeKAi7ZEwK1W/mpbJbgexH9gz4PrOhuQqsnYhc6UAJN0E+z65k89DDN4WAIVwlEHHcwbjAbNGBjtFw+oUFDBSrGWEWlH4ZitwiqfiLxe/MOs+Qgjozj9xXIboJEgMb5N4nSC9q8ezExFvF5+vZlccvBRJSELPn9E6E4LtL3x7ZqI0FwuGKDm9ViS/pwDKaktk61zaun8rlqqMaIfjeLbGOZ3hym4Mr3kUIev/v5s4fOG9FAsUo/i6tmdffYBU8oJOZraBoC6ljF8rqAVExgtoPY3xjJRUoNbBrAUWLdNGzHwh8c9BONTeCGo4E7/8F6wVinplW3OsPdymv9p1OXXD5EH6o+ZACOmL0KkNs+JCAx8LlUDJrt13Yv80sJwC5bgPTINeO7EZVZDlczoVfYmkHjx7klpE1glvrBRO+mqLIko9DYJo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf526e0-23c6-41f1-ccf6-08dcefa0d372
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3977.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 18:15:20.5047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFu7+coa/QNIWnVHrMnSeOz7rlR4ks9kJRl8z8LG1cG0nwjZ+0JJ7JAX6NC0AoL8j4WwQqLm99G25l8sJPLrg9IqUv252lHfABcOrYTiDYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5042
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_13,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410180116
X-Proofpoint-GUID: e0XkzgEfAGdDT4BiwUZ8KlmWL5eVDxKi
X-Proofpoint-ORIG-GUID: e0XkzgEfAGdDT4BiwUZ8KlmWL5eVDxKi




On 10/14/24 06:55, Ryan Roberts wrote:
> Hi All,
>
> Patch bomb incoming... This covers many subsystems, so I've included a core set
> of people on the full series and additionally included maintainers on relevant
> patches. I haven't included those maintainers on this cover letter since the
> numbers were far too big for it to work. But I've included a link to this cover
> letter on each patch, so they can hopefully find their way here. For follow up
> submissions I'll break it up by subsystem, but for now thought it was important
> to show the full picture.
>
> This RFC series implements support for boot-time page size selection within the
> arm64 kernel. arm64 supports 3 base page sizes (4K, 16K, 64K), but to date, page
> size has been selected at compile-time, meaning the size is baked into a given
> kernel image. As use of larger-than-4K page sizes become more prevalent this
> starts to present a problem for distributions. Boot-time page size selection
> enables the creation of a single kernel image, which can be told which page size
> to use on the kernel command line.
>
> Why is having an image-per-page size problematic?
> =================================================
>
> Many traditional distros are now supporting both 4K and 64K. And this means
> managing 2 kernel packages, along with drivers for each. For some, it means
> multiple installer flavours and multiple ISOs. All of this adds up to a
> less-than-ideal level of complexity. Additionally, Android now supports 4K and
> 16K kernels. I'm told having to explicitly manage their KABI for each kernel is
> painful, and the extra flash space required for both kernel images and the
> duplicated modules has been problematic. Boot-time page size selection solves
> all of this.
>
> Additionally, in starting to think about the longer term deployment story for
> D128 page tables, which Arm architecture now supports, a lot of the same
> problems need to be solved, so this work sets us up nicely for that.
>
> So what's the down side?
> ========================
>
> Well nothing's free; Various static allocations in the kernel image must be
> sized for the worst case (largest supported page size), so image size is in line
> with size of 64K compile-time image. So if you're interested in 4K or 16K, there
> is a slight increase to the image size. But I expect that problem goes away if
> you're compressing the image - its just some extra zeros. At boot-time, I expect
> we could free the unused static storage once we know the page size - although
> that would be a follow up enhancement.
>
> And then there is performance. Since PAGE_SIZE and friends are no longer
> compile-time constants, we must look up their values and do arithmetic at
> runtime instead of compile-time. My early perf testing suggests this is
> inperceptible for real-world workloads, and only has small impact on
> microbenchmarks - more on this below.
>
> Approach
> ========
>
> The basic idea is to rid the source of any assumptions that PAGE_SIZE and
> friends are compile-time constant, but in a way that allows the compiler to
> perform the same optimizations as was previously being done if they do turn out
> to be compile-time constant. Where constants are required, we use limits;
> PAGE_SIZE_MIN and PAGE_SIZE_MAX. See commit log in patch 1 for full description
> of all the classes of problems to solve.
>
> By default PAGE_SIZE_MIN=PAGE_SIZE_MAX=PAGE_SIZE. But an arch may opt-in to
> boot-time page size selection by defining PAGE_SIZE_MIN & PAGE_SIZE_MAX. arm64
> does this if the user selects the CONFIG_ARM64_BOOT_TIME_PAGE_SIZE Kconfig,
> which is an alternative to selecting a compile-time page size.
>
> When boot-time page size is active, the arch pgtable geometry macro definitions
> resolve to something that can be configured at boot. The arm64 implementation in
> this series mainly uses global, __ro_after_init variables. I've tried using
> alternatives patching, but that performs worse than loading from memory; I think
> due to code size bloat.
>
> Status
> ======
>
> When CONFIG_ARM64_BOOT_TIME_PAGE_SIZE is selected, I've only implemented enough
> to compile the kernel image itself with defconfig (and a few other bits and
> pieces). This is enough to build a kernel that can boot under QEMU or FVP. I'll
> happily do the rest of the work to enable all the extra drivers, but wanted to
> get feedback on the shape of this effort first. If anyone wants to do any
> testing, and has a must-have config, let me know and I'll prioritize enabling it
> first.
>
> The series is arranged as follows:
>
>    - patch 1:	   Add macros required for converting non-arch code to support
>    		   boot-time page size selection
>    - patches 2-36:  Remove PAGE_SIZE compile-time constant assumption from all
>    		   non-arch code
>    - patches 37-38: Some arm64 tidy ups
>    - patch 39:	   Add macros required for converting arm64 code to support
>    		   boot-time page size selection
>    - patches 40-56: arm64 changes to support boot-time page size selection
>    - patch 57:	   Add arm64 Kconfig option to enable boot-time page size
>    		   selection
>
> Ideally, I'd like to get the basics merged (something like this series), then
> incrementally improve it over a handful of kernel releases until we can
> demonstrate that we have feature parity with the compile-time build and no
> performance blockers. Once at that point, ideally the compile-time build options
> would be removed and the code could be cleaned up further.
>
> One of the bigger peices that I'd propose to add as a follow up, is to make
> va-size boot-time selectable too. That will greatly simplify LPA2 fallback
> handling.
>
> Assuming people are ammenable to the rough shape, how would I go about getting
> the non-arch changes merged? Since they cover many subsystems, will each piece
> need to go independently to each relevant maintainer or could it all be merged
> together through the arm64 tree?
>
> Image Size
> ==========
>
> The below shows the size of a defconfig (+ xfs, squashfs, ftrace, kprobes)
> kernel image on disk for base (before any changes applied), compile (with
> changes, configured for compile-time page size) and boot (with changes,
> configured for boot-time page size).
>
> You can see the that compile-16k and 64k configs are actually slightly smaller
> than the baselines; that's due to optimizing some buffer sizes which didn't need
> to depend on page size during the series. The boot-time image is ~1% bigger than
> the 64k compile-time image. I believe there is scope to improve this to make it
> equal to compile-64k if required:
>
> | config      | size/KB | diff/KB |  diff/% |
> |-------------|---------|---------|---------|
> | base-4k     |   54895 |       0 |    0.0% |
> | base-16k    |   55161 |     266 |    0.5% |
> | base-64k    |   56775 |    1880 |    3.4% |
> | compile-4k  |   54895 |       0 |    0.0% |
> | compile-16k |   55097 |     202 |    0.4% |
> | compile-64k |   56391 |    1496 |    2.7% |
> | boot-4K     |   57045 |    2150 |    3.9% |
>
> And below shows the size of the image in memory at run-time, separated for text
> and data costs. The boot image has ~1% text cost; most likely due to the fact
> that PAGE_SIZE and friends are not compile-time constants so need instructions
> to load the values and do arithmetic. I believe we could eventually get the data
> cost to match the cost for the compile image for the chosen page size by freeing
> the ends of the static buffers not needed for the selected page size:
>
> |             |    text |    text |    text |    data |    data |    data |
> | config      | size/KB | diff/KB |  diff/% | size/KB | diff/KB |  diff/% |
> |-------------|---------|---------|---------|---------|---------|---------|
> | base-4k     |   20561 |       0 |    0.0% |   14314 |       0 |    0.0% |
> | base-16k    |   20439 |    -122 |   -0.6% |   14625 |     311 |    2.2% |
> | base-64k    |   20435 |    -126 |   -0.6% |   15673 |    1359 |    9.5% |
> | compile-4k  |   20565 |       4 |    0.0% |   14315 |       1 |    0.0% |
> | compile-16k |   20443 |    -118 |   -0.6% |   14517 |     204 |    1.4% |
> | compile-64k |   20439 |    -122 |   -0.6% |   15134 |     820 |    5.7% |
> | boot-4K     |   20811 |     250 |    1.2% |   15287 |     973 |    6.8% |
>
> Functional Testing
> ==================
>
> I've build-tested defconfig for all arches supported by tuxmake (which is most)
> without issue.
>
> I've boot-tested arm64 with CONFIG_ARM64_BOOT_TIME_PAGE_SIZE for all page sizes
> and a few va-sizes, and additionally have run all the mm-selftests, with no
> regressions observed vs the equivalent compile-time page size build (although
> the mm-selftests have a few existing failures when run against 16K and 64K
> kernels - those should really be investigated and fixed independently).
>
> Test coverage is lacking for many of the drivers that I've touched, but in many
> cases, I'm hoping the changes are simple enough that review might suffice?
>
> Performance Testing
> ===================
>
> I've run some limited performance benchmarks:
>
> First, a real-world benchmark that causes a lot of page table manipulation (and
> therefore we would expect to see regression here if we are going to see it
> anywhere); kernel compilation. It barely registers a change. Values are times,
> so smaller is better. All relative to base-4k:
>
> |             |    kern |    kern |    user |    user |    real |    real |
> | config      |    mean |   stdev |    mean |   stdev |    mean |   stdev |
> |-------------|---------|---------|---------|---------|---------|---------|
> | base-4k     |    0.0% |    1.1% |    0.0% |    0.3% |    0.0% |    0.3% |
> | compile-4k  |   -0.2% |    1.1% |   -0.2% |    0.3% |   -0.1% |    0.3% |
> | boot-4k     |    0.1% |    1.0% |   -0.3% |    0.2% |   -0.2% |    0.2% |
>
> The Speedometer JavaScript benchmark also shows no change. Values are runs per
> min, so bigger is better. All relative to base-4k:
>
> | config      |    mean |   stdev |
> |-------------|---------|---------|
> | base-4k     |    0.0% |    0.8% |
> | compile-4k  |    0.4% |    0.8% |
> | boot-4k     |    0.0% |    0.9% |
>
> Finally, I've run some microbenchmarks known to stress page table manipulations
> (originally from David Hildenbrand). The fork test maps/allocs 1G of anon
> memory, then measures the cost of fork(). The munmap test maps/allocs 1G of anon
> memory then measures the cost of munmap()ing it. The fork test is known to be
> extremely sensitive to any changes that cause instructions to be aligned
> differently in cachelines. When using this test for other changes, I've seen
> double digit regressions for the slightest thing, so 12% regression on this test
> is actually fairly good. This likely represents the extreme worst case for
> regressions that will be observed across other microbenchmarks (famous last
> words). Values are times, so smaller is better. All relative to base-4k:
>
> |             |    fork |    fork |  munmap |  munmap |
> | config      |    mean |   stdev |   stdev |   stdev |
> |-------------|---------|---------|---------|---------|
> | base-4k     |    0.0% |    1.3% |    0.0% |    0.3% |
> | compile-4k  |    0.1% |    1.3% |   -0.9% |    0.1% |
> | boot-4k     |   12.8% |    1.2% |    3.8% |    1.0% |
>
> NOTE: The series applies on top of v6.11.
>
> Thanks,
> Ryan
>
>
> Ryan Roberts (57):
>    mm: Add macros ahead of supporting boot-time page size selection
>    vmlinux: Align to PAGE_SIZE_MAX
>    mm/memcontrol: Fix seq_buf size to save memory when PAGE_SIZE is large
>    mm/page_alloc: Make page_frag_cache boot-time page size compatible
>    mm: Avoid split pmd ptl if pmd level is run-time folded
>    mm: Remove PAGE_SIZE compile-time constant assumption
>    fs: Introduce MAX_BUF_PER_PAGE_SIZE_MAX for array sizing
>    fs: Remove PAGE_SIZE compile-time constant assumption
>    fs/nfs: Remove PAGE_SIZE compile-time constant assumption
>    fs/ext4: Remove PAGE_SIZE compile-time constant assumption
>    fork: Permit boot-time THREAD_SIZE determination
>    cgroup: Remove PAGE_SIZE compile-time constant assumption
>    bpf: Remove PAGE_SIZE compile-time constant assumption
>    pm/hibernate: Remove PAGE_SIZE compile-time constant assumption
>    stackdepot: Remove PAGE_SIZE compile-time constant assumption
>    perf: Remove PAGE_SIZE compile-time constant assumption
>    kvm: Remove PAGE_SIZE compile-time constant assumption
>    trace: Remove PAGE_SIZE compile-time constant assumption
>    crash: Remove PAGE_SIZE compile-time constant assumption
>    crypto: Remove PAGE_SIZE compile-time constant assumption
>    sunrpc: Remove PAGE_SIZE compile-time constant assumption
>    sound: Remove PAGE_SIZE compile-time constant assumption
>    net: Remove PAGE_SIZE compile-time constant assumption
>    net: fec: Remove PAGE_SIZE compile-time constant assumption
>    net: marvell: Remove PAGE_SIZE compile-time constant assumption
>    net: hns3: Remove PAGE_SIZE compile-time constant assumption
>    net: e1000: Remove PAGE_SIZE compile-time constant assumption
>    net: igbvf: Remove PAGE_SIZE compile-time constant assumption
>    net: igb: Remove PAGE_SIZE compile-time constant assumption
>    drivers/base: Remove PAGE_SIZE compile-time constant assumption
>    edac: Remove PAGE_SIZE compile-time constant assumption
>    optee: Remove PAGE_SIZE compile-time constant assumption
>    random: Remove PAGE_SIZE compile-time constant assumption
>    sata_sil24: Remove PAGE_SIZE compile-time constant assumption
>    virtio: Remove PAGE_SIZE compile-time constant assumption
>    xen: Remove PAGE_SIZE compile-time constant assumption
>    arm64: Fix macros to work in C code in addition to the linker script
>    arm64: Track early pgtable allocation limit
>    arm64: Introduce macros required for boot-time page selection
>    arm64: Refactor early pgtable size calculation macros
>    arm64: Pass desired page size on command line
>    arm64: Divorce early init from PAGE_SIZE
>    arm64: Clean up simple cases of CONFIG_ARM64_*K_PAGES
>    arm64: Align sections to PAGE_SIZE_MAX
>    arm64: Rework trampoline rodata mapping
>    arm64: Generalize fixmap for boot-time page size
>    arm64: Statically allocate and align for worst-case page size
>    arm64: Convert switch to if for non-const comparison values
>    arm64: Convert BUILD_BUG_ON to VM_BUG_ON
>    arm64: Remove PAGE_SZ asm-offset
>    arm64: Introduce cpu features for page sizes
>    arm64: Remove PAGE_SIZE from assembly code
>    arm64: Runtime-fold pmd level
>    arm64: Support runtime folding in idmap_kpti_install_ng_mappings
>    arm64: TRAMP_VALIAS is no longer compile-time constant
>    arm64: Determine THREAD_SIZE at boot-time
>    arm64: Enable boot-time page size selection
>
>   arch/alpha/include/asm/page.h                 |   1 +
>   arch/arc/include/asm/page.h                   |   1 +
>   arch/arm/include/asm/page.h                   |   1 +
>   arch/arm64/Kconfig                            |  26 ++-
>   arch/arm64/include/asm/assembler.h            |  78 ++++++-
>   arch/arm64/include/asm/cpufeature.h           |  44 +++-
>   arch/arm64/include/asm/efi.h                  |   2 +-
>   arch/arm64/include/asm/fixmap.h               |  28 ++-
>   arch/arm64/include/asm/kernel-pgtable.h       | 150 +++++++++----
>   arch/arm64/include/asm/kvm_arm.h              |  21 +-
>   arch/arm64/include/asm/kvm_hyp.h              |  11 +
>   arch/arm64/include/asm/kvm_pgtable.h          |   6 +-
>   arch/arm64/include/asm/memory.h               |  62 ++++--
>   arch/arm64/include/asm/page-def.h             |   3 +-
>   arch/arm64/include/asm/pgalloc.h              |  16 +-
>   arch/arm64/include/asm/pgtable-geometry.h     |  46 ++++
>   arch/arm64/include/asm/pgtable-hwdef.h        |  28 ++-
>   arch/arm64/include/asm/pgtable-prot.h         |   2 +-
>   arch/arm64/include/asm/pgtable.h              | 133 +++++++++---
>   arch/arm64/include/asm/processor.h            |  10 +-
>   arch/arm64/include/asm/sections.h             |   1 +
>   arch/arm64/include/asm/smp.h                  |   1 +
>   arch/arm64/include/asm/sparsemem.h            |  15 +-
>   arch/arm64/include/asm/sysreg.h               |  54 +++--
>   arch/arm64/include/asm/tlb.h                  |   3 +
>   arch/arm64/kernel/asm-offsets.c               |   4 +-
>   arch/arm64/kernel/cpufeature.c                |  93 ++++++--
>   arch/arm64/kernel/efi.c                       |   2 +-
>   arch/arm64/kernel/entry.S                     |  60 +++++-
>   arch/arm64/kernel/head.S                      |  46 +++-
>   arch/arm64/kernel/hibernate-asm.S             |   6 +-
>   arch/arm64/kernel/image-vars.h                |  14 ++
>   arch/arm64/kernel/image.h                     |   4 +
>   arch/arm64/kernel/pi/idreg-override.c         |  68 +++++-
>   arch/arm64/kernel/pi/map_kernel.c             | 165 ++++++++++----
>   arch/arm64/kernel/pi/map_range.c              | 201 ++++++++++++++++--
>   arch/arm64/kernel/pi/pi.h                     |  63 +++++-
>   arch/arm64/kernel/relocate_kernel.S           |  10 +-
>   arch/arm64/kernel/vdso-wrap.S                 |   4 +-
>   arch/arm64/kernel/vdso.c                      |   7 +-
>   arch/arm64/kernel/vdso/vdso.lds.S             |   4 +-
>   arch/arm64/kernel/vdso32-wrap.S               |   4 +-
>   arch/arm64/kernel/vdso32/vdso.lds.S           |   4 +-
>   arch/arm64/kernel/vmlinux.lds.S               |  48 +++--
>   arch/arm64/kvm/arm.c                          |  10 +
>   arch/arm64/kvm/hyp/nvhe/Makefile              |   1 +
>   arch/arm64/kvm/hyp/nvhe/host.S                |  10 +-
>   arch/arm64/kvm/hyp/nvhe/hyp.lds.S             |   4 +-
>   arch/arm64/kvm/hyp/nvhe/pgtable-geometry.c    |  16 ++
>   arch/arm64/kvm/mmu.c                          |  39 ++--
>   arch/arm64/lib/clear_page.S                   |   7 +-
>   arch/arm64/lib/copy_page.S                    |  33 ++-
>   arch/arm64/lib/mte.S                          |  27 ++-
>   arch/arm64/mm/Makefile                        |   1 +
>   arch/arm64/mm/fixmap.c                        |  38 ++--
>   arch/arm64/mm/hugetlbpage.c                   |  40 +---
>   arch/arm64/mm/init.c                          |  26 +--
>   arch/arm64/mm/kasan_init.c                    |   8 +-
>   arch/arm64/mm/mmu.c                           |  53 +++--
>   arch/arm64/mm/pgd.c                           |  12 +-
>   arch/arm64/mm/pgtable-geometry.c              |  24 +++
>   arch/arm64/mm/proc.S                          | 128 ++++++++---
>   arch/arm64/mm/ptdump.c                        |   3 +-
>   arch/arm64/tools/cpucaps                      |   3 +
>   arch/csky/include/asm/page.h                  |   3 +
>   arch/hexagon/include/asm/page.h               |   2 +
>   arch/loongarch/include/asm/page.h             |   2 +
>   arch/m68k/include/asm/page.h                  |   1 +
>   arch/microblaze/include/asm/page.h            |   1 +
>   arch/mips/include/asm/page.h                  |   1 +
>   arch/nios2/include/asm/page.h                 |   2 +
>   arch/openrisc/include/asm/page.h              |   1 +
>   arch/parisc/include/asm/page.h                |   1 +
>   arch/powerpc/include/asm/page.h               |   2 +
>   arch/riscv/include/asm/page.h                 |   1 +
>   arch/s390/include/asm/page.h                  |   1 +
>   arch/sh/include/asm/page.h                    |   1 +
>   arch/sparc/include/asm/page.h                 |   3 +
>   arch/um/include/asm/page.h                    |   2 +
>   arch/x86/include/asm/page_types.h             |   2 +
>   arch/xtensa/include/asm/page.h                |   1 +
>   crypto/lskcipher.c                            |   4 +-
>   drivers/ata/sata_sil24.c                      |  46 ++--
>   drivers/base/node.c                           |   6 +-
>   drivers/base/topology.c                       |  32 +--
>   drivers/block/virtio_blk.c                    |   2 +-
>   drivers/char/random.c                         |   4 +-
>   drivers/edac/edac_mc.h                        |  13 +-
>   drivers/firmware/efi/libstub/arm64.c          |   3 +-
>   drivers/irqchip/irq-gic-v3-its.c              |   2 +-
>   drivers/mtd/mtdswap.c                         |   4 +-
>   drivers/net/ethernet/freescale/fec.h          |   3 +-
>   drivers/net/ethernet/freescale/fec_main.c     |   5 +-
>   .../net/ethernet/hisilicon/hns3/hns3_enet.h   |   4 +-
>   drivers/net/ethernet/intel/e1000/e1000_main.c |   6 +-
>   drivers/net/ethernet/intel/igb/igb.h          |  25 +--
>   drivers/net/ethernet/intel/igb/igb_main.c     | 149 +++++++------
>   drivers/net/ethernet/intel/igbvf/netdev.c     |   6 +-
>   drivers/net/ethernet/marvell/mvneta.c         |   9 +-
>   drivers/net/ethernet/marvell/sky2.h           |   2 +-
>   drivers/tee/optee/call.c                      |   7 +-
>   drivers/tee/optee/smc_abi.c                   |   2 +-
>   drivers/virtio/virtio_balloon.c               |  10 +-
>   drivers/xen/balloon.c                         |  11 +-
>   drivers/xen/biomerge.c                        |  12 +-
>   drivers/xen/privcmd.c                         |   2 +-
>   drivers/xen/xenbus/xenbus_client.c            |   5 +-
>   drivers/xen/xlate_mmu.c                       |   6 +-
>   fs/binfmt_elf.c                               |  11 +-
>   fs/buffer.c                                   |   2 +-
>   fs/coredump.c                                 |   8 +-
>   fs/ext4/ext4.h                                |  36 ++--
>   fs/ext4/move_extent.c                         |   2 +-
>   fs/ext4/readpage.c                            |   2 +-
>   fs/fat/dir.c                                  |   4 +-
>   fs/fat/fatent.c                               |   4 +-
>   fs/nfs/nfs42proc.c                            |   2 +-
>   fs/nfs/nfs42xattr.c                           |   2 +-
>   fs/nfs/nfs4proc.c                             |   2 +-
>   include/asm-generic/pgtable-geometry.h        |  71 +++++++
>   include/asm-generic/vmlinux.lds.h             |  38 ++--
>   include/linux/buffer_head.h                   |   1 +
>   include/linux/cpumask.h                       |   5 +
>   include/linux/linkage.h                       |   4 +-
>   include/linux/mm.h                            |  17 +-
>   include/linux/mm_types.h                      |  15 +-
>   include/linux/mm_types_task.h                 |   2 +-
>   include/linux/mmzone.h                        |   3 +-
>   include/linux/netlink.h                       |   6 +-
>   include/linux/percpu-defs.h                   |   4 +-
>   include/linux/perf_event.h                    |   2 +-
>   include/linux/sched.h                         |   4 +-
>   include/linux/slab.h                          |   7 +-
>   include/linux/stackdepot.h                    |   6 +-
>   include/linux/sunrpc/svc.h                    |   8 +-
>   include/linux/sunrpc/svc_rdma.h               |   4 +-
>   include/linux/sunrpc/svcsock.h                |   2 +-
>   include/linux/swap.h                          |  17 +-
>   include/linux/swapops.h                       |   6 +-
>   include/linux/thread_info.h                   |  10 +-
>   include/xen/page.h                            |   2 +
>   init/main.c                                   |   7 +-
>   kernel/bpf/core.c                             |   9 +-
>   kernel/bpf/ringbuf.c                          |  54 ++---
>   kernel/cgroup/cgroup.c                        |   8 +-
>   kernel/crash_core.c                           |   2 +-
>   kernel/events/core.c                          |   2 +-
>   kernel/fork.c                                 |  71 +++----
>   kernel/power/power.h                          |   2 +-
>   kernel/power/snapshot.c                       |   2 +-
>   kernel/power/swap.c                           | 129 +++++++++--
>   kernel/trace/fgraph.c                         |   2 +-
>   kernel/trace/trace.c                          |   2 +-
>   lib/stackdepot.c                              |   6 +-
>   mm/kasan/report.c                             |   3 +-
>   mm/memcontrol.c                               |  11 +-
>   mm/memory.c                                   |   4 +-
>   mm/mmap.c                                     |   2 +-
>   mm/page-writeback.c                           |   2 +-
>   mm/page_alloc.c                               |  31 +--
>   mm/slub.c                                     |   2 +-
>   mm/sparse.c                                   |   2 +-
>   mm/swapfile.c                                 |   2 +-
>   mm/vmalloc.c                                  |   7 +-
>   net/9p/trans_virtio.c                         |   4 +-
>   net/core/hotdata.c                            |   4 +-
>   net/core/skbuff.c                             |   4 +-
>   net/core/sysctl_net_core.c                    |   2 +-
>   net/sunrpc/cache.c                            |   3 +-
>   net/unix/af_unix.c                            |   2 +-
>   sound/soc/soc-utils.c                         |   4 +-
>   virt/kvm/kvm_main.c                           |   2 +-
>   172 files changed, 2185 insertions(+), 951 deletions(-)
>   create mode 100644 arch/arm64/include/asm/pgtable-geometry.h
>   create mode 100644 arch/arm64/kvm/hyp/nvhe/pgtable-geometry.c
>   create mode 100644 arch/arm64/mm/pgtable-geometry.c
>   create mode 100644 include/asm-generic/pgtable-geometry.h
>
> --
> 2.43.0
>
>

Hi Ryan,

First off, this is excellent work!  Your cover page was very detailed 
and made the patch set easier to understand.

Some questions/comments:

Once a kernel is booted with a certain page size, could there be issues 
if it is booted later with a different page size?  How about if this is 
done frequently?

A random example of this: Lets say a retailer, doctors office or a 
similar OLTP environment prefers a small page size during the day for 
performance reasons.  Then in the off-hours prefer a large page size for 
DSS type workloads like running reports or batch jobs.

I'm thinking how this might be used for cost savings.  The best approach 
would be to have multiple systems/VMs/cloud instances for the different 
workload types.  However, and end user might only have one system type 
and change the page size regularly as in that example.


Also, the performance impact does look very minimal.  It will be 
interesting to see if there are any effects on the larger industry 
standard benchmarks like TPC and SPEC.

Thanks,

Joe



