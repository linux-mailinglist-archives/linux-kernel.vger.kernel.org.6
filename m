Return-Path: <linux-kernel+bounces-562312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DADFAA622A3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 01:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D47D7AE461
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 00:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CE31373;
	Sat, 15 Mar 2025 00:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tyrgxdzW"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205FC10E9
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 00:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741997827; cv=fail; b=O6xb2KE5C0e+IjO3n0d/rjPiDyp/V5z5ue7DQ6xqgNmHe4aof6nYsxxBd4LjWwfAfAMTuazXdHVrN4Cm5T/UiGLgkhUCf2N8cHIwJ0pATYNyLvxuET2xyAN9OfaY754Grix7J3R6YglljuLwhluf+zoRBtNb2bv05SeFZjafMaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741997827; c=relaxed/simple;
	bh=Q90AzJvBJp4i5BubOo8kmjLI7WbVOK9s90ocY3uCknw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=peostwMnmlMUlqLmhCeJmddHhlz62mX8mk+cJSfN5aWyvsK9gFOpzlI+VaZ0UwwFzinu2uBoQgIz6oS1g9C6ruUn0n/8g9wCqz+Wj0BdzizJPRqHjIWlGlZ9pOkHEiu8HTQnZw2XK3OoD6CWpsxdeQHuH2Gt5HJu0j7BkRKtN80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tyrgxdzW; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fP3wKcCdNAlVhscBUMy2ZJbe9l8nMQsZf8PeEzAX81CBsHRITgBWdNJU/IkTjeyLhsVAs6IHWp2B7Qi/7EYbM0kVjcv43S48re7jnSqd+Iq+Ycu1xstpiExPM1VMDGcTMD0B84fiOao7FQHHhUPDBpnIoijDjYT/wtB8LYa2kv40EEtAAqDg+1T/KS2x/WKxM22dwJ73DfPByF/m0uoZYwn77YUYFsP1kja+rUND1PLcuQ+vEINRIAvjMTeAHi4yGUd9Ij0oLZ8lvl+zpR8MAWCkhlKlkdfHWj5PmNef80bPyLScqNqBrmWD8AWCO405C19pOHw96hzcj3wIF7Eskw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnYxMETmpjOI5Vm80TmNeiD1yqhpHckE57IQl0yHocg=;
 b=mERx6SVpwHIdGj2j9SEHQmZGl7VYOt7V/jVBV0WANEK2v/ePpLLiLx99IMngX/YD3fP/W5tOMJ0H+6X3qDJNU+Xd4Hw12nR8W6KSKX3qbl++sx172HQ+jYZpKRbTuyB5LWrkpejgiksBla3tga0iw0t+jSybo6vHxax1xIarpkPhMe5UDOvU40Rnsik4zjCs3yLcZk2vEEwxCRtrRwgvc3GRpgGLbDsmKpm7TOrfvrY/JJSiWMvB9Na9MT11UjOZ4htKRbpeojnBS8Bp+0cx/+dtrgHhvMLN8WWZf3WvkOguE0jbpT7/ezDlc/bZFm+3wW57t697X0WFddSIb46Qdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnYxMETmpjOI5Vm80TmNeiD1yqhpHckE57IQl0yHocg=;
 b=tyrgxdzWfQGLekF4VyMAuZBUPt7Lezp1uJIYfrBsSvsfmQLO7tDuRMsV8s88rphh7zToBbqC5x2398qdsmVRp2L/qxOiNPeECS9tXrnErNDBpkUEjgVMvocMArYWCGfGEyJ0QmhJg8bfgbbnVatftjEHDGnSJFtGk0M6HfjmUFYQFQQe0zOCUSsujsnwe9FihhYzThkHi+okonN2tD4WiFQFa+MByNg7NWU6ivuZgyBNKfuEUejMxYK7Bx0fMcfVsZEnWTJATfjnQKw/UmfPBPF+Bx3RNmSdpb9kmos5gjmADildk9OcAu7wXWzA2nTYlQPDFCIZ3hSz862/WiVPCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Sat, 15 Mar
 2025 00:17:00 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%6]) with mapi id 15.20.8511.031; Sat, 15 Mar 2025
 00:17:00 +0000
