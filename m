Return-Path: <linux-kernel+bounces-171819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 751C88BE91A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9851F1C20AD0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E7316D31E;
	Tue,  7 May 2024 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PbmBmYoD"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A5916D302
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099327; cv=fail; b=ixqWbscrq2s0Pd8KRxW+aP3v4auOaMTeYc0vkwzgt8z9pkDlzHAlPSn7uR5JT0JVqI+Wr0y+hNqvEEoaIi/y7khxDd9LCJ55PTjJg97oU6HXr16U/fcwNcZDgEoqLunLNloQVe1qkHqHPKFn3NhLjJCSjseO+5zielV+8HpRQxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099327; c=relaxed/simple;
	bh=YNY7sJd8LxqbnuSsgq5TSbRnCMeee5l/x1+PQjOjUF8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sOeZkVrMM3g8lcLYW1MSWhYggF5hv7zdVehF7jo/BDyX0wruy/7BezTUpyZnogK2z1fs1Z25ratChu2bcU1b3NQyIe9VoWdQ24yLxTElLykqm1PRvFAmA8fVFF5ybaVgZZyKw69UdkOCrg2CJEC5GNSokdI71xqhgtLX3twQFNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PbmBmYoD; arc=fail smtp.client-ip=40.107.102.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrGT5xpav/FNqFNm2GCNtKaDRpzxARXSmECD/r6dKsWuNLdQh58IYNrhconozQX1l72nmDa8ZIktfjt9GO2I2BoKCbO3UDpEuvYYgOU81LBv4Aq4qbpHMKsPQx+fUTIm9URUwN4u6AkJycV8XCULX1nPEfN1uAqYbnY5C2v8ZAU8Mope9enUCTZ7fX/l2fZASqKWPAn3kSzYEWJEbAhum17YPVp58B/HB6jsH35n8ABk6OtyNBYgSLuFTUtSR5qfPtoPHoL1eH3ClVgia9mnu6svoLv8xxEwcRMc+Wa5rePPKJh/V4PzzIF57ofiFflY5cU27DbgxsTmnf1dkaKsfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPolYrSEfKTT6LLHz10WmO4L3kB5TFUp75T3mMLXB/w=;
 b=G0YddfCI0VUWIS80Y05cmUktk6SDZuQCjT3RBEo+tCYmTLGu21LHNGtjEVXBgxyh9RhPnzRbjAu0fkP48V+POK7oWBIC/Fs+IbDFt8wnAxWwtFnW+nwbDemVGCPGu06+pJDmvQWagcNqhMjcXJH6HeslaGfU5p17y3BXV5L/DwpGAB9/NcNTQjI52UyVqQrNqw24lp+ZXxEiLgc8CPkcvxuXTYfCAgXAhLLnnyVMoHzrriFzkj+nipoMcHrR0jCXRAdba3FhiotZL8jYRlo843Y03lIMA60RZyDC49M0YXga0VLUwv3Ur1nOtc5ikftVrdQa57OW/jbRUlA76cxMcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPolYrSEfKTT6LLHz10WmO4L3kB5TFUp75T3mMLXB/w=;
 b=PbmBmYoDpTxkfUz427cRessfAyRiE3UmPraM5UYQbQQ/Vx6Qxsl16zhhkFb5eq6Y4yUFL74a1E5fkXa1n7IDBuVDcDENoFry9pc29p0qxr2WQwQ9BuJZLE/X2dG1Pv7XGN+FFy3NHpU8oA22rMIX12MEXpfMTv3aYXcACIQ8kRGlkqt8E44b/WyIzn50YQcLaBsIGSQ/ANG4Yv8djC4p+o3HcEqLwhMBrvmVWqsBBf1qDH/VL3cTWdDh63coG7gM4hsJPAqdU6f1iGwUp0GGEqCRM08KcYft2ku1kduj1nYd6hgqisaVn7FS4ya74v9KDu6H47vDDESLZkk3PQA5ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Tue, 7 May
 2024 16:28:41 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::5b0:8154:dfef:2cac]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::5b0:8154:dfef:2cac%3]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 16:28:41 +0000
Message-ID: <302d50ac-45ff-470e-90a0-b349821706a6@nvidia.com>
Date: Tue, 7 May 2024 09:28:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fault: speed up uffd-unit-test by 10x: rate-limit
 "MCE: Killing" logs
