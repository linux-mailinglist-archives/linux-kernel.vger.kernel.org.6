Return-Path: <linux-kernel+bounces-199468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7088D8783
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9002028AA19
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C05413213E;
	Mon,  3 Jun 2024 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RxgvBq3Z"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE9C1369A3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717433770; cv=fail; b=eT7BQRy17zr+6C3iKSBAM/0D/7X4Mt+Pi4fBcmhKHJG0SP8Gy9WjkxOV16XOUkUrLugCKMHs40ZMxONFBw7z60FcKQKL7zMZWDTqvRuM45EgyPgYPEgTDBALxTyaBhieXzsZSeItMv4PUsokRcyRda0jqiZuGqDNVqi3YDPW90s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717433770; c=relaxed/simple;
	bh=GO6BmUI45ZCgu3o7H1zBJ1vhL5XQCkIVIieUYvB/49c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hEdLZ7oDBkVjYYBhgEGy7BClOQg6qNo3QGhPqb3S9d2Sp/44fDhcdy07NJ9ALzY6BBnjskdPf124o+rEcNZjhIFYebFa7VFk0N7Mq8RSNhUxD1mDaMQ4W3uphHRH2cx9YKJZmCyE9XXB2HXIKsYoOzVT+/ZiNQHhIKh9cwoVw7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RxgvBq3Z; arc=fail smtp.client-ip=40.107.100.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPv3vidg4Hs1zdQRFRN/RGVgb8k98AV3kLIvfXJgwd8mZ8+zf1HDTSUUf9Y+6l+gKsD9RPsOnSn+pWC8KxxgfLIJn6IyhfhsTn1Cw1K/xMJiJrOE2cAoBmFfhz6stdWbJSonjZKPaYX6n4qxW4rMy4cNMtjbu6cJCVUkKTzCSVuNsg66DGXrtVfUf+Dcowe73C16D+Nw2zmnACuu79kB9YbpoUiu6uqAT/Ll7Y8mIz0lGCgKz7B2K+VFjpy1DNpYfjYWqZSb+58sFgJtuF2c71bvEb+A6dHCZ7iMKFnZzombBkqXL8BC2K8eygPMUjdWctI7ViXgtP2i55EH0WE4LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqvPUZo/alyLSjq0/+yWvha4eWyoe8cHYf7Ywu0+k/I=;
 b=lWYxCqjtpXKsI2UpJU5KOpyoWg9MQE+m3abPXnDXr0xCOqCMJzuhiEWxp4096Ncexrr/0pDnBc6Lg+2AKItiSpKXarZ/HoiPfgRNNKE+W0DIGykTyOXhQFEpAM8RApm75yHBKE0vaiYif1T5em/qVp4hu66XarxHUfEiDwJqOiLS9f5u+Vx8sqmvKfBaJUwcueMFET7gQtkpIj3vbwkGJ+VlQ4yJ3t1JzuJyATAkJ8Pw3jEeHCFKgrZqHVksNxmfDqO4Ea6nif2ShzJinOz8JfPHjR+EQsi/5Q963LSqJnxWks3Ul8QWvJUn8K3kD3aM30+a6oetsOutbf7PjOozfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqvPUZo/alyLSjq0/+yWvha4eWyoe8cHYf7Ywu0+k/I=;
 b=RxgvBq3Z8/QxnmIq0SrOHZq7NEWcSrhr/iPxKnVxOvkHHFHySq1Q7BOJS8K7RnCJnLkJk/uqgLyB6vDzzlcEXR449M4pECeNJljjcAAt+n76YxNEQM4rOwtfp9a86hUHKNB46kMs6G1B3iNwuP2zvX19MVXkzvYP4fX42zUJi3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SA1PR12MB6947.namprd12.prod.outlook.com (2603:10b6:806:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Mon, 3 Jun
 2024 16:56:04 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 16:56:04 +0000
Message-ID: <141a9666-f3cf-4323-9536-4367f489be43@amd.com>
Date: Mon, 3 Jun 2024 11:56:01 -0500
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
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com> <Zl3hPefvOwPv0Mjn@kernel.org>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <Zl3hPefvOwPv0Mjn@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:805:de::32) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|SA1PR12MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: f5bcafc9-22da-4df1-c54b-08dc83ee0e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MURaZ2NUejRmUGF0TU5NVVVFdk44Vm5OdHNuOGNvTnhzZVJsdm9BQTNLT2tF?=
 =?utf-8?B?R1BzeVdnVWZOMXIwRnFSeW1pQ3EvdDREdkIzcW1mMHgwczJVUFZ4NFc5TEdP?=
 =?utf-8?B?ZmxDWWZJTTJ0NHdWSTllVmJqY3FyNzlNRk42WjdwYmhJeUs1cWlHUE9lZHUx?=
 =?utf-8?B?T0w0dEhtMTVWZlk1OXhhTkUxY3FMUm5IdThrckhMdFhYWDUydTFMYUlxSmxT?=
 =?utf-8?B?eCtIR1lzcjJ4Umkrcjk5TFdLWEo0S08zdFZRLy93cm1oOWZOYng5UHBQRmNs?=
 =?utf-8?B?T1ZLWEIzZVF4T2l3bjkrSkg5bVFMZHlPc1pTbGFScitvQnY1NWdZQWhaWXRU?=
 =?utf-8?B?cDVNM3UvVFZHbXBOQzdwbyt0aVliVWlwV2lEQzR1dHUwVXBqaDhEa0FFRHFQ?=
 =?utf-8?B?d241VU93NnZGMzcvSHVZeFFpRUhiNnpVRU1rOFdtY0s4VlJ1UG1OaVUrZWE3?=
 =?utf-8?B?b3dtK3R0TG1MSnJXUlNtRmhBVzRacm56cEFlZ1hmT21WaThsd2N5dm9HQWVG?=
 =?utf-8?B?L2RxUTAwYk5ULzAwclpvN3lqeEdVNXhHTStSbjB1Z3p4Z3dQUHZ5cEIzMFpU?=
 =?utf-8?B?cU1Nbi9QMUxFMncrQnlKLzZaVUtLVlIxODFpbnR0bHI1MERNNUdxdVZ2cm05?=
 =?utf-8?B?ZDhLcmhKeVVIN1h2QmlHVTlkbUdKNExoMkZKeDFFK2pVVEt3TnpUQXltSEVi?=
 =?utf-8?B?cXhUbExMRmRsZUM4R0FWVzdNSjNFMnZVSWtUWTZJVHhNempiUmp1T28vdUZW?=
 =?utf-8?B?VGo1ZEYzVEs1dkZiOGFhUzJGL0lFRXliQTRQaTM4YlgzdERLd201SWpVQm9Y?=
 =?utf-8?B?V05RcG9UdGh0K080NTVtNkZ1YTVtS1o0Qm5YalVmK1NHQnNvYkJneGVrTE1B?=
 =?utf-8?B?QVpIdkpPVnMweGEvczdsWEhYYU1sYi8zbEU4RGRCaVNTR2hQVDVneStML2NX?=
 =?utf-8?B?QnZnVmFoNXNvS0R5YzQyWTZ4SXppNkRodXpmczd1Y1lCQXF1UFpjWEl2WTZ2?=
 =?utf-8?B?bnA0d0ZDeFU4aVB2T3Bva3NqTGp3cTViK1lKOHFqbUVwU2dYRDVvTHcranpL?=
 =?utf-8?B?eWFoaURHWFBSZ28yZGYyemtxb0NWK29pZHE1WlQ4b2I2RlY2WXV5ZE93MnNX?=
 =?utf-8?B?L2JoVjMxZnd1aDk4d3BPaDdXWC8xcWhraWR6QmIzNWlGN3h5QmNFYkRGa1Ny?=
 =?utf-8?B?UitSMkhuamFuU3JaeWp0aUcweVoxUlB2c05UUEV5ZFZDWVo4MUFjOTg2Ukhw?=
 =?utf-8?B?V3l2NGxORDJDV2RHaFNkclBFQmJrbkI3NmtHZmhXUDVwSlFZbU5pNkZpRElk?=
 =?utf-8?B?YU1QMW9WWFNjZklOWjQycHN2Vy9tT0FBRzVhZ3F3OE9kdTErWElSWTFWMHFo?=
 =?utf-8?B?dkUyTjN5K0t6UUtKVGxGMVpYS1hhWTZ5SURySk1HZlZ4cVpWaEdDTnR5UzNt?=
 =?utf-8?B?cnFMb21zS29SLzFMelYyeUkrTWk4TWFraUM2TW9jRkVJYk5jSXB5dy95N1Ja?=
 =?utf-8?B?aVFRL2lkRFBoUjBaWEVMKzBKbG9LN3hKQ2QxYk5ZQzBMZDVvRGV0SGVCcUtX?=
 =?utf-8?B?d0gvblVObmN4bm01d3J5c2g3R2VwcmZ1Vit2V2JmWm4xMDBGRnFhLzBoQXJ4?=
 =?utf-8?B?SXNqaldqVkozS3BQQTFyc1BaMHhWYzhBZ1dVY3FCQTVPdDdxUzk3S1JjdEZ5?=
 =?utf-8?B?NDYwdkhranYyMitySDd5TmVGbU9CcTFWMWZFbUxaaTNEUjJnL1dnb1RnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vk0vRnk4elBhV1BnblIyT0tZRnNycllxWGo0dkJMRnpSNnp3YjNJaFd4R2kx?=
 =?utf-8?B?QUg4TkRScXVBSjgvNjNLZ1FjbXBMc0tvU3Q4a3RCUWs3YTRkZlB6SUJVanh6?=
 =?utf-8?B?R0k3bzEyQzRwSWxkOVh1azVLVWhpeXUrV0VJMGRaTUJBMnJsYm1TK1RMbVVx?=
 =?utf-8?B?aVlWZ2Y5VnFycm9GSTRCY3dFYXZHZG5LdlM0NmFta283dTBpR2JRT0RmT21i?=
 =?utf-8?B?TDIzcVlxTVY1SG84MGNzSWkrMUpkOURJMXQyVnd4R3ZkMlFMdTZlanpicTJv?=
 =?utf-8?B?cmROYlZtTG9vKzZ4VVhkdjM3WHE0VTdLZ1M0NXhhV01zZy9IeS8wMVM3NkM0?=
 =?utf-8?B?dUVRRU9NSFc1Ykt1Snl0OTlkaytlYWdmZjkwbDU3TC9rcjVPTkY5bGJCOVZS?=
 =?utf-8?B?bnZ2SGUzN0ZTa2QzYTgzQTFRZlRYLzgrS1dicGloam9mQTdKaVRuUE50SHV6?=
 =?utf-8?B?T2EzWUdPQVJsNHBsZ3hYZjRDZFlvTGIwUExrKzNRUUxOUTRpUzJ4bllCZkt3?=
 =?utf-8?B?S2QwNnp2Z0NVQVVtaFY4VkMwdWgxd2FIRGc0eVdWNUxmOUJFYU11a1BDN3Fy?=
 =?utf-8?B?M0NzSWU2T0hLQi9tSC95TGpHTXlDLzJmRGl6L0dRK0JEWWlhMHVuQUx6RUN0?=
 =?utf-8?B?M1V2UXRDUXdkZXR2ekx1LzRmaVFYeWVTT2ZLeHFsRWF1STBHaCt4S0pTbG5N?=
 =?utf-8?B?TjBXR3JaMlhPaWxwT1RSRFlQZHlZZUhId08zaCtTcnhxamgzY0tvTE5xdjJr?=
 =?utf-8?B?S0grY21SaUs0Tjd5V2cvNTNHU0ludWZWa3dsREhjUC9sZ2U0eGFjb2UvRVQ1?=
 =?utf-8?B?RFUvTnlONkMwU2tlSEJJTDFtVGtpMDk3QjJuc3JoVWdzYWFnL3ZBZnFHQnBS?=
 =?utf-8?B?d0ZkWVJvNlE4a0t2SXg5WWo2V2hOblBwVmJzaDFkeFpjTUlKYzZGRko5R0hR?=
 =?utf-8?B?NlNqL0xuYmJCVzZZMHJicHNPSGh4Wmo2MmZlWjF3TnJnVVdRbzVtWjlsYXcy?=
 =?utf-8?B?T0ZZUnVvVHA4c0JqZkRoUU5VTm9INFJKY1ZXbEIrZmluampJSmJMczBwNGhI?=
 =?utf-8?B?SDBHdmpEN3l2TWRvMjR4NWpYZWN2SEh1NmRHemJ1Z3ZVdUgrQ3BvVE5sTmNE?=
 =?utf-8?B?SEEvUnd4YXZDZFV1NlJLQXBHVzlNcEpPSFdGRjlrQ2JOcWlkYVpWS2tkazNW?=
 =?utf-8?B?M2dpY1NKZlFudUxxTytjNWtIZG42TjN3NWFHcUJBUDhyVlEwaEhuK1RRNmE3?=
 =?utf-8?B?TUlzU2I2TXdQRG1yNjh1WDQvbDQ4QXFxSkZXcUxhczgwaFNtYUkzQ3diQ24x?=
 =?utf-8?B?QnRrWWNZUWVINzJSSzlwRjlBbElNRU92eXpHYlo1QmNKbDBIYVcrTVNiMVVY?=
 =?utf-8?B?aUtVMzhobm1vaVBkWEJtOURhSWcwaDJvbU9HRW9NVCtNUkZkNGZRZFFXWGxq?=
 =?utf-8?B?c25tVWZoR3d0bWM1V2ttMXpQWmw2VkVRci9CbWh2aDZaZ0dTZEpSTEhTNXNr?=
 =?utf-8?B?TnJRaW1OTGgwTGVvRW5tMGZSNWs0WXI1ZWlpYVlKdlh6V09Hc0t4YXl4WjRR?=
 =?utf-8?B?eml5K2dOTm55elZaTEdHQjRDR3ZQNnBaMlhpcDM1ajJ4NkM5aG5IYWozUmFP?=
 =?utf-8?B?eTZxNFdqN1AxL2oxeHlLVFJ2UkFUdDk5S1BTUEhwelRxUGxpR3lTY24rVDFi?=
 =?utf-8?B?UXN0dEgxbStrdkkrU0JnNDdVMU43WUt2TFB3N0Z5TXNHYlBEbmQ1eWFQSEJP?=
 =?utf-8?B?ak1PTldndFhFSmN3RnhxN0RYbzhGNEZ4UUMyenVQV09ubnM2YzNPZUxqbmtt?=
 =?utf-8?B?aHV4bGkyMDBpb0c2c2cwcUsvVnI3L2xxNElGZmFRaGpOaGR4elpBYm9HaThr?=
 =?utf-8?B?dHNJbzBSQjFKUUp4Snp2RUVyZlhmcWtnZWY0emhQTUhUcGdGUEZaYk0ybG5S?=
 =?utf-8?B?QnpyTFAzZk9odzJ0RnltUnNWcmticHRQVTBQNnJmcXRkcG80TTd3bG1qOERn?=
 =?utf-8?B?UHNHNHRQMkhxT0RjWWJ0eDlONVMza1g1NUpEK2RZdzZ0T3JZNEFPY1M2dUR5?=
 =?utf-8?B?QlhzVllRVEtFZ09hUVlsSWI2ei8zcDQyU2JOZnBVT0hTV2N6V3R4S2c5ZGEw?=
 =?utf-8?Q?cLpo6fvVVDbwcu7V4XPlaLPQn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5bcafc9-22da-4df1-c54b-08dc83ee0e59
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 16:56:04.7561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRZXhty8sQ+YgIvxaydqkeFRyeau/RodS2LbsnGusC1zCvrP7j6cyyRPufKOXqu7qnqhP+Nhco/9EvKuh7jo4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6947

