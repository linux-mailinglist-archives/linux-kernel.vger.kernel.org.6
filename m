Return-Path: <linux-kernel+bounces-560407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBAFA603B6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 179653BC1C8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9221F5828;
	Thu, 13 Mar 2025 21:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OU/TCx1S"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7757E1F30C3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 21:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741902900; cv=fail; b=UOjd1ftfgAEwup50eoeEJhQ9k8w4QXZwF6y9YZyfJHXZf2wr/mQEFFu/OlY8mDl6NNi+ybYe//ZxGHUGw8elxkUwHpXheS2dr79oJdBIWBkRUw6h5quveV0pU5iaW/gGSh8VccvlVICpivVEaKSVPak9YpTxhZucWDyi3IfRghI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741902900; c=relaxed/simple;
	bh=VrE/8SiMhLtsVHDgMHBdscveJir6Phc6bg/dL/GX1p8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iHOb+GlhB1QJkQKgJzDv8FuJl806O7aoYdyYlF0nZvqRwEivLjpVqn0COoiltxC2a62y4BLahFBG4LdkGCCZYHe9FgawD1Xb5OYGNIqQItSbqWALT5hTSOySBOoEMQBXS3Ctw4JCzVJEfUSfUp4WTaCtlQ8WROEs5Vpt7sE+2Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OU/TCx1S; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFSWm6Yr8CgoOK0I1l1jpLY0hbMDjTo78qq5OL296+lpwezJ294I+8Z3hsFTyZxPcOxplNEo4EHYyO+kR2pHf4Y5O/fMLe4CLFvGhw0Fwfkm0nBM4Ak4YnFZ2YvukuMYdhjA1Zdlvggzhp7LAxd4/qHOWGPDx53eYVUoOqvfZZFae2O3/Q7ZTcEbF/vBoNw/Mjaf3xu+Ux7yhoAdEBv818iEw2JFlO1sRjr+ey0QjSE4QmBfjf7efzoBsJqhRvqM1MuYIZQYmVQdDyQBIsLSuB4ixNEnmdCkkcT4axzeKd9/isZVLHo7e+pO/vEHaR4mT5B0HjP01o0PO8t7Ox7F0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oLMirMPdWs7zIbvpEPE5OqfaT582h0RWalj5hoYfIo=;
 b=qgsjeWBS1u2LIbtD/HsxssEaOjkQlXu4T35cQb2UmwJ9Xdd1kpL9/UhKqF3G/gFucrQAkbOeGn/jw0ThnSLz9hoTzolCYDT9zqSx5rmsZ9h2WUK6Rm1Ry3eSEJ8T5qB1N42f4ILt652RCcQxXMNIfLSslUaBwoGd05pwvNYU/w4V5yD9uAPMQzCx8CWHAU1liKHy+2SJ5JIN6bMjO1HhKrLfMvbGjTKL1Gc18JLVluRC7MFhfbnq0zk7LWPV+lzUwZ3G71YOh3ZrIfpb2397iREU/QPxz2a9795xXrw0JUaAN0DXWJFFSEkXm4aZiEBwD0AU6l57iGr8JcxZ7CWKkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oLMirMPdWs7zIbvpEPE5OqfaT582h0RWalj5hoYfIo=;
 b=OU/TCx1SQ1MifU6awfLDN7zTqBtQEVlGR9pI81um+/469BJ7qlFnSBkp0A/BpjNG/Dki8lM08Iq+z2GWEFG/u8dMAwEJ+WEBqO4odGZ2fplBUBwWzw37N7YpXizGOLaZAyZiVZq6oKXsjBEon4iOukmMe52T1T7nrTUPyP7xNsPkLBQiofZJ501pTwkF9LPW5aEJ4Odlvxs1+WNMR4E64hagAnzGSIsJYDiS8YU9OnwepcuqlPj6oph2YkGeEAJJYOTOVek9Kw6Qz9xZFxWpk54UdjS/BpGPtsAigWwKEPac/urHmHUAuYeHzorPxqpWlX80jznSXEc0om5gLhmvSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by DS7PR12MB8229.namprd12.prod.outlook.com (2603:10b6:8:ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 21:54:54 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%7]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 21:54:52 +0000
