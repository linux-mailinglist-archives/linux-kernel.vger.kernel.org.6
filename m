Return-Path: <linux-kernel+bounces-538755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EAFA49CAC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F313B2B55
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A051EF36F;
	Fri, 28 Feb 2025 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="qUdkQuv3"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021102.outbound.protection.outlook.com [40.107.192.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82C61EF361
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754900; cv=fail; b=QSp/pBMm/TFx8v/8HuJxIC3QnDQvQQeQ8sXc2/mZv4I5O/IJBoFGtLtK39v31ZO5Xrzt2j++0759I2BSFVHk0Vv78o1phNdHdw5h19rckKlyIwGOat3wB+Ngr3Nb9xQVP6VJHnUOijVpi/Ol3N3r11Qfx/W5uTS4lKjL+epHczI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754900; c=relaxed/simple;
	bh=igYutbDpORdA+I008oAKrwkY8exgkP4UGVIyTChKMAk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DmK9qDVXG/asc2ez097gGX392Xmnb3WUA+YJM6JfXJrmNqSojpNToFyRfX879xX3aBMq8ioLz7s80oJtjpwIdj80t51w2L1otFKwG0upC6VTd6YdYpnXc7tTdxtm31uIqQigWTcEKpdDtGK3arV7Yka2qdixYc3Q1AFtotnXOJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=qUdkQuv3; arc=fail smtp.client-ip=40.107.192.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLjWv+7TIjUGZnUvkNcHZgqiO1CGaBV67/3d4kRQBFGpnqwIKlkF/xERyBStVrRZeCMLxRSfEGck8Ygzo48k2mRzx8hKre8/DFX2+eC6jwO+oFBJ4LLxjOjoPzw3PdSfFwAoYqNnG0ZLYWAyMppwu7b66r7JCvDZlcuqE0DF5OF75iKNQD7wFBRruIdacul4c/AypX4BYPe9JVWG/S9C3AaDmWowrrZ7OLO713TWQuMuSe8SeJwRlG6VUkF+nB/MkI/BGkWSBR0IPhsJfWI+JE+J9kppZ1+dA4YxVdnZywzEKmRUD63nRtlVW0XltTtKijmyJNSNzrkXoJzamAEhcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgK+oLg8AUq90N2uu1URdoyCtyYft3xL8hsPSWHlmKk=;
 b=a1ck4f2jSsJ8ZwGVjzVzr5USuYDiwF4UcMXv/O1J/caJy75EeldBQwFn09uBlzniTJgjQvH1mrR4ATAET/A4vXk7z4scVpBuoW10ODmJLqITnW1aVbfNIB827caHLkbQkB2MRR4GHxaptwEnNYCoXccdTQo+jW8U6SVHxEyUzU4VhDF5GUNxKHyiqTC1MclPaeK2f5Id57CxBUvyvoRv6LxfoIzvE/gwf4KevcEiolOnJdBAtd4ohGdmVqlByuwUYAV1eGX6/or67oVUBQHGedXDxYWyYOHTA3agSldWQCP9Kgr8JMrdPifsIHz4XoQ5CYZ3p7oGsD1Lris7/bIqQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgK+oLg8AUq90N2uu1URdoyCtyYft3xL8hsPSWHlmKk=;
 b=qUdkQuv3FigtMfBEY22aYbbhl8y5E5Xn2oH3W26dFBV87x0sywDa4OnpAKzMQe0/HpXdhe1/Kbrf+dANfdkrJw02r00SSvXVdPONVlt8Mu/KuazSmkLlXCAMQmXMf05lYo7TQHAbBGphzlpMNFUb58AGlCvQo7aEoTS8vX9qR6s7fgUv+ZHkIVmrRzJrIUEErwNIh6prSbsVhbbr7Wia98XU1z3HIa3+9KBfOHstVaWBuS/p2KrlpVxv1iAWhTUoJvh+L0oVP6EjI4eRAIM9OUh6LyvVV1Jfau9ya+JSzILoPb0Yav7kTaXLXVwDCjGKCjJxfyjEA/Pnhkffw07tPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PR01MB8665.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 15:01:36 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 15:01:36 +0000
Message-ID: <78ebaad9-c7ba-423a-a824-c2b1a499aea6@efficios.com>
Date: Fri, 28 Feb 2025 10:01:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] SKSM: Synchronous Kernel Samepage Merging
To: David Hildenbrand <david@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Olivier Dion <odion@efficios.com>,
 linux-mm@kvack.org