Message-ID: <551b9797-20d6-4bfe-b54c-84dd7aae7794@nvidia.com>
Date: Sat, 15 Mar 2025 11:16:54 +1100
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
 <b63b1de8-7eec-4235-b61e-e654e78543ba@nvidia.com>
 <fa8d5e76694918bdaae9faee9648776f298f78ca.camel@web.de>
 <7866593f-0322-4fb3-9729-82366940fc85@nvidia.com>
 <a168e78b-ae27-4675-8821-0b1a2499b2b2@nvidia.com>
 <5d34bfc5109b8d104fd4f8550dd17945344f9d07.camel@web.de>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <5d34bfc5109b8d104fd4f8550dd17945344f9d07.camel@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a03:505::16) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e1fbcde-835c-44b0-3be1-08dd6356b47b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUdBbGwzYkUyQ1kwb292U0tjL3JGRkc2TG02WmE4QlZFelk3OE5QUVlNbno4?=
 =?utf-8?B?SDJWQVFQZ3k5K3lPTDNTYjlISXVGWlAzNGpVdFZPYTAwNmhVci80Rkd1OVl1?=
 =?utf-8?B?cXNiU2M4UExDZWNLTGpQZS9WYVdtQnJ5aTlWKzZVQmFSVnM0cEU2aTREcHZi?=
 =?utf-8?B?WG1ETXFWdW9OQ1I5c1lmMkJZUFpkbUk3WCtabzRaczZmN2lQeWs4UHVaM0pX?=
 =?utf-8?B?bTh0VzJwQmlhUkNJS1I5RVh6TVU4bGVZd1FEOEo2bURYUnNkRjh3UC82S2hU?=
 =?utf-8?B?RU1RbEQwd1Z4Rk1uYy9JQ3JKWW9zRVZ6diswTElIWjcyNWF6dXdSMzhERytW?=
 =?utf-8?B?T1ZhMFJhNHVXdUtKLzYxa3F0NUFmTEtrNm5EQTJ6YjRPbjJZK1MxTnp3bmpY?=
 =?utf-8?B?S3I4T0xjdDh6RlMzQUFSOFg4SEVTODUwdmhRczBhTUFYbUZjK0ZnTDFTTU9M?=
 =?utf-8?B?VkYvRzAxNU16NnpMYldQVHd0aFczTVdOdDhGTVBlT1p2aW9wQVZhdm1vSkJF?=
 =?utf-8?B?KzJxTEhSVCtuaTdpN3Q1WTFTZjFpRVJ2R0dtRnJUTThVV3JJZjJYZllrL2VR?=
 =?utf-8?B?VCtobDIrWGl6a0FZeXphb1RFSTlMVnFSYVRFSG9WTk02Vm1hM2xyblBQd1RH?=
 =?utf-8?B?Y2U3dVk1Yktoc0lFT0Njb3RPZzlwbFRyajh2Tk9kSmJJcVEzMytXdGF3MWFZ?=
 =?utf-8?B?MWZyWG43YnA4Wkk5TlRqVWRJMEZ1QnZEY1lTZmtjUmFibGlibCtNVk9CRVNW?=
 =?utf-8?B?SjFuazJDUHVxMkd5ZENhNldFd1Bwak4wQkdEV1FIek1xNkVGQ3JIUElWR3l4?=
 =?utf-8?B?Q3dpL1NOSTdYcTg5V3lmNUc3eDJWWGl5Q2ViVEx0VjltYjFiR1FuczZLRHRJ?=
 =?utf-8?B?UkQwZVJXZURTK05rdVQ2TU9vTmR5Y0JsTlN4bmIrRnNuWitVTDVmaDArQUVx?=
 =?utf-8?B?dGUxZ25VZkpzdUhET2h0eExkcmlsT1o0OHlwaFlTKzRMT0dvWDZoWG82YWVh?=
 =?utf-8?B?bmRKbVpMVExTR3dUTjRIb05VWjNVc0RGTFJaeE1CRHNmV09PVEtlcnp4VE9L?=
 =?utf-8?B?KzRSZkk0VXM4MHVpT0Q5NGVlaUdzb0Y0WngyRS9icUF5UzNpeG9YdHBHU0c5?=
 =?utf-8?B?MjdXb3laOFQ2eHVDb3VRbVIyN2FNU0JjUEM5WGErL1lZbXR2c0t4RTVlV3BF?=
 =?utf-8?B?UnBwU3VOVVdlSC9WWnB4Q1JMNk9BZi9UaGFVSDZUQUVwRGwwSnBEK0x4N0Rk?=
 =?utf-8?B?ZlVwMGlUaFFLK3c4RzdCMVZ4bithdDRiZ3lrZlVnWHN3dmw0UEpiTEtnSmMx?=
 =?utf-8?B?OFVJN3dydHd5UnltNDFFNVpMQThjSUc4UWt2YVowbWc1OGVRVGREa01iZXRF?=
 =?utf-8?B?UnhRekx5Qnp1STR4VUlDYVh6YTdDcThVcW1wajc0Wkg1TkZqbXh6YjcvVXJm?=
 =?utf-8?B?cGtJSXZXNEZFU0E4N0xRMVoyWGgweHZOOGJHbnlCYTdKL2l3Mzl4cmRZVUhH?=
 =?utf-8?B?Z2d2a1k3cUcySzEvYVh0eGZwcWY0Z1IwVUdPT3E4aXY5VmhXK29vazRLS3k4?=
 =?utf-8?B?WHZsUHNSZGJBcTRvdWVPNEI3SXkzZzAzNHJMS2tVV3pJNE4vMlFoLzJnblU5?=
 =?utf-8?B?emx5T0czVnZsWGdhTnpGaFRqNytYNVorWGp1K0pFTDdxV3htanprZUM4eXc5?=
 =?utf-8?B?cTVRQ3lLQnlLSzE2Ymx5Zml1dk53VUMyUW5rRmJ2blh2SFkvTW5Udi95UkJY?=
 =?utf-8?B?WWYxYks2S3VKaEFNUTl2ZDBPSVpqSGpvOGhFZGZsNC9Kejc1QnBhUzlZdXVQ?=
 =?utf-8?B?a0JJaUZsQXFmVDc3V1RFNmh2ZVZkWGNGVTBVdXk4azlnZFh3WmxOR1FBbnIy?=
 =?utf-8?Q?PCZiilZZNN/xg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGc5UVVtYTd3WkpWTmVLRjgzZXpobmIwOFpDckhhdkd3SXdYaXpFcmQ2OWx0?=
 =?utf-8?B?ZG1kQ1dkNTlZVGN2LzNOZWc4QVJWb2hJNHVMcWpzNFdnU3hheSttbUcxbCta?=
 =?utf-8?B?MldSczFLY1NYcDEvRWRWT05Tam5kb2RlcjhzQmdWWExHZUNqZ0V2aE02TG1x?=
 =?utf-8?B?NUVVcEx1cFRrU3hRRmY2SklYa0N6aTR3N29FYlhGNUxuVnFIbHN0aVhEdDVH?=
 =?utf-8?B?blYxWWI4UTl5UHZZRVRlRjJoSUVhenJrakFpZWZTQndqQ3l2ZFZvdWtZMTFs?=
 =?utf-8?B?bzQ0Mm9sbTdjKytxZEtDRmdBUTJ5N3pMTGJWU0hPelJJYUx2emZjTi83Mmk2?=
 =?utf-8?B?TlIzMmMvMWJQdVVMbitMNXYwb1N3RmFIWWRzbWVORmRGd2F2NUR6alNaYzBF?=
 =?utf-8?B?ZG5NTEI1aFZVTDliQXVBUzE2NTk5TndZMzZ0M1dVOXpCajNOZm5qajdqcHdP?=
 =?utf-8?B?OTdZWHcwYmk1NFArcm5yUUI5NHhDNjUwejM5b00rdHFVSmJvTThOQVp4M2hz?=
 =?utf-8?B?VzUvNno4enFvdi9vc3UyOEMvTFE5TERJTVZqMTJwNCs1MmZxUXFzOWR0MFo4?=
 =?utf-8?B?NXF6N0VwZlBmQ0hZU3AxVGRqYkoyYlhrWlcyTGtKSVkvUHNsUUdBSU9TZmlV?=
 =?utf-8?B?ZGpYbUtRakhiV2hmV01sZmJkMVFZa2ZycFRUUUE3N2ovL3Q3cVRKWFdYNnFN?=
 =?utf-8?B?bW1DY05tS3hDVHpmaUIwbUlSRERUcnBaRlREQnNRM0J4c1d5UjMwbHVSS2s0?=
 =?utf-8?B?WHNTbGhETmw4bDZGQU90MnVSSFRVc0YwU2JWZnl0QlpGNlZjajNta2M2M3Jk?=
 =?utf-8?B?MlBaNW80Wm1iamg0cFovOGl5NS9WMm4zbVR0MS9MMUNYZFVxTlZqVzBacnFM?=
 =?utf-8?B?eExiMGpMUzJiVUI5OFNmWVJCVE1GVnFnNzNTYmh1TGVJeXhGMW5mMlk5ODIy?=
 =?utf-8?B?KzlZWWZrU2Y1VU5tUnlqd0JMaUhGNGROR1pqMlh0Wi9ZY1N5cjVSeGZpK0E3?=
 =?utf-8?B?YWFzdng0cDgxM283U2pBSlNoU3N3eGI4bGc5Vjl3Y3BkcXNHdnRSYkpUTk13?=
 =?utf-8?B?SUMvT3RPNmRVQkRybTg3WmYrVDVTYTBlT1JtVzB2VVNpNWdUcGxWYkJabUdS?=
 =?utf-8?B?cTNUWVpXWVA2elpMRGNabkc3eG1idm9EUHkzbEppd01aUU1QYjRoOHZHV0RO?=
 =?utf-8?B?VDFxV01pcWRoSStMazZHa2g4bjJWdzlpMW1USmFLRTlDaEYrenBDa1RUakFC?=
 =?utf-8?B?UnFHWmxaSWdJWVJWcHVBUjVYSllsZkY2bTdjTUU3elhRcHhrcCszRHMrZnV0?=
 =?utf-8?B?UjJQN0Zva1pHV09SUFFmcGNEN1hEMXFSUFNBRFBvaFJ6QmFib1luWWFQRjFp?=
 =?utf-8?B?ck5PQlVBSDFhcTZxdFpNdlFLbVY2UHFMQThLSEYyRTFZT0lIL00xRklFUHJh?=
 =?utf-8?B?ZnFzQkY5cVBkT29tV1pXV0sxbkVxNS9iMkg5empleGRVM01kLzRla2hIK3Nw?=
 =?utf-8?B?b2pCMWFGejZjSHBOYmFWVWVRVUlSN0hZMXNvY2Ywald6QWpKMzFkeVFGZWlp?=
 =?utf-8?B?OGhvWnUvQTA4Ky9UTUx2VmJ6L2NEQWRFSE50d24rWFZ3dTZ5TUF2VExsV29v?=
 =?utf-8?B?aGlSVTloZkFDM25aWTlMTG5ySlhNT05pNTlUd1RYMnEvOUp5ZnNCTWpCYXhV?=
 =?utf-8?B?SkR0Q2FrMWY0a0NrQmw0OSs1VnN4ZTIvcnRCbFFmTmlTUGdPQXRnendmV0t3?=
 =?utf-8?B?Z2p4NkdRWXJSNk5aZjVNWk8xUUgxYVVodGFpVHk3ZnFYMUtFeGlnYW5QSS9D?=
 =?utf-8?B?SWtSZm9nNTFreUx5UjM2OWV2VkpFd2dqZlJMMkJoZ1dmbnplTjhsNks0M2l6?=
 =?utf-8?B?SU1iZWVFalBQZjl4MUp4WFBZeXd6NC9sZkxONEpnVFpDSmZ2RVJJRXB5WWxu?=
 =?utf-8?B?Mi84bUpsUEVwM2JpZ0RFc1FWRjN6M1dOL1hqQnR6NGRzc2F3U1Z0ZUxzMmV2?=
 =?utf-8?B?NlUyTmtQUDlVblZGQWVaSDJQYWliZkoxZmpyZjFsMzJEaWoxdnhZZzZCTEg3?=
 =?utf-8?B?SE0rRmoyU0pyUFhCb0JHQU1DK05FaHE3UklGcHNkcVdqSXV5bHorTmJyNWFN?=
 =?utf-8?Q?bW1fczAHsSYzqGq3xYMEJ7xbv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1fbcde-835c-44b0-3be1-08dd6356b47b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 00:17:00.4015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RWGFkHP/o3fZC8KezSK27EXtTwSwN4Q10GhTWyuXKrc4GqIwH7L1SV4/jG12VzH6NKkJ28hBlu2Ch5TIu89LOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758