To: David Hildenbrand <david@redhat.com>, Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 Peter Xu <peterx@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>
References: <20240507022939.236896-1-jhubbard@nvidia.com>
 <016d8cff-efc3-4ef1-9aff-7c21c48f2d69@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <016d8cff-efc3-4ef1-9aff-7c21c48f2d69@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:a03:180::19) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4140:EE_|SA0PR12MB4432:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d18185-f1cb-40ca-b140-08dc6eb2c18f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjhlcHVJeTJuQTJjN3B0UEY0N0k1WlNKOFMwZm1EMzQ1WFNJT3Rlc0d6MHVx?=
 =?utf-8?B?emdPU2t6eFl0S2pmVXBtWjh1ODB0TUFhQTdJMmJPelhyemRYVmJSNVZmNlQ0?=
 =?utf-8?B?eVhkeFViYnNDa25qd1NWOCtQUFlvSjRoKzZ6K0taZEI2R1pkalZKbE54UHFz?=
 =?utf-8?B?aG1nWUdhaTFJak5scStid0s2UmF5L0xDbGZCWFJJUVBsMFVtVzRyQ01CUVZq?=
 =?utf-8?B?SUw1eXhwZFpjVTE4L015ejRqSW5TbWJyR2ZlajJtcHZxV25ZUjZNQlcvWVJt?=
 =?utf-8?B?SkNrMFF4c0JiaXZsM252UWlrb0F3WDU5cGJxbEpKSU5pVVVBc01nbE1Nd3By?=
 =?utf-8?B?NGhHY2hoVnFiR3VBOUdQMThXQXRXclN4aTd2YW1qVGNhQkhqdEtPNlR0S3U0?=
 =?utf-8?B?WVZ2S1EyK01CZ1JMd1Nya0d2QUxUTnVLUWVTV1E2MVVGRHFkQVpLSnpwRi9W?=
 =?utf-8?B?WUxxYTFMbTMrbkJBMGxFUmF4RnprSEtYMDlkRGY5REM0VU9MZU5Tekl4K2F3?=
 =?utf-8?B?WjRFRVVCNzFpMThuenRjSittYUkycWVENFdKS1MzcHBUTmd0WXVBUGJaa3Zx?=
 =?utf-8?B?NC9vOU1ZeWhFSSt2QmYrNjlETllMWVpTb2I0QWpBd1hLQXNkNGZRUEg0OUcz?=
 =?utf-8?B?amlRNXpxR1c1N2IrZjZmTDFaVFc1OTFYSzM3aU0xYzFkRU5PbTh6VHlXdkZW?=
 =?utf-8?B?NkhtL3o2Uk9xZHpEUmhFVURTdXZQTnlSNlFwYnF4cTBRN2E4N2ZHMjRhNnJM?=
 =?utf-8?B?SHF5QmJhNDkwU0hyU29ZZDN0emJHbXJBdkc5T2VlRTdqWmdxL050SnVIRVZE?=
 =?utf-8?B?eFF5dmpxSHNSdkhtRTE1L0ZoUzdxWVJpWGw0d2xrZ2owUWRkeVRORS81cFpD?=
 =?utf-8?B?NEUwOW9BNUlUNHc3bEY3LzZVUTgxTXBrazUrZEZydnlCK0c5L0NkQklqSFo0?=
 =?utf-8?B?SzJTdWpBQ0FUaFNLampObVIrdHpOekxzN09wbGtUOHAvNFJweGE5QjFGSXF4?=
 =?utf-8?B?NStLSDJjVlZJYVpzQmt4N0cxSnM4eUQ1OWRCWTJXRjVLc2dJcXR1U0htN2wr?=
 =?utf-8?B?aFArNmdadVpjOFExWnA3OVplMjd0azVwQlJZa3p4MCsraWNUUStiWlYyQVlk?=
 =?utf-8?B?WTBudE41SW5nYmlTYUIxdVYyNUh3Y1hvQUd3WEtyUVo0S2ZVTjRMa1NwcDRn?=
 =?utf-8?B?VmZxWGZkZDRTeXZnU1UvMHgxdEo0cGV5MngzbDUzbmhtS2hzUlczRmQ3aGZB?=
 =?utf-8?B?TTVrajE0WFViR3haQzc5WGhyQ3ZodVpkZjl2QTNQQitCbzJMbm5YZjhWM3Nv?=
 =?utf-8?B?ekpjMkZ4S3A3bzA3SzFFY2ZRMXZrUWdOejVRMWp5eHVoTmJzY1dtR2hYK3Ju?=
 =?utf-8?B?WkVVVlp1amI4YWE3ZXhLZEp6SEpqbzBNaktCVU9YWlJjTXVKYjJra0dteE80?=
 =?utf-8?B?YjY4MnM2aDcxVm9OcVdtUGlxWWIzdUJGTmJ1RzNqRlM0Z29GS1BhUStVbDRD?=
 =?utf-8?B?RjRGUlRpbHJzR01UanVlTFZBREpMOTdrYU8xdCsyY2FtTjdIM0FiYm80cERJ?=
 =?utf-8?B?ZVB6dVhReFgyT3BDLzdWdUgxcnA4UDZneUJyYjBQaGkrWDhZZndiTFk5VHJH?=
 =?utf-8?B?ZU5sUG1tbHgrNWxTUmZkMk5LTzRrYlBpVExsbFBzUUQzNXdSMU5jdksrcEtx?=
 =?utf-8?B?SVB5ck9FSFhPWllrNjZnVGlLQStJM2tSc2QyK1RFcHl0YjNsTjZsVjZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnZPOWIvRTZPbzlWR0NvRUE5dk5CV0c1c2lvWHE3OUMzWHFnU0hlYTBvTksv?=
 =?utf-8?B?azE3NEpYU3k5UVQvbGhYKzRFSTNQS3VPM2hnSnE1cStIZHl3K25tbnZmUXdC?=
 =?utf-8?B?TkN4ZVQ1ODVMMFFkUVpacXB2bWFwYUE0K2JJZDJ2eFZTZWw4bXY5eXIxOU40?=
 =?utf-8?B?NWRhSE5Zc1FvK2RtRzlCMVVSTXhhY2xmMFIzV2JyVWljcW5DbHc5Tjc5UEts?=
 =?utf-8?B?bGxERU9kU2NZOGxxSXdTOHROVGRBZWZ1KzI3aTl5emRvYzJJZ2pUblNGaXpX?=
 =?utf-8?B?YUorUkk0NSs5NG9IOVZVR1QrYnY3eXFyZ0p3eHpFSlRDcFNvemt4WWdSM2da?=
 =?utf-8?B?Qi92UXVPZGlFdTVyamQ0UlNUTGE1ZE0yNjJUQk10ekJCcVZINEhxRXhlem1k?=
 =?utf-8?B?NjJkRzIzV05NTVBPT29nWUl2YWx3cXZBRzBUTEF5SzJ2MGlLK2ZrdEJHTXB2?=
 =?utf-8?B?M2pqMFcwcWpRVGc2ZVJ0NEhzNW5udVZUODdLMTIwbWZNRjk0UlVCbHFnWkly?=
 =?utf-8?B?Z05jZG5HUEUvalpnZTA5QTViTmRBZUVIY3A1M1FUb0lGK3BDMnI4citvVVhy?=
 =?utf-8?B?YWJxYXNqbDFKVjkxQVNDTkNNdkZRUU9mb3NabkNjSng0ei9mdUlUUFc0S3Q1?=
 =?utf-8?B?Z2VJZUtTWHJWWWtNUm5USk9ua0NjaklMaG9OR1pVUi84VjlLRHBFS3FoSW5m?=
 =?utf-8?B?d0ZFL1I0aGRZYXpPSVljRzVlU1FLb1ZDRjQyYTNxSEljZmtmMGFqUXpZbHFh?=
 =?utf-8?B?blJCeTdHTDRyU29VZ253c3l5L2dXN2JVMVcvdDFWeFk4eXVZb2cyWWRpZjlm?=
 =?utf-8?B?VHZtMFAwSVFFY0xmVXpQUTNSd0hMY25QR2lpeXN4UGJXcUw3QWpuMnIxYUF0?=
 =?utf-8?B?czZoaVRDVGhkOTNGUU4vdnJaN0s2NHNHOXJlR3REdms2T09kQUFqcDBNb210?=
 =?utf-8?B?M2QzdFM2RmpyLzE1ZXJhQmJsSlI2eUZ2dmZNdEVIOFp3aml5RXROS2dVNUF3?=
 =?utf-8?B?WFJFWWJvTlNqRTliSENUa0EvOEQvMTcyak03NDVaUVQvT2dSRzRFSVkzRURO?=
 =?utf-8?B?V2JvV1JucGdBZXpVVEJ3VGRFUFNheW43MlN4b2FGcms3U1kxYXAyM1F6aVVa?=
 =?utf-8?B?Qml1bWFTYnlWZ3ZkbzNxNEkvdGYvdmlUWlh4ZWJ6MkJjTHZZTi9HMmdBZno5?=
 =?utf-8?B?UXBRSXd6RmxBWGZDd2F5Wjh4emtyeEJ0bm5JRWFKOS9nb0pFOTdFZ1Qzcllr?=
 =?utf-8?B?UlpuRzNialdBa1NjamtoK0ZPZXlJYUw3WHBXcmx5Mmw3RHdlei8wL0htL05D?=
 =?utf-8?B?bVRmUlFmZloxcWZyZ3p1blFNTkNVcWVjcXBOb2dQeEFhR0pMSWF4ZUw1R3VG?=
 =?utf-8?B?cEhsYkI3N2k3QlVvNnljdHArYUNvUDBMRFlaaVFlcEVvYTdicGlWc2dkeEJp?=
 =?utf-8?B?ekRMY2I2OWhxMTQ3L0RWUlJnSUlub2JEZXNOV01SeHlxVnVmUXdqRUJvd3hK?=
 =?utf-8?B?TUlmM0VkektCUC9sZ2JXMkh1R1RtcFJpb2RrSUx3N2lYZGZXQkNKTUl0QktL?=
 =?utf-8?B?TkNGZTdyZUhHME5FTWNBekpxSG53Q2daelBVV01KOGd5VjEweDhoR1ZVeWxt?=
 =?utf-8?B?UTNGaythdTFPc2F1NTE0NEpNRUFMS1ZsRFZuVThjTXFaRWwrdWtjQlRxTWU2?=
 =?utf-8?B?bkNpUDVXN0swc1lWeXVtYUhDdExwL0w0ZUdCYTA0eUlEdDRSUm9NajhLM1Z5?=
 =?utf-8?B?N2UyM0RuWllsU0tFSVlCRlVmemJqZXpLTWF3cytQbXBNdkQ0am9VSDJtYnFG?=
 =?utf-8?B?akFHTGNYakNMK2JVeDdHS0wxVVE0V3RKMDRnbjYrV0dXRHlpN255a3VIVEJN?=
 =?utf-8?B?bjhCdExYQ3VSWGVCalhHWjl5cUwzdmJUTXhLNTVpTFhHNm5UdmcxbHRoanQr?=
 =?utf-8?B?L0RielVyUEEzKy9jcDBqYllpcFNubDdrdktJVkZjM3lQc0JoM21mMHY5S3Jo?=
 =?utf-8?B?UnQ0MUtCWGl5U1dpZk1zaUxSamlxS1dEcnZMUm9iZzhtNk52a05qWXdJeUsw?=
 =?utf-8?B?NjAwZlVBZmxoc1dOWC90ZXZmOGpySXFHeXJGTkl6NC9KUGUwU0twVE4xUU9I?=
 =?utf-8?B?ZThaa1NJODFnbWtGT3o3cWJ0N0FvMm15dExCVXdLMVlDQUt5VktDb2YyYTdv?=
 =?utf-8?Q?S7s8U+ns5kZLV6bcQftsV6M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d18185-f1cb-40ca-b140-08dc6eb2c18f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 16:28:41.1545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0txLQCQpCkmCSxv1ZZCfFWZJW9GYn3v71r3cJDa1H7Jt81Ai47BajMkGj2ozPM4CYbcZHI5hd8TxhtPPM/vD8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432