References: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wgedRzDqOLhbOnvziVHZm9jtGOrT4GJEqA9etJDwTQ5Mg@mail.gmail.com>
 <8524caa9-e1f6-4411-b86b-d9457ddb8007@efficios.com>
 <CAHk-=wi5-+P49c3NPeZB_qrNyOtAJS3YadHB0q7J3eZ3UUwrjw@mail.gmail.com>
 <029759d4-f7b2-4ec6-b5d0-7c8a1c0fbd80@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <029759d4-f7b2-4ec6-b5d0-7c8a1c0fbd80@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::23) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PR01MB8665:EE_
X-MS-Office365-Filtering-Correlation-Id: a74174db-460a-40c8-1685-08dd5808cbdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0t6NEtTdWoyakxJNC9QY2k4eUpKdjBaMlE3enRVSml3MDFyTjFsSEZyV0E2?=
 =?utf-8?B?MW1KQ2VVOGJoeDBUNkhqSnZtT3c4R1RUTFNOdHNEeG1TRE5vUzdlamZUK3pN?=
 =?utf-8?B?aEFicnhXbElpOS9GcDJIRjlJNy9GZlRZZWF1WnFJcHVQdDlFUmFQR055UlJr?=
 =?utf-8?B?c0ZjcnlYV2gyQjJCS2x4b0xIbExmSWdaZmYxMS9aUEdGTzRwWmZscjY2RDVC?=
 =?utf-8?B?S1BVcUVnYStndzdhM1JZaExISCsxTDMvQkNiRytJVUQrNlM1cjRBYmpNMjRK?=
 =?utf-8?B?bmJuTG5TWCswUDBMWGEvVVNXaEcvbUpXcDFIU1Q1U1ROL2JKdXA4bjhGTXB2?=
 =?utf-8?B?NDdUQmJWalZGQTdsdk5sdmFrYVVBTi9BcU5oQWxUQ1ArK3phM2I1OU5JZ3ZD?=
 =?utf-8?B?STFVQ2FYUlZmV1ZqZ09hSSswN2YvalhaMHBJL0hiTDkybFllcUVzREpSTU01?=
 =?utf-8?B?M0kyQ0FKMzBZQStra2VQUzNqdzZaVXlFcjZTREQ0aGFRekt0b0lHam5KcWs3?=
 =?utf-8?B?SVc0V0Q1RFpvZVp0aldRUC9EQUJpeVI3dXFTZGxVSmV3VHNVbklaWnBWWjUx?=
 =?utf-8?B?dVlSd08xVEx1UnNEOTR0ODMvQXB2Zy9Nc2NuZnFUWElmQ2dtZzFLWFZBdklk?=
 =?utf-8?B?ZzBrcmd4TWQ5NWRJY3k1dUczaWo0Vjd1LzM3RXdwOXVlUWJzMFZ4RVphOHBX?=
 =?utf-8?B?K0M2dUxKSnk5bkNwcGoxWDlSOE8yT0NaSzRYaGU2MFYvVVVQSjRYMUEwa1RW?=
 =?utf-8?B?NVdOSG8wN2NOUks3czJFOS9OY2JVckYxUkNIVks1OTVIUUpjMUxhOCtuUkpS?=
 =?utf-8?B?ay9KWHp5Qi80Nlp5S1EyVkU1YURQSmxjOFJ2ZWYxVWVDbTFSaVBnb3VuZnNi?=
 =?utf-8?B?QTR3S3MrTWlqOUY5ZSsyY3Y4cGJPVGNQNnQ3ZHM5OHZQRFMwNXF5bjVRRHc0?=
 =?utf-8?B?d1NmR2hvbk9LRTFpZ0p0eWNPdFBrRU1UbGFXaC9PcTBKelFGVkcvM1Y4VGJ5?=
 =?utf-8?B?N1RVTGYzaGRUeFIxcERscDVEYzd5YS9ncGNSV1BqSmZMdXVFMURSTE9lSEpo?=
 =?utf-8?B?aXJ0eWFwdUcwL21ac0VRQ0RrdUhkS3luclZaZzB1dE5LSUcvTHVlWi9hR1dz?=
 =?utf-8?B?WW9ya0dTelZGQTV2Q3pjb21ocWovK1pWSTJiUHF1cXNUUXIzOEg0eDRLM3dI?=
 =?utf-8?B?WVNBTC9EQm1EUzd1U1p6Q3lNQTZLVzJ5U1dYR081M09IY1ZxK2ZYV0lHc3A3?=
 =?utf-8?B?UzdPdXhyQmh4S2o2aVhxeHFpMkwzc3JFTWdGMmUwdE5LWGMyeDU1NnFVNzB5?=
 =?utf-8?B?UmJuSmFUN1kyWlFoTHdJSUUvOGhRcjBFVFhHMVpacm9JWk9PSFZwMGZUZE4z?=
 =?utf-8?B?QnQ2UWpyL2lpUVgzbWtqcDhNYmdLRHQvNW5aZlBlWFI4eHU0QmdZbHFxelFx?=
 =?utf-8?B?Nit6NzJsRXFGejNEcDBqMTIydkpsaGNsS3I5ZW5rdmpTSGtyT05MLytZT29i?=
 =?utf-8?B?RWtXK2JRb3lCOGQ5d2ZWb3VpQ3JsbTExTjNWMGxkOEdlaEFmZ2hjd2lWTWl3?=
 =?utf-8?B?Vmh6YmE4TGFpa01IZ3poZk9ibEZLMUpZSzN2V2VGaCtONjM0UVpxT2daYzRr?=
 =?utf-8?B?UUorN3k1Z0paSjBzd1NGNGU2SExjaGZZc0lrV2FtRlhPYUpnTXNDdExzR28x?=
 =?utf-8?B?c3puTWpNaWt0L0pGdTY5QmFtcm1WMWNjREdGZm5QSDl2bm1zU08wWnpUMVQ3?=
 =?utf-8?Q?K0eEAQPE03p3SB2m6s9/5s8LHEwcBS1yO7la59Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rm8rRUl0MDk5RlNVcElqMjUwMW9tZ3gzU3Iwek1lcGxnVzNrNUd0MDg1SWEz?=
 =?utf-8?B?cDhPVVdwOUNoM2xMaDBtWkNHTmdJQUloejU3U0prb0lzSEVMaWxNSlNrc1Fw?=
 =?utf-8?B?cUlaQmQ0Z3RhdzBTRHdrMzRET3JSZjVhQ0YveFhWcFVkS3cvR1F2UjREVU5q?=
 =?utf-8?B?RENJR0pXZjFrOFpMdjRiNURDNlh0aVU4RWhZQTVRZDN4aW9tYnBKVXRUU3pK?=
 =?utf-8?B?emxhMk8yQzQ1cVJlMC9CQWdiSzQ2S1NncTlsRit0TlVnM0J0T3JsTzVEMWJp?=
 =?utf-8?B?eC9hbXNnT2J2TEFnTXY0Sng3UzBGZkVjZmx5S28vZ3BMcmI1QzgwUjdzek5n?=
 =?utf-8?B?ZUt6b1c1TUhScjcyYU5Ma3dZamVVcy9FbDFtS2t6TVQrMEJLRzVVV1dhTXZD?=
 =?utf-8?B?NklzSzZ0Mk5KTGMrNWJCTkE5Wm9Xa3d5MkdkQkZ3WHAxM0tEV2dNKy92QTVr?=
 =?utf-8?B?VzVQWWxFenAzWjc2ODQzR3VVRldPTVZDSXoyU3d3eFlaMGYvWE5UWnFIaEJq?=
 =?utf-8?B?T3V6RmF6SW5oMGxUZjRLSzdoV0ljcGsvRE5qS2xPOEI1S040RmNIYUlya1Vk?=
 =?utf-8?B?SkI0NTVOeHFlZjRvTkVySXNsYzV0a2liTmVZUW5WcG9qdXBoQVZkM1gyc3dm?=
 =?utf-8?B?Z25jSVNJb3pwSzV5QUpxVXVjOUpSbFdUekQ3WHBzUlQ3UUFJQnhKOEp3Tjcz?=
 =?utf-8?B?RmZtLytBOXNFZEdLQTVGays2ZElIR2lOTWwrMFNRK1Erc2NYSTFJMk9ObGpy?=
 =?utf-8?B?TDUwTUkvakZrRm0xMFlMS3MwMENLZVczNjdUL2VCZmxuVWhZdG9JdVE2ZjM3?=
 =?utf-8?B?dEs3aHY5a1d5YVdpY29JMWFPOWY0U1dSdEhjYlQrMERXaUhIaldud0VKNW5m?=
 =?utf-8?B?cUVENSsxeXM1bmcyNkh1anN3M1FOR01JZmsvRGlJczFhaThqM2ZWSkpBQnZU?=
 =?utf-8?B?cUMrM09VWW92azVyRFZkeGxBbmx1dGQrS0JFVXc4M0d3Q1drc1dYRUNzeGUx?=
 =?utf-8?B?WDN4NmZsZEo3WGRQa3lFQ0ZETDFoRmZ0NDJjYjFFMmRmdE5EcTUxcDgxY3pz?=
 =?utf-8?B?WWJwTEtMaEpiMk5PRlNUd1BHajFaU1EzcWEvcHdtOHpsUk92UW9pTndWUlZm?=
 =?utf-8?B?ZXhZTm9NRGE1M2srMitYelA0bitSck9uZlFwa1VBTGFJWnh1cWdGZmdYS3Fq?=
 =?utf-8?B?dkhha3pVallLck1rdGpJb3JVOTI1UXI2dWZBeW1RWEc0UzVVTlNCTzg5eVJw?=
 =?utf-8?B?Z011UXFJeHllUXZtNDJIc3c5ajkzVmhrVGtwalZZbHU1VkdvU0NsTTY1dmdU?=
 =?utf-8?B?M2d5U1hxRTlXeklWYnp6Z2JZSS9BeEQvQ0NKMEZHVWlnQXVGcFI2ZHQzSjVx?=
 =?utf-8?B?N1FvSUZVL2tOZGtSenJOMllFaGVRcDdWby9Lb29RY2dVU3d3SndsNXI4dmhY?=
 =?utf-8?B?MjJ0R2drc0VSb0VaSEZJeHRONzl0K2w0VytJNXdSQ3YycS9vZUgvRUU5RU9x?=
 =?utf-8?B?SHZMZG5GY0E0TDdPekVxQ3M4K3MxRnJYWS9mcm5YTkdZRkFtb2dlT09RSnRB?=
 =?utf-8?B?bjBjT00xSTE2bjl2cFV5Z2VxRWxGZExadVluRmRiUVEwSGhwWkRrcG9uaHgr?=
 =?utf-8?B?U1pRN0FoNkdBdGdEVi95MkpWb3p1SmVjaEQ4WG9IOFNrMGw0MmF6RlduNUht?=
 =?utf-8?B?RkVVeXZPZjBCVnlwTXhyZEZVRERDbEpWanFPV1k4anh5VlZmcWVpQmtEcnhU?=
 =?utf-8?B?MTYvdUIxTnVYTFFQQkN6YVM2SXZjQW8xc2xkRG1EYWxPd0JPSWR4VWNaREdt?=
 =?utf-8?B?SnladDFWMkRaa2NKK2ZXeTltMnNIaTNkd3NSajVsYS9ycGJlc1luQiswbjJW?=
 =?utf-8?B?QXRiMG1MaVl2V3dEQm5zM0xjU3pXRzcwTHp5R0lhbFNKOGhkMUFSU1dodXpF?=
 =?utf-8?B?Z0pVRWJVYnhxbDExWkNxcTBDRW1pNHFYbGx2bVowQ3RBMWNkNkRtTnZyQ2k0?=
 =?utf-8?B?cHU2UkZpd0lyNlpqeXdnYk0xTGoyNjNpejVCK21BOFpUeWRYeFVrdWtCMjdI?=
 =?utf-8?B?QU9aejJRMHU4ZUNxcG53TEVSR1BmSHhDclNEd1VzMTEzc0twUnBIVkgyekU5?=
 =?utf-8?B?NXNEeFlEQ1o2SHAvU2Y2RGpGQjU4Yk5tN3ZNcEUxZWh4ZTd4RjJ6YStGODhr?=
 =?utf-8?B?dnJEdm9xY0l5bXVMcTRPbDlnaHZwek5KUHIwVXFOZzY4QWZuSHJmTjM5czlN?=
 =?utf-8?Q?7ZTPIGdHW+o/j8mA5pgXlzJoMS0xtHe7RctnLYE91s=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a74174db-460a-40c8-1685-08dd5808cbdb
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:01:36.1691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUM9kOgpzZX5Ju2Ej2osQkyYxxDm1Z29BKNqSsRl6w6mc6kcEKAWJ0n8+2+S9g49WsykQEOqGPnA/RBwhuwa5KjHyKOgRXp5I+WO4Nu4yN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8665