On 3/15/25 01:18, Bert Karwatzki wrote:
> Am Samstag, dem 15.03.2025 um 00:34 +1100 schrieb Balbir Singh:
>> On 3/14/25 17:14, Balbir Singh wrote:
>>> On 3/14/25 09:22, Bert Karwatzki wrote:
>>>> Am Freitag, dem 14.03.2025 um 08:54 +1100 schrieb Balbir Singh:
>>>>> On 3/14/25 05:12, Bert Karwatzki wrote:
>>>>>> Am Donnerstag, dem 13.03.2025 um 22:47 +1100 schrieb Balbir Singh:
>>>>>>>
>>>>>>>
>>>>>>> Anyway, I think the nokaslr result is interesting, it seems like with nokaslr
>>>>>>> even the older kernels have problems with the game
>>>>>>>
>>>>>>> Could you confirm if with nokaslr
>>>>>>>
>>>>>> Now I've tested kernel 6.8.12 with nokaslr
>>>>>>
>>>>>>> 1. Only one single game stellaris is not working?
>>>>>>> 2. The entire laptop does not work?
>>>>>>> 3. Laptop works and other games work? Just one game is not working as
>>>>>> expected?
>>>>>>
>>>>>>
>>>>>> Stellaris is showing the input lag and the entire graphical user interface shows
>>>>>> the same input lag as long as stellaris is running.
>>>>>> Civilization 6 shows the same input lag as stellaris, probably even worse.
>>>>>> Magic the Gathering: Arena (with wine) works normally.
>>>>>> Valheim also works normally.
>>>>>> Crusader Kings 2 works normally
>>>>>> Rogue Heroes: Ruins of Tasos (a Zelda lookalike) works normally.
>>>>>> Baldur's Gate I & II and Icewind Dale work normally.
>>>>>>
>>>>>> Also the input lag is only in the GUI, if I switch to a text console (ctrl + alt
>>>>>> + Fn), input works normally even while the affected games are running.
>>>>>>
>>>>>> Games aside everything else (e.g. compiling kernels) seems to work with nokaslr.
>>>>>>
>>>>>
>>>>> Would it be fair to assume that anything Xorg/Wayland is working fine
>>>>> when the game is not running, even with nokaslr?
>>>>>
>>>> Yes, Xorg (I'm normally using xfce4 as desktop) works fine. I also tested with
>>>> gnome using Xwayland, here the buggy behaviour also exists, with the addtion
>>>> that mouse position is off, i.e. to click a button in the game you have to click
>>>> somewhat above it.
>>>
>>> So the issue is narrowed down to just the games you've mentioned with nokaslr/patch?
>>>
>>>>
>>>>> +amd-gfx@lists.freedesktop.org to see if there are known issues with
>>>>> nokaslr and the games you mentioned.
>>>>>
>>>>>
>>>>> Balbir Singh
>>>>>
>>>>> PS: I came across an interesting link
>>>>> https://www.alex-ionescu.com/behind-windows-x64s-44-bit-memory-addressing-limit/
>>>>>
>>>>> I think SLIST_HEADER is used by wine as well for user space and I am not sure
>>>>> if in this situation the game is hitting this scenario, but surprisingly the other
>>>>> games are not. This is assuming the game uses wine. I am not sure it's related,
>>>>> but the 44 bits caught my attention.
>>>>
>>>> Stellaris is a native linux game (x86_64), the one game (MTGA) I tested with
>>>> wine worked fine.
>>>>
>>>
>>> Thanks for the update! I wonder if there are any game logs. If you can look for any
>>> warnings/errors it might be interesting to see where the difference is coming from?
>>>
>>
>> In addition to the above, does radeontop give you any info about what might be
>> going on? I am also curious if
> 
> This got me to test stellaris and Civ6 using the discrete Graphics card:
> 03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 23
> [Radeon RX 6600/6600 XT/6600M] (rev c3)
>  (with DRI_PRIME=1) and here the problems do not occur.
> 
> This is the CPU-builtin GPU, which I normally use to play stellaris as graphics
> aren't very demanding, here the problems occur when using nokaslr
> 08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
> Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c5)
> 

