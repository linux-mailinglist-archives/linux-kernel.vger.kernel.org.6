Return-Path: <linux-kernel+bounces-330197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB5E979AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924F41C22836
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 05:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F0A3EA71;
	Mon, 16 Sep 2024 05:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="TBTeeWdP"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298CC27452;
	Mon, 16 Sep 2024 05:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726464813; cv=fail; b=kpCN5Fi/I0ye+4SamwetnoYRXh7jbxWHkaXg/wQmWkaDfbSYPkZC+f+e/0Mu9ZMeOq2/E+nu2Lj70ic8horRlWdAI6Rd6u0Euko0PSk6FGbHjrndORdB38LNkUI0G5DSXOUXtlpMLeebkoGD6MQJ1FD0xwKSQUeHKv3/OeP5pk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726464813; c=relaxed/simple;
	bh=lOrUk7g77E0XwlkLvzC+c5VLSe1oTuv8K5yif+fnUMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=crWV+EttEOFUQ6f71tHtgVZOwZM5/BNrcf5eC3mr8Ur/1dHEiaB+aK1vxUEt9Pz9FRFzMSXfvMpvKHNe7oDJJTltaI8DLIijXWgMNxo/Zrv2zgnqtiPZYOQ9z88YC6JUNODUiNBj1UTzdQmWUQBfs6BKlxK3kPkUueeWLNoXZiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=TBTeeWdP; arc=fail smtp.client-ip=40.107.22.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7tyy4zWKyl97LUDuVg+7VSf9iPY+Ym4a9JAj8RL988mWmIJVFI8Kmdlfjp9DO5oBxr2JcAVW1CXjJeKlOBDVx/Ksd4Fze315rINAf/EqXweBN3YyToPuF/9YAabaAl4FGULNgTP1CpK8yITRKDHyz28pTKyrkEbihK2B2v4Lx0Wgf7Ih+wo0MbN7US4302xD327OnbseP546u9o57nHXXV1JhZSKPR1O3p8j3EetayeXRl/Y/DETAjrhSCNiIUnt6NjA3KnNlG/NrfLi7ohymDGNmKblJscONcqW5Ca2RNLHvfllsxRzDpCIARhEKMPBMp1u5fZowlMc8QrHv/faw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsLbcAV/DGa+mU6rqAZmFjGv/3NEb28inrfecENUtrU=;
 b=SqB9GMMZwvXCJabt1gvdXuzvyFpB/bK6NJnU5C5A23e/U+LoFjZCp0IiBUFiL/IwYsHoraTwoe8bMiBxxX98+iaEkUU8F1Jw+dp5tiBBoZJKoiiUfh1oDEcF8OVd+qZnmU+29i58PrFbdJWRG9Yr/7mKw2xgOQ70yAtYeC5nPsKkD4c9MQ/hxgwQQ2QuGXX6pqQ+aSly0Bz0R/Th5aviilOosQJ592/VGv3BRn359t/PnnQD09n7w301uBpHr/75qn+qgOLCtBjQGfSf1KLn/eHmrAW/pUCn+l0Am7nfJ7lC4VDkrtD7x+Olflg8FsAcPzeht0eeGFrPEDhsYyuNMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=gmail.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsLbcAV/DGa+mU6rqAZmFjGv/3NEb28inrfecENUtrU=;
 b=TBTeeWdPcbJ8BtQ8DiMBncxaxJMMEH4Gd5HJ9BawEl3biMS2NSgdrsv0KD0tB6PvlzJtSfsQt1J+uLKKGUOa9jBX+126f6qsBP7Ji+cTBg/WXmfTxy/lpTVKYlXblJQ7xiV7J5bIYcAcTNHxHuDAaODwKk9KZY14aCP2F5rqPnqzfXL1y1s4UE95Lho8ijGjy4M+sAe+rCbDKCpUpA7EdolbaIe7+eVlemoGINo11WSwHuPlWC9oKy3j6k/vaQu8ArSDfE5PkaRvLomanxaPmyu090xJmeP7jj/eUHFdM4AlqHkOcwOF1ZDeM/GRI9sJM8Gz2WZSkwYqPGeN8NcGIg==
Received: from PA7P264CA0402.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:39b::15)
 by DB8PR10MB3130.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:f9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 05:33:26 +0000
