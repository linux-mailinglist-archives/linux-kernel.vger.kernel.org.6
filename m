Return-Path: <linux-kernel+bounces-199262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 951EE8D848C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E043286A0F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D19515C3;
	Mon,  3 Jun 2024 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0hTitrFQ"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6484422075
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717423321; cv=fail; b=bjRkbePADa4UUm+yOyFws/xyZvU4nSbp1BIw8ob7NVm5irnSa73PW25qBgIl2OhqNxM2Zx1WMtivRC4tJx0G5tx2PFXPBemOrD7XQm/hBII9NfZTJeUOvd20WhJGADwx0wsVOp+I+7Gb1M9cUv6+K9zbvaXueM9AxfvACtPNWcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717423321; c=relaxed/simple;
	bh=ch2hkyG+rxfFI48wDRt1bnmiJ/aGu5UKkcR8l6L+7mI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZClYvD46S9se9ll6kguysfhcQl/9tAEz69XPyHv70eL8LNB7nRAyfcShiSSyt/RLit2CFaE4u/6ftl3bj9jEMNFp7P2b5Mh3t83OSjPaD6EkLHiDOD4RJEUjIw9+4lT9f4nAQhFGNVfA6emWkc/Dsw3esaCbzMWICRir6yB4CAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0hTitrFQ; arc=fail smtp.client-ip=40.107.101.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcZVuGEBAQa/AfOBnOqd53+2PlHRriCc9MTHneCJ1LdhwDIawePNmFYC3YbB8dGiS/U6LxLdHS44SymAhbq/wzah8b9JQgOR9cZBBI/AaULBLzXhkkVLkVnVZ7T8kRdhSRyQrtHeeB/7phewYMKEb6KTJgRfE+p4Z4jm7E6FTpVZFm025mhM9q1zjf23YHyt239X3MAierteC9dQFMyhyRIRcJ1t23fBoPQsmqCFLeQnfsuQTWnpaSU456dhHjiVGjF8vzL1XcO/gj8GiB5EyeWRhwnJ2nwpvzVU8jV24C4NRh+DewZI9ES5vnTLg4qgcI4vByrST5ASwv2EKXx54w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cU6UL8eruH22RT4RZHN7uflZyrtBUxxK2bKSHIJzFo=;
 b=nC0Thr8/FPupuUJ8OV6EGn+IlATaUBACJtH72zqHM3xULvKiDfTc0vO4k7qbQoaIrkuAjrBlXNIKhIYxIJUCKrDfCfmXgeti2DpN7j8DOBpPYy/yxxCJ9fu4LC8G6ZeO5ImZnX7R4ldEVj7gbumkwZ8PgoaWdrsPODbLvZhX/wKJ9fc+oPYA5BLJO5ievoaNsH273k0qkWdLmcoCoRbKLktHjQ7Hx21Ea21Ek8is1PGRJno7TiKeqRQRZtkful0VKEl+QenCwUIaIha+s88+XmrS6eHwtlQ2Y82HJ7RY7a5OiBddbt82dFm/4kpXBEDqVGYjvfuE4hXGmDSwjJiAuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cU6UL8eruH22RT4RZHN7uflZyrtBUxxK2bKSHIJzFo=;
 b=0hTitrFQVZQfDyIkV9Cdm6NXn7sCvKIpTlhOpfS3dqFaJDNfuyCKoQAapHhLc0SPFkg58fZgKcOkXO4CIagQTTYKs3gliV7XNWG+4XkC39Z9tmWcFwrnUlon9XgF3IuZD3BttUKuBCgYVgJZDM+1BafBVLMsorkYsm9nC5RxqhM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by PH7PR12MB5927.namprd12.prod.outlook.com (2603:10b6:510:1da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 3 Jun
 2024 14:01:53 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 14:01:51 +0000
Message-ID: <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
Date: Mon, 3 Jun 2024 09:01:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Content-Language: en-US
To: Mike Rapoport <rppt@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org,
 hpa@zytor.com, peterz@infradead.org, adrian.hunter@intel.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
 rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, michael.roth@amd.com,
 seanjc@google.com, kai.huang@intel.com, bhe@redhat.com,
 kirill.shutemov@linux.intel.com, bdas@redhat.com, vkuznets@redhat.com,
 dionnaglaze@google.com, anisinha@redhat.com, jroedel@suse.de,
 ardb@kernel.org, kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <cover.1717111180.git.ashish.kalra@amd.com>
 <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
 <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com> <Zl3HfiQ6oHdTdOdA@kernel.org>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <Zl3HfiQ6oHdTdOdA@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::9) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|PH7PR12MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 567cadb5-c58c-464b-ae47-08dc83d5b7de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WG9qSU9qSmJXR2tiRnBvWGhJNi9BaFlTVkxiR2VoRSsyV2dWd01JaUFna3lP?=
 =?utf-8?B?MEgrZk8xNUNTRUlNSjgwQ0xybU5xV1UzQ3FzY0hiR25hQjRLZlFxb0VBaHVI?=
 =?utf-8?B?MURqOUd1RmgwMjdpaExaaFc0RzNIS293VGc1bjJlb1B3Tzg4M0xkM1NBRjg4?=
 =?utf-8?B?T1JGZ3RDYXVqQUE2cHRuNXljSmNYaFg0dkMxcnhoOEMyNEdpZjZTWGNiY3Uz?=
 =?utf-8?B?SWFWNXZ4eFdFNGlZb2s2NE1JRUNGVHV6bTdWYklCZ1RTbGtYRHFSSFZyVjVX?=
 =?utf-8?B?RWQrdldlaHJOa0d0Ni9qeEJ0WHJZdURvd0hHSjQ5VFVKaVlDNDlNc1lzL0hV?=
 =?utf-8?B?Y05JbmFKSTAyNlMxdWsxUU5tMXg2WjduYlkybUF4OVpiUkZTRDExcWNxSURZ?=
 =?utf-8?B?QzU5MHRoVGd5WGpUdW1Iays2S251cWQwRnA1bXJRdmhCSVBUb3VTOTc5a1Fz?=
 =?utf-8?B?Q1lLRWRnSkU2bHp3R3BxbUNMUHF3NnA5RnYvM3BxbnZhcmRnbmVORGtESHAz?=
 =?utf-8?B?MGNMdjlUT3AvNkQ4Y0dFcXBFU2VzWUkzbk42VmlJUTIrejE2a2Z2SkI5M1ds?=
 =?utf-8?B?Z2ZESTl2dUh4dVRMazN6S3UyVUx1eDBuOGI0M2J0NUNTMTMzKzdVeU1BM0tU?=
 =?utf-8?B?SktWZmZCTEhWN0ljSEFJT252UVZ3UjJDY0JkTUN1VDE1YVpvZVlaRkNRNTNO?=
 =?utf-8?B?b2dhSTZkZUR2eHM0aDdBYVhRaUlKVmNkL1Z0cG01Wk9YTFNnMkNVWDNBZklr?=
 =?utf-8?B?eXlTQTZNeUJacDNpUzVUNzRMNXd6Wjlid0lVNHlta0RlTEJRb1dYZDUxanFD?=
 =?utf-8?B?YWVXRGYyWW92cURBUlpLQzNpTG1ZalozMDRsRGFPbmdGNUhJbXFCYTdScWFw?=
 =?utf-8?B?ZUozbEliTWREQWpqaHJiSUx4VUtnSFdLZlFzU05mc1Z1VXk1WXhYOElmbjhX?=
 =?utf-8?B?bFJZbCs3VmpyR3J0by8vMElsMmxBN3ZsWmtLMWhyVDg2TkwyWXdlaTAvbEFQ?=
 =?utf-8?B?cGo3MmIzUzRKMXQ3ZitaVU5nSHU3TVVWNkNLL2s5bTdKb05EN1MvVkpkQ053?=
 =?utf-8?B?c2FCNWdFQkNJai9HbjZmQWEzVUJWZUdPQ3lYbHFTY1J3eU5NQjQ2SzJSYnE3?=
 =?utf-8?B?L0l0NnBjMUFwK3llQmFjRmtXTWhUTkJkbTViYXlRZ2NXc0U5YWQzM05LdWpm?=
 =?utf-8?B?YVc4Y0ZTMkNiaFBQVkZza2l5c0N4MkRhNFZNVm1kV1lrWU8wYWNLbm1GMHNs?=
 =?utf-8?B?a1JVSUV3R1EwUUVoUEhUT0pPVTE2NkQvYmFjNTEzdUVoS3V3Q2Q0UDV6eEM5?=
 =?utf-8?B?S1BpYm9LbTMrVHJFRzZyV0lIRWNaRC9tSFk0SU5pOUFaL2xIT0ozdmdpWGZN?=
 =?utf-8?B?dFN3SXI1Y1F5alB6V3NpMDgwL2tjSXBnRmU3WW81VHpwNlJZcklKbFlLdFdN?=
 =?utf-8?B?anNNd2VqMkp0dWd3Szhrb2xqckpJTVFOSFBwNXhrZ3hVK0prNjZYNjNSMFlE?=
 =?utf-8?B?MDlOdHhCc29VOVBUYmhialZDQUNmQ0I3L0d4b09jTzFzaEpEUUR4bDA0YVR6?=
 =?utf-8?B?MzRsWElDckZpT3k3aURlc2FkQkhFeXoydnR6cUlRU29Pa2NsMzVVY3FiUC90?=
 =?utf-8?B?V25QQXBBV3UwNVVJcmZRdUxuZVpYeUJPOXNRajl6NUlHbzhmYk4vUWx4SWp2?=
 =?utf-8?B?cDJyQVVsK3F2N3RqcmYyaGVPVmZFQ3U3cEl0N29xTElPbjlhRE5LZVlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGQ0TEp5R0QxTE1qK1BMRVdDclJJSmdDQko5c081Y1dnMUo4RU1MNzErMU5k?=
 =?utf-8?B?Uk5wQnZzRTA5Wm5PZ1hXaVI1bDIzVm1CV3YrMVQ2eXdBUGs1ZkovZWxJREFB?=
 =?utf-8?B?cmF6QVNsUFhEb1p3bVB6U2lRdDZuRDYyS1dWVlYrZDU5ZHVYZmhYcUpPODVZ?=
 =?utf-8?B?ZWt0QklqL1IwZUwzZFAvSVBvMXdyQjYvRktCbjd2U0toUUE4dmNMSmNsZWlG?=
 =?utf-8?B?NVY1NS95Y1VLbXgwU1p3UXJCNUFYbWRCTEhYaVV0NEZESFkwZEE4RlBZaExQ?=
 =?utf-8?B?Z2RzOHFmcG56dEt3bGtZeXFrZEdPdzV5bjRZMS9LNTZFVytUK1BqMUhPQ1Nu?=
 =?utf-8?B?cXFwejNEa1Y4RUV6cjJQNzJFQTFJVFMxbDFEQXlMZ0c4UDRjMUFaM1VXNGZy?=
 =?utf-8?B?RUwrRUp0RENnRUlSWGtKK0l6dWk1bkNBSGdtOG5MTVF6RGFHS25kMjJ2NDlR?=
 =?utf-8?B?dDNIZlNqTWh5SjZNbFpYVURqQXJSTjMwOU9RV2FpN3dPa01JcVlOdHVvcWRu?=
 =?utf-8?B?SHdLeVgxYmpiWVlLc2VQTytVSk45MzZCR2ROaXlUUE1yK0hKUC9OWVBHRk9t?=
 =?utf-8?B?Y1EzK3RxNk1zZFBhZzY3cEQ5b0ZuZ1VGbW9aVm1nRU8rOEMybE9OKytyMGFk?=
 =?utf-8?B?NlNqWVU5SzJnTnhGUEY0blB2V2p3cDFnVTJBSUdYQjRSMm4vWmozZzZBRmNO?=
 =?utf-8?B?SFAvOXY4bGh4UzdkQVlwVUNHajRuelRnRngxQVZoMEdjbzJyV3hkOGEwNVU1?=
 =?utf-8?B?Zm5QMlFQZUlTY1hZNS9OeUFURE9QbHl3WUFhS2NYc3ptcEczaWt6VzJHY3Jm?=
 =?utf-8?B?N0REeE9DR2lTc3RQSDVMLzJVZ3Bab05ickNGdHpiZ3BOOVRJbGJNUnAvVEcv?=
 =?utf-8?B?TFd2VFRMWE83SzltM2xKOW5DZGJqNzRHR085SnBaUTlqV2NVektQVFNSZFJU?=
 =?utf-8?B?MkVUdkJvUnNHNklUMU1HQlhjUm5kck53YzZqaWEzWHY0UDlHUC93Qnc0VVpP?=
 =?utf-8?B?eEN0TU11Rnk2TXhUaUxvVWpZb0NIUDNjWGF5VE5VcnRNVXh1d252MHJ2RHNo?=
 =?utf-8?B?OFBkS3VTNkRtZXVYUnhkNExJQ3IvR2dJWlZublhWOFVXOUlud0lUVmNOS0Qz?=
 =?utf-8?B?cDFmVHFWVHdjZnBPRFdnTlh6SXpOY1RnYlBrczJBQzVzU0twSHQ4SE9EbVV3?=
 =?utf-8?B?WWo4cjI5ZTlXT3RKangrRnFWcEdCOW9sNFVyMTlvakJIVnFISzlXWXE5Q3NT?=
 =?utf-8?B?blhBOVRxNSs0eWhRTm1oNFN3NjFHU2tWeVZRK1N4QTdndHBURDBGWnFFK0xQ?=
 =?utf-8?B?Nlk0d2JlU1J6QnZzVllYdzdieU4vQVhNMzFGaDJDMW9IK0hYQStMZVg5dUk3?=
 =?utf-8?B?Q3FzbUpwZzhIdUhIcWVFd0FPNTZtQmVlWFgyellIaDlOQngxQmxHVVo5QjlE?=
 =?utf-8?B?UWxZc3VhN2g4SUI3NHIwN1JSSjA4NFFrSEhZaitTMGJsQzJIQm1NUVVMSk9h?=
 =?utf-8?B?eUZmaUtYOUNMZkdhaTU5NXlDRzZlenlwaTFhVVZWelo4MkhiUzJBL2owS0w5?=
 =?utf-8?B?NU8rTno4Ymx6Y2RjN0dOVGtJQUFyQ3ZDdTJnRG9uMnF1T0FkVXFxcFFvRmN2?=
 =?utf-8?B?VmF6TG5ZYWdwQVZMcGUxa21ub0V6cm1uL1JNbE01ZEp0eDk5N3ZCMmpsZTVY?=
 =?utf-8?B?cFhFc2JIKzBqL2lic0dCd3kzT3Zmd1E2b2tKaGQ4REFjeWo1RWVpbXRRZXhx?=
 =?utf-8?B?UzBqNHo3N2ZaY1RsY2RyamZIUnovYkdja2lrOTcrKzFmL1hycUliN3dhby9G?=
 =?utf-8?B?YWY1RmV0TkVPZnJET01HeGIrQ3lGZkZybVBYbXpMblNPZ1hhWGE4RTMyYWV3?=
 =?utf-8?B?QUlCZjdXeEFHNGdRS3hRQktPU1JORDBwQ3pzZE9YZzRqUzN0T3UyNm9lVWJE?=
 =?utf-8?B?ZjVFd2ZKaUtPbHhDa3U3T21KN0cwVFNYTnJidmZ4RXVlWk90OUZNVXI5UERo?=
 =?utf-8?B?a1NpQ29BTVZiajhYUytPTVJsdW1RR0tlT0w0REpVUVJldVlaWlRGMUw0NUhw?=
 =?utf-8?B?QVl2LytYNUt5UVBEdWd1bEI2c01zd3FsbFUwWGo1Q1FJeVoxVUQ1MVFYbEJy?=
 =?utf-8?Q?PL+c+VUTk7u+1BzJMJhduhGZo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 567cadb5-c58c-464b-ae47-08dc83d5b7de
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 14:01:51.6952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1hc/1bEcQU+5hwBfchNM67lQCK2kuQXsZFq+zBYiKRtpwS6EpSo89a31yMXDKSjUkaTYvGg481pBBAk4xCXhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5927

