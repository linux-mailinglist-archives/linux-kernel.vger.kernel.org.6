Return-Path: <linux-kernel+bounces-518310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63995A38D07
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4EA3B3C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08A6237163;
	Mon, 17 Feb 2025 20:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="SlqENjSe"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020117.outbound.protection.outlook.com [52.101.191.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDE823642E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 20:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822959; cv=fail; b=a7O/BAdCIJMDur3yVYBVLVTdZQjrarVXkWLAokkta0N0SFe4CFINAQqDOiYz1zuRh892sn3iOB4w0pjx3KI0Y20gZ0FmuRFwWUzrj7qLqEnw7st4xBZOZXuaEPPxRcsdbji4Grs6WXPlChi9q7W/3a1VDmSkNhLKAZM5MORGTyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822959; c=relaxed/simple;
	bh=0dcXSOU7z7DK1PmWqQ2+PjKoJyHqOyoOH4E2GPZE1Xc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=foQ+hD70ls+mnqAUDZya4y7VLlkvzCpTHJ9pnCdLqy/dFLqoXRvGtUlEnAJqkdQ+JwKW27Ds30jL8lPlBajrbKNSDoY2HP3DLozkGui6RDiXVK+ze48lqG1X+4hxOF7Pqr6O0bv6JarhechoMTSX3W0vm9yFIdBswJ3EOOk9HJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=SlqENjSe; arc=fail smtp.client-ip=52.101.191.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7iOglT20VObYUybYMCFvpMuR3+7uwzO3lyeQITuPTd7s5xVjIbb0CZUqxp9FJ12+vE8G5TihifjZPpKZOXq0ykUqCo45EufYRARgHfHocUxhf9Em4ztrxF0WatS63VDHj9XmSy+hwVQQTGuj+fftgPdudsV8RF6bsLnACLTVXdP9yTN8LE33LmG+G08/guVlYSBM3W3OCkCTjmyR9tmG4ELdSsedOgfL8mkq8MS2ubvDb9tYCWY3bKp9lPP0nbHNltwJaZgUoAodjVl8/HK2BiviKb8en4n48cdEG4gVunrOkQPnOpU0Oyy9c2LJomyl7ItgF+uD1mMqasocXZduw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Eh0xr/u40NdfM/TGujvlUfAhTRr8cELUH2e8Y1SITg=;
 b=OJgQibQ77PexrqQ5isoPdKxefCh4FcJtfGNSDPUBrutoHs7XsrEhcgSlofloEiS1HXS/OkmltozWe0O8j2BgQlXELruxd6vVYEfIPQoTSrp4m5tFGQiALQCmucZ2kIsBKyvI+UpJ1tyOqphI1pYxAK0kNxGgwlFfTn6LGe2tK598PH6liIGFfLwC+hWhli33X85Ygjv85lFGO8GIzzeuOwUmvXcMgTJ3mv+HEBxeI/ak8mH5zZ+LOUmsA5+ReUx8uKOf52YasMYmWIK3oSjT68Hmh8z3TnnsfKfZM73wsAnGky5UuZQf1IBBCZeYo4+nG2gfdbQBSkLmXfxQra5SjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Eh0xr/u40NdfM/TGujvlUfAhTRr8cELUH2e8Y1SITg=;
 b=SlqENjSev++wJMwff20sK4vA6mkdSAwaZGCZ0SbCZE743ZJg3/oLxHkOhJeaeV1oYbmSpuqet0MRYilNByiICbySZ2ZKHluA85m+1QfSRQ/4Dg/izIg+pkhVFh/HMqOyXK65wzL1kNnkGUH5cj7//9FZDe3mVRZsLiSOu1bf87Sa1RfjxrDqRnnlXlDHGnAoABCIjI7f8D3GvlPC36NjhUGV36kJ62YZPuXYICV0mIP8/NSu/NpoG71cx0Zx11l+3mlHgp0TeTN8+w/rhaNwPZYXVp874EWw7IeXCF+3wLM+pHGXmCFiGTyugF6p+rR0A//Rvgp2LdSGKu/jPPT1tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR01MB10625.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:74::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 20:09:14 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 20:09:14 +0000
Message-ID: <4caee61b-2214-4ae8-a9e1-2c1ff0efd7ef@efficios.com>
Date: Mon, 17 Feb 2025 15:09:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] pkeys: add API to switch to permissive pkey register
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dmitry Vyukov <dvyukov@google.com>, peterz@infradead.org,
 boqun.feng@gmail.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com,
 elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1739790300.git.dvyukov@google.com>
 <ffd123bb0c73df5cdd3a5807b360bd390983150b.1739790300.git.dvyukov@google.com>
 <9e866a2c-ef36-4008-a3f9-c476161f64c7@efficios.com>