On 5/7/24 1:13 AM, David Hildenbrand wrote:
> The patch subject is misleading. This should be "don't flood the system 

I went back and forth on that subject line. :)

> log". Nobody cares about the speed of a unittest ;)

Yes they do. People should actually run the selftests, which in turn have
enshrined their guidelines in kernel doc. See dev-tools/kselftest.rst,
"Contributing new tests", which says, as you would hope, "Don't take
too long".

It's important. Tests need to be quick, and having one out of 50 that
blows it up is worth fixing.

> 
> On 07.05.24 04:29, John Hubbard wrote:
>> If a system experiences a lot of memory failures, then any associated
>> printk() output really needs to be rate-limited. I noticed this while
>> running selftests/mm/uffd-unit-tests, which logs 12,305 lines of output,
>> adding (on my system) an extra 97 seconds of runtime due to printk time.
> 
> Recently discussed:
> 
> https://lkml.kernel.org/r/a9e3120d-8b79-4435-b113-ceb20aa45ee2@alu.unizg.hr
> 
> See the pros/cons of using ratelimiting, and what an alternative for 
> uffd is that Axel is working on.
> 
> (CCing Peter and Axel)
> 

That thread seems to have stalled. I *do* have MCE experience (writing a 
handler,
dealing with MCEs and related bugs), and what they wrote so far is exactly
correct: if you were going to flood the log, then no, we don't need to see
every single line printed. The first 10 or so, plus the fact that rate 
limiting
kicked in, is sufficient to proceed with debugging and/or hardware 
replacement.

I'd like to just do this patch almost as-is, just with a fixed up subject,
perhaps:

     x86/fault: rate-limit to avoid flooding dmesg with "MCE: Killing" 
reports

Yes?

thanks,
-- 
John Hubbard
NVIDIA