Message-ID: <b63b1de8-7eec-4235-b61e-e654e78543ba@nvidia.com>
Date: Fri, 14 Mar 2025 08:54:47 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7ffb791423c7 breaks steam game
To: Bert Karwatzki <spasswolf@web.de>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <20250310112206.4168-1-spasswolf@web.de>
 <951f9d13-72e4-41c3-9ace-8639e2a9485d@nvidia.com>
 <ce940e2a-632d-41be-9f13-e5b11d49b0db@nvidia.com>
 <09131c563332c892284ec7fb4ce706996131db8c.camel@web.de>
 <9a5df5627d3d72b2a97f501dfb7d944cc1e9920f.camel@web.de>
 <fdea59fe-f570-489f-bf88-1ffd47119cac@nvidia.com>
 <414f4deb8c7670a159854006b0c410ce05a6049e.camel@web.de>
 <12d950ee-4152-4ad6-b93e-7c5b75804b1a@nvidia.com>
 <705e95cec3dc5181ca2aa73722e6b84f63f3e91d.camel@web.de>
 <20b5823e-247a-456a-bb55-d50f212a9f5a@nvidia.com>
 <a34a1ae0b1d226b1bac7d73daa24da8e5899cb3e.camel@web.de>
 <c7bb0bd1-529d-466d-9cce-abbac4b480ab@nvidia.com>
 <146277bb0ecbb392d490683c424b8ae0dfa82838.camel@web.de>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <146277bb0ecbb392d490683c424b8ae0dfa82838.camel@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::27) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: c81febf3-024c-45b9-28d4-08dd6279aed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmNmMTRGMEJCYXVmcDU5amNvWW5rU2FITzZzM1VQNSt1Rm1ySTQ1bzdWTGlD?=
 =?utf-8?B?cnRGVjloZlplZHpDeXBLNzN6T2YyRGZ4YmpkMzUvR0xlNmo1ZXd3cXhQZVRp?=
 =?utf-8?B?T3dwdG5ZdXVIOEF4QTk0NU9tWWcrdmgyVjNiaktFWkl5YWN4YjYwL2lmUjFr?=
 =?utf-8?B?ZERGSUNNalN1ZlNjZjRWT3JzUkQ0azVlUUx4dVIremtYOVYrRGFiNEx1Q2ZO?=
 =?utf-8?B?dUdRaUhoZlNDY1gzMW1wb0tMa2t6cEtiK1psUzdrMTZiMnVEOXBnQTZXYUJx?=
 =?utf-8?B?TnNzbDVnemJBVjh0Tk5OVnZKNUNLd3UyeVprK1NXUnIrOEV5SEJMamtNNGNO?=
 =?utf-8?B?TkFHdXN5ZXR6TTJEaTNNTlFjZjhmdzBQUEFrbkh1bTlrVWJRL3dWRTdRS1Rw?=
 =?utf-8?B?Tlp2dDcwbUJTS1BvQVc2WWNEQTZOMDkrS3dmMTRoNHdra2piSlk4QW9NNFBS?=
 =?utf-8?B?MnBlcnUrdWdkZ29QVnVlcTgxcTFhVkU0U3l0eFI2L3JxbmJxOFdLeEZMdW9v?=
 =?utf-8?B?cGpRczNMR29qTDVoRFpyMGU2WnJta0tuajlPcjJXMHFtV0ZSWDZpVDc4N0s4?=
 =?utf-8?B?N0Q3VkI2ai9TbnYwVi9aNEs1RGpkMmFGdUo0Y3hnTFUzY1ZPNCsyMFlzcXRk?=
 =?utf-8?B?RFVtQ1JkekdGazl2MXNFQllpckkzb3pBVzRnWU5UTEpDQlVmbVFScUZuVkFZ?=
 =?utf-8?B?bFh6MXRUemtsQktNbmxOVGVQTVU5dDJHV2JsVUs3alNMTjhQRXlLK0w5Tk9o?=
 =?utf-8?B?MTdtRjU3YmhMYmMwb1pRdnVOVUhoNml0aHU3U2lvVUI1M0VmMzNtMWQrckJS?=
 =?utf-8?B?d1hvaU9NNm4wU0FLcmY3M25zaHk0UGJnWGxRcW9MNnhrNWNMUVBKSHlJbkIr?=
 =?utf-8?B?ek9GLzNGUFVGbnVYY0hOUU9jU0tuK0QyR1pPZXJBSGFubWVLQllFbnNOL0JS?=
 =?utf-8?B?WC9FMjdVa283bk9jR0JwZ0l0SGQvMStJRVRKdzk0WGlFa08ybHcrSERJenk1?=
 =?utf-8?B?eTVUdVZNbkZLWmxGYUhsQzNhR3hMY2hFYTNzblhGRDc2RkJraFEzWjhVeG03?=
 =?utf-8?B?UEoweUF4SWRKSnJPQ1Z3MnVjK2VsdnNyaTBmV2h5aDJyN1RWQmUrTFJBRVda?=
 =?utf-8?B?YUV0YkNueHgzQmw5ZVJudzJhOEpSUWdhUlJ4L0FIV2w3azQ0dkJ3U1hmVGpE?=
 =?utf-8?B?N3ZOVDdxSDhaZ25hK3Z5Q21zKzRIMG1ubkJaYWZkMWdTcEtnYmdiaUFxanp6?=
 =?utf-8?B?TGF2M2N2d1hOOWcxUmdGYWpBR2Q1Q0x4ajhDdzFxekZlM2NQanlTalBaZllK?=
 =?utf-8?B?cFVtWHlGTFdabjVROStoaTcwa045NHB4VmloMWNPakZsdlRMVUZWa0YzMGx5?=
 =?utf-8?B?cWFmL3R4ZCtWL0o5V3RReXJMa1IwLzQ5d1N3eWpqYml2VGpWTXBYOEREeG5r?=
 =?utf-8?B?U3hmbElpRFd5STZtTjdQcFEvN0JNR0lGQ0JENEg0dWp2SlN1a05mb0NTL2Q1?=
 =?utf-8?B?V1hXbk5acm1ZZWpXR3owdDV2MXFhTEJEVENLVSt0c3JPcXFkQkVlNEc0TzZE?=
 =?utf-8?B?UnBhRSs5VWwwRnkxQUNGVXJsdHczWVhnRHk3N1d3T3R6eEFWM1JIaTZsOUNO?=
 =?utf-8?B?UDFNeUZ0V2ZFRzJCNVVKTTBqOW55RGFrT0E5OVY5VE1JZHU5R3hXcnF0UHRT?=
 =?utf-8?B?UkRRRnFVWUZBNkI2WGFwSnJ1ZWl2S1RNNlE5SHNlR3BSZm52TzROdnhCSjlD?=
 =?utf-8?B?aUppZHpScTNhVitpeEZCVEkzeTluVVFuSWx4d0l5cTFHU1ByaGM0cmVTaFVW?=
 =?utf-8?B?NTlTYWtSc1g2OGpGZjVHcDJGYXJiNU9MNmVSN3RyR09BUTVOZWUwVUxJVWs4?=
 =?utf-8?Q?0icZtpn4p06Y9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFhMdjg1Nmd4TkQ5M1lEdFU2Um9ZQktNbm5sbU1TOGNXTElvT2dKZEpjRjIw?=
 =?utf-8?B?OGVJU1hPUDJ4TitnaEhCYXJkcjFJVjFFTFdQYjI3R2dBdHBmWkFVRi9YRHFF?=
 =?utf-8?B?ZWZUa0lwRG9BYUYyQmlOT3Fhdzk1WHhhbFMvWVhCNDhoTElGRVdXb0tRdC84?=
 =?utf-8?B?SzdwQVFjb3dvRzFjWVA5MkgwOUpQZzR1MWxsd1lyWlllNFhnN0d2VElyd2FM?=
 =?utf-8?B?SFpQZVlBbTNEdXJlZ3VUV1hSWlJpYVhhM3NPVGpqeWQvOEkzMlBuMHB4dEpF?=
 =?utf-8?B?QWxpT3poQnlTZ01QenRINzZFL3lySFh1QU9lWjZOeFg5aWJ5Mnl1UkRTd2py?=
 =?utf-8?B?dFpwWmxRYmRiNmtUUEhycEFjZWVDKzhmK0UwWFJSU1N4SThmbXZIWjNNYVJD?=
 =?utf-8?B?RzVYbTdLSjNnb3lLTGZHcDdLTWYzdXhRSTNZaFBvMkVCNGI1KzQwZzNkUGh1?=
 =?utf-8?B?aHl3ajVQN1BORTZUUm1vdW53YytoSUxNUi9iUjk1bS9zMjFXbk9SaVVYekNK?=
 =?utf-8?B?VEVFb3lRYlpyS0d4NnlhN2tNMkJkeEV2V29VR0Jvc1hBaytEbmFId2VkdC9G?=
 =?utf-8?B?OEFEWG51VkdYbkM2bzBpY3VsdkFlRnVEeHNyQ0MvQ1ZnOVV6YXprWHI3aUxO?=
 =?utf-8?B?cjlpMkV2ZGpFZEJYb0dhdm1xWDJSNkwvT2RYVFF4NGF3OE96bFFDYU5Lc2NU?=
 =?utf-8?B?N0phUlQrUmdhd2w0MUF0djM4VDhtRGFzM1M1THM3a3JwRXVVT2pEOExMTTNy?=
 =?utf-8?B?OENtNVJ0Q3pRS2tPcnd5SkxwZExNWVhyaGVmNjNzUWovdTZzRWR4dTZiUlli?=
 =?utf-8?B?cHBSOWNFelFqUW1ZUHJvZkhCY2o5V3d1bDVLRFJ3RDhGM3YvYlM5TDBtNW1Z?=
 =?utf-8?B?Zml2NnptMU1YOVpLd1FEekFYR2VFbWF4dFVxdWNWWFVyTVZxbGRmcWVSMm9z?=
 =?utf-8?B?UmtNQWsyZFJOY3hkRVlBQUFNdlhYVTNDMjBUSWszVlVhcHlNeEViS2JhT3RK?=
 =?utf-8?B?LzJHQXVRUjBBTTNBb0xLaVR3MEVzaFRodW1nTVFQcDhjUTdrcjBUYVI2Vm40?=
 =?utf-8?B?NUFKY3FFdnh2QjFjQjlEZWNGb2lGeWcrK0pBNWt0Qm9XbFBnaHJiYWdlUDBn?=
 =?utf-8?B?ckJmbkNqVHVSVC9HWG9ma1pMZDNhRnZKb25IMUtZeTgxekl3MFJ6eDBmTnR1?=
 =?utf-8?B?YXp5TW8wNWRsVWcvYnloczJVRzE5aFlLckg0QVRpc1kzWklQODN1VklTSGhQ?=
 =?utf-8?B?aTNDRTVCQzRscFozQXNwdmwxZk1EMVVLbHdaNEx3Si8va2Zkdnc4N1Qxc0hh?=
 =?utf-8?B?cmNYQmVCS0lVWkIwNnVCbExTVzI3SjdrUjYxdmtuM3ZYbngwTS93MlRDQ1RG?=
 =?utf-8?B?RTRRQnFwRXBZc1BYWStmdUVWZTRBMnZVZzBqYkdVMCtMRllyU2ZiY3JKeFBw?=
 =?utf-8?B?SjUzeXRwMFo3SFBTcktMRzFkK0JGS1JySE9VazBiRmtialdDdXFFdGtwZ28y?=
 =?utf-8?B?YWpYYnZSRXkvdlpXblVuRFQ1QWlHZkhQSVBqUkdaaTlPeVhVL2ZZRzl5V2Vs?=
 =?utf-8?B?NVVCdG5ldWVKMDFvUzQ1V0NCaFJnQjluQkpCRHlORS9EQXJZNURVRzhRRmwv?=
 =?utf-8?B?ek1XNFFtVDJGRktSRERsOE1vbndXUHhpbytubzA5UUcxb0x0dEJ3dUZHT2I5?=
 =?utf-8?B?V0xwYnA3cDJNOEN5dFJ6ZUFGSERzVWhRUGpidXkwK1NTdzd6by85R21YdlRX?=
 =?utf-8?B?aEFWSEpxWmlBWmd3UXd3NEdvUCtkUEFwRnhKSmRiUkRHVmpVOXJjVlNXNkZM?=
 =?utf-8?B?c0VFNGJaZ1hZM3dQSVZxaUpZeUR1NWFmMDNUbFBMOVZobGs1VHNPdkNJdldt?=
 =?utf-8?B?OFdKOUtnSkZta0pwOGltbzcwZUNqc2NzY2pDcGRVcFVDYlF6a08vclRSUkRG?=
 =?utf-8?B?ajNUTitxWENwR1ByT3o4WjBxVExjV3ZQdUF1NzhLcjBnWjh1SjRqOFAzR2lq?=
 =?utf-8?B?TXZuUHVVdTFsam5EcDVHcjdFN0pWK1IxWDBseExzNWVWNGFYREJUYkVjaE5p?=
 =?utf-8?B?L2NhT0x3d3ViMzB1aXp5alJWTDI3dGZDQ2h5d1hOME5YbWt0MG02ZU5sdHhC?=
 =?utf-8?Q?U0Rr3BEb2R2gRRvv8RiOX9VLk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81febf3-024c-45b9-28d4-08dd6279aed3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 21:54:52.1451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9lVey/gUy0QCAW6HVIWUWCHK9I6x7eqj0T1AiZ34gWq2+XL0StkeMXchcIZlaanuwogWQPQTBUpct8jXPhTcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229