Content-Language: en-US
In-Reply-To: <9e866a2c-ef36-4008-a3f9-c476161f64c7@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0266.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::31) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR01MB10625:EE_
X-MS-Office365-Filtering-Correlation-Id: c252ecfc-afe3-4e23-0101-08dd4f8ef333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azFlL2crLzNKSkZubmFUeXBCUVhxVE1sLzJWVWZycXJtY3YveTBzSWorNHpp?=
 =?utf-8?B?anl3YnJMRE8ySngrVEZacHpxMkpYMVA5dGdzZUJvQWUvb2NHbkk1ay9LS3ZI?=
 =?utf-8?B?NTliUVZsVE0xRVd6bGFjV0ZXR3hPcTV5ZmdNeEc1d004MldnRG5URFZUbjRp?=
 =?utf-8?B?QUNOT1JaZ1h6UnlkZzZmdzhQUGZmRXY5ZThmb0dkZlNLOThwWWs2ZFoyOVM5?=
 =?utf-8?B?Q3dtSzhHWUs3RkF1TWVOV0N0OGkxQ1pHRks2c2wxK3V2a1UvZ0d3WkpRYmRj?=
 =?utf-8?B?QVBnZDhTUCs0TUVqeUpNelZQNEM0Z1NGOEh3a0xHYmN5R0R1bXcxMjI5VzV5?=
 =?utf-8?B?UlNiOTgrWldnYXhyeEh2ZTZEUjZiYWZ4NG40N3RhU0thbVNweWhUSzJXVzVC?=
 =?utf-8?B?OU5lNjI5N05kSTVYdlZ0NVdIK0FDZFJGbEwrakh2bCtDOXh0aFJiUlRLY20w?=
 =?utf-8?B?d3V3MS9OcVc4cDJIYmo2NGdnOUZISXUwM09jREwzTjZsWU5UM1VialA4SEha?=
 =?utf-8?B?TGZCN1pITkk0OHRNRGNPYnFVZXRFalRsUjR6QUNqZUpCaUJ2ZkFkRW5ZWFJT?=
 =?utf-8?B?bkdTcjArQmRsN2V5Q05lcy96TCt4NUJ6R0VpeUNqZytnUnFUWG5QZ0p1QkZX?=
 =?utf-8?B?SnA4NTFCVFl0aHhvaDVvRTF2c0ExekRzeHZWSW5rYUtoV012bCtpM0VMamk2?=
 =?utf-8?B?L1puWFcvMUJ3ZERNV2J3eFZPenFoQzN5M0thNFFRc1UybUJzZmU0OWZOV3ll?=
 =?utf-8?B?cXpXaVZHOElteS9OZjJwK0J0SHlXVkFVbTNSeVJmeXM5angzVjVvL2NjTkw0?=
 =?utf-8?B?UHBIUXc1cUFHZXF5OElJOEoveTlOQ2VRSUtwbjYxeVFJby95QTdVanBxKzRh?=
 =?utf-8?B?bTNYcEVZdXpMZjFLQjdQbGlwR25JUG1NdTMzVE5UM3NzN0paVjFSOEpma0dj?=
 =?utf-8?B?SHZscmR2VEVaVXhhYjFDRTBCdDYwSTFqai9BVS83V0IxNHVHb3hDTGpQVjQ4?=
 =?utf-8?B?cWtNdkNyTVR4bkpDRkVpZ2w4N3ptK01OUlZYbmpzei90VkhURTlzOWJLVjAz?=
 =?utf-8?B?eUVqMlhlTVhseVUzc1U5YzdFU3l2dGR2UnhOTEw0Z3JhcE1hRVozRlNKemgv?=
 =?utf-8?B?WVcyK1p1ZXhUbWpNZFcwRldNd1R4V2dJYVpGTVltQTJ1RFVwVHo4WCt6dDdv?=
 =?utf-8?B?Y3c1VlZQbDNKK0xMQmdSNVNRRjBUNU94TGVBS2FnNS9keTFrYjlMYWtKZFgy?=
 =?utf-8?B?TnU1SU5DbThmZzVuWUFteXNBbmdQYXdnZzVxaXgxUUF5dDNkMlpsN2hrb0Ns?=
 =?utf-8?B?YTVrb0FZdzBsaWNvN0UxVHpVZmMyYlhSYnh5RjIzd3d4My91OGdEd1F0ZU1X?=
 =?utf-8?B?VTcvWHExVnhKc2lHaUNMdmdUL3I3dFUvZEROTlpUZndaY2tLa0JiQ2JyLzRk?=
 =?utf-8?B?dW8zMUp0clo1SnRIM0ZzazZCSDJvK2NUclRBZ3Y2c3Z4cFVGcTFTQ01zTjhD?=
 =?utf-8?B?Zi9ZSEh4OHpIcjBoeUJtTHdrazdVc1NGK0lYamxscUVGY2hEM0NleVJxVHFo?=
 =?utf-8?B?blU2bnh3ZGkzck1tUmNmWlFYQ2xlWGR1ZVZ3ZnBEK1gvZWIyRzgrZDNvWGQ2?=
 =?utf-8?B?SUhYdUhYVXREb1hBYThCeTl1VFJvOVBSejJXSUJ0S2g3WVY2TlJSdGt4eFkz?=
 =?utf-8?B?WkxhVmZSeC9VcmQyN25yQWNvOXRFZXZYZWFWc3FJNFR3c1A2MHk2eUNmb3BH?=
 =?utf-8?B?OTNTK2trR2JWWUMyQ2JMUEYyYzB6SE9kM0tVM3BwLzFSNW1tcUpmU0RKdEdC?=
 =?utf-8?B?TWhLWndmRkh0M296c1BVK00xSFJhUTAvUExENzM5T1JhQk42MGxqUE5yYjJB?=
 =?utf-8?Q?arT1HTdlHgzBs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bG9mU0VaVGVGbkNHUDV1MzNEWVhrRTYrQVdMUlhBU0JieWhkaTJSdGxrY1Jx?=
 =?utf-8?B?ZkxROStRclRXVTd3OWk4QnV5WXJXbGZha21YOGtaNjVyUU5zNEZKeGNES3pj?=
 =?utf-8?B?bm0yR1QreFk5QWRpQUdHS1JiS0dQRm5JL2dTME1KSUhxMWhSdzhyMVNxMW5l?=
 =?utf-8?B?SU5TYko1SU5xYnN2MW9saW9ueDZyR1l2ZXpXMUF3d2plYzNMbVQ5MHc0UVY1?=
 =?utf-8?B?TWloN0lCN0RLalAvTzRjWXFsNjJ2alIwTmlHSXRJM1o0dmRrSFNCQ2hSQ21h?=
 =?utf-8?B?b09LaVJleHhCbVpPZVUwN0JlSWtaOVA1dTlKYlppQk9IWWx5RWJnemIza1Y2?=
 =?utf-8?B?czJBSmpjNis1eEYxTmZ5MXEvUHRlZFNrTDVMRzZQWE9OdVI5aHNqa3diK2tY?=
 =?utf-8?B?ZlR1UFFVUkFQeGdsN1Y1N2QxWHhmYkZ6RVJtQ3BUT2IzbkRxcmYyM3BtWkVU?=
 =?utf-8?B?cE9PMnJWSnkyVjZGbE5sVlNTTVo2YTY5R0ZTK1E0ZElHM0VOMk5hNmFKNXkz?=
 =?utf-8?B?Q3JoSnRVVGN1ZUpVNXB4bG9YQWpUdnNXbXltazRKVXFLRklRMmxKcHl2M0NJ?=
 =?utf-8?B?VUkwTUNOVlIxMHI3K25vejBtYnNDbDhMRzc3QVFqRnh4RGl0VitXWDhnSTIy?=
 =?utf-8?B?ZGI3a1dKUllmZWtQVnlUNW1PcFIwNHM2VWlTVDRZZUg0ZksxSkx5WmU5Zkpr?=
 =?utf-8?B?UXB5d2tFaDIwcGxNRUZjWHNuWnJrVkJKck5jVUczZXZVdmVKY25CNUgzdWM2?=
 =?utf-8?B?Wk5rcFNoVXRKWXpMZFYrZkRFdVFFNHBKbGJuWkFQRTJDSW9xYTNhallsNmhE?=
 =?utf-8?B?aGZ5azh4NDJBQnZ5YWFEaFU3a3hjUmhTNFBFcTJzN0dsNHFzS1ArUmxWOUZu?=
 =?utf-8?B?TmZ4dnN6MjAzQ01XczI0RWc4RmJGZGNiVm8yZ3B4Q2hLSXhpR21JMzg0azR2?=
 =?utf-8?B?RkZZRHNOYVVCbGdsZFhsYUZVUEdpTitrem45UDFmOURJaC9EengveXdKaCsx?=
 =?utf-8?B?blo4eVdTNDZLcStlajlUekZLRzlpYWdCa2NPT3U0c2pnMGZUV1BHc0VvZFpQ?=
 =?utf-8?B?RVdBWmMybWsxMCtzU2YzeDB3bVlRdVB0VEJEcStRc0ZrTThkejcvNlhyVjN3?=
 =?utf-8?B?R1BuZ01uNzJ2b2ZLWVJlVFltaitlaHo0NW96S0tpbzYrenVQZDhEMGs3NzZH?=
 =?utf-8?B?NDRITC9aS0RQSVU2U21Hd2JEb2RBM1VLV1pCajV6RkFyUG81d0FNZ1o3Ny9r?=
 =?utf-8?B?YTBMaUZpb2k0S1kvSXFnczA5dHRvck5RS09xTzEyc296NzZKRllaeVFVdXpG?=
 =?utf-8?B?dGNHMmV2K0x6NTdNWTQvOTVCdFhaSDYvalVVNzFzL2ZFS2YvSGdlMWowTGph?=
 =?utf-8?B?ZHpOZkg2ZXZaSU1lQ3JrdS9wcE5yVkJ1UkVSV0p0U2trMU9GWFIxcFpXMDN5?=
 =?utf-8?B?TGxYMjFkOGNCNXE5SGZ5U01Jb1NnbElya3V5dTNXTmQybHpaVHVBUmh2dEt4?=
 =?utf-8?B?WTM5aFJsT1B0UU9OM0pIL2NrR01EZlNibm9ZcXpTMGpISWxOQnJNcEhpY2Jt?=
 =?utf-8?B?NnJVNXZKZDVzRmcwaGQ2N2hQZ2d6UXdhV2hRL0Y5TVM2MksrbXJKdCt0ZXVE?=
 =?utf-8?B?V25Kek80NENqWWFZNzg2OWxsTnpCM3RXWXdOTVd5QmlWUkwyMWh6N2dwd054?=
 =?utf-8?B?T2lFYmEwb0xBbTlPcWMzS3VJQndsLzhrbHRPejVrWkoybDE3eWlwbDI0MXZm?=
 =?utf-8?B?M2FnNkdQSWtscGIzWUhsZjh2N2EyMDZ4akVhWm9GYkg0MlI1MG5UVEZiWURm?=
 =?utf-8?B?SUNWR0J0UVRlZWh1T21kc0Y2STZxSGNQREU0TStOQUZnM0JTeG9RNUo3dURu?=
 =?utf-8?B?YWh0NStxdmlqck55T2orTXVXRXkxdUxEV0VFUWdzTzRnbm5HRldCc09tU3Rv?=
 =?utf-8?B?THRnd20vdkdtVkxyNTBmbWdTVThhRTNQUlNzVmNvZzdIZ2pLYzNObnBtekhS?=
 =?utf-8?B?a01MVGttRzJWdERNdlg5dGRyVXFiYStLWklUVHJPTmxnYSs0WGFyZmhEek5M?=
 =?utf-8?B?cG0xTFYrWk96SkNyRDhpYjR1TkZJNFcxMVBoSHpFekxTSEhoWXJFZEgrc1Z0?=
 =?utf-8?B?ZXVtcDl1OUxKV2xHdURVNFdBMGhLZTZrSzU3U0JQMHE2TU1MNHJFeXBIYVpT?=
 =?utf-8?Q?K/rksffPchQc1lDjqc0bKtg=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c252ecfc-afe3-4e23-0101-08dd4f8ef333
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 20:09:14.1515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sqR8yiDGdQaxvwDCB/aDjt/5m9fRJJbWTi7K9/pqFD9CWDhLvCTh5op1UsaVh9nW4W8Erx6sWa9Qr6FqZwjWHmGYtWk5SJsNovT8J+106w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB10625

On 2025-02-17 15:08, Mathieu Desnoyers wrote:
> On 2025-02-17 06:07, Dmitry Vyukov wrote:
>> The API allows to switch to permissive pkey register that allows accesses
>> to all PKEYs. This is functionality is already used in x86 signal 
>> delivery,
>> and will be needed for rseq.
> 
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Sorry for double-review, I'll jump to the next patch.

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