On 6/3/2024 10:29 AM, Mike Rapoport wrote:

> On Mon, Jun 03, 2024 at 09:01:49AM -0500, Kalra, Ashish wrote:
>> On 6/3/2024 8:39 AM, Mike Rapoport wrote:
>>
>>> On Mon, Jun 03, 2024 at 08:06:56AM -0500, Kalra, Ashish wrote:
>>>> On 6/3/2024 3:56 AM, Borislav Petkov wrote
>>>>
>>>>>> EFI memory map and due to early allocation it uses memblock allocation.
>>>>>>
>>>>>> Later during boot, efi_enter_virtual_mode() calls kexec_enter_virtual_mode()
>>>>>> in case of a kexec-ed kernel boot.
>>>>>>
>>>>>> This function kexec_enter_virtual_mode() installs the new EFI memory map by
>>>>>> calling efi_memmap_init_late() which remaps the efi_memmap physically allocated
>>>>>> in efi_arch_mem_reserve(), but this remapping is still using memblock allocation.
>>>>>>
>>>>>> Subsequently, when memblock is freed later in boot flow, this remapped
>>>>>> efi_memmap will have random corruption (similar to a use-after-free scenario).
>>>>>>
>>>>>> The corrupted EFI memory map is then passed to the next kexec-ed kernel
>>>>>> which causes a panic when trying to use the corrupted EFI memory map.
>>>>> This sounds fishy: memblock allocated memory is not freed later in the
>>>>> boot - it remains reserved. Only free memory is freed from memblock to
>>>>> the buddy allocator.
>>>>>
>>>>> Or is the problem that memblock-allocated memory cannot be memremapped
>>>>> because *raisins*?
>>>> This is what seems to be happening:
>>>>
>>>> efi_arch_mem_reserve() calls efi_memmap_alloc() to allocate memory for
>>>> EFI memory map and due to early allocation it uses memblock allocation.
>>>>
>>>> And later efi_enter_virtual_mode() calls kexec_enter_virtual_mode()
>>>> in case of a kexec-ed kernel boot.
>>>>
>>>> This function kexec_enter_virtual_mode() installs the new EFI memory map by
>>>> calling efi_memmap_init_late() which does memremap() on memblock-allocated memory.
>>> Does the issue happen only with SNP?
>> This is observed under SNP as efi_arch_mem_reserve() is only being called
>> with SNP enabled and then efi_arch_mem_reserve() allocates EFI memory map
>> using memblock.
> I don't see how efi_arch_mem_reserve() is only called with SNP. What did I
> miss?
>   