Aaah.. this is strange, because the only movement in iomem was for the discrete GPU

From your eariler message

 fee00000-fee00fff : pnp 00:04
 ff000000-ffffffff : pnp 00:04
 100000000-fee2fffff : System RAM
-  3a7e00000-3a89d2f56 : Kernel code
-  3a8a00000-3a8e31fff : Kernel rodata
-  3a9000000-3a912a5ff : Kernel data
-  3a969c000-3a97fffff : Kernel bss
+  d32200000-d32dd0f56 : Kernel code
+  d32e00000-d33231fff : Kernel rodata
+  d33400000-d3352a5ff : Kernel data
+  d33a9c000-d33bfffff : Kernel bss
 fee300000-100fffffff : Reserved
 1010000000-ffffffffff : PCI Bus 0000:00
   fc00000000-fe0fffffff : PCI Bus 0000:01
@@ -104,4 +104,4 @@
       fe30300000-fe303fffff : 0000:04:00.0
     fe30400000-fe30403fff : 0000:04:00.0
     fe30404000-fe30404fff : 0000:04:00.0
-3ffe00000000-3fffffffffff : 0000:03:00.0
+afe00000000-affffffffff : 0000:03:00.0

I am hoping someone from amd-gfx to chime in with known issues of the driver
and nokaslr or help debug further.

Balbir Singh