On 2025-02-28 08:59, David Hildenbrand wrote:
> On 28.02.25 06:17, Linus Torvalds wrote:
>> On Thu, 27 Feb 2025 at 19:03, Mathieu Desnoyers
>> <mathieu.desnoyers@efficios.com> wrote:
>>>
>>> I'd be fine with SKSM replacing KSM entirely. However, I don't
>>> think we should try to re-implement the existing KSM userspace ABIs
>>> over SKSM.
>>
>> No, absolutely. The only point (for me) for your new synchronous one
>> would be if it replaced the kernel thread async scanning, which would
>> make the old user space interface basically pointless.
>>
>> But I don't actually know who uses KSM right now. My reaction really
>> comes from a "it's not nice code in the kernel", not from any actual
>> knowledge of the users.
>>
>> Maybe it works really well in some cloud VM environment, and we're
>> stuck with it forever.
> 
> Exactly that; and besides the VM use-case, lately people stated using it 
> in the context of interpreters (IIRC inside Meta) quite successfully as 
> well.
> 

I suspect that SKSM is a better fit for JIT and code patching than KSM,
because user-space knows better when a set of pages is going to become
invariant for a long time and thus benefit from merging. This removes
the background scanning from the picture.

Does the interpreter use-case require background scanning, or does
it know when a set of pages are meant to become invariant for a long
time ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

