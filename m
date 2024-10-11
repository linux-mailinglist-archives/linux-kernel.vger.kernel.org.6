Return-Path: <linux-kernel+bounces-360663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 897D4999DE2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A424B1F22B92
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0827A209F50;
	Fri, 11 Oct 2024 07:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OyYtT2hd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yrtrHuNy"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251B01CDA19
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631647; cv=fail; b=WWXdYQQilhWVMARcIhfwUpAkWXfYR8ku6qzwmSHK+Kpbe3V7VuhxwW+EDp1AcJgSYOCMsHTByLg3xDgXZGw6E2zXJjztotCtLMr38k0+kLHcKfLeuIFpsuqlWMnPNYJq/C2fC0fxLkHZ1Byg6SyuAFVgMjsYQFhZI3bil7VZuYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631647; c=relaxed/simple;
	bh=RundX8k0kO5qHsvhN4myxkp2D/cmmAMSTkP+Vxk5QM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KY5PuvfxAi2tmRwwPCk8Ov8LwTl0bG9v0sGrdPqxDrP98cmctLDg/er9WgJafM+Z8fbG/A5yRWNhsrL4EmQw9e60//pLk80rkpIC6H00gJbvoz6hIKfXuuk9gNBZkEz0tuIU3BJ/aVG30Ro0rOJin0guulnxoB9mDXEiIMH/XDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OyYtT2hd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yrtrHuNy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49B6Bhfr003583;
	Fri, 11 Oct 2024 07:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mULc37Qg6E2m3wXGMjzTsfGYctQ+6mx8ncqVXHwfkK8=; b=
	OyYtT2hd2EaWlkW+0DxfK+Gs0fSvZOeVqZKydRphQa0dlNoSmDsYapPeQKyZzx15
	5RyGOTQuVMMA7PiUzb+JESobyXQkXOee69qJf9Hcy6UnjIh5Q7Mp2IAkhZ+oe0ei
	WRCWAoQ1rdi6l8n88bYeW17V0xd8ZMiQEXi/UV9CPuStzB4M3KMeoyi3rfb3j+gq
	IfzZNEKSGZKuzxfeHWPPyXtoAxpcwol0STzTWNgTLzIcbOiurHrG4QJ8Txtw7kkw
	g5SPSEFZRqmZgt+WXKU1Dq+VAtD+q4u1QPQlrZOD3FOgyCHNMeIpsiEx8L9G7ZW7
	AUbgbsJ2knBU/Xe8ISxSkA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422yyvccpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 07:26:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49B6WuDW017566;
	Fri, 11 Oct 2024 07:26:46 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwb3upg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 07:26:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lov/mfzuRgjanapA5FDgz2QzkcaKN7K1YWZ0MsjApDNgpaV6U/PusWeu8jeGe087hoDeZ9AKHdPH/9dSGH9uAWX18U0JVvfaxpCLwmfzoQ6+V+NgxTlAoZij0mhcptd8ev2U4jQrWMJ+C/s9cWZROFURJXRFplICBC4ATvi6omtnWxnisZQA2Ga4xLJnGVwkHP3FtPVjbvOLG+s3u5Mfyr4L7TeIXO2x7e7fnNTR1/pjmQGI6I9ioN1Ztqq2c3F+7W+W6TBUfIhiCrlYaXrxoSPPNH8APiqawOoQdG8jJ6LB/Scop90/pjLfZJJoNkGBLKTPYKqbYrWySeNLcENZ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mULc37Qg6E2m3wXGMjzTsfGYctQ+6mx8ncqVXHwfkK8=;
 b=skGj1VBWJ3sf34NCuphbFAsdYtE6kMYHfi3Kf847RqFGY6goFWxDU5QzBAhl6435Zc1U7OtKfi9bNne02n3Pnth1UnA/DbqTEet1P8jBrnPsMrsv0RQ1NzTwFH/i99kqKPAPjCeqUnqDAJth3kfWjVJGcIukT5W2fcnslVds1V+9EdCDIKSKOx7cN9E8PtVnLqOVP1JXwOmXI0NZMVXVFXnQc2KLooAay1xb5ILr3BBRQL04Z2pELPhy0J/YB1jCkR2jE94gAjNP1U5an9Uy090DEaoij9nBeo46bieRnI79C9Rhp3l7rwEH3VrVLQfwcrBHt9Ics2mhP/NL1W6L5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mULc37Qg6E2m3wXGMjzTsfGYctQ+6mx8ncqVXHwfkK8=;
 b=yrtrHuNyJBO0rfaIVpPxtZad9b9OoLPpiMliN4rOsnTdptHz/FlPSNFAEBh0DX1QPbB7CeGlS/lZJTowtPlmtQcUMGwgb8i9nisXdzsS1Y2RI3hKtah8w1qpIiT0Ca0aQ0waebBuixhcuOQATbdTyuTZCcQlZdQn4B1rvKcU6d8=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by LV8PR10MB7751.namprd10.prod.outlook.com (2603:10b6:408:1e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 07:26:41 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 07:26:41 +0000
Date: Fri, 11 Oct 2024 08:26:37 +0100
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
Message-ID: <fa645dd9-3835-4e1d-aa04-1892d97a6c86@lucifer.local>
References: <202409301043.629bea78-oliver.sang@intel.com>
 <77321196-5812-4e5b-be4c-20930e6f22bc@lucifer.local>
 <ZwTt/wB/mmszSXc3@xsang-OptiPlex-9020>
 <8f5e8ae0-dfaf-4b33-ae79-ca6065dc96ec@lucifer.local>
 <ZwYmTnWEhgWO702t@xsang-OptiPlex-9020>
 <5b7227fa-d0f1-452e-b1b3-9d7b87641522@lucifer.local>
 <ZwiRdemGMY6Z6pSN@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwiRdemGMY6Z6pSN@xsang-OptiPlex-9020>
X-ClientProxiedBy: LO4P302CA0043.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::16) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|LV8PR10MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: 925d613d-d60e-4c69-faf3-08dce9c60d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2Vqekg5aW8rVzJldFFicWRIanNOQ3Y4cXdpMytSb21JTWo0enFJbEtZS2dq?=
 =?utf-8?B?bFUxcEhKNFlKd3JWZ2FvRGc1SlZIK3IrUXQyWW9zRkV6amhEbkJjWkRlTjhR?=
 =?utf-8?B?Tk1RMStwSVlVa1ZORFE2RHpuemtxNEtkQ1cxdlpwRlhDN0JFZXZiRk1oRzNo?=
 =?utf-8?B?em9TZS9mRHdxWnEzWjUzQmFKQjhzNEhmSUphLzd3d1E0eEozZ25zQ0V4WEF5?=
 =?utf-8?B?K3BSU2JreEUrKzAyQStCZXVPRXNZNE9SbGxwV21BS3ptMjBvQVNVcXQrbDBF?=
 =?utf-8?B?bmg4RzhzYm9NYmw0OGpidURRZGh0NHViWElzSHozc21uZm1mVlpjRVZhNm5B?=
 =?utf-8?B?WVZGNGU4UTl6bUdxMWFISkZwd2lUbE55YXR4NWdoUzE3RE5nd0x4TDB4OHBq?=
 =?utf-8?B?S2RDeitLV2Z2YTg3QXNXVG0zV0VYdk13V2lkUktmZFhPRVB0eHVCWUVWM2s1?=
 =?utf-8?B?RUJQZ2VhSHI5U3p1SXpFLzlzeXhwQ1d1L2FQRzFhYXBkRWtwUDJBTDhoVDJC?=
 =?utf-8?B?NldHL2p4TjU0bTQ2dVJXM1o1RFR3YVo1NUp2ZWIvYnozNzRrbWxtcExwQ3Jo?=
 =?utf-8?B?UkJEclRqZVV5WTMzTk94ZjhsZTdZckkrY2xIeVVOMTYyNkRReEYyMUNOZUh4?=
 =?utf-8?B?bjBjRFp0emFxVmV5UXN6blJIMXU3aWVXcjJNcnpzaG0xZ3ZCR1J2em1yOUZW?=
 =?utf-8?B?YWpVd2RRSE02ZGZKRWF6R1pJbjhBVzkzUnZockxhaVNZSlcySkZkNGNLYmlu?=
 =?utf-8?B?NDNZWU9QSHQ1QnErTXllN3J4ZXpGN20xV082VElCcHR4bGRYeFZwS3JxdHl0?=
 =?utf-8?B?RllKNFBIWUFreGtqQUp2SzF1MEp2TDhKOFM5Y2JuWTl3TXp5aXhldnZEdWxX?=
 =?utf-8?B?dnhzVU9hS0NSWjlFenl5ZmNQRnozZ213b2dMaTNEdi8yZ0RLOWdvZGJVRGdK?=
 =?utf-8?B?cGxuaC9BNUVweHJlYkVsRDQ5ZUd1NWkrM1lRc0tGSXVNVVRTNjdmckplbFJu?=
 =?utf-8?B?SXo5M09FVFJCc0laNjNTSXVaZnNuSDhPWlAwOFpGY00xdE1qSWFJdU9SUUtO?=
 =?utf-8?B?cVVzUzZCQzBnYldrM2xlbkk5WGRudzUxdGhsamNacG1CcXMxQXFaa25vZnFE?=
 =?utf-8?B?VGxSMjRHblY4bEw3YkJRM2FhYWxVaUV6ZmJnQ3ZBSEJjWFZCamlKK0Y5WGxO?=
 =?utf-8?B?d2JxcTgveFNRbVhCQ0I4YWwzYXpUekpiTUxsTnF6bHB4bWF2UlBiNUFyMER2?=
 =?utf-8?B?c3RKY0hTcmNFWk1VcnFTYW9id1V5MVdTRks2SExuRFNlVXY4aURhT1NOb2ZG?=
 =?utf-8?B?S1RwU29EdjVadnk2djdrTjIxcGlBdjFReEFEYUlQRlcyZTY5WmNCME9rU29o?=
 =?utf-8?B?ejIwUTJsMmN0czh6WkYzWWJibzZDUk9nd3Q0L1gyTXFxdWpYL0dYaHhRd0hv?=
 =?utf-8?B?SWVZd1BubHMrZzR3S01lSGpLRjYyeG5ON2FaS3FDcnZ6aUNIYXcvdFhCUHBG?=
 =?utf-8?B?V3B2TEFmK2JxeVpXYmlERjdqTnBKS3cvNlBCSEVNUHdELzNpSVFZU2pPeDFh?=
 =?utf-8?B?d1hwUXhReG1qU1hyaGpWd0hPam80aS8xVnQyaDBWeTVUUXMxNklpV0svaEMy?=
 =?utf-8?B?d1V0YzR3WjcwZUFvS1p3QnVqNGtHVVB5S0NMMmUweVU1UFhVdERBdzNrb212?=
 =?utf-8?B?dngzaUdMa3dTMktmdktjNmlZUXdNdE5paFpSNXBMOFZ1UG1NVzNMallnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTUzTU94UzJHOW42NnhjQTdGYVNFSGxYL0RUWnNBUFlpdldYTjVCdjZoamxT?=
 =?utf-8?B?L08xL3huVU5Dc2o1M2NhSGQ3MWpycmZCQmpwRy81cElzZ1Z6cGx4VHNVanVz?=
 =?utf-8?B?OG5wcTViWmlZMnB2YTRLZlpjbUp1K3UrdlJIamZzNlgwVjV2bU95c0cwNENN?=
 =?utf-8?B?dVI0R2RQbjBNeVJSaUhnRHNwbjVrRkRoNkpQZGpSM2RBc2V6a0EvdEtudHdQ?=
 =?utf-8?B?UzV3aWV6d3REd1RaUDdzUURRc1VJbUVKaDRrMXRsNlNKWkdtdGJnc1JmVFRD?=
 =?utf-8?B?QzhFYlFObW5LVm1Uc3ArNkFwRUhhRGtxM01Db21wc1dBNmFtU0s4ZmI1czd5?=
 =?utf-8?B?RDM5Y0IxdjJKc2RySGFZZnpMLzIyVHFpM1hsYTJCTXN1R3Y2QUNVQTJrbkQy?=
 =?utf-8?B?QjAwa25ScGl6SW5KNE9oYXFuWkxIM2thY0pJYjF4elVnRHhqTkRpakI2SDVI?=
 =?utf-8?B?dDFkMldxYWRra09wM0FFOFlWbEZncFBtSHloTHNOYkJLYU9UUDVPS2Fzc3JF?=
 =?utf-8?B?RUp5dWxSTCsyTmtjVDQ5S2Z1T2haR2xQenN2d0VGQ1UrUHZDWS83SE5BUnNS?=
 =?utf-8?B?UEFSYUlQeVhwUUswdCtHbnZSVzV5cU1wWmR1cmVsR3FheG1tM0xCSWpUeHYy?=
 =?utf-8?B?VElKMFh2ejRjdlFQYXRockRkOENMS0l4T2hGUy9vb0d2bDV4TS9aYjZJeTZN?=
 =?utf-8?B?bXl2aDRYYmQzS0hDZm5MVm1oUXNHK3ZtMHcrZmVUTFlLNjBWUVk0c01mSEJM?=
 =?utf-8?B?M3VxUGpnSWJpNzhuZlBnUFJhVUVRN3g1a0svbXVRWEQ0dnY5Z29WRDhsUHht?=
 =?utf-8?B?VlRMWmRaUHdieDBScjdTNHNrd3p5bW5Od05LSFVVYlZmYW10YndsOHNqeXdZ?=
 =?utf-8?B?S1dNY1VLeFNqbWJOY01MZXI2akdnRjErNEFGRFUwSDBCQjlWMk9BcUNtcmNB?=
 =?utf-8?B?Zm1PcWg4RzFyUUU0b3RzK0xIRHFVMmJrbTU5UzYyLy8yYWJjQlorM2o3MUZV?=
 =?utf-8?B?b0pTaFV6ZkVyeERZSk0rRXhkNWdzQUlaT2lSRFVEcUFXWGhaYm1KcTE1SDJv?=
 =?utf-8?B?QjFFOEtQMlBZMlNUSUU0Z3JucVNlWU8yNTJ2WlpuVDVqQVdKdm10TGVsQ3Js?=
 =?utf-8?B?U0tNT0FJZXU5SUNESlpnWjBNcy9NL1owYkxvVHFOeWhtWU9mWHA1UTVzN202?=
 =?utf-8?B?L3AwMzJXN1NEM3RBU2J1QkU3SW40bGNRaWlhektCWDJHaExqUGRYSGdOb1Q5?=
 =?utf-8?B?WVloY0ZWRDcrcXlSWlRTY2tGUDNDL1VEWDV6SUVXN1RqeHpNUGxRcDQ4SU5H?=
 =?utf-8?B?MUpTL0dLM0xTM0VubzZFQmVkRUFkSlpSK3BaL2svdjI5Um9tM1RtRzNLZUFr?=
 =?utf-8?B?dTdtNDNkaWhubUFyajJ6ekdMQzVydjJmaFY2TjRLc2VBRTIyU2I0S3hncFAy?=
 =?utf-8?B?K3ljdnFrWWxDYjA4Z1Fta0NaRVB1SjdPY0RSU2MwTG5yeTc5eUNNMmhYcy9F?=
 =?utf-8?B?UUh4bTNSeEt4OGFxZjEyV29CMXVLWVhYZW5GZkJCMUlidGpydk9EMnQvN1hp?=
 =?utf-8?B?Vng4UXZHbGJMNi9saUhHbXYvT21jUUo4Z2RYcTF3TXJiQVgrbXk1SE56bmJk?=
 =?utf-8?B?UDVSNW9ieWpuTjlST3JGcTBxYi8vbGpsVnZUSkZjdFZJTUNaSytBazZCNTlP?=
 =?utf-8?B?dHp3eUVnZkJ5aHhOL0RZN1A2WGVMQllSVEZyYWdvQzBsT051QzFZM0oxc2Ry?=
 =?utf-8?B?dUFWSjhvaWhtcTgrWVBOaEE0Q3Z4dVZERmwzaG13anZlMm9Xa0hzOGoxZXFt?=
 =?utf-8?B?U0xFMjRrVFp1QW9wdWdQNDFXUC9BU0loNCtZQjIwaDRBRTRYQ0EveEwzMVhq?=
 =?utf-8?B?YVFlU3lBOFdHNzlWSUZ3NG9rMURWbDBUU2poclRyMStBWkxEblhZeTNzMVNm?=
 =?utf-8?B?ZE41eWpQZGJyNEd3TmV5QUMyaDYrV3g0cUZtZURjS3phTTFnOEZnRllEeUFW?=
 =?utf-8?B?bC9IcHpDNHVQUVMyZm1oU2c3RUs1bFhDNVZ3dHZYREY3Tkwrc2dacjA3dVo0?=
 =?utf-8?B?d2VQNm8xakZDS3Z4MmlVZHFNYWttMTl2dE1kWXVQM3JMV294TkZXVXU0MXBN?=
 =?utf-8?B?VGY5YitjNURjUU8vVXMxVlV0Ui9nMTkvWFFnMHZiZDQ0SXRTQm1DeWVhQWFB?=
 =?utf-8?B?YnFBYkIrS3FaSnpGamFndkE2dkYyaWg4RTFHdmNKNjhSZnRRZlM4TzlveEJD?=
 =?utf-8?B?a0lobndWRERGeTRyZTVXRmZndmt3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6WXIccL4gXblHqRNVI5H5Bq081rufaDfNC6RafDe/+YDVr5WpdwPB2oHlOwNleqtqPRUYAOifmPKZB/0U/4sKrPd0/K01GjfV2KvUGypRRhfpXEAWh9ivekVw8QwqbbglAczDCUzBXW8bmLF9KlQPV0ixNxrOGrl6WQdTh5XNM0TDRCNk7bZAVfmUJbhbqosAqY6rQfVU7efqqVSLp3hePNw2xhuniSIWZrE6QpmNZKqXAFHMwPKTsZmKIvkT/ohNO3MY6KIG6b4RyLuePvVhgD9qVWDAsK2kfQxcrPRUzm0yx4YAP8tjOEr1jYhYrpI/V7jyu51eeIkgXtyjbgnMf5SJZNBE8JmduScC9cdckcLRwDdDnfpdFgn29YjyF3s1ETpajj2esqoyKZ4nluBpObtgU4ibyv8zoPqZr5QPevq/ZfI2YNQ2Sx8BUMoWFtM8y54Jm3SSQC3gd0cbDTjXBqMpKxu1BlQ0VfGYP3rB1i6yqc6D/mmGhwMvRAbMAayiyhy+M8RN+7bydLffQPjtSt4wUq/0sNffjorGi17fM1tIcFskzQar1V5TKsZqLlq5z9c4ZawJLnGhznQN3NgBAckzSgbxsrujkuwFWJVA9k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925d613d-d60e-4c69-faf3-08dce9c60d0c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 07:26:41.5424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VC8zsa9LAdLca/uW6nuig+SR7qFlOnjXeInVa29m+xRBlLny1nUr7S1j4XBLhKFqBi4u/fXH9hrUZBn1IfbuhrXkDhEDq3hOr2PTy5m21Tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7751
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_05,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110048
X-Proofpoint-GUID: kcqG-Seeo0KBBnf4xvu5A1FG-Zo_OWKL
X-Proofpoint-ORIG-GUID: kcqG-Seeo0KBBnf4xvu5A1FG-Zo_OWKL