On 3/14/25 05:12, Bert Karwatzki wrote:
> Am Donnerstag, dem 13.03.2025 um 22:47 +1100 schrieb Balbir Singh:
>>
>>
>> Anyway, I think the nokaslr result is interesting, it seems like with nokaslr
>> even the older kernels have problems with the game
>>
>> Could you confirm if with nokaslr
>>
> Now I've tested kernel 6.8.12 with nokaslr
> 
>> 1. Only one single game stellaris is not working?
>> 2. The entire laptop does not work?
>> 3. Laptop works and other games work? Just one game is not working as
> expected?
> 
> 
> Stellaris is showing the input lag and the entire graphical user interface shows
> the same input lag as long as stellaris is running.
> Civilization 6 shows the same input lag as stellaris, probably even worse.
> Magic the Gathering: Arena (with wine) works normally.
> Valheim also works normally.
> Crusader Kings 2 works normally
> Rogue Heroes: Ruins of Tasos (a Zelda lookalike) works normally.
> Baldur's Gate I & II and Icewind Dale work normally.
> 
> Also the input lag is only in the GUI, if I switch to a text console (ctrl + alt
> + Fn), input works normally even while the affected games are running.
> 
> Games aside everything else (e.g. compiling kernels) seems to work with nokaslr.
> 

Would it be fair to assume that anything Xorg/Wayland is working fine
when the game is not running, even with nokaslr?

+amd-gfx@lists.freedesktop.org to see if there are known issues with
nokaslr and the games you mentioned.


Balbir Singh

PS: I came across an interesting link
https://www.alex-ionescu.com/behind-windows-x64s-44-bit-memory-addressing-limit/

I think SLIST_HEADER is used by wine as well for user space and I am not sure
if in this situation the game is hitting this scenario, but surprisingly the other
games are not. This is assuming the game uses wine. I am not sure it's related,
but the 44 bits caught my attention.