This is the call stack for efi_arch_mem_reserve():

[    0.310010]  efi_arch_mem_reserve+0xb1/0x220
[    0.311382]  efi_mem_reserve+0x36/0x60
[    0.311973]  efi_bgrt_init+0x17d/0x1a0
[    0.313265]  acpi_parse_bgrt+0x12/0x20
[    0.313858]  acpi_table_parse+0x77/0xd0
[    0.314463]  acpi_boot_init+0x362/0x630
[    0.315069]  setup_arch+0xa88/0xf80
[    0.315629]  start_kernel+0x68/0xa90
[    0.316194]  x86_64_start_reservations+0x1c/0x30
[    0.316921]  x86_64_start_kernel+0xbf/0x110
[    0.317582]  common_startup_64+0x13e/0x141

So, probably it is being invoked specifically for AMD platform ?

>> If we skip efi_arch_mem_reserve() (which should probably be anyway skipped
>> for kexec case), then for kexec boot, EFI memmap is memremapped in the same
>> virtual address as the first kernel and not the allocated memblock address.
> Maybe we should skip efi_arch_mem_reserve() for kexec case, but I think we
> still need to understand what's causing memory corruption.

When, efi_arch_mem_reserve() allocates memory for EFI memory map using 
memblock and then later in boot, kexec_enter_virtual_mode() does 
memremap on this memblock allocated memory, subsequently after this i 
see EFI memory map corruption, so are there are any issues doing 
memremap on memblock-allocated memory ?

Thanks, Ashish

>>> I didn't really dig, but my theory would be that it has something to do
>>> with arch_memremap_can_ram_remap() in arch/x86/mm/ioremap.c
>>>> Thanks, Ashish