Received: from AM4PEPF00025F97.EURPRD83.prod.outlook.com
 (2603:10a6:102:39b:cafe::4) by PA7P264CA0402.outlook.office365.com
 (2603:10a6:102:39b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Mon, 16 Sep 2024 05:33:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AM4PEPF00025F97.mail.protection.outlook.com (10.167.16.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.1 via Frontend Transport; Mon, 16 Sep 2024 05:33:26 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 16 Sep
 2024 07:33:13 +0200
Received: from [10.34.219.93] (10.139.217.196) by SI-EXCAS2000.de.bosch.com
 (10.139.217.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Sep
 2024 07:33:12 +0200
Message-ID: <3a421753-07fa-451a-90fa-e04d1a731b1a@de.bosch.com>
Date: Mon, 16 Sep 2024 07:33:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kernel-docs: Add new section for Rust learning
 materials
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, <corbet@lwn.net>,
	<ojeda@kernel.org>
CC: <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<benno.lossin@proton.me>, <a.hindborg@samsung.com>, <aliceryhl@google.com>,
	<workflows@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
	<bilbao@vt.edu>
References: <20240913153824.161150-1-carlos.bilbao.osdev@gmail.com>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20240913153824.161150-1-carlos.bilbao.osdev@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F97:EE_|DB8PR10MB3130:EE_
X-MS-Office365-Filtering-Correlation-Id: d9bdba0a-45e5-4414-f7f7-08dcd61116c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0UyZUcrWVMwd1BnVGJTeUtoT245RTdUcXBKSWN0bEpUWW1iWnpBam9HV1pR?=
 =?utf-8?B?VVhyZlVlSVU4V1BwUHhPb3M4OThkSkJ1M0diUHA0TDdNTXlaUGhZWG5CQXRG?=
 =?utf-8?B?RTdoWVVNRVFxTEtCOXZMZGxtN2lSK3lJZjk4c3J1RnJvMTVVMkZyR2JNalI0?=
 =?utf-8?B?NjI1QWdUTDFsU0lIYklXaHFTZUxYMGdJVW0xdlgzaU9hWXFtbXMwWTk2RnBT?=
 =?utf-8?B?T256eHlLTlNTaXJrYmZyRUxWN05RMVNDZG5TbUlXb3VjbmlkckVpZGFVUDk2?=
 =?utf-8?B?R3JodDVxazJwVG1hWS80OXNHem4wdDVvRjRiRGR3bzlRWmNhQjRzVkVOKzJE?=
 =?utf-8?B?UHhNWjA1RnJKbFRDVGRCZldrTGlqWUpWb3VuZ1VMbUdZVXR6UHhVaFFaR2ZC?=
 =?utf-8?B?b0V3b0hlYi9rVWRaQ1NFWU02SmhwWEYyU3F5di9ZNXQ2OVplcXhVU0M2eTAz?=
 =?utf-8?B?bE5kSUoxYkw4citWdzNWZWwzUkRLaENjTEFNS3MvRHY1K1ZMeXhKNjk5RlFw?=
 =?utf-8?B?RjZndTA3S1Z5VS9RTUtpZFcyb0hNRUsrL05qcDhDUlNYbHBZTHhsTnBQR1hJ?=
 =?utf-8?B?NGdjbkR4bGdUQkFITEhHelZsVy9ZSWg1YXpScjFZVFp2MnlvVXF1d05Ldkw0?=
 =?utf-8?B?b2dXR3dKbmtKYW5jQUZjMDA3UkIzWlZXT1A1QWphN0hwYTU2WWZ5Q0I2ZHli?=
 =?utf-8?B?QkRHcHF4S0phdWt1bkY0UFpGMGNJNDc0ZTg2dC9TSWsveTJoMENHeXRJbm5Q?=
 =?utf-8?B?U3ZCUVV3Sm1uWXI3OFh5aXo3a1VQYjVzb3Y2dElsa1hWRU9JdkVyclQ2V0Nh?=
 =?utf-8?B?UlVUdStkVnNHay9OYllldytjZkViOVNRQU9KQUk0QXY0cjZESzBnMUVTSUdN?=
 =?utf-8?B?YmF0YU54SHdCQ3NON01OK3dlQ05SZkVkb3luSG5vQ1VDczV0dHFOUnU1TVJ6?=
 =?utf-8?B?SE9ERWQ3dithTWE3NTBYbXovWVQrZXdnWHBHcFROaVNjNENMSDVTSldKcWNV?=
 =?utf-8?B?dzcyaGtRNTE0c0dYeFdQMFYydnN3cS9IVXFUb1l5STR6RHA5d0FTUFJOWmRC?=
 =?utf-8?B?VWpHQ2ltWVNTNlV4Q2JGazVYcU1kZHhocGtlbTdFd3cvVWs5dVEwSjhSalMx?=
 =?utf-8?B?MDl3aDVCS3ZGVWo0QlpNMHp3Q2hXS3Y3VkQ5ZG5Mdlh1TVhQUmxUd2xScjk5?=
 =?utf-8?B?YlkvSEFSTnNrYU9SSk9DTFhNN1drSVdMZ2t5emxOeklJVStqbEZNbUZlYXBy?=
 =?utf-8?B?cVhReHV0YzhGYTAzTFdZQm1uWFpvWnRGTW1uc1BVeVR5WnVFK2RHT3NYZEZS?=
 =?utf-8?B?dkhYUStlTmNsNmQ2TzRYZkR6ZzlKS3d1OUFKbVpLSHRFYi9TUWpiSTY3bUNp?=
 =?utf-8?B?SVFUWm9iVXB6Q1JYRkEyWW9SbEs4Vm8xSFp6UnZDSkxIT1FTYlVnaTVLNEo4?=
 =?utf-8?B?SEtnQ0FMdUZDbHlGclNPb0tBYXlvd0JWVXhiakdHOHVHLytZeHZOQ2RNa0dR?=
 =?utf-8?B?cDN1QzZxSjFiKzZOV1E0T2JkamVFUkFVYXZkdCt0V3I2M0JXSFdGdlhRdUlr?=
 =?utf-8?B?ZWwzaUdvMVZaOGwxSG9KYjBiajdTZERyaDVoSlg3OFoyVEMzSjlMUTZuWCs4?=
 =?utf-8?B?VXA4K3hhSVJWcW05aEkydW9XZGowMWJ6YTZCR2d2Q0k3RXNhaHQ1V2xoQVpH?=
 =?utf-8?B?QTFSRHpESTJCeEwrdG5OQ0FpVXo5dDF6Ukh2MmtBOVIrRmZHVXZicXEwYjZS?=
 =?utf-8?B?WkhuYmhXZ3UxQlJGb0FJck5LbEZLb1ZRdWVaOFBiQVVhUzdkQ052QTFQcUNK?=
 =?utf-8?B?TXloYTBPVW1sRDE4T29hZGhORUN6NGc3VThKTTR0Tjl5YTRWZkFWVEgxbjd6?=
 =?utf-8?B?eWs1eGVRUmFDYWxTcTBhL2VyMC9DYkh2UjJFaEh4QTVMczFWZGJGWmxKb0JF?=
 =?utf-8?Q?nVgHi/9wsuAhODcUDB+8lGhGxEh6s0Nx?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 05:33:26.3676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9bdba0a-45e5-4414-f7f7-08dcd61116c0
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F97.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3130

On 13.09.2024 17:38, Carlos Bilbao wrote:
> Include a new section in the Index of Further Kernel Documentation with
> resources to learn Rust. Reference it in the Rust index.
> 
> Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>


Many thanks!

Two minor things below. With these:

Reviewed-by: Dirk Behme <dirk.behme@de.bosch.com>

Dirk


> ---
> 
> Changes since v1:
>   - Added two more Rust blogs proposed by Dirk Behme.
> 
> ---
>   Documentation/process/kernel-docs.rst | 131 +++++++++++++++++++++++---
>   Documentation/rust/index.rst          |   3 +
>   2 files changed, 123 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
> index 55552ec4b043..b56c2adcb954 100644
> --- a/Documentation/process/kernel-docs.rst
> +++ b/Documentation/process/kernel-docs.rst
> @@ -72,17 +72,6 @@ On-line docs
...
> +    * Title: **Learning Rust the Dangerous Way**

It looks to me the that it is called "Learn" and not "Learning"?

...
> +    * Name: **Linux Plumbers (LPC) Rust presentations**

Here I would add the year "2024" somewhere. There have been previous 
LPCs and most probably there will be some in the next years ;)