On Fri, Oct 11, 2024 at 10:46:13AM +0800, Oliver Sang wrote:
> hi, Lorenzo,
>
> On Wed, Oct 09, 2024 at 10:24:58PM +0100, Lorenzo Stoakes wrote:
> > On Wed, Oct 09, 2024 at 02:44:30PM +0800, Oliver Sang wrote:
> > [snip]
> > > >
> > > > I will look into this now, if I provide patches would you be able to test
> > > > them using the same boxes? It'd be much appreciated!
> > >
> > > sure! that's our pleasure!
> > >
> >
> > Hi Oliver,
> >
> > Thanks so much for this, could you give the below a try? I've not tried to
> > seriously test it locally yet, so it'd be good to set your test machines on
> > it.
> >
> > If this doesn't help it suggests call stack/branching might be a thing here
> > in which case I have other approaches I can take before we have to
> > duplicate this code.
> >
> > This patch is against the mm-unstable branch in Andrew's tree [0] but
> > hopefully should apply fine to Linus's too.
> >
> > [0]:https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/
> >
> > Thanks again!
>
> you are welcome!
>
> I found the patch could be applied directly on cacded5e42, so I did it.
> this is our normal practice that we want to avoid impacts from other commits.
>
> but if your patch should reply on some new patches in mm-unstable or mainline,
> please let me know. I could reapply and retest.
>
> I mentioned patch base since I found by my applyment upon cacded5e42, your
> patch seems not have obvious performance impact, still have similar regression.
>
> for brief, I just list 2 examples here. all tests and full data are attached
> as fc21959f74bc11-cacded5e42b960-2e71337ac26478

Thanks for testing this suffices to rule this one out... I will try to get a
functional and reliable performance environment locally so I can properly
address this and then we can try something else.

Thanks!
Lorenzo