On 6/3/2024 8:39 AM, Mike Rapoport wrote:

> On Mon, Jun 03, 2024 at 08:06:56AM -0500, Kalra, Ashish wrote:
>> On 6/3/2024 3:56 AM, Borislav Petkov wrote
>>
>>>> EFI memory map and due to early allocation it uses memblock allocation.
>>>>
>>>> Later during boot, efi_enter_virtual_mode() calls kexec_enter_virtual_mode()
>>>> in case of a kexec-ed kernel boot.
>>>>
>>>> This function kexec_enter_virtual_mode() installs the new EFI memory map by
>>>> calling efi_memmap_init_late() which remaps the efi_memmap physically allocated
>>>> in efi_arch_mem_reserve(), but this remapping is still using memblock allocation.
>>>>
>>>> Subsequently, when memblock is freed later in boot flow, this remapped
>>>> efi_memmap will have random corruption (similar to a use-after-free scenario).
>>>>
>>>> The corrupted EFI memory map is then passed to the next kexec-ed kernel
>>>> which causes a panic when trying to use the corrupted EFI memory map.
>>> This sounds fishy: memblock allocated memory is not freed later in the
>>> boot - it remains reserved. Only free memory is freed from memblock to
>>> the buddy allocator.
>>>
>>> Or is the problem that memblock-allocated memory cannot be memremapped
>>> because *raisins*?
>> This is what seems to be happening:
>>
>> efi_arch_mem_reserve() calls efi_memmap_alloc() to allocate memory for
>> EFI memory map and due to early allocation it uses memblock allocation.
>>
>> And later efi_enter_virtual_mode() calls kexec_enter_virtual_mode()
>> in case of a kexec-ed kernel boot.
>>
>> This function kexec_enter_virtual_mode() installs the new EFI memory map by
>> calling efi_memmap_init_late() which does memremap() on memblock-allocated memory.
> Does the issue happen only with SNP?

This is observed under SNP as efi_arch_mem_reserve() is only being 
called with SNP enabled and then efi_arch_mem_reserve() allocates EFI 
memory map using memblock.

If we skip efi_arch_mem_reserve() (which should probably be anyway 
skipped for kexec case), then for kexec boot, EFI memmap is memremapped 
in the same virtual address as the first kernel and not the allocated 
memblock address.

Thanks, Ashish

>
> I didn't really dig, but my theory would be that it has something to do
> with arch_memremap_can_ram_remap() in arch/x86/mm/ioremap.c
>   
>> Thanks, Ashish

