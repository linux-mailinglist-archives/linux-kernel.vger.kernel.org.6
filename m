Return-Path: <linux-kernel+bounces-568168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CA5A68F05
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A57283A934F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B691C2DC8;
	Wed, 19 Mar 2025 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TUBAaSRJ"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E211B4F15;
	Wed, 19 Mar 2025 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394311; cv=fail; b=S6Gna1Qm2sYVPs+uTN+vXU1A21vdmIdJ7RPRBV/BHE0XN0A54U2p7q+3bsxbqpsHPFz4EJO4U/VCoGhUoe90MVMbBQsBBqqJ9zv1n1EqVazrlR3kvDhKE2RMiYWoiy60G9kZLUD8eyR4lOy445s9M1aYjMY45Xu+vbyXaT5HWj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394311; c=relaxed/simple;
	bh=HF+QzPvewfam6nu4ujIaDKb2PaazoTuySQhjdYpcLNI=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=PmQZcaruG4CrFRDGAosz9JMZwu1TJ+2/FwcRYNijQ3DYNZVZxB+lox8SM5LDiI+33xNBheUjE9PSF4kJgKITKHUJ3CYlL4q3EbLqhzeQmHHkSz2vRRKKqf92Mzq7HrlPa8PtrIUSxab1NGM12ADJ69nvVu2A3bLldkHF1ooOqyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TUBAaSRJ; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fi8pEm4DrPnGUuK3iZrV7qw+Qombln0zdnvOFJVvtjEG+Y6ZDQljOHcctOb7g/yYedJf/1lMtqMUbI3V+6tKrkaI3Suej7Ii6MqiGDT5ozOxoXBjbB7Rgjb414sjEIEMOO/uV/aqHvZumXOqzZ1vMTStt1uSYVuXIr7RVzn3N4xYUlO5bfWB30NWJrJPdxXBW5055hKOfEsLBnTJPDBajNHYw0FXjxnmLeTmE7AgNBCZXqwgiga0uCY1OMhqWd2oo1b4nqEMEFVnWpFsiaGJbZfBEfdX41nQZIEWNhm557RAphQOhfCFy1tNCZfgsy3h+QdJQ5DsVgh8R19KY8ulOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fet6fMcSEkM7Brw+T20eG9gjt5ShXm35kE2eWrvnOII=;
 b=gxFs1GMWa3yilvwK0Njcaz0zG0zvM4piK6L2dFPe0JuOye1l33W0Xehb5DislunLbbzpgUM9s4JjEB3L4sc+XHctErRY4ZbzrNp8IY6TlnfqWr61hN0RFqY4a4fvPZWoZiWaGJEbFIKYRHCKMTBmvFXjpUGr3ctJugt0jwyh3/NKDC8fCTgiP/jMsMwql50r8aLfoffc5WoEEJMQ87lMKHUE6V3RlALjWQV0cpJUDS0/WlGjFMUMCEIoq7qVDGSWCw7loSyq49cLW174qZZN1z8olUVtfajNsmGkPthOWNQavzbuhzpLS++zGCdAqD3KROmr4x1+O4DILsAECPHT+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fet6fMcSEkM7Brw+T20eG9gjt5ShXm35kE2eWrvnOII=;
 b=TUBAaSRJTGnbEi8AvMnZmTC63UnBkzJ3aeKkFqEuNJnQEBMZrqDc53Q/BCPPI6Fsh1lHFhA8G/F4vqyjVg5lQbAwN88Wrc7QcfLXa/6M7d7eRv9WJ15wscwyKrTxpzryS3zIhyv92rQxHBR3MI2XmJF8NVDP3Q35+xwgi+N2FQT34DuSXWF0GjV2qH6uSlzHnad5Lsxc9jEcc/a7z8yXcxIEX5JRkwy6jp2Kyjo78jD2VOOCrGJbwgwiIP3XtTMJj+MMLiV8cCSRnDU9chK6ra2BmW5JF2ERUF0pF6ghxwfYebs13uamTOpNaltou7LS17wlmfN6GNPD8tC3+oAUAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 14:25:06 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%6]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 14:25:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Mar 2025 23:25:03 +0900
Message-Id: <D8KB8CPBOIY1.10ATK35TV2X79@nvidia.com>
To: "Daniel Almeida" <daniel.almeida@collabora.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Fiona
 Behrens" <me@kloenk.dev>