>
> (1)
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
> commit:
>   fc21959f74bc11 ("mm: abstract vma_expand() to use vma_merge_struct")
>   cacded5e42b960 ("mm: avoid using vma_merge() for new VMAs")
>   2e71337ac26478 ("mm: explicitly enable an expand-only merge mode for brk()")
>
> fc21959f74bc1138 cacded5e42b9609b07b22d80c10 2e71337ac2647889d3d9d76a5ce
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>    3540976            -6.4%    3314159            -6.7%    3302864        aim9.brk_test.ops_per_sec
>
>
> (2) which is using same Ivy Bridge-EP in our original report
> (test machine: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory)
>
> =========================================================================================
> compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
>   gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-ivb-2ep2/brk_test/aim9/300s
>
> commit:
>   fc21959f74bc11 ("mm: abstract vma_expand() to use vma_merge_struct")
>   cacded5e42b960 ("mm: avoid using vma_merge() for new VMAs")
>   2e71337ac26478 ("mm: explicitly enable an expand-only merge mode for brk()")
>
> fc21959f74bc1138 cacded5e42b9609b07b22d80c10 2e71337ac2647889d3d9d76a5ce
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>    1322908            -5.0%    1256536            -4.1%    1268145        aim9.brk_test.ops_per_sec
>
> >
> > Best, Lorenzo
> >
> >
> > ----8<----
> > From 7eb4aa421b357668bc44405c58b0444abf44334a Mon Sep 17 00:00:00 2001
> > From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Date: Wed, 9 Oct 2024 21:57:03 +0100
> > Subject: [PATCH] mm: explicitly enable an expand-only merge mode for brk()
> >
> > Try to do less work on brk() to improve perf.
> > ---
> >  mm/mmap.c |  1 +
> >  mm/vma.c  | 25 ++++++++++++++++---------
> >  mm/vma.h  | 11 +++++++++++
> >  3 files changed, 28 insertions(+), 9 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 02f7b45c3076..c2c68ef45a3b 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1740,6 +1740,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  	if (vma && vma->vm_end == addr) {
> >  		VMG_STATE(vmg, mm, vmi, addr, addr + len, flags, PHYS_PFN(addr));
> >
> > +		vmg.mode = VMA_MERGE_MODE_EXPAND_ONLY;
> >  		vmg.prev = vma;
> >  		vma_iter_next_range(vmi);
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 749c4881fd60..f525a0750c41 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -561,6 +561,7 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
> >  	unsigned long end = vmg->end;
> >  	pgoff_t pgoff = vmg->pgoff;
> >  	pgoff_t pglen = PHYS_PFN(end - start);
> > +	bool expand_only = vmg_mode_expand_only(vmg);
> >  	bool can_merge_left, can_merge_right;
> >
> >  	mmap_assert_write_locked(vmg->mm);
> > @@ -575,7 +576,7 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
> >  		return NULL;
> >
> >  	can_merge_left = can_vma_merge_left(vmg);
> > -	can_merge_right = can_vma_merge_right(vmg, can_merge_left);
> > +	can_merge_right = !expand_only && can_vma_merge_right(vmg, can_merge_left);
> >
> >  	/* If we can merge with the next VMA, adjust vmg accordingly. */
> >  	if (can_merge_right) {
> > @@ -603,13 +604,18 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
> >  		return vmg->vma;
> >  	}
> >
> > -	/* If expansion failed, reset state. Allows us to retry merge later. */
> > -	vmg->vma = NULL;
> > -	vmg->start = start;
> > -	vmg->end = end;
> > -	vmg->pgoff = pgoff;
> > -	if (vmg->vma == prev)
> > -		vma_iter_set(vmg->vmi, start);
> > +	/*
> > +	 * Unless in expand only case and expansion failed, reset state.
> > +	 * Allows us to retry merge later.
> > +	 */
> > +	if (!expand_only) {
> > +		vmg->vma = NULL;
> > +		vmg->start = start;
> > +		vmg->end = end;
> > +		vmg->pgoff = pgoff;
> > +		if (vmg->vma == prev)
> > +			vma_iter_set(vmg->vmi, start);
> > +	}
> >
> >  	return NULL;
> >  }
> > @@ -641,7 +647,8 @@ int vma_expand(struct vma_merge_struct *vmg)
> >  	mmap_assert_write_locked(vmg->mm);
> >
> >  	vma_start_write(vma);
> > -	if (next && (vma != next) && (vmg->end == next->vm_end)) {
> > +	if (!vmg_mode_expand_only(vmg) && next &&
> > +	    (vma != next) && (vmg->end == next->vm_end)) {
> >  		int ret;
> >
> >  		remove_next = true;
> > diff --git a/mm/vma.h b/mm/vma.h
> > index 82354fe5edd0..14224b36a979 100644
> > --- a/mm/vma.h
> > +++ b/mm/vma.h
> > @@ -52,6 +52,11 @@ struct vma_munmap_struct {
> >  	unsigned long data_vm;
> >  };
> >
> > +enum vma_merge_mode {
> > +	VMA_MERGE_MODE_NORMAL,
> > +	VMA_MERGE_MODE_EXPAND_ONLY,
> > +};
> > +
> >  enum vma_merge_state {
> >  	VMA_MERGE_START,
> >  	VMA_MERGE_ERROR_NOMEM,
> > @@ -75,9 +80,15 @@ struct vma_merge_struct {
> >  	struct mempolicy *policy;
> >  	struct vm_userfaultfd_ctx uffd_ctx;
> >  	struct anon_vma_name *anon_name;
> > +	enum vma_merge_mode mode;
> >  	enum vma_merge_state state;
> >  };
> >
> > +static inline bool vmg_mode_expand_only(struct vma_merge_struct *vmg)
> > +{
> > +	return vmg->mode == VMA_MERGE_MODE_EXPAND_ONLY;
> > +}
> > +
> >  static inline bool vmg_nomem(struct vma_merge_struct *vmg)
> >  {
> >  	return vmg->state == VMA_MERGE_ERROR_NOMEM;
> > --
> > 2.46.2

> =========================================================================================
> compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
>   gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-gnr-1ap1/brk_test/aim9/300s
>
> commit:
>   fc21959f74bc11 ("mm: abstract vma_expand() to use vma_merge_struct")
>   cacded5e42b960 ("mm: avoid using vma_merge() for new VMAs")
>   2e71337ac26478 ("mm: explicitly enable an expand-only merge mode for brk()")
>
> fc21959f74bc1138 cacded5e42b9609b07b22d80c10 2e71337ac2647889d3d9d76a5ce
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>    3220697            -6.0%    3028867            -6.4%    3014713        aim9.brk_test.ops_per_sec
>      24.58            -3.9%      23.63            -5.5%      23.24        time.user_time
>     119459            -3.2%     115601            -2.9%     115971        proc-vmstat.nr_active_anon
>     120943            -3.2%     117079            -2.9%     117450        proc-vmstat.nr_shmem
>     119459            -3.2%     115601            -2.9%     115971        proc-vmstat.nr_zone_active_anon
>       0.02 �120%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
>       3.27 �  5%   +5112.4%     170.40 �218%   +5144.5%     171.45 �216%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
>       0.20 �188%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.01 � 70%    +100.0%       0.01 � 84%   +3512.9%       0.19 �199%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
>       0.93 � 16%      -4.1%       0.89 � 14%     -25.0%       0.70 � 11%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>       0.02 �120%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.20 �188%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.01 � 70%    +100.0%       0.01 � 84%   +3512.9%       0.19 �199%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
>       0.02 �  2%      -4.1%       0.02 �  2%      -6.3%       0.02 �  4%  perf-stat.i.MPKI
>  1.767e+09            +4.2%  1.841e+09            +3.7%  1.833e+09        perf-stat.i.branch-instructions
>       0.45            -6.2%       0.42            -5.9%       0.42        perf-stat.i.cpi
>  8.347e+09            +6.6%    8.9e+09            +6.2%  8.863e+09        perf-stat.i.instructions
>       2.27            +6.6%       2.42            +6.0%       2.41        perf-stat.i.ipc
>       0.03 �  4%      -2.0%       0.03 �  3%      -7.8%       0.03 �  4%  perf-stat.overall.MPKI
>       0.44            -5.9%       0.42            -5.4%       0.42        perf-stat.overall.cpi
>       2.25            +6.2%       2.39            +5.7%       2.38        perf-stat.overall.ipc
>  1.761e+09            +4.2%  1.834e+09            +3.7%  1.827e+09        perf-stat.ps.branch-instructions
>  8.319e+09            +6.6%   8.87e+09            +6.2%  8.834e+09        perf-stat.ps.instructions
>  2.519e+12            +6.4%   2.68e+12            +5.8%  2.665e+12        perf-stat.total.instructions
>       7.07            -7.1        0.00            -7.1        0.00        perf-profile.calltrace.cycles-pp.mas_store_prealloc.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       6.30            -6.3        0.00            -6.3        0.00        perf-profile.calltrace.cycles-pp.mas_preallocate.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      18.35            -1.0       17.36            -1.4       16.92        perf-profile.calltrace.cycles-pp.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      16.40            -0.9       15.47            -1.3       15.05        perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64
>      10.17            -0.8        9.36            -1.2        8.93        perf-profile.calltrace.cycles-pp.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.do_brk_flags
>      11.92            -0.8       11.12            -1.3       10.64        perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk
>       5.07 �  3%      -0.2        4.84 �  2%      -0.2        4.88 �  3%  perf-profile.calltrace.cycles-pp.__get_unmapped_area.check_brk_limits.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       5.40 �  3%      -0.2        5.18 �  2%      -0.1        5.28 �  3%  perf-profile.calltrace.cycles-pp.check_brk_limits.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>       3.66 �  2%      -0.2        3.50 �  2%      -0.1        3.52 �  3%  perf-profile.calltrace.cycles-pp.thp_get_unmapped_area_vmflags.__get_unmapped_area.check_brk_limits.__do_sys_brk.do_syscall_64
>       0.60 �  5%      -0.1        0.46 � 45%      -0.2        0.36 � 70%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.brk
>       1.66 �  2%      -0.1        1.56 �  3%      -0.1        1.60 �  2%  perf-profile.calltrace.cycles-pp.up_write.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>       0.68 �  3%      -0.1        0.60 �  5%      -0.1        0.60 �  5%  perf-profile.calltrace.cycles-pp.kfree.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk
>       5.91 �  2%      -0.1        5.85            -0.4        5.49        perf-profile.calltrace.cycles-pp.mas_find.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>       0.97 �  4%      -0.1        0.91 �  4%      -0.1        0.91 �  3%  perf-profile.calltrace.cycles-pp.mas_next_slot.mas_find.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       4.23 �  2%      -0.0        4.21            -0.4        3.82        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.37 � 70%      +0.3        0.67 �  4%      +0.2        0.57 � 44%  perf-profile.calltrace.cycles-pp.strlen.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk
>       0.00            +0.5        0.47 � 44%      +0.6        0.58 �  5%  perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags
>       0.49 � 44%      +0.5        1.02 �  5%      +0.5        1.02 �  8%  perf-profile.calltrace.cycles-pp.__vm_enough_memory.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      83.74            +0.5       84.28            +0.6       84.32        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>       0.00            +0.6        0.60 �  6%      +0.6        0.58 �  7%  perf-profile.calltrace.cycles-pp.mas_next_range.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00            +0.7        0.65 �  7%      +0.7        0.66 �  4%  perf-profile.calltrace.cycles-pp.mas_wr_slot_store.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags
>       0.00            +0.7        0.68 �  4%      +0.7        0.67 �  8%  perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.__vm_enough_memory.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.00            +0.7        0.68 �  2%      +0.8        0.80 �  4%  perf-profile.calltrace.cycles-pp.mas_next_slot.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      80.24            +0.7       80.95            +0.7       80.98        perf-profile.calltrace.cycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>       0.00            +0.7        0.74 �  2%      +0.8        0.76 �  2%  perf-profile.calltrace.cycles-pp.vma_adjust_trans_huge.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +0.8        0.75 �  4%      +0.8        0.81 �  5%  perf-profile.calltrace.cycles-pp.can_vma_merge_after.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.00            +0.8        0.81 �  3%      +0.7        0.69 �  7%  perf-profile.calltrace.cycles-pp.mas_prev.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.00            +0.8        0.84 �  5%      +0.8        0.84 �  6%  perf-profile.calltrace.cycles-pp.__anon_vma_interval_tree_remove.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags
>       0.00            +1.3        1.30 �  5%      +1.3        1.32 �  2%  perf-profile.calltrace.cycles-pp.mas_prev_slot.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.00            +1.4        1.35 �  4%      +1.3        1.32 �  4%  perf-profile.calltrace.cycles-pp.up_write.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +1.6        1.60 �  4%      +1.6        1.56 �  4%  perf-profile.calltrace.cycles-pp.up_write.vma_complete.vma_expand.vma_merge_new_range.do_brk_flags
>       0.00            +1.8        1.76 �  2%      +1.9        1.86 �  2%  perf-profile.calltrace.cycles-pp.mas_leaf_max_gap.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range
>       0.00            +1.8        1.78 �  2%      +1.6        1.64 �  4%  perf-profile.calltrace.cycles-pp.init_multi_vma_prep.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +2.0        2.03            +2.0        2.04 �  2%  perf-profile.calltrace.cycles-pp.down_write.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags
>       0.00            +2.1        2.06 �  3%      +2.1        2.06 �  4%  perf-profile.calltrace.cycles-pp.down_write.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +2.3        2.29 �  3%      +2.4        2.37 �  2%  perf-profile.calltrace.cycles-pp.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags
>      53.64            +2.6       56.21            +2.6       56.28        perf-profile.calltrace.cycles-pp.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>       0.00            +3.1        3.14 �  2%      +3.1        3.10 �  5%  perf-profile.calltrace.cycles-pp.vma_complete.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +3.2        3.25            +3.6        3.64 �  3%  perf-profile.calltrace.cycles-pp.mas_wr_store_type.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags
>       0.00            +3.8        3.84            +3.9        3.86 �  2%  perf-profile.calltrace.cycles-pp.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +5.3        5.31 �  2%      +5.7        5.67 �  2%  perf-profile.calltrace.cycles-pp.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +6.1        6.07            +6.4        6.41        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00           +27.7       27.74           +28.3       28.33        perf-profile.calltrace.cycles-pp.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.00           +32.4       32.43           +33.0       33.02        perf-profile.calltrace.cycles-pp.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      18.49            -1.0       17.47            -1.5       17.01        perf-profile.children.cycles-pp.perf_event_mmap
>       6.54            -1.0        5.54 �  2%      -0.7        5.90 �  2%  perf-profile.children.cycles-pp.mas_preallocate
>       7.40            -1.0        6.40 �  2%      -0.6        6.76        perf-profile.children.cycles-pp.mas_store_prealloc
>       5.68            -1.0        4.72            -1.0        4.66 �  3%  perf-profile.children.cycles-pp.up_write
>      16.88            -0.9       15.93            -1.4       15.51        perf-profile.children.cycles-pp.perf_event_mmap_event
>      10.35            -0.8        9.53            -1.2        9.10        perf-profile.children.cycles-pp.perf_event_mmap_output
>      12.16            -0.8       11.35            -1.3       10.86        perf-profile.children.cycles-pp.perf_iterate_sb
>       4.02 �  2%      -0.7        3.32            -0.3        3.72 �  3%  perf-profile.children.cycles-pp.mas_wr_store_type
>       2.97            -0.6        2.37 �  3%      -0.5        2.45 �  2%  perf-profile.children.cycles-pp.mas_update_gap
>       1.36 �  8%      -0.6        0.80 �  4%      -0.5        0.86 �  4%  perf-profile.children.cycles-pp.can_vma_merge_after
>       2.26 �  2%      -0.5        1.80 �  2%      -0.4        1.89 �  2%  perf-profile.children.cycles-pp.mas_leaf_max_gap
>       3.71 �  2%      -0.3        3.44            -0.3        3.42 �  4%  perf-profile.children.cycles-pp.vma_complete
>       5.62 �  3%      -0.2        5.40 �  2%      -0.1        5.51 �  3%  perf-profile.children.cycles-pp.check_brk_limits
>       3.83 �  2%      -0.2        3.65 �  2%      -0.2        3.67 �  3%  perf-profile.children.cycles-pp.thp_get_unmapped_area_vmflags
>       0.66 �  7%      -0.1        0.55 �  9%      -0.1        0.54 �  6%  perf-profile.children.cycles-pp.may_expand_vm
>       1.98 �  3%      -0.1        1.86 �  2%      -0.3        1.71 �  4%  perf-profile.children.cycles-pp.init_multi_vma_prep
>       0.78 �  3%      -0.1        0.69 �  4%      -0.1        0.69 �  5%  perf-profile.children.cycles-pp.kfree
>       0.15 � 12%      -0.1        0.08 � 13%      -0.1        0.07 � 23%  perf-profile.children.cycles-pp.arch_vma_name
>       6.23 �  2%      -0.1        6.17            -0.4        5.78        perf-profile.children.cycles-pp.mas_find
>       0.60 �  6%      -0.1        0.54 �  8%      -0.1        0.51 �  7%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
>       4.32 �  2%      -0.0        4.30            -0.4        3.92        perf-profile.children.cycles-pp.mas_walk
>       0.20 �  8%      -0.0        0.17 �  7%      -0.0        0.15 � 14%  perf-profile.children.cycles-pp.__x64_sys_brk
>       0.26 �  5%      -0.0        0.24 �  9%      -0.0        0.22 �  9%  perf-profile.children.cycles-pp.__rb_insert_augmented
>       0.23 �  7%      +0.0        0.24 � 18%      +0.0        0.27 �  6%  perf-profile.children.cycles-pp.hrtimer_interrupt
>       0.24 �  7%      +0.0        0.24 � 18%      +0.0        0.27 �  5%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>       0.58 �  7%      +0.1        0.66 �  7%      +0.1        0.67 �  2%  perf-profile.children.cycles-pp.mas_wr_slot_store
>       0.19 � 10%      +0.1        0.31 � 10%      +0.1        0.32 � 16%  perf-profile.children.cycles-pp.rb_next
>       0.50 �  4%      +0.1        0.62 �  7%      +0.2        0.66 �  7%  perf-profile.children.cycles-pp.mas_wr_store_entry
>       0.40 �  6%      +0.1        0.53 �  6%      +0.1        0.54 �  6%  perf-profile.children.cycles-pp.strnlen
>       0.58 � 13%      +0.2        0.75 �  4%      +0.1        0.72 � 13%  perf-profile.children.cycles-pp.strlen
>       0.96 �  6%      +0.2        1.14 �  3%      +0.2        1.16 �  3%  perf-profile.children.cycles-pp.rcu_all_qs
>       0.68 �  3%      +0.3        0.98 �  5%      +0.3        1.01 �  6%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
>       1.77 �  4%      +0.3        2.09            +0.3        2.08 �  4%  perf-profile.children.cycles-pp.__cond_resched
>       0.00            +0.4        0.36 �  9%      +0.4        0.36 �  8%  perf-profile.children.cycles-pp.mas_next_setup
>       0.36 �  8%      +0.4        0.76 �  3%      +0.4        0.76 �  9%  perf-profile.children.cycles-pp.percpu_counter_add_batch
>       0.48 �  7%      +0.4        0.90 �  6%      +0.4        0.86 �  4%  perf-profile.children.cycles-pp.mas_prev_setup
>      84.69            +0.5       85.19            +0.6       85.27        perf-profile.children.cycles-pp.do_syscall_64
>       0.67 �  9%      +0.6        1.24 �  4%      +0.6        1.27 �  7%  perf-profile.children.cycles-pp.__vm_enough_memory
>       3.81            +0.6        4.39            +0.6        4.40 �  3%  perf-profile.children.cycles-pp.down_write
>      80.98            +0.7       81.64            +0.7       81.71        perf-profile.children.cycles-pp.__do_sys_brk
>       1.05 �  4%      +0.7        1.72 �  3%      +0.8        1.82 �  3%  perf-profile.children.cycles-pp.mas_next_slot
>       0.00            +0.7        0.70 �  6%      +0.7        0.69 �  5%  perf-profile.children.cycles-pp.mas_next_range
>       1.11 �  4%      +1.0        2.10 �  3%      +0.8        1.92 �  3%  perf-profile.children.cycles-pp.mas_prev
>       2.82 �  3%      +1.2        4.07            +1.3        4.09 �  2%  perf-profile.children.cycles-pp.vma_prepare
>       1.54 �  4%      +1.3        2.88 �  3%      +1.3        2.84 �  3%  perf-profile.children.cycles-pp.mas_prev_slot
>      54.97            +1.6       56.61            +1.8       56.79        perf-profile.children.cycles-pp.do_brk_flags
>       0.00           +28.6       28.64           +29.2       29.16        perf-profile.children.cycles-pp.vma_expand
>       0.00           +32.9       32.91           +33.4       33.37        perf-profile.children.cycles-pp.vma_merge_new_range
>       5.90 �  2%      -3.5        2.37 �  4%      -3.4        2.55        perf-profile.self.cycles-pp.do_brk_flags
>       5.36 �  2%      -1.0        4.38            -1.0        4.36 �  3%  perf-profile.self.cycles-pp.up_write
>      10.18            -0.8        9.36            -1.2        8.94        perf-profile.self.cycles-pp.perf_event_mmap_output
>       3.86 �  2%      -0.7        3.18            -0.3        3.57 �  3%  perf-profile.self.cycles-pp.mas_wr_store_type
>       1.28 �  7%      -0.5        0.74 �  4%      -0.5        0.78 �  4%  perf-profile.self.cycles-pp.can_vma_merge_after
>       3.02 �  2%      -0.5        2.52 �  4%      -0.3        2.75 �  3%  perf-profile.self.cycles-pp.mas_store_prealloc
>       2.19 �  2%      -0.4        1.78 �  2%      -0.3        1.87 �  2%  perf-profile.self.cycles-pp.mas_leaf_max_gap
>       5.03            -0.4        4.67            -0.1        4.92 �  2%  perf-profile.self.cycles-pp.__do_sys_brk
>       2.60 �  4%      -0.3        2.27 �  5%      -0.3        2.25 �  2%  perf-profile.self.cycles-pp.mas_preallocate
>       1.89 �  4%      -0.3        1.59 �  4%      -0.3        1.62 �  5%  perf-profile.self.cycles-pp.perf_event_mmap_event
>       1.71 �  4%      -0.2        1.53 �  3%      -0.2        1.50 �  5%  perf-profile.self.cycles-pp.entry_SYSCALL_64
>       0.74 �  3%      -0.2        0.57 �  7%      -0.2        0.56 �  6%  perf-profile.self.cycles-pp.mas_update_gap
>       1.89 �  4%      -0.2        1.73 �  2%      -0.3        1.62 �  4%  perf-profile.self.cycles-pp.init_multi_vma_prep
>       1.58 �  4%      -0.1        1.47 �  3%      -0.2        1.42 �  4%  perf-profile.self.cycles-pp.perf_event_mmap
>       1.27 �  2%      -0.1        1.16 �  2%      -0.1        1.19 �  9%  perf-profile.self.cycles-pp.vma_complete
>       1.20 �  2%      -0.1        1.12 �  4%      -0.1        1.08 �  2%  perf-profile.self.cycles-pp.do_syscall_64
>       0.69 �  2%      -0.1        0.61 �  4%      -0.1        0.60 �  5%  perf-profile.self.cycles-pp.kfree
>       0.60 �  6%      -0.1        0.54 �  8%      -0.1        0.51 �  7%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
>       1.60 �  2%      -0.1        1.56 �  6%      -0.1        1.55        perf-profile.self.cycles-pp.down_write_killable
>       4.24 �  2%      -0.0        4.20            -0.4        3.84        perf-profile.self.cycles-pp.mas_walk
>       0.50 �  7%      -0.0        0.47 �  9%      -0.1        0.45 �  5%  perf-profile.self.cycles-pp.may_expand_vm
>       0.42 �  4%      +0.1        0.49 �  7%      +0.1        0.53 �  6%  perf-profile.self.cycles-pp.mas_wr_store_entry
>       0.15 � 10%      +0.1        0.24 � 11%      +0.1        0.23 � 19%  perf-profile.self.cycles-pp.rb_next
>       0.58 �  8%      +0.1        0.68 �  5%      +0.1        0.71 �  6%  perf-profile.self.cycles-pp.rcu_all_qs
>       0.37 �  5%      +0.1        0.50 �  7%      +0.1        0.50 �  4%  perf-profile.self.cycles-pp.strnlen
>       0.54 � 13%      +0.2        0.68 �  4%      +0.1        0.64 � 14%  perf-profile.self.cycles-pp.strlen
>       1.01 �  6%      +0.2        1.17 �  2%      +0.1        1.11 �  4%  perf-profile.self.cycles-pp.__cond_resched
>       0.66 �  6%      +0.2        0.83 �  2%      +0.2        0.84 �  3%  perf-profile.self.cycles-pp.vma_prepare
>       0.46 �  6%      +0.2        0.67 �  7%      +0.2        0.70 �  5%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
>       0.34 � 12%      +0.2        0.54 �  3%      +0.2        0.58 �  9%  perf-profile.self.cycles-pp.__vm_enough_memory
>       0.00            +0.3        0.29 � 10%      +0.3        0.28 � 11%  perf-profile.self.cycles-pp.mas_next_setup
>       0.32 � 11%      +0.3        0.62 �  7%      +0.3        0.58 �  8%  perf-profile.self.cycles-pp.mas_prev_setup
>       0.23 �  7%      +0.3        0.55 �  6%      +0.3        0.55 � 10%  perf-profile.self.cycles-pp.percpu_counter_add_batch
>       0.00            +0.4        0.35 �  7%      +0.3        0.30 �  7%  perf-profile.self.cycles-pp.mas_next_range
>       2.65 �  3%      +0.4        3.00 �  2%      +0.4        3.05 �  2%  perf-profile.self.cycles-pp.down_write
>       0.64 �  5%      +0.6        1.21 �  3%      +0.5        1.12 �  5%  perf-profile.self.cycles-pp.mas_prev
>       0.89 �  5%      +0.7        1.54 �  3%      +0.8        1.64 �  4%  perf-profile.self.cycles-pp.mas_next_slot
>       1.46 �  4%      +1.3        2.72 �  3%      +1.2        2.70 �  3%  perf-profile.self.cycles-pp.mas_prev_slot
>       0.00            +1.3        1.33 �  2%      +1.2        1.16 �  4%  perf-profile.self.cycles-pp.vma_merge_new_range
>       0.00            +3.5        3.54 �  3%      +3.6        3.55 �  2%  perf-profile.self.cycles-pp.vma_expand
>
> =========================================================================================
> compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
>   gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-emr-2sp1/brk_test/aim9/300s
>
> commit:
>   fc21959f74bc11 ("mm: abstract vma_expand() to use vma_merge_struct")
>   cacded5e42b960 ("mm: avoid using vma_merge() for new VMAs")
>   2e71337ac26478 ("mm: explicitly enable an expand-only merge mode for brk()")
>
> fc21959f74bc1138 cacded5e42b9609b07b22d80c10 2e71337ac2647889d3d9d76a5ce
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>    3669298            -6.5%    3430070            -6.8%    3420919        aim9.brk_test.ops_per_sec
>      23.53            -4.9%      22.38            -6.4%      22.03        time.user_time
>     491107 �  5%      -7.2%     455906 �  6%      -5.5%     464283 �  6%  meminfo.Active
>     491011 �  5%      -7.2%     455810 �  6%      -5.5%     464155 �  6%  meminfo.Active(anon)
>     505666 �  5%      -7.0%     470410 �  5%      -5.3%     478879 �  6%  meminfo.Shmem
>     122753 �  5%      -7.1%     113979 �  6%      -5.5%     116019 �  6%  proc-vmstat.nr_active_anon
>     899298            -1.0%     890515            -0.7%     892592        proc-vmstat.nr_file_pages
>     126417 �  5%      -6.9%     117634 �  5%      -5.3%     119701 �  6%  proc-vmstat.nr_shmem
>     122753 �  5%      -7.1%     113979 �  6%      -5.5%     116019 �  6%  proc-vmstat.nr_zone_active_anon
>     595.50 � 22%     +53.6%     914.50 � 12%     +17.1%     697.33 � 20%  proc-vmstat.numa_hint_faults_local
>      17958            -4.3%      17188 �  2%      -4.3%      17180 �  2%  proc-vmstat.pgactivate
>    1817569 � 69%     -43.1%    1035076 �127%     +63.5%    2972153 �  3%  numa-meminfo.node0.FilePages
>      16515 � 73%     -29.4%      11657 �108%     +79.5%      29650        numa-meminfo.node0.Mapped
>    1811617 � 69%     -43.2%    1029482 �128%     +63.8%    2967951 �  3%  numa-meminfo.node0.Unevictable
>      40474 � 40%     -61.8%      15444 � 40%     -50.4%      20065 � 59%  numa-meminfo.node1.KReclaimable
>      40474 � 40%     -61.8%      15444 � 40%     -50.4%      20065 � 59%  numa-meminfo.node1.SReclaimable
>     484115 �  6%      -7.3%     448760 �  6%     -10.1%     435387 � 11%  numa-meminfo.node3.Active
>     484083 �  6%      -7.3%     448760 �  6%     -10.1%     435387 � 11%  numa-meminfo.node3.Active(anon)
>     485577 �  6%      -7.3%     450224 �  6%     -10.0%     436799 � 11%  numa-meminfo.node3.Shmem
>     454393 � 69%     -43.1%     258770 �127%     +63.5%     743038 �  3%  numa-vmstat.node0.nr_file_pages
>       4178 � 73%     -28.5%       2988 �107%     +81.6%       7590 �  2%  numa-vmstat.node0.nr_mapped
>     452904 � 69%     -43.2%     257370 �128%     +63.8%     741987 �  3%  numa-vmstat.node0.nr_unevictable
>     452904 � 69%     -43.2%     257370 �128%     +63.8%     741987 �  3%  numa-vmstat.node0.nr_zone_unevictable
>      10118 � 40%     -61.8%       3861 � 40%     -50.4%       5016 � 59%  numa-vmstat.node1.nr_slab_reclaimable
>     121015 �  6%      -7.3%     112196 �  6%     -10.1%     108836 � 11%  numa-vmstat.node3.nr_active_anon
>     121371 �  6%      -7.3%     112537 �  6%     -10.1%     109168 � 11%  numa-vmstat.node3.nr_shmem
>     121015 �  6%      -7.3%     112196 �  6%     -10.1%     108836 � 11%  numa-vmstat.node3.nr_zone_active_anon
>       0.01 � 52%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.01 � 15%      +7.0%       0.01 � 16%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
>       0.06 � 69%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.01 � 17%      -3.8%       0.01 � 21%    -100.0%       0.00        perf-sched.sch_delay.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
>     400.06            +0.0%     400.07          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
>      10.00            +0.0%      10.00          -100.0%       0.00        perf-sched.wait_and_delay.count.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
>     999.53            -0.0%     999.38          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
>       0.01 � 52%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
>     400.05            +0.0%     400.06          -100.0%       0.00        perf-sched.wait_time.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
>       0.06 � 69%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
>     999.52            -0.0%     999.37          -100.0%       0.00        perf-sched.wait_time.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
>  2.071e+09            +2.8%  2.128e+09            +2.8%   2.13e+09        perf-stat.i.branch-instructions
>       0.48            -4.2%       0.46            -4.9%       0.45        perf-stat.i.cpi
>  4.717e+09            -0.7%  4.686e+09            +0.1%  4.723e+09        perf-stat.i.cpu-cycles
>  9.794e+09            +5.1%   1.03e+10            +5.2%   1.03e+10        perf-stat.i.instructions
>       2.15            +5.8%       2.28            +5.5%       2.27        perf-stat.i.ipc
>       0.34 �  3%      -0.0        0.33            -0.0        0.34        perf-stat.overall.branch-miss-rate%
>       0.48            -5.5%       0.46            -4.8%       0.46        perf-stat.overall.cpi
>       2.08            +5.8%       2.20            +5.1%       2.18        perf-stat.overall.ipc
>  2.063e+09            +2.8%   2.12e+09            +2.8%  2.122e+09        perf-stat.ps.branch-instructions
>  4.703e+09            -0.7%  4.672e+09            +0.1%  4.709e+09        perf-stat.ps.cpu-cycles
>  9.758e+09            +5.1%  1.026e+10            +5.2%  1.026e+10        perf-stat.ps.instructions
>  2.944e+12            +5.5%  3.106e+12            +5.0%  3.092e+12        perf-stat.total.instructions
>       6.54 �  2%      -6.5        0.00            -6.5        0.00        perf-profile.calltrace.cycles-pp.mas_store_prealloc.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       6.22            -6.2        0.00            -6.2        0.00        perf-profile.calltrace.cycles-pp.mas_preallocate.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      17.43            -0.7       16.76            -1.0       16.39        perf-profile.calltrace.cycles-pp.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       9.69 �  2%      -0.6        9.07            -1.0        8.73        perf-profile.calltrace.cycles-pp.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.do_brk_flags
>      11.30 �  2%      -0.6       10.71            -0.9       10.35        perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk
>      15.57            -0.5       15.05            -0.8       14.73        perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64
>       2.76            -0.1        2.62 �  3%      -0.2        2.60 �  3%  perf-profile.calltrace.cycles-pp.userfaultfd_unmap_complete.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>       0.84 �  4%      -0.1        0.74 �  8%      -0.1        0.70 �  5%  perf-profile.calltrace.cycles-pp.security_vm_enough_memory_mm.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.75 �  7%      -0.1        0.68 � 10%      -0.1        0.64 � 10%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
>       0.75 �  7%      -0.1        0.68 � 10%      -0.1        0.64 � 10%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
>       0.75 �  7%      -0.1        0.68 � 10%      -0.1        0.64 � 10%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
>       1.12 �  5%      +0.2        1.29 �  3%      +0.2        1.29 �  2%  perf-profile.calltrace.cycles-pp.sized_strscpy.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk
>       0.65 �  6%      +0.4        1.07 �  5%      +0.4        1.07 �  4%  perf-profile.calltrace.cycles-pp.__vm_enough_memory.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00            +0.5        0.48 � 45%      +0.5        0.54 �  6%  perf-profile.calltrace.cycles-pp.mas_next_range.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00            +0.5        0.54 �  4%      +0.4        0.36 � 70%  perf-profile.calltrace.cycles-pp.mas_wr_slot_store.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags
>       0.00            +0.5        0.55 �  4%      +0.5        0.48 � 45%  perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags
>       0.00            +0.7        0.66 �  4%      +0.8        0.80 �  4%  perf-profile.calltrace.cycles-pp.mas_next_slot.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00            +0.7        0.68 �  9%      +0.7        0.71 �  5%  perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.__vm_enough_memory.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.00            +0.7        0.68 �  4%      +0.8        0.76 �  6%  perf-profile.calltrace.cycles-pp.can_vma_merge_after.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.00            +0.8        0.76 �  2%      +0.8        0.77 �  7%  perf-profile.calltrace.cycles-pp.vma_adjust_trans_huge.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>      81.90            +0.8       82.67            +0.7       82.64        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.brk
>       0.00            +0.8        0.80 �  3%      +0.7        0.65 �  8%  perf-profile.calltrace.cycles-pp.mas_prev.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
>      80.94            +0.8       81.76            +0.8       81.74        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>       0.00            +0.8        0.82 �  3%      +0.9        0.87 �  6%  perf-profile.calltrace.cycles-pp.__anon_vma_interval_tree_remove.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags
>      77.52            +1.0       78.50            +0.9       78.40        perf-profile.calltrace.cycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>       0.00            +1.3        1.26 �  3%      +1.3        1.33 �  5%  perf-profile.calltrace.cycles-pp.mas_prev_slot.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.00            +1.3        1.35 �  3%      +1.3        1.30 �  4%  perf-profile.calltrace.cycles-pp.up_write.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +1.6        1.56 �  2%      +1.6        1.56 �  5%  perf-profile.calltrace.cycles-pp.up_write.vma_complete.vma_expand.vma_merge_new_range.do_brk_flags
>       0.00            +1.7        1.72 �  3%      +1.7        1.66 �  3%  perf-profile.calltrace.cycles-pp.init_multi_vma_prep.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +1.9        1.87 �  4%      +1.9        1.94 �  4%  perf-profile.calltrace.cycles-pp.mas_leaf_max_gap.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range
>       0.00            +2.1        2.07 �  2%      +2.1        2.15 �  4%  perf-profile.calltrace.cycles-pp.down_write.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags
>       0.00            +2.1        2.14 �  2%      +2.1        2.12 �  3%  perf-profile.calltrace.cycles-pp.down_write.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +2.4        2.37 �  2%      +2.4        2.41 �  3%  perf-profile.calltrace.cycles-pp.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags
>      51.80            +2.9       54.66            +2.7       54.52        perf-profile.calltrace.cycles-pp.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>       0.00            +3.0        3.02 �  2%      +3.2        3.17        perf-profile.calltrace.cycles-pp.mas_wr_store_type.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags
>       0.00            +3.1        3.06            +3.1        3.08 �  2%  perf-profile.calltrace.cycles-pp.vma_complete.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +3.9        3.86            +4.0        3.96 �  2%  perf-profile.calltrace.cycles-pp.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +5.0        5.01            +5.2        5.18 �  2%  perf-profile.calltrace.cycles-pp.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +5.9        5.88            +6.1        6.10        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00           +27.1       27.13           +27.4       27.39        perf-profile.calltrace.cycles-pp.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.00           +31.6       31.63           +32.0       32.01        perf-profile.calltrace.cycles-pp.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       6.46            -1.2        5.24            -1.1        5.40 �  2%  perf-profile.children.cycles-pp.mas_preallocate
>       5.54            -0.9        4.64            -0.9        4.63 �  3%  perf-profile.children.cycles-pp.up_write
>       3.99            -0.9        3.10 �  2%      -0.8        3.24        perf-profile.children.cycles-pp.mas_wr_store_type
>      17.57            -0.7       16.87            -1.1       16.50        perf-profile.children.cycles-pp.perf_event_mmap
>       9.85 �  2%      -0.6        9.22            -1.0        8.90        perf-profile.children.cycles-pp.perf_event_mmap_output
>       6.82 �  2%      -0.6        6.22            -0.4        6.43        perf-profile.children.cycles-pp.mas_store_prealloc
>       1.33 �  5%      -0.6        0.75 �  4%      -0.5        0.82 �  5%  perf-profile.children.cycles-pp.can_vma_merge_after
>      11.53 �  2%      -0.6       10.96            -1.0       10.58        perf-profile.children.cycles-pp.perf_iterate_sb
>      16.03            -0.5       15.50            -0.8       15.18        perf-profile.children.cycles-pp.perf_event_mmap_event
>       2.65 �  3%      -0.2        2.40 �  3%      -0.2        2.44 �  3%  perf-profile.children.cycles-pp.mas_update_gap
>       2.18 �  2%      -0.2        1.94 �  3%      -0.2        1.99 �  3%  perf-profile.children.cycles-pp.mas_leaf_max_gap
>       2.85            -0.2        2.70 �  3%      -0.2        2.68 �  3%  perf-profile.children.cycles-pp.userfaultfd_unmap_complete
>       3.52            -0.1        3.38 �  2%      -0.1        3.38 �  2%  perf-profile.children.cycles-pp.vma_complete
>       0.62 �  7%      -0.1        0.48 �  9%      -0.1        0.50 �  7%  perf-profile.children.cycles-pp.may_expand_vm
>       1.92 �  2%      -0.1        1.79 �  3%      -0.2        1.73 �  3%  perf-profile.children.cycles-pp.init_multi_vma_prep
>       1.05 �  3%      -0.1        0.95 �  6%      -0.1        0.91 �  6%  perf-profile.children.cycles-pp.security_vm_enough_memory_mm
>       0.75 �  7%      -0.1        0.68 � 10%      -0.1        0.64 � 10%  perf-profile.children.cycles-pp.kthread
>       0.40 �  6%      -0.1        0.35 �  9%      -0.0        0.38 �  8%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
>       0.35 �  2%      -0.0        0.33 �  7%      -0.0        0.31 �  6%  perf-profile.children.cycles-pp.brk_test
>       0.11 � 20%      +0.0        0.14 �  8%      +0.0        0.13 �  6%  perf-profile.children.cycles-pp.anon_vma_interval_tree_remove
>       0.52 �  3%      +0.0        0.56 �  4%      +0.0        0.54 � 10%  perf-profile.children.cycles-pp.mas_wr_slot_store
>       0.20 � 11%      +0.1        0.28 �  7%      +0.1        0.31 �  5%  perf-profile.children.cycles-pp.rb_next
>       0.49 �  3%      +0.1        0.61 �  4%      +0.2        0.64 �  7%  perf-profile.children.cycles-pp.mas_wr_store_entry
>       0.98 �  4%      +0.1        1.11 �  3%      +0.1        1.11 �  4%  perf-profile.children.cycles-pp.rcu_all_qs
>       0.39 �  7%      +0.2        0.55 �  7%      +0.2        0.60 �  6%  perf-profile.children.cycles-pp.strnlen
>       1.18 �  5%      +0.2        1.37 �  3%      +0.2        1.36 �  2%  perf-profile.children.cycles-pp.sized_strscpy
>       1.78 �  3%      +0.3        2.04 �  2%      +0.2        2.02 �  3%  perf-profile.children.cycles-pp.__cond_resched
>       0.00            +0.3        0.33 �  4%      +0.3        0.31 � 10%  perf-profile.children.cycles-pp.mas_next_setup
>       0.41 �  9%      +0.4        0.76 �  7%      +0.4        0.80 �  6%  perf-profile.children.cycles-pp.percpu_counter_add_batch
>       0.58 �  4%      +0.4        0.96 �  2%      +0.4        1.01 �  6%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
>       0.44 � 17%      +0.4        0.85 �  7%      +0.4        0.80 �  5%  perf-profile.children.cycles-pp.mas_prev_setup
>       4.11 �  2%      +0.4        4.52            +0.5        4.58        perf-profile.children.cycles-pp.down_write
>       0.74 �  6%      +0.6        1.29 �  5%      +0.6        1.32 �  3%  perf-profile.children.cycles-pp.__vm_enough_memory
>       0.00            +0.7        0.67 �  6%      +0.6        0.63 �  7%  perf-profile.children.cycles-pp.mas_next_range
>       0.95 �  5%      +0.7        1.64 �  2%      +0.9        1.84 �  3%  perf-profile.children.cycles-pp.mas_next_slot
>      78.23            +0.9       79.17            +0.8       79.07        perf-profile.children.cycles-pp.__do_sys_brk
>       1.02 � 14%      +1.0        1.99 �  4%      +0.8        1.86 �  6%  perf-profile.children.cycles-pp.mas_prev
>       2.89 �  3%      +1.2        4.10            +1.3        4.19 �  2%  perf-profile.children.cycles-pp.vma_prepare
>       1.38 � 12%      +1.3        2.73 �  4%      +1.3        2.73 �  3%  perf-profile.children.cycles-pp.mas_prev_slot
>      53.08            +1.9       55.03            +1.9       54.96        perf-profile.children.cycles-pp.do_brk_flags
>       0.00           +28.0       27.95           +28.2       28.20        perf-profile.children.cycles-pp.vma_expand
>       0.00           +32.1       32.10           +32.3       32.32        perf-profile.children.cycles-pp.vma_merge_new_range
>       5.69            -3.4        2.34 �  3%      -3.3        2.36 �  3%  perf-profile.self.cycles-pp.do_brk_flags
>       5.22            -0.9        4.33 �  2%      -0.9        4.33 �  3%  perf-profile.self.cycles-pp.up_write
>       3.82            -0.9        2.95 �  3%      -0.7        3.09        perf-profile.self.cycles-pp.mas_wr_store_type
>       9.68 �  2%      -0.6        9.05            -1.0        8.73        perf-profile.self.cycles-pp.perf_event_mmap_output
>       1.28 �  5%      -0.6        0.69 �  6%      -0.5        0.75 �  5%  perf-profile.self.cycles-pp.can_vma_merge_after
>       2.88 �  3%      -0.4        2.44 �  2%      -0.2        2.65 �  2%  perf-profile.self.cycles-pp.mas_store_prealloc
>       2.55            -0.3        2.22 �  2%      -0.3        2.22 �  4%  perf-profile.self.cycles-pp.mas_preallocate
>       4.98 �  2%      -0.3        4.70            -0.2        4.76        perf-profile.self.cycles-pp.__do_sys_brk
>       2.15 �  3%      -0.2        1.93 �  3%      -0.2        1.98 �  3%  perf-profile.self.cycles-pp.mas_leaf_max_gap
>       1.82            -0.2        1.60 �  4%      -0.2        1.62 �  3%  perf-profile.self.cycles-pp.perf_event_mmap_event
>       1.51 �  4%      -0.2        1.31 �  4%      -0.3        1.26        perf-profile.self.cycles-pp.perf_event_mmap
>       1.85 �  2%      -0.2        1.66 �  3%      -0.2        1.61 �  3%  perf-profile.self.cycles-pp.init_multi_vma_prep
>       2.77            -0.1        2.63 �  3%      -0.2        2.60 �  3%  perf-profile.self.cycles-pp.userfaultfd_unmap_complete
>       0.75 �  5%      -0.1        0.67 �  4%      -0.1        0.65 �  5%  perf-profile.self.cycles-pp.security_vm_enough_memory_mm
>       0.88 �  2%      -0.0        0.85 �  3%      -0.1        0.82 �  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
>       0.28 �  5%      -0.0        0.26 �  8%      -0.0        0.24 �  8%  perf-profile.self.cycles-pp.brk_test
>       0.03 � 70%      +0.0        0.07 � 14%      +0.0        0.07 �  8%  perf-profile.self.cycles-pp.anon_vma_interval_tree_remove
>       0.15 � 12%      +0.1        0.20 �  5%      +0.1        0.24 �  6%  perf-profile.self.cycles-pp.rb_next
>       0.40 �  5%      +0.1        0.48 �  5%      +0.1        0.50 � 10%  perf-profile.self.cycles-pp.mas_wr_store_entry
>       0.34 �  6%      +0.2        0.50 �  8%      +0.2        0.54 �  4%  perf-profile.self.cycles-pp.strnlen
>       0.66 �  4%      +0.2        0.84 �  5%      +0.1        0.80 �  4%  perf-profile.self.cycles-pp.vma_prepare
>       1.12 �  5%      +0.2        1.30 �  3%      +0.2        1.28 �  2%  perf-profile.self.cycles-pp.sized_strscpy
>       3.00 �  2%      +0.2        3.19 �  2%      +0.3        3.27 �  2%  perf-profile.self.cycles-pp.down_write
>       0.92 �  4%      +0.2        1.13 �  2%      +0.2        1.08 �  3%  perf-profile.self.cycles-pp.__cond_resched
>       0.00            +0.3        0.26 �  7%      +0.3        0.25 � 12%  perf-profile.self.cycles-pp.mas_next_setup
>       0.28 �  8%      +0.3        0.54 �  8%      +0.3        0.56 �  6%  perf-profile.self.cycles-pp.percpu_counter_add_batch
>       0.29 � 12%      +0.3        0.58 �  9%      +0.3        0.60 �  4%  perf-profile.self.cycles-pp.__vm_enough_memory
>       0.29 � 24%      +0.3        0.58 �  7%      +0.2        0.54 �  7%  perf-profile.self.cycles-pp.mas_prev_setup
>       0.40 �  4%      +0.3        0.70 �  2%      +0.3        0.72 �  8%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
>       0.00            +0.4        0.36 �  6%      +0.3        0.28 � 12%  perf-profile.self.cycles-pp.mas_next_range
>       0.58 � 14%      +0.5        1.12 �  5%      +0.5        1.10 �  6%  perf-profile.self.cycles-pp.mas_prev
>       0.81 �  4%      +0.7        1.48 �  3%      +0.8        1.64 �  4%  perf-profile.self.cycles-pp.mas_next_slot
>       1.32 � 11%      +1.3        2.59 �  3%      +1.3        2.60 �  3%  perf-profile.self.cycles-pp.mas_prev_slot
>       0.00            +1.3        1.30 �  4%      +1.1        1.14 �  6%  perf-profile.self.cycles-pp.vma_merge_new_range
>       0.00            +3.4        3.39            +3.4        3.36        perf-profile.self.cycles-pp.vma_expand
>
> =========================================================================================
> compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
>   gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/brk_test/aim9/300s
>
> commit:
>   fc21959f74bc11 ("mm: abstract vma_expand() to use vma_merge_struct")
>   cacded5e42b960 ("mm: avoid using vma_merge() for new VMAs")
>   2e71337ac26478 ("mm: explicitly enable an expand-only merge mode for brk()")
>
> fc21959f74bc1138 cacded5e42b9609b07b22d80c10 2e71337ac2647889d3d9d76a5ce
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>    3540976            -6.4%    3314159            -6.7%    3302864        aim9.brk_test.ops_per_sec
>      23.65            -5.8%      22.28            -6.5%      22.10        time.user_time
>     568.02 � 10%      -0.2%     567.09 � 12%     +18.0%     670.52 �  8%  sched_debug.cfs_rq:/.avg_vruntime.min
>     568.02 � 10%      -0.2%     567.09 � 12%     +18.0%     670.52 �  8%  sched_debug.cfs_rq:/.min_vruntime.min
>     111409 �  2%      -5.1%     105748 �  3%      -4.9%     105984 �  2%  proc-vmstat.nr_active_anon
>     114711 �  2%      -5.0%     109006 �  3%      -4.7%     109341 �  2%  proc-vmstat.nr_shmem
>     111409 �  2%      -5.1%     105748 �  3%      -4.9%     105984 �  2%  proc-vmstat.nr_zone_active_anon
>      17422 �  2%      -5.3%      16494            -1.9%      17084 �  2%  proc-vmstat.pgactivate
>  1.999e+09            +3.2%  2.064e+09            +2.9%  2.057e+09        perf-stat.i.branch-instructions
>       0.47            -5.1%       0.44            -4.4%       0.45        perf-stat.i.cpi
>  9.452e+09            +5.6%  9.983e+09            +5.3%  9.951e+09        perf-stat.i.instructions
>       2.19            +5.8%       2.31            +5.2%       2.30        perf-stat.i.ipc
>       0.33 �  3%      -0.0        0.31            -0.0        0.32        perf-stat.overall.branch-miss-rate%
>       0.47            -5.1%       0.45            -4.4%       0.45        perf-stat.overall.cpi
>       2.12            +5.4%       2.23            +4.7%       2.21        perf-stat.overall.ipc
>  1.991e+09            +3.2%  2.056e+09            +2.9%   2.05e+09        perf-stat.ps.branch-instructions
>  9.417e+09            +5.6%  9.946e+09            +5.3%  9.915e+09        perf-stat.ps.instructions
>  2.841e+12            +5.7%  3.002e+12            +5.2%  2.988e+12        perf-stat.total.instructions
>       0.01 � 42%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.02 � 37%     -68.5%       0.01 � 44%     -57.7%       0.01 � 63%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.02 � 38%     +31.7%       0.02 � 21%     +53.8%       0.03 � 10%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>       0.04 � 66%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.05 � 47%     -75.3%       0.01 � 83%     -69.2%       0.01 � 74%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.01 �  9%     +33.8%       0.02 � 18%     +17.5%       0.02 � 10%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>       0.44 � 49%     -29.7%       0.31 � 35%    +145.0%       1.09 � 41%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>       0.08 � 57%     -69.7%       0.02 �146%      +6.7%       0.09 � 66%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
>       0.10 � 37%     +45.2%       0.15 �  8%     +20.5%       0.12 � 13%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>       7209 �  3%      -7.8%       6648 �  2%      -3.6%       6948 �  3%  perf-sched.total_wait_and_delay.count.ms
>       1533 �  6%     -10.2%       1377            -2.6%       1493 �  7%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       0.01 � 42%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.02 � 37%     -68.5%       0.01 � 44%     -57.7%       0.01 � 63%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.04 � 66%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.05 � 47%     -75.3%       0.01 � 83%     -69.2%       0.01 � 74%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       6.61            -6.6        0.00            -6.6        0.00        perf-profile.calltrace.cycles-pp.mas_store_prealloc.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       6.20            -6.2        0.00            -6.2        0.00        perf-profile.calltrace.cycles-pp.mas_preallocate.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      17.96            -1.1       16.87            -1.5       16.43        perf-profile.calltrace.cycles-pp.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      16.08            -1.0       15.10            -1.3       14.78        perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64
>       9.85            -0.8        9.02            -1.2        8.66        perf-profile.calltrace.cycles-pp.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.do_brk_flags
>      11.56            -0.8       10.73            -1.2       10.33 �  2%  perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk
>       5.32            -0.2        5.10 �  5%      -0.3        5.03        perf-profile.calltrace.cycles-pp.check_brk_limits.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>       3.57 �  2%      -0.1        3.43 �  3%      -0.2        3.40 �  3%  perf-profile.calltrace.cycles-pp.thp_get_unmapped_area_vmflags.__get_unmapped_area.check_brk_limits.__do_sys_brk.do_syscall_64
>       4.87            -0.1        4.74 �  4%      -0.2        4.66 �  2%  perf-profile.calltrace.cycles-pp.__get_unmapped_area.check_brk_limits.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       2.76 �  2%      -0.1        2.66 �  3%      -0.2        2.58 �  3%  perf-profile.calltrace.cycles-pp.userfaultfd_unmap_complete.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>       1.11 � 15%      -0.1        1.04 �  4%      -0.1        0.96 �  5%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
>       0.64 �  4%      +0.4        1.06 �  2%      +0.4        1.06 �  5%  perf-profile.calltrace.cycles-pp.__vm_enough_memory.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00            +0.6        0.56 �  5%      +0.6        0.56 �  4%  perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags
>       0.00            +0.6        0.57 �  6%      +0.5        0.47 � 46%  perf-profile.calltrace.cycles-pp.mas_wr_slot_store.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags
>       0.00            +0.6        0.58 �  7%      +0.6        0.58 �  3%  perf-profile.calltrace.cycles-pp.mas_next_range.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00            +0.7        0.69 �  4%      +0.7        0.71 �  5%  perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.__vm_enough_memory.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.00            +0.7        0.70 �  6%      +0.8        0.78 �  6%  perf-profile.calltrace.cycles-pp.mas_next_slot.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00            +0.7        0.73 �  8%      +0.7        0.74 �  8%  perf-profile.calltrace.cycles-pp.vma_adjust_trans_huge.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +0.7        0.74 �  5%      +0.7        0.74 �  7%  perf-profile.calltrace.cycles-pp.can_vma_merge_after.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.00            +0.8        0.84 �  2%      +0.7        0.70 �  4%  perf-profile.calltrace.cycles-pp.mas_prev.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.00            +0.9        0.88 �  5%      +0.9        0.86 �  3%  perf-profile.calltrace.cycles-pp.__anon_vma_interval_tree_remove.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags
>      78.92            +0.9       79.81            +0.5       79.46        perf-profile.calltrace.cycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>       0.00            +1.3        1.28 �  2%      +1.3        1.30 �  5%  perf-profile.calltrace.cycles-pp.mas_prev_slot.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.00            +1.4        1.42 �  3%      +1.4        1.36 �  3%  perf-profile.calltrace.cycles-pp.up_write.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +1.6        1.59 �  4%      +1.6        1.64 �  3%  perf-profile.calltrace.cycles-pp.up_write.vma_complete.vma_expand.vma_merge_new_range.do_brk_flags
>       0.00            +1.8        1.80 �  4%      +1.7        1.73 �  2%  perf-profile.calltrace.cycles-pp.init_multi_vma_prep.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +1.9        1.89 �  4%      +1.9        1.90 �  5%  perf-profile.calltrace.cycles-pp.mas_leaf_max_gap.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range
>       0.00            +2.1        2.06 �  3%      +2.2        2.17 �  2%  perf-profile.calltrace.cycles-pp.down_write.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags
>       0.00            +2.1        2.12 �  2%      +2.1        2.14 �  2%  perf-profile.calltrace.cycles-pp.down_write.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +2.4        2.43 �  4%      +2.4        2.40 �  4%  perf-profile.calltrace.cycles-pp.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags
>      52.76            +2.6       55.40            +2.7       55.48        perf-profile.calltrace.cycles-pp.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>       0.00            +3.0        2.98            +3.4        3.38 �  2%  perf-profile.calltrace.cycles-pp.mas_wr_store_type.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags
>       0.00            +3.1        3.11 �  3%      +3.2        3.18 �  5%  perf-profile.calltrace.cycles-pp.vma_complete.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +3.9        3.90 �  2%      +4.0        4.00 �  2%  perf-profile.calltrace.cycles-pp.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +5.0        4.96            +5.4        5.39        perf-profile.calltrace.cycles-pp.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +6.0        6.04 �  2%      +6.2        6.15        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00           +27.5       27.47           +28.1       28.06        perf-profile.calltrace.cycles-pp.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.00           +32.1       32.09           +32.7       32.73        perf-profile.calltrace.cycles-pp.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       6.44            -1.2        5.20            -0.8        5.64        perf-profile.children.cycles-pp.mas_preallocate
>      18.11            -1.1       16.99            -1.6       16.55        perf-profile.children.cycles-pp.perf_event_mmap
>       4.01 �  2%      -1.0        3.06            -0.6        3.45 �  2%  perf-profile.children.cycles-pp.mas_wr_store_type
>      16.54            -0.9       15.60            -1.3       15.27        perf-profile.children.cycles-pp.perf_event_mmap_event
>      10.02            -0.8        9.18            -1.2        8.80        perf-profile.children.cycles-pp.perf_event_mmap_output
>       5.61            -0.8        4.77            -0.8        4.80 �  2%  perf-profile.children.cycles-pp.up_write
>      11.80            -0.8       10.97            -1.2       10.57 �  2%  perf-profile.children.cycles-pp.perf_iterate_sb
>       1.39            -0.6        0.81 �  3%      -0.6        0.81 �  6%  perf-profile.children.cycles-pp.can_vma_merge_after
>       6.89            -0.5        6.38            -0.4        6.52        perf-profile.children.cycles-pp.mas_store_prealloc
>       3.67 �  2%      -0.3        3.41 �  3%      -0.2        3.48 �  5%  perf-profile.children.cycles-pp.vma_complete
>       5.55            -0.2        5.32 �  4%      -0.3        5.23        perf-profile.children.cycles-pp.check_brk_limits
>       2.20 �  4%      -0.2        1.97 �  3%      -0.2        1.96 �  4%  perf-profile.children.cycles-pp.mas_leaf_max_gap
>       2.68 �  3%      -0.2        2.47 �  3%      -0.2        2.44 �  4%  perf-profile.children.cycles-pp.mas_update_gap
>       5.11            -0.2        4.91 �  4%      -0.3        4.84 �  2%  perf-profile.children.cycles-pp.__get_unmapped_area
>       2.51 �  3%      -0.1        2.36 �  3%      -0.2        2.32 �  2%  perf-profile.children.cycles-pp.down_write_killable
>       0.61 �  5%      -0.1        0.49 �  7%      -0.1        0.50 �  5%  perf-profile.children.cycles-pp.may_expand_vm
>       3.67            -0.1        3.55 �  3%      -0.2        3.51 �  3%  perf-profile.children.cycles-pp.thp_get_unmapped_area_vmflags
>       1.25 �  4%      -0.1        1.14 �  5%      -0.1        1.19 �  4%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>       2.85 �  2%      -0.1        2.74 �  2%      -0.2        2.66 �  3%  perf-profile.children.cycles-pp.userfaultfd_unmap_complete
>       0.14 � 11%      -0.1        0.08 � 12%      -0.1        0.06 � 14%  perf-profile.children.cycles-pp.arch_vma_name
>       0.42            -0.1        0.36 �  4%      -0.0        0.40 �  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
>       0.36 �  6%      -0.1        0.31 �  4%      -0.0        0.34 � 11%  perf-profile.children.cycles-pp.brk_test
>       2.39            -0.1        2.34 �  5%      -0.1        2.29        perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown_vmflags
>       0.25 �  5%      -0.0        0.21 �  9%      -0.0        0.23 � 13%  perf-profile.children.cycles-pp.__rb_insert_augmented
>       1.92 �  2%      -0.0        1.89 �  4%      -0.1        1.80 �  2%  perf-profile.children.cycles-pp.init_multi_vma_prep
>       0.31 � 10%      -0.0        0.29 � 10%      -0.0        0.26 �  9%  perf-profile.children.cycles-pp.sched_setaffinity
>       0.14 �  3%      -0.0        0.14 �  7%      -0.0        0.11 �  8%  perf-profile.children.cycles-pp.intel_idle
>       0.08 � 10%      +0.0        0.12 � 16%      +0.0        0.10 �  9%  perf-profile.children.cycles-pp.mmap_region
>       0.09 �  8%      +0.0        0.12 � 15%      +0.0        0.11 �  8%  perf-profile.children.cycles-pp.do_mmap
>       0.10 � 14%      +0.0        0.15 � 11%      +0.0        0.14 � 13%  perf-profile.children.cycles-pp.anon_vma_interval_tree_remove
>       1.01 �  5%      +0.1        1.08 �  5%      +0.1        1.12        perf-profile.children.cycles-pp.rcu_all_qs
>       0.19 �  5%      +0.1        0.30 �  5%      +0.1        0.28 �  8%  perf-profile.children.cycles-pp.rb_next
>       1.27 �  4%      +0.1        1.40 �  2%      +0.1        1.37 �  5%  perf-profile.children.cycles-pp.sized_strscpy
>       0.42 �  6%      +0.1        0.57 �  6%      +0.2        0.63 �  9%  perf-profile.children.cycles-pp.strnlen
>       0.48 �  4%      +0.2        0.64 �  5%      +0.2        0.65 �  5%  perf-profile.children.cycles-pp.mas_wr_store_entry
>       1.80 �  4%      +0.2        2.02 �  2%      +0.2        2.00        perf-profile.children.cycles-pp.__cond_resched
>       0.00            +0.3        0.31 � 12%      +0.3        0.32 �  3%  perf-profile.children.cycles-pp.mas_next_setup
>       4.16 �  3%      +0.3        4.48            +0.5        4.64 �  3%  perf-profile.children.cycles-pp.down_write
>       0.40 �  6%      +0.4        0.78 �  4%      +0.4        0.79 �  3%  perf-profile.children.cycles-pp.percpu_counter_add_batch
>       0.48 �  4%      +0.4        0.92 �  5%      +0.4        0.90 �  3%  perf-profile.children.cycles-pp.mas_prev_setup
>       0.56 �  6%      +0.5        1.02 �  4%      +0.5        1.01 �  4%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
>       0.79 �  4%      +0.5        1.30 �  3%      +0.5        1.30 �  4%  perf-profile.children.cycles-pp.__vm_enough_memory
>       1.02 �  2%      +0.7        1.72 �  3%      +0.8        1.79 �  4%  perf-profile.children.cycles-pp.mas_next_slot
>       0.00            +0.7        0.70 �  6%      +0.7        0.68 �  4%  perf-profile.children.cycles-pp.mas_next_range
>      79.62            +0.9       80.50            +0.5       80.13        perf-profile.children.cycles-pp.__do_sys_brk
>       1.10 �  3%      +1.0        2.10 �  3%      +0.8        1.94 �  3%  perf-profile.children.cycles-pp.mas_prev
>       2.86 �  3%      +1.3        4.12 �  3%      +1.4        4.25        perf-profile.children.cycles-pp.vma_prepare
>       1.45 �  4%      +1.3        2.79 �  3%      +1.3        2.77 �  3%  perf-profile.children.cycles-pp.mas_prev_slot
>      54.06            +1.8       55.82            +1.9       55.95        perf-profile.children.cycles-pp.do_brk_flags
>       0.00           +28.3       28.30           +28.9       28.88        perf-profile.children.cycles-pp.vma_expand
>       0.00           +32.6       32.58           +33.1       33.05        perf-profile.children.cycles-pp.vma_merge_new_range
>       5.90 �  2%      -3.4        2.47 �  3%      -3.4        2.47 �  2%  perf-profile.self.cycles-pp.do_brk_flags
>       3.84 �  2%      -0.9        2.90            -0.6        3.28 �  3%  perf-profile.self.cycles-pp.mas_wr_store_type
>       9.85            -0.8        9.02            -1.2        8.63        perf-profile.self.cycles-pp.perf_event_mmap_output
>       5.26            -0.8        4.47 �  2%      -0.8        4.49 �  2%  perf-profile.self.cycles-pp.up_write
>       1.34 �  2%      -0.6        0.75 �  3%      -0.6        0.74 �  5%  perf-profile.self.cycles-pp.can_vma_merge_after
>       2.86            -0.4        2.47 �  5%      -0.2        2.70 �  2%  perf-profile.self.cycles-pp.mas_store_prealloc
>       2.50 �  2%      -0.3        2.22 �  2%      -0.2        2.27 �  2%  perf-profile.self.cycles-pp.mas_preallocate
>       5.02 �  2%      -0.2        4.79            -0.3        4.69        perf-profile.self.cycles-pp.__do_sys_brk
>       2.19 �  4%      -0.2        1.96 �  3%      -0.2        1.95 �  4%  perf-profile.self.cycles-pp.mas_leaf_max_gap
>       1.87 �  3%      -0.2        1.66 �  4%      -0.2        1.71 �  6%  perf-profile.self.cycles-pp.perf_event_mmap_event
>       1.52 �  3%      -0.2        1.33 �  2%      -0.3        1.24 �  2%  perf-profile.self.cycles-pp.perf_event_mmap
>       1.82 �  3%      -0.1        1.68 �  4%      -0.2        1.66 �  3%  perf-profile.self.cycles-pp.down_write_killable
>       1.84 �  2%      -0.1        1.74 �  4%      -0.2        1.67 �  2%  perf-profile.self.cycles-pp.init_multi_vma_prep
>       2.77 �  2%      -0.1        2.67 �  2%      -0.2        2.58 �  3%  perf-profile.self.cycles-pp.userfaultfd_unmap_complete
>       1.18 �  2%      -0.1        1.09            -0.1        1.11 �  6%  perf-profile.self.cycles-pp.do_syscall_64
>       0.92 �  3%      -0.1        0.84 �  6%      -0.1        0.82 �  5%  perf-profile.self.cycles-pp.__get_unmapped_area
>       2.30            -0.0        2.26 �  5%      -0.1        2.21        perf-profile.self.cycles-pp.arch_get_unmapped_area_topdown_vmflags
>       0.33 �  4%      -0.0        0.30 �  5%      -0.0        0.33 �  6%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
>       1.08 �  2%      -0.0        1.05 �  4%      -0.1        1.00 �  2%  perf-profile.self.cycles-pp.mas_find
>       0.14 �  3%      -0.0        0.14 �  7%      -0.0        0.11 �  8%  perf-profile.self.cycles-pp.intel_idle
>       0.03 � 70%      +0.1        0.08 � 14%      +0.0        0.07 � 15%  perf-profile.self.cycles-pp.anon_vma_interval_tree_remove
>       0.13 �  7%      +0.1        0.22 � 10%      +0.1        0.22 � 11%  perf-profile.self.cycles-pp.rb_next
>       0.40 �  7%      +0.1        0.50 �  9%      +0.1        0.51 �  6%  perf-profile.self.cycles-pp.mas_wr_store_entry
>       1.21 �  4%      +0.1        1.32 �  2%      +0.1        1.30 �  5%  perf-profile.self.cycles-pp.sized_strscpy
>       0.38 �  7%      +0.1        0.50 �  7%      +0.2        0.57 �  9%  perf-profile.self.cycles-pp.strnlen
>       0.95 �  7%      +0.1        1.10 �  4%      +0.1        1.08        perf-profile.self.cycles-pp.__cond_resched
>       0.63 �  5%      +0.2        0.82 �  9%      +0.2        0.83 �  2%  perf-profile.self.cycles-pp.vma_prepare
>       2.98 �  2%      +0.2        3.20            +0.3        3.32 �  4%  perf-profile.self.cycles-pp.down_write
>       0.37 �  6%      +0.2        0.60 �  6%      +0.2        0.58 �  4%  perf-profile.self.cycles-pp.__vm_enough_memory
>       0.00            +0.2        0.24 � 11%      +0.2        0.24 �  5%  perf-profile.self.cycles-pp.mas_next_setup
>       0.24 �  6%      +0.3        0.54 �  6%      +0.3        0.56 �  4%  perf-profile.self.cycles-pp.percpu_counter_add_batch
>       0.32 �  4%      +0.3        0.64 �  5%      +0.3        0.62 �  3%  perf-profile.self.cycles-pp.mas_prev_setup
>       0.38 � 10%      +0.3        0.72 �  6%      +0.3        0.73 �  6%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
>       0.00            +0.4        0.41 �  5%      +0.3        0.33 �  9%  perf-profile.self.cycles-pp.mas_next_range
>       0.63 �  5%      +0.5        1.17 �  3%      +0.5        1.10 �  5%  perf-profile.self.cycles-pp.mas_prev
>       0.87 �  3%      +0.6        1.49 �  3%      +0.7        1.61 �  6%  perf-profile.self.cycles-pp.mas_next_slot
>       1.37 �  4%      +1.3        2.64 �  3%      +1.3        2.62 �  4%  perf-profile.self.cycles-pp.mas_prev_slot
>       0.00            +1.3        1.30            +1.2        1.19 �  4%  perf-profile.self.cycles-pp.vma_merge_new_range
>       0.00            +3.4        3.45 �  2%      +3.4        3.43 �  2%  perf-profile.self.cycles-pp.vma_expand
>
> =========================================================================================
> compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
>   gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-icl-2sp9/brk_test/aim9/300s
>
> commit:
>   fc21959f74bc11 ("mm: abstract vma_expand() to use vma_merge_struct")
>   cacded5e42b960 ("mm: avoid using vma_merge() for new VMAs")
>   2e71337ac26478 ("mm: explicitly enable an expand-only merge mode for brk()")
>
> fc21959f74bc1138 cacded5e42b9609b07b22d80c10 2e71337ac2647889d3d9d76a5ce
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>    2667734            -5.6%    2518021            -6.2%    2503505        aim9.brk_test.ops_per_sec
>     196.00            +0.0%     196.00         +1038.8%       2231 � 89%  meminfo.Inactive(file)
>      23.94            -8.7%      21.86 �  2%      -6.0%      22.51        time.user_time
>       0.01 � 47%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.06 � 34%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.01 � 47%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.06 � 34%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
>      49.00            +0.0%      49.00         +1039.3%     558.24 � 89%  proc-vmstat.nr_inactive_file
>      49.00            +0.0%      49.00         +1039.3%     558.24 � 89%  proc-vmstat.nr_zone_inactive_file
>     948658            +2.3%     970280            +3.2%     978780        proc-vmstat.pgalloc_normal
>     792310            -1.5%     780779            -1.7%     779104        proc-vmstat.pgfault
>     814343            +2.4%     833987            +3.0%     839063        proc-vmstat.pgfree
>  1.721e+09            +3.0%  1.773e+09            +2.6%  1.765e+09        perf-stat.i.branch-instructions
>       0.54            -5.4%       0.52            -4.8%       0.52        perf-stat.i.cpi
>  7.553e+09            +6.0%  8.003e+09            +5.5%  7.968e+09        perf-stat.i.instructions
>       1.86            +6.1%       1.97            +5.3%       1.96        perf-stat.i.ipc
>       2399            -1.1%       2372            -1.3%       2367        perf-stat.i.minor-faults
>       2399            -1.1%       2372            -1.3%       2367        perf-stat.i.page-faults
>       0.36 �  2%      -0.0        0.35            +0.0        0.36        perf-stat.overall.branch-miss-rate%
>       0.55            -5.3%       0.52            -4.6%       0.52        perf-stat.overall.cpi
>       1.82            +5.6%       1.92            +4.8%       1.91        perf-stat.overall.ipc
>  1.715e+09            +3.0%  1.767e+09            +2.6%   1.76e+09        perf-stat.ps.branch-instructions
>  7.529e+09            +5.9%  7.977e+09            +5.5%  7.942e+09        perf-stat.ps.instructions
>       2391            -1.1%       2364            -1.3%       2359        perf-stat.ps.minor-faults
>       2391            -1.1%       2364            -1.3%       2359        perf-stat.ps.page-faults
>  2.275e+12            +5.8%  2.408e+12            +5.3%  2.395e+12        perf-stat.total.instructions
>       6.58 �  2%      -6.6        0.00            -6.6        0.00        perf-profile.calltrace.cycles-pp.mas_store_prealloc.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       5.76 �  2%      -5.8        0.00            -5.8        0.00        perf-profile.calltrace.cycles-pp.mas_preallocate.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      18.35            -1.3       17.10            -1.0       17.32        perf-profile.calltrace.cycles-pp.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      15.92            -1.1       14.78 �  2%      -0.9       15.03        perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64
>      11.03            -0.7       10.33            -0.7       10.36        perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk
>       4.22 �  3%      -0.4        3.79 �  2%      -0.5        3.69        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       8.48            -0.4        8.08 �  2%      -0.5        7.95        perf-profile.calltrace.cycles-pp.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.do_brk_flags
>       5.32            -0.3        4.98            -0.2        5.10 �  3%  perf-profile.calltrace.cycles-pp.clear_bhb_loop.brk
>       5.38 �  3%      -0.3        5.06            -0.5        4.89        perf-profile.calltrace.cycles-pp.mas_find.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>       1.16 �  7%      -0.3        0.86 �  5%      -0.3        0.90 �  5%  perf-profile.calltrace.cycles-pp.__vm_enough_memory.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.88 � 14%      -0.2        0.64 �  8%      -0.2        0.64 �  4%  perf-profile.calltrace.cycles-pp.security_vm_enough_memory_mm.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       5.56            -0.2        5.38            -0.2        5.34        perf-profile.calltrace.cycles-pp.check_brk_limits.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>       0.74 �  6%      -0.2        0.57 �  6%      -0.1        0.62 �  7%  perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.__vm_enough_memory.do_brk_flags.__do_sys_brk.do_syscall_64
>       5.09            -0.2        4.92            -0.2        4.90        perf-profile.calltrace.cycles-pp.__get_unmapped_area.check_brk_limits.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       3.73            -0.2        3.56 �  2%      -0.2        3.58 �  2%  perf-profile.calltrace.cycles-pp.thp_get_unmapped_area_vmflags.__get_unmapped_area.check_brk_limits.__do_sys_brk.do_syscall_64
>       1.25 �  2%      -0.2        1.08 �  9%      -0.1        1.13 �  4%  perf-profile.calltrace.cycles-pp.sized_strscpy.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk
>       1.98 �  2%      -0.1        1.84 �  3%      -0.1        1.88 �  2%  perf-profile.calltrace.cycles-pp.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>       0.55 �  2%      -0.1        0.42 � 44%      -0.1        0.46 � 44%  perf-profile.calltrace.cycles-pp.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.78 �  3%      -0.1        0.72 �  4%      -0.1        0.72 �  3%  perf-profile.calltrace.cycles-pp.mas_prev.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>       0.00            +0.6        0.56 �  5%      +0.1        0.09 �223%  perf-profile.calltrace.cycles-pp.anon_vma_interval_tree_insert.vma_complete.vma_expand.vma_merge_new_range.do_brk_flags
>       0.00            +0.6        0.64            +0.6        0.60 �  7%  perf-profile.calltrace.cycles-pp.vma_adjust_trans_huge.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +0.7        0.69 �  8%      +0.7        0.70 �  8%  perf-profile.calltrace.cycles-pp.__anon_vma_interval_tree_remove.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags
>       0.00            +0.8        0.78 �  4%      +0.9        0.88 �  5%  perf-profile.calltrace.cycles-pp.mas_next_range.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00            +0.8        0.80 �  2%      +0.7        0.72 �  3%  perf-profile.calltrace.cycles-pp.mas_prev.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
>      82.26            +0.8       83.07            +0.7       82.95        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.brk
>       0.00            +0.8        0.82 �  4%      +0.8        0.80 �  5%  perf-profile.calltrace.cycles-pp.can_vma_merge_after.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
>      81.38            +0.8       82.20            +0.7       82.07        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>       0.00            +0.8        0.84 �  4%      +0.8        0.80 �  7%  perf-profile.calltrace.cycles-pp.mas_wr_slot_store.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags
>      77.94            +1.0       78.92            +0.8       78.74        perf-profile.calltrace.cycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>       0.00            +1.2        1.24 �  3%      +1.2        1.18 �  4%  perf-profile.calltrace.cycles-pp.mas_prev_slot.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.00            +1.3        1.32 �  2%      +1.4        1.37 �  3%  perf-profile.calltrace.cycles-pp.mas_next_slot.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00            +1.4        1.38 �  2%      +1.4        1.42 �  4%  perf-profile.calltrace.cycles-pp.down_write.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags
>       0.00            +1.4        1.40 �  4%      +1.4        1.38        perf-profile.calltrace.cycles-pp.up_write.vma_complete.vma_expand.vma_merge_new_range.do_brk_flags
>       0.00            +1.6        1.64            +1.7        1.66 �  3%  perf-profile.calltrace.cycles-pp.up_write.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +1.8        1.82 �  5%      +1.7        1.73 �  3%  perf-profile.calltrace.cycles-pp.down_write.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +1.9        1.89 �  3%      +1.9        1.89 �  2%  perf-profile.calltrace.cycles-pp.init_multi_vma_prep.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +1.9        1.92 �  3%      +1.9        1.91        perf-profile.calltrace.cycles-pp.mas_leaf_max_gap.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range
>       0.00            +2.3        2.31            +2.3        2.31 �  3%  perf-profile.calltrace.cycles-pp.mas_wr_store_type.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags
>       0.00            +2.7        2.68 �  2%      +2.6        2.62        perf-profile.calltrace.cycles-pp.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags
>       0.00            +2.9        2.92 �  4%      +2.8        2.81        perf-profile.calltrace.cycles-pp.vma_complete.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +2.9        2.93 �  2%      +2.9        2.94 �  3%  perf-profile.calltrace.cycles-pp.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>      53.19            +3.0       56.14            +2.6       55.83        perf-profile.calltrace.cycles-pp.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>       0.00            +4.4        4.42            +4.4        4.40        perf-profile.calltrace.cycles-pp.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +7.1        7.09            +7.0        6.95        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00           +26.8       26.83           +26.3       26.31        perf-profile.calltrace.cycles-pp.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.00           +31.4       31.41           +30.8       30.83        perf-profile.calltrace.cycles-pp.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       5.93            -1.3        4.62            -1.3        4.60        perf-profile.children.cycles-pp.mas_preallocate
>      18.48            -1.3       17.23            -1.0       17.46        perf-profile.children.cycles-pp.perf_event_mmap
>      16.41            -1.2       15.23            -0.9       15.47        perf-profile.children.cycles-pp.perf_event_mmap_event
>       3.46            -1.1        2.37            -1.1        2.38 �  3%  perf-profile.children.cycles-pp.mas_wr_store_type
>      11.24            -0.7       10.52 �  2%      -0.7       10.56        perf-profile.children.cycles-pp.perf_iterate_sb
>       4.29 �  3%      -0.4        3.86 �  2%      -0.5        3.76        perf-profile.children.cycles-pp.mas_walk
>       8.61            -0.4        8.21 �  2%      -0.5        8.07        perf-profile.children.cycles-pp.perf_event_mmap_output
>       0.83 �  7%      -0.4        0.47 �  8%      -0.4        0.45 � 10%  perf-profile.children.cycles-pp.may_expand_vm
>       3.82            -0.3        3.48 �  3%      -0.4        3.41        perf-profile.children.cycles-pp.down_write
>       5.39            -0.3        5.06            -0.2        5.18 �  3%  perf-profile.children.cycles-pp.clear_bhb_loop
>       1.36 �  5%      -0.3        1.03 �  5%      -0.3        1.08 �  4%  perf-profile.children.cycles-pp.__vm_enough_memory
>       5.64 �  3%      -0.3        5.32            -0.5        5.13        perf-profile.children.cycles-pp.mas_find
>       1.18 �  5%      -0.3        0.88 �  4%      -0.3        0.87 �  3%  perf-profile.children.cycles-pp.can_vma_merge_after
>       0.57 � 22%      -0.2        0.33 � 12%      -0.2        0.36 �  7%  perf-profile.children.cycles-pp.cap_vm_enough_memory
>       1.06 � 11%      -0.2        0.83 �  9%      -0.2        0.82 �  5%  perf-profile.children.cycles-pp.security_vm_enough_memory_mm
>       5.30            -0.2        5.11            -0.2        5.10        perf-profile.children.cycles-pp.__get_unmapped_area
>       5.75            -0.2        5.56            -0.2        5.52        perf-profile.children.cycles-pp.check_brk_limits
>       0.82 �  4%      -0.2        0.64 �  4%      -0.1        0.70 �  7%  perf-profile.children.cycles-pp.percpu_counter_add_batch
>       3.86            -0.2        3.69 �  2%      -0.1        3.71 �  2%  perf-profile.children.cycles-pp.thp_get_unmapped_area_vmflags
>       1.32 �  2%      -0.2        1.16 �  8%      -0.1        1.20 �  3%  perf-profile.children.cycles-pp.sized_strscpy
>       2.10 �  2%      -0.1        1.96 �  2%      -0.1        2.00 �  3%  perf-profile.children.cycles-pp.down_write_killable
>       1.86 �  3%      -0.1        1.74 �  2%      -0.1        1.80 �  4%  perf-profile.children.cycles-pp.__cond_resched
>       0.57 �  7%      -0.1        0.45 � 13%      -0.1        0.46 �  2%  perf-profile.children.cycles-pp.strlen
>       2.78            -0.1        2.66 �  2%      -0.1        2.64 �  2%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown_vmflags
>       0.10 � 13%      +0.0        0.11 � 16%      +0.0        0.12 � 11%  perf-profile.children.cycles-pp.vfs_read
>       0.10 � 11%      +0.0        0.12 � 13%      +0.0        0.14 �  8%  perf-profile.children.cycles-pp.read
>       0.70 �  2%      +0.1        0.81 �  6%      +0.1        0.82 �  7%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
>       0.68 �  9%      +0.2        0.90 �  3%      +0.2        0.86 �  6%  perf-profile.children.cycles-pp.mas_wr_slot_store
>       0.34 �  5%      +0.3        0.68 �  6%      +0.3        0.68 �  4%  perf-profile.children.cycles-pp.mas_prev_setup
>       0.00            +0.4        0.43 �  2%      +0.4        0.41 �  7%  perf-profile.children.cycles-pp.mas_next_setup
>       6.91 �  2%      +0.5        7.37            +0.4        7.26        perf-profile.children.cycles-pp.mas_store_prealloc
>       0.92 �  3%      +0.8        1.76 �  3%      +0.8        1.69 �  2%  perf-profile.children.cycles-pp.mas_prev
>      83.20            +0.9       84.05            +0.7       83.90        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>      82.36            +0.9       83.23            +0.7       83.08        perf-profile.children.cycles-pp.do_syscall_64
>      78.68            +0.9       79.62            +0.8       79.46        perf-profile.children.cycles-pp.__do_sys_brk
>       0.00            +0.9        0.94 �  3%      +1.1        1.05 �  5%  perf-profile.children.cycles-pp.mas_next_range
>       1.35 �  5%      +1.2        2.59 �  3%      +1.2        2.52        perf-profile.children.cycles-pp.mas_prev_slot
>       0.84 �  3%      +1.4        2.26 �  3%      +1.4        2.27 �  2%  perf-profile.children.cycles-pp.mas_next_slot
>      54.26            +2.3       56.54            +2.0       56.30        perf-profile.children.cycles-pp.do_brk_flags
>       0.00           +27.5       27.55           +27.0       27.00        perf-profile.children.cycles-pp.vma_expand
>       0.00           +31.9       31.86           +31.1       31.13        perf-profile.children.cycles-pp.vma_merge_new_range
>       6.50            -3.3        3.19 �  2%      -3.1        3.35        perf-profile.self.cycles-pp.do_brk_flags
>       3.35            -1.1        2.25            -1.1        2.25 �  2%  perf-profile.self.cycles-pp.mas_wr_store_type
>       5.31 �  2%      -0.4        4.88            -0.2        5.14 �  2%  perf-profile.self.cycles-pp.__do_sys_brk
>       4.22 �  3%      -0.4        3.80 �  2%      -0.5        3.70        perf-profile.self.cycles-pp.mas_walk
>       8.47            -0.4        8.07 �  2%      -0.5        7.94        perf-profile.self.cycles-pp.perf_event_mmap_output
>       0.71 �  8%      -0.3        0.38 �  8%      -0.3        0.36 � 12%  perf-profile.self.cycles-pp.may_expand_vm
>       5.32            -0.3        5.00            -0.2        5.11 �  3%  perf-profile.self.cycles-pp.clear_bhb_loop
>       1.12 �  5%      -0.3        0.82 �  4%      -0.3        0.80 �  5%  perf-profile.self.cycles-pp.can_vma_merge_after
>       2.62            -0.2        2.38 �  5%      -0.3        2.32 �  3%  perf-profile.self.cycles-pp.down_write
>       0.44 � 28%      -0.2        0.20 � 13%      -0.2        0.24 �  7%  perf-profile.self.cycles-pp.cap_vm_enough_memory
>       2.50 �  3%      -0.2        2.31 �  2%      -0.2        2.28        perf-profile.self.cycles-pp.mas_preallocate
>       0.61 �  9%      -0.2        0.42 �  7%      -0.2        0.42 �  6%  perf-profile.self.cycles-pp.__vm_enough_memory
>       1.26 �  2%      -0.2        1.09 �  9%      -0.1        1.14 �  3%  perf-profile.self.cycles-pp.sized_strscpy
>       0.57 �  5%      -0.1        0.44 �  4%      -0.1        0.47 �  8%  perf-profile.self.cycles-pp.percpu_counter_add_batch
>       2.25 �  3%      -0.1        2.13 �  3%      -0.0        2.25 �  2%  perf-profile.self.cycles-pp.perf_event_mmap_event
>       2.70            -0.1        2.60 �  2%      -0.1        2.58 �  2%  perf-profile.self.cycles-pp.arch_get_unmapped_area_topdown_vmflags
>       0.50 �  8%      -0.1        0.40 � 12%      -0.1        0.41 �  2%  perf-profile.self.cycles-pp.strlen
>       0.57 �  4%      -0.1        0.52 �  4%      -0.0        0.55 �  4%  perf-profile.self.cycles-pp.strnlen
>       1.40 �  3%      -0.0        1.34 �  2%      -0.1        1.33 �  2%  perf-profile.self.cycles-pp.down_write_killable
>       0.01 �223%      +0.1        0.06 � 15%      +0.0        0.05 � 48%  perf-profile.self.cycles-pp.anon_vma_interval_tree_remove
>       0.51 �  4%      +0.1        0.60 �  5%      +0.1        0.60 �  7%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
>       2.87 �  2%      +0.2        3.10 �  2%      +0.2        3.09 �  2%  perf-profile.self.cycles-pp.mas_store_prealloc
>       0.61 �  8%      +0.2        0.84 �  4%      +0.2        0.81 �  7%  perf-profile.self.cycles-pp.mas_wr_slot_store
>       0.26 �  7%      +0.3        0.56 �  5%      +0.3        0.56 �  7%  perf-profile.self.cycles-pp.mas_prev_setup
>       0.00            +0.3        0.33 �  3%      +0.3        0.31 � 10%  perf-profile.self.cycles-pp.mas_next_setup
>       0.53 �  6%      +0.4        0.98 �  3%      +0.4        0.94 �  7%  perf-profile.self.cycles-pp.mas_prev
>       0.00            +0.6        0.56 �  5%      +0.6        0.62 �  5%  perf-profile.self.cycles-pp.mas_next_range
>       1.29 �  4%      +1.2        2.46 �  3%      +1.1        2.39        perf-profile.self.cycles-pp.mas_prev_slot
>       0.72 �  4%      +1.4        2.07 �  3%      +1.4        2.09        perf-profile.self.cycles-pp.mas_next_slot
>       0.00            +1.4        1.40 �  4%      +1.2        1.24 �  5%  perf-profile.self.cycles-pp.vma_merge_new_range
>       0.00            +3.6        3.55 �  6%      +3.4        3.42 �  2%  perf-profile.self.cycles-pp.vma_expand
>
> =========================================================================================
> compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
>   gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-ivb-2ep2/brk_test/aim9/300s
>
> commit:
>   fc21959f74bc11 ("mm: abstract vma_expand() to use vma_merge_struct")
>   cacded5e42b960 ("mm: avoid using vma_merge() for new VMAs")
>   2e71337ac26478 ("mm: explicitly enable an expand-only merge mode for brk()")
>
> fc21959f74bc1138 cacded5e42b9609b07b22d80c10 2e71337ac2647889d3d9d76a5ce
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>     201.54            +2.9%     207.44            +2.5%     206.52        time.system_time
>      97.58            -6.0%      91.75            -5.0%      92.66        time.user_time
>    1322908            -5.0%    1256536            -4.1%    1268145        aim9.brk_test.ops_per_sec
>     201.54            +2.9%     207.44            +2.5%     206.52        aim9.time.system_time
>      97.58            -6.0%      91.75            -5.0%      92.66        aim9.time.user_time
>       0.04 � 82%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.10 � 60%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
>      90.66 � 71%    +411.1%     463.37 �113%    +160.5%     236.20 � 12%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.blk_execute_rq
>     127.98 � 86%    +586.2%     878.13 �150%    +192.6%     374.47 � 56%  perf-sched.wait_and_delay.max.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.blk_execute_rq
>       0.04 � 82%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
>     111.98 � 31%    +323.3%     474.03 �108%    +110.6%     235.86 � 12%  perf-sched.wait_time.avg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.blk_execute_rq
>       0.10 � 60%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
>     149.30 � 58%    +495.3%     888.79 �147%    +150.4%     373.80 � 57%  perf-sched.wait_time.max.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.blk_execute_rq
>       0.30 �  2%      -9.0%       0.27 �  4%     -11.5%       0.27 �  7%  perf-stat.i.MPKI
>   8.33e+08            +3.9%  8.654e+08            +4.5%  8.708e+08        perf-stat.i.branch-instructions
>       1.15            -0.1        1.09            -0.1        1.08        perf-stat.i.branch-miss-rate%
>   12964626            -1.9%   12711922            -2.6%   12624576        perf-stat.i.branch-misses
>       1.11            -7.4%       1.03            -7.9%       1.03        perf-stat.i.cpi
>  3.943e+09            +6.0%   4.18e+09            +6.7%  4.206e+09        perf-stat.i.instructions
>       0.91            +7.9%       0.98            +8.5%       0.99        perf-stat.i.ipc
>       0.29 �  2%      -9.1%       0.27 �  4%     -10.8%       0.26 �  7%  perf-stat.overall.MPKI
>       1.56            -0.1        1.47            -0.1        1.45        perf-stat.overall.branch-miss-rate%
>       1.08            -6.8%       1.01            -7.2%       1.01        perf-stat.overall.cpi
>       0.92            +7.2%       0.99            +7.8%       0.99        perf-stat.overall.ipc
>  8.303e+08            +3.9%  8.627e+08            +4.5%  8.681e+08        perf-stat.ps.branch-instructions
>   12931205            -2.0%   12678170            -2.6%   12593410        perf-stat.ps.branch-misses
>   3.93e+09            +6.0%  4.167e+09            +6.7%  4.193e+09        perf-stat.ps.instructions
>  1.184e+12            +6.1%  1.256e+12            +6.7%  1.263e+12        perf-stat.total.instructions
>       7.16 �  2%      -0.4        6.76 �  4%      -0.3        6.83 �  5%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.brk
>       5.72 �  2%      -0.4        5.35 �  3%      -0.2        5.53 �  4%  perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64
>       6.13 �  2%      -0.3        5.84 �  3%      -0.2        5.97 �  4%  perf-profile.calltrace.cycles-pp.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.83 � 11%      -0.1        0.71 �  5%      -0.1        0.76 �  5%  perf-profile.calltrace.cycles-pp.__vm_enough_memory.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00            +0.6        0.58 �  5%      +0.6        0.57 �  8%  perf-profile.calltrace.cycles-pp.mas_leaf_max_gap.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range
>      16.73 �  2%      +0.6       17.34            +0.5       17.27 �  4%  perf-profile.calltrace.cycles-pp.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>       0.00            +0.7        0.66 �  6%      +0.6        0.61 � 45%  perf-profile.calltrace.cycles-pp.mas_wr_store_type.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags
>      24.21            +0.7       24.90            +0.5       24.71 �  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>      23.33            +0.7       24.05 �  2%      +0.5       23.87 �  3%  perf-profile.calltrace.cycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>       0.00            +0.8        0.82 �  4%      +0.9        0.92 � 11%  perf-profile.calltrace.cycles-pp.vma_complete.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +0.9        0.87 �  5%      +0.9        0.86 �  6%  perf-profile.calltrace.cycles-pp.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags
>       0.00            +1.1        1.07 �  9%      +1.0        1.01 � 14%  perf-profile.calltrace.cycles-pp.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +1.1        1.10 �  6%      +1.2        1.15 � 10%  perf-profile.calltrace.cycles-pp.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +2.3        2.26 �  5%      +2.2        2.19 �  5%  perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +7.6        7.56 �  3%      +7.5        7.48 �  4%  perf-profile.calltrace.cycles-pp.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.00            +8.6        8.62 �  4%      +8.4        8.40 �  4%  perf-profile.calltrace.cycles-pp.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       7.74 �  2%      -0.4        7.30 �  4%      -0.4        7.38 �  5%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
>       5.81 �  2%      -0.4        5.43 �  3%      -0.2        5.60 �  4%  perf-profile.children.cycles-pp.perf_event_mmap_event
>       6.18 �  2%      -0.3        5.88 �  3%      -0.2        6.00 �  4%  perf-profile.children.cycles-pp.perf_event_mmap
>       3.93            -0.2        3.73 �  3%      -0.1        3.81 �  4%  perf-profile.children.cycles-pp.perf_iterate_sb
>       0.22 � 29%      -0.1        0.08 � 17%      -0.1        0.09 � 42%  perf-profile.children.cycles-pp.may_expand_vm
>       0.96 �  3%      -0.1        0.83 �  4%      -0.0        0.93 � 11%  perf-profile.children.cycles-pp.vma_complete
>       0.61 � 14%      -0.1        0.52 �  7%      -0.0        0.57 �  9%  perf-profile.children.cycles-pp.percpu_counter_add_batch
>       0.15 �  7%      -0.1        0.08 � 20%      -0.1        0.08 � 25%  perf-profile.children.cycles-pp.brk_test
>       0.10 � 11%      +0.0        0.10 � 28%      +0.0        0.12 � 10%  perf-profile.children.cycles-pp.run_posix_cpu_timers
>       0.08 � 11%      +0.0        0.12 � 14%      +0.0        0.12 � 12%  perf-profile.children.cycles-pp.mas_prev_setup
>       0.00            +0.0        0.05 � 46%      +0.1        0.08 � 16%  perf-profile.children.cycles-pp.mas_next_setup
>       0.24 � 19%      +0.1        0.31 �  9%      +0.1        0.32 �  9%  perf-profile.children.cycles-pp.mas_prev
>       0.17 � 12%      +0.1        0.27 � 10%      +0.0        0.19 � 16%  perf-profile.children.cycles-pp.mas_wr_store_entry
>       0.00            +0.2        0.15 � 11%      +0.2        0.17 �  8%  perf-profile.children.cycles-pp.mas_next_range
>       0.19 �  8%      +0.2        0.38 � 10%      +0.2        0.41 �  8%  perf-profile.children.cycles-pp.mas_next_slot
>       0.34 � 17%      +0.3        0.64 �  6%      +0.3        0.61 �  6%  perf-profile.children.cycles-pp.mas_prev_slot
>      23.40            +0.7       24.12 �  2%      +0.5       23.94 �  3%  perf-profile.children.cycles-pp.__do_sys_brk
>       0.00            +7.6        7.59 �  3%      +7.5        7.49 �  4%  perf-profile.children.cycles-pp.vma_expand
>       0.00            +8.7        8.66 �  4%      +8.5        8.46 �  4%  perf-profile.children.cycles-pp.vma_merge_new_range
>       1.61 � 10%      -0.9        0.69 �  8%      -0.8        0.83 � 14%  perf-profile.self.cycles-pp.do_brk_flags
>       7.64 �  2%      -0.4        7.20 �  4%      -0.4        7.28 �  5%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
>       0.22 � 30%      -0.1        0.08 � 17%      -0.1        0.09 � 42%  perf-profile.self.cycles-pp.may_expand_vm
>       0.57 � 15%      -0.1        0.46 �  6%      -0.0        0.53 � 10%  perf-profile.self.cycles-pp.percpu_counter_add_batch
>       0.77 �  7%      -0.1        0.69 �  5%      -0.1        0.69 �  5%  perf-profile.self.cycles-pp.perf_event_mmap_event
>       0.15 �  7%      -0.1        0.08 � 20%      -0.1        0.08 � 24%  perf-profile.self.cycles-pp.brk_test
>       0.20 �  5%      -0.0        0.18 �  4%      +0.0        0.20 �  9%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
>       0.10 � 11%      +0.0        0.10 � 28%      +0.0        0.12 � 10%  perf-profile.self.cycles-pp.run_posix_cpu_timers
>       0.07 � 18%      +0.0        0.10 � 18%      +0.0        0.11 � 11%  perf-profile.self.cycles-pp.mas_prev_setup
>       0.00            +0.1        0.09 � 12%      +0.1        0.11 �  9%  perf-profile.self.cycles-pp.mas_next_range
>       0.36 �  8%      +0.1        0.45 �  6%      +0.0        0.40 � 11%  perf-profile.self.cycles-pp.perf_event_mmap
>       0.15 � 13%      +0.1        0.25 � 14%      +0.0        0.17 � 16%  perf-profile.self.cycles-pp.mas_wr_store_entry
>       0.17 � 11%      +0.2        0.37 � 11%      +0.2        0.40 �  9%  perf-profile.self.cycles-pp.mas_next_slot
>       0.34 � 17%      +0.3        0.64 �  6%      +0.3        0.61 �  6%  perf-profile.self.cycles-pp.mas_prev_slot
>       0.00            +0.3        0.33 �  5%      +0.3        0.30 �  7%  perf-profile.self.cycles-pp.vma_merge_new_range
>       0.00            +0.8        0.81 �  9%      +0.7        0.74 �  9%  perf-profile.self.cycles-pp.vma_expand
>