Subject: Re: [PATCH v4] rust: kernel: add support for bits/genmask macros
From: "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250318-topic-panthor-rs-genmask-v4-1-35004fca6ac5@collabora.com>
In-Reply-To: <20250318-topic-panthor-rs-genmask-v4-1-35004fca6ac5@collabora.com>
X-ClientProxiedBy: OS0PR01CA0041.jpnprd01.prod.outlook.com
 (2603:1096:604:98::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: d46ed0a1-2ff5-4175-ee5a-08dd66f1d88b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjVuQmpIY0hQVTBxVVVvL29CTXlXcEFwVWdtOVpBYzRZeDRTYjBHMWJPVFBz?=
 =?utf-8?B?dkF6clI1Tml3dk5MOHJmVWpoZDlKVENwME1idnpnNERycml5OEhhdnNacDMw?=
 =?utf-8?B?QzVnaytwUGQ4dHVpWlVUNlhhWHFTcXV2V0RrekhncmN6N3VYTEFTcnNSNE1w?=
 =?utf-8?B?Rk1rWFRFWG55Zk5YSWczK2hhSU50S21MRGg4THFGNjQxUWI5RFJZZzh2Z0t3?=
 =?utf-8?B?L2Y0ZnNCejdUZTJwOEtYWVVqZTB4bm5JZ3JmbFp0cWQxRHpsR1dsRkF5RitV?=
 =?utf-8?B?N0EyUlhTZXZidmE5cWZWRll5NmNxS2FBbGVBd3E3NGpkdGdBRkc2aWZSSmZs?=
 =?utf-8?B?TXlCMUZJM2E3YUxmeEU2V1FiTUJLVnE4bExHMmJISUdHZVZQK2ZRM3FNVEVn?=
 =?utf-8?B?dG5OZXNGWjQ5Y0p4dlp0YWhTcy9VVGVRTUtSOURaVW5aREhlOGVEMGxXTHpN?=
 =?utf-8?B?SzQxbkJzaU9wbm1FaVhwSWx5MjJyN1JsUVlMcUY3RUJ3SUJtZDU3eTNzdjhs?=
 =?utf-8?B?MmRhZm5TNXZ4ZHF5L2ZxYUY2UTlqSWJzRnJUN2FjY2xLZVdTMlFFTFhxZU10?=
 =?utf-8?B?YUwxbk9ETlpjSU45VlZuamN5Vjhqczh4M011WGVWUWpRT0QwWm51a1dLckF0?=
 =?utf-8?B?MExBZWpDV3JsNlNiRmV2bDlUTEd1cmJZeVo3Y3dlZGM2eXU3ZTZMVit3Ymxl?=
 =?utf-8?B?V2YyODhldFhoTkFSdVphN3paNGpyVkFrTkdwYTNxdVJib3hVNTBZcXhtOXRx?=
 =?utf-8?B?ZG02MVRsRzhxanFlTzJMN0d2RDRidFhTcnkveUlzM1NOQ0ttZkUxVVVZWEJ6?=
 =?utf-8?B?KzBrTDhuUGRhKytPa0J4QmFoV0xSaTRxQlVSeXZnc0lmUGhlOGxtQzdMeVEr?=
 =?utf-8?B?dVk3Vkl1RVRUZXQrRldod1k1c2tGSWh4bkpZMUgwL1ZLeEpETFR1VkpPRHAy?=
 =?utf-8?B?Z0hybGxmYTFZZzBYRFAzYmV4bzVOMDg1TmE0RUh1VG5IM3J4bHVBVmRqanJw?=
 =?utf-8?B?bytvM0N6QVVuZ1k2Y1NZNmpMZCtqM3Rud01oR1JSdDJ5VUMxeHY1aWl2clUy?=
 =?utf-8?B?SklGRmpiWk12TEp5TENsV2w0YktvaU5CaytjL2h0c2phSXByR3dqNCs4QURo?=
 =?utf-8?B?T2YyNmdqQlpQVlkxTzVvYTVpMjlMTlFoL1doUFNuSDdzY3AzQTZwSEVpTnRW?=
 =?utf-8?B?dzdRb1JSbFlHaFFhSUQ5YWt1bWJuNWdpOUsvK0ozQUc1T2NSdlNGc2ZhYTlV?=
 =?utf-8?B?NVFKLyt6TXExa0o2T0RsdWNqb1RhZFJJM2VpY1pJem9EazJBM011cC9PbjVI?=
 =?utf-8?B?OCtpcmo1TG9aQU5wOXdybkZZeW9TK25neDFqbys0S2pmUzI0bUJRdy9CZ1B4?=
 =?utf-8?B?N0VBL3lBeDNHT2JreDlJekZuVTUwY2xDdGViMkpWM2ZMSHpIWDJ5Q01MUmdV?=
 =?utf-8?B?eGZjalNFaTVXQmJyejdQOXRVL3Q1TUpkdC9RbGNUNmpXanN6dGtkUjJ2WWI1?=
 =?utf-8?B?cUFIa2kvTDRNM0V1NmRUUHRZSmNWWFVObTBxdzh6KzAwS2JFVGZPSllaRCt4?=
 =?utf-8?B?WVhiMndRb0JlY1VmR2hvZjJyU2lFR2tyRHBPVnFGRjRBZTk5T0ZycDBreFl6?=
 =?utf-8?B?R0Q5bXNjRUN2ZXlkWmRoeFVzeDYwS1pqYTFsVXU3UUNiQXMwWFRDWFE5WGZR?=
 =?utf-8?B?VjhxMTBwYUtwRzhYL2syUEkzdVIwN3FKbTBSSkNaN0RnQlUwSVJ2YmM1NXRy?=
 =?utf-8?B?U1dRUk1rNnREKzdPc2QwbU5UM1VmUENDU0Y0UDRHUFZCWWFGU3VhMGRjTXhZ?=
 =?utf-8?B?Q1FDbUlnS0t5UzBBNW1SVkxyUFZjcno3Vnhka1lKSUYvTThjRjZuOUN2cFRT?=
 =?utf-8?B?V1k4cTZHMUJiTVJ1S1hTajl3S1RjenI1RGtIMkFPY1NkOFRBVW1BZFJNc241?=
 =?utf-8?Q?DH8Zsk7jvtY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NE9vVDRTeTJWanVHL1A0OUsydlhuQTBVWHJvbzJ4SzM4QUh1NlVQd2xubWEw?=
 =?utf-8?B?Y3BlSmI2RFphSnNaVDdid1NtbFlPc0EvbUhSbllPKzZsQkc5OWFudk1iK2Jk?=
 =?utf-8?B?V1FhZUdZRE1BT3gweEorRUluSXFpeGhBWUZTeVhMNTlkSWJ5RUdaMGkzcE1H?=
 =?utf-8?B?TkhmVmhLcFovcEs0eTMvbTdCM3FoRWtqYmFnSHlFTkR6SjVlQTF3bS9wVldG?=
 =?utf-8?B?OGxFNk5xRUc5UFdSMjJKNDEzQ2RnRlRSeVUzVmhxcFBaVVRkZHpnYitNWUU3?=
 =?utf-8?B?R2RJUk9FekZoTkZKRGtCRVBhMmZRUHBnYkQvMjlKOTZZTDVQWU9scjc5R1lM?=
 =?utf-8?B?N01wNmVhaUt6TEQrODBRRDlzRHUrcmI1K2VyNHNKQUQvRzlRUXFva0dwajdh?=
 =?utf-8?B?QWZ5dUpFNGoraWwzSjZZQVhwOWdVMEFWWUFpdkZITFZzTVFHZTBQUWxpaEFJ?=
 =?utf-8?B?d2FJWklRdGNMZ1NjaktXeTZwOENtRDBYb3Z5d2VjSFBNcFNyZG1wck1JeXhV?=
 =?utf-8?B?UUh2NEx0MTBlKzM1SWNOYVNqeklKUldhZ0d0SHRYSU5CeUNkSXhBbHNWUSto?=
 =?utf-8?B?cnFtTDdEUGZRNDJFQmE2ZzFCY09xK1A1WGQ2eG9VTGxIWVF4a1QxRFRKWmhS?=
 =?utf-8?B?cWtoUFdRMWVyMzQxTFlVZThxSkVVaEJubXBTS0w5UUFHWUVYcnVHV3NYeXc3?=
 =?utf-8?B?eXo1bXlUcFpzMTB0WWMxdkgwWE1ZL2p0bmZJWGNGQkdvYzVoVFh4S2IrTlZS?=
 =?utf-8?B?N2ozRDRtNVRFKytVTlV0SVNRbmVGS1lUZU50ckVIQ1pMbUcxSSt2OGhweTRj?=
 =?utf-8?B?ZnZ4M2hXd1U3OHBUUFFsZ0tEUTIyVDNMbHZqd1I4dUE3azJHcUgzWUUveTFY?=
 =?utf-8?B?cHZaMDZndDRFUUZkV1dFeEN5UXpXVVZhejZTeDg1bm5iOUZjbUxEY1pIbGRB?=
 =?utf-8?B?Y1ptUVZ6bWVMNkhDelBYbFh2VEpDb2RWTGlYSmd0dExoNnZNT3dOYUIrRGJX?=
 =?utf-8?B?R1l3U1NVMXgvZUF3eDUxV3RZSWZ4V3I2Q09Ya3prVXBqT2V0R3p0YTFRcnpK?=
 =?utf-8?B?YlVRc0tobyt6cTNoL3JjZDA3aFd3bnpSc05qc1FhVkQ4U0dDNUdLbkZJck9O?=
 =?utf-8?B?TDRnU2xRZmdNaG9MWnhKaGpxc2hmQjNUbHJJQ3VhMnhEbmtCY0dmSkEwOFVk?=
 =?utf-8?B?T2grVlVFUTQzYmNnNW1MQmZNNjRKK0M3cVIrSktEUGlvdDZvcWVUUWZtM21Z?=
 =?utf-8?B?Rk1iSTgrOFdSL29nclJmSG12NjZxMm5pYjMxWTI5blI5cHJkMnFJU01xcVlr?=
 =?utf-8?B?TWRrNnl3NXdRMlM3V0ZUbytEZm9PakdZNi9FSmtmaXlnSERYV3NkNDVKNnFM?=
 =?utf-8?B?bUZDV0o0TnNtTndMdzlESXUxMlVSVzBsanNvbm1CbE1pS0JCUEc2SDBHb1RK?=
 =?utf-8?B?ckRsRU9CNk9mL0FsWk5HWUxWbW5ITEQzdFJrd29sQ0tEUEpFRWlFZE9KUmNV?=
 =?utf-8?B?TmIyMUkwdnpsWmtmSkVVY2t6WW1rNHBXOUlHM2pyRkVVMWEzN2MrODJLNGdI?=
 =?utf-8?B?VFhtN2tCOU15VUdKby9tZHZQVVMvMEM2WkNKZGNrN0EyUG1Nb3BFcUJ2NGpm?=
 =?utf-8?B?OUVhS3daZVplVFVEang4eE50SHpqZHpnSk5tUmM5YTJyRnlMUmFJUHY4WnpT?=
 =?utf-8?B?UjloZlY1NVBFakVrWGw5SkFrZEh2MThvRWVSMTd0WG1MMkwwekJrbFAzQ1dH?=
 =?utf-8?B?WDF0eU5ac2lLOHdEZTlRa1ViYnVySGlCNTJ5U2VLNzVOYkcxd2F2dDFQbXQ0?=
 =?utf-8?B?ODNGeXNaWGEvQjlQTmIzV2ZpaHIxVWQ3b3lmc1E1K2MxNjZ1YkNqODdDQ1VU?=
 =?utf-8?B?SXpoWFB0SWNDOXZRd2ZHN2g4S1RHQ0FXS0x3WWVUdVNZSFhWQWxZTGZWYzFO?=
 =?utf-8?B?aDQ3VStaT2Z0OXliY0VtM1I4TXduNDF2d3QyQ0NZV1dSZWVCdkhzOFd0dStO?=
 =?utf-8?B?S3RWYndKTmxwSU5yTXpXa2tsQlFCZjd1bHd1YkxMdnlWVng3YUMrRnRpTk5y?=
 =?utf-8?B?d3VwK1ZhSDU2OEwzWTlic1FoSWFMOXdMaUoxZVVlMDB1RkR4aDNocyt1WEtw?=
 =?utf-8?B?aGN4bVhzOGlaZ3BSdHhUd1A2NmdDc0F2MmErZUZUYWNCcTA2ekVBZHVwR1V2?=
 =?utf-8?Q?h3e+XpGLdZnu0T14g4Jo+uucKGLMXPpSB1Dg4RFaQI6S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d46ed0a1-2ff5-4175-ee5a-08dd66f1d88b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 14:25:06.4263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lIqvH/Ff8WIpzCsbSoz1FD8Wqqw+/14jXICgZZQXPQ/ma5x+fU4ZJoClAEtUexnMBkWZB9erhXDAs4U7OkZLig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643

Hi Daniel,

On Wed Mar 19, 2025 at 12:34 AM JST, Daniel Almeida wrote:
> In light of bindgen being unable to generate bindings for macros,
> manually define the bit and genmask C macros in Rust.
>
> Bit and genmask are frequently used in drivers, and are simple enough to
> just be redefined. Their implementation is also unlikely to ever change.
>
> These macros are converted from their kernel equivalent. Since
> genmask_u32 and genmask_u64 are thought to suffice, these two versions
> are implemented as const fns instead of declarative macros.
>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Cool, I'll probably depend on this for the next version of my register
layout patch [1].

[1]
https://lore.kernel.org/rust-for-linux/20250313-registers-v1-1-8d498537e8b2=
@nvidia.com/

> ---
> Changes in v4:
> - Split bits into bits_u32 and bits_u64
> - Added r-b's
> - Rebased on top of rust-next
> - Link to v3: https://lore.kernel.org/r/20250121-topic-panthor-rs-genmask=
-v3-1-5c3bdf21ce05@collabora.com
>
> Changes in v3:
> - Changed from declarative macro to const fn
> - Added separate versions for u32 and u64
> - Link to v2: https://lore.kernel.org/r/20241024-topic-panthor-rs-genmask=
-v2-1-85237c1f0cea@collabora.com
>
> Changes in v2:
>
> - Added ticks around `BIT`, and `h >=3Dl` (Thanks, Benno).
> - Decided to keep the arguments as `expr`, as I see no issues with that
> - Added a proper example, with an assert_eq!() (Thanks, Benno)
> - Fixed the condition h <=3D l, which should be h >=3D l.
> - Checked that the assert for the condition above is described in the
>   docs.
> ---
>  rust/kernel/bits.rs | 49 +++++++++++++++++++++++++++++++++++++++++++++++=
++
>  rust/kernel/lib.rs  |  1 +
>  2 files changed, 50 insertions(+)
>
> diff --git a/rust/kernel/bits.rs b/rust/kernel/bits.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..ec13bb480082de9584b7d23c7=
8df0e76d0fbf132
> --- /dev/null
> +++ b/rust/kernel/bits.rs
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Bit manipulation macros.
> +//!
> +//! C header: [`include/linux/bits.h`](srctree/include/linux/bits.h)
> +
> +/// Produces a literal where bit `n` is set.
> +///
> +/// Equivalent to the kernel's `BIT` macro.
> +pub const fn bit_u32(n: u32) -> u32 {
> +    1 << n
> +}
> +
> +/// Produces a literal where bit `n` is set.
> +///
> +/// Equivalent to the kernel's `BIT` macro.
> +pub const fn bit_u64(n: u32) -> u64 {
> +    1u64 << n as u64
> +}
> +
> +/// Create a contiguous bitmask starting at bit position `l` and ending =
at
> +/// position `h`, where `h >=3D l`.
> +///
> +/// # Examples
> +/// ```
> +///     use kernel::bits::genmask_u64;
> +///     let mask =3D genmask_u64(39, 21);
> +///     assert_eq!(mask, 0x000000ffffe00000);
> +/// ```
> +///
> +pub const fn genmask_u64(h: u32, l: u32) -> u64 {
> +    assert!(h >=3D l);
> +    (!0u64 - (1u64 << l) + 1) & (!0u64 >> (64 - 1 - h))
> +}
> +
> +/// Create a contiguous bitmask starting at bit position `l` and ending =
at
> +/// position `h`, where `h >=3D l`.
> +///
> +/// # Examples
> +/// ```
> +///     use kernel::bits::genmask_u32;
> +///     let mask =3D genmask_u32(9, 0);
> +///     assert_eq!(mask, 0x000003ff);
> +/// ```
> +///
> +pub const fn genmask_u32(h: u32, l: u32) -> u32 {
> +    assert!(h >=3D l);
> +    (!0u32 - (1u32 << l) + 1) & (!0u32 >> (32 - 1 - h))
> +}

Would it make sense to also have u16 and u8 variants? I guess one can
always use genmask_u32 and then cast to the desired type though.

