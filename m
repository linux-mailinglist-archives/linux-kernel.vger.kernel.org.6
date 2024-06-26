Return-Path: <linux-kernel+bounces-231288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BE2918A37
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1D51C22B14
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BAB19004F;
	Wed, 26 Jun 2024 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ij8yU2aP"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1644DEEDD
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719423442; cv=fail; b=stWXkhhVwAD0l5ZfCEvoZfZtl4JEFufxjqMU98y+4rk8T7uOQYoqulsgGxgbr6zrEzN70Pud7/y8y0kjyCy5foW2QSqOVIg+AigHy4GElXml5jy2CoF/cu9RPCXDRaUwvb2lWC/yymGctZf39+orYX5toHnAfMebWuevnAdHW4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719423442; c=relaxed/simple;
	bh=wbnpVyI71K9kXzQwoyEZCdE9hgTipn5dHH8gfe2nLKc=;
	h=Content-Type:Date:Message-Id:To:From:Subject:Cc:References:
	 In-Reply-To:MIME-Version; b=UYPOkTh/VXhnbL2xA4FZH4XtFCmeSq+PKxa/8xD5F5EXErRjnrUxsuQ+ALEM9cDmsZgYmdI2J+VrUyZa0aMNNnYdpECXeozXKKaahqRicGKeS9sT0bgahUG7yHDiNrsJ09C+gyAaWuWozb8Fct7fpj7qfEN/7ZcVDEu1QyoUxcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ij8yU2aP; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMhy96rkpL8pJ62k7YlFISctzpn8TO1eH5en3j+36De9/D6aI9OkdUJOt0Z/MWpmvz0Sp5lP6yCFrH/RvsiNy8FjMXInO5vJoW++zpC6JB8LHwd9OCSWcOPJYjVIzt75gNF+ObGJOWVpG9DsgOP1mtrz4w6AjieUXwRJ0tRJ4jOv3HQB0SEbAj7S8/oStH0BcV73QVnkw1ZUpQjufh7tf2ChSmQ7jW6hXY+nXpQknY2J/5gRTxhzzsp9ckOuxoK4aOqNgNy3GNkVFhpnTIS4VwPlGSc2P3aI+I+aN/yBJFz1Ud2KGh4P9dChpXL5UaR31OCxsncKE+NGVLCsRi/XTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xx6LZtDfyBGRp0TKPWtwSHEH/7k2ERYlM6qpmbOE6zk=;
 b=GQuQ9iCnC4lWFc4nhio0wOHrDiQBCSHi4YpX+djAHwq2dleFzV0CVhmNTrYuEL6VxudV8uTpUksRiDOZe99pBr2vJN2We/7yA4UGNAly6CcJy7nQme+cBU4Bx8D1oCTCrGz+luN7oTAyUXEH16f0wf0X7hWfdgW+7If0EQqRyCDkzctu/Jgr2sR05yMWQqeks1B/vonrpWjzUCUi15BDqEYjUsh5HPv9ZYSx0fj8RC4zOBD5mYD7Yu+m+emQn32XYzQCEQW/0oRHMmIOu/zf5IfcgnLoVMQX0ZSDPArYQZ19tSygAvNfXgQtt7Y9PiA3qeHKBrWoY665WaShpmhBbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xx6LZtDfyBGRp0TKPWtwSHEH/7k2ERYlM6qpmbOE6zk=;
 b=ij8yU2aPNJFTIgneO4zA8JSfiBD97jhIDlj8zKbrvlq/Rt8LLswJ1MOZsaBDIPKTny/yhZ++mhpEbNbz/9PKMYapuAbVbzhNPqTG4yY+WYA3fGWdI2R2rGwNXt/Aey/1SYLga7V+CCdTxWre+X0aqLxFLSh0DZ4DKZTzE8Ba2twb0YbKyL1VOvRACXYKZb40kRzOE/h04cNe6Q1aLCNCynd59cZmxE8aKGQWZLH7/UkGJ/91RI+qaha4bQ47IPSLst60vAt0OkNX61tXivC79v+G7mY6/6Fsf4RJF6AETggxgPPa7zMRwcalLAQj54L1hW0W0zUn87a1SkfzmTbyNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH7PR12MB7234.namprd12.prod.outlook.com (2603:10b6:510:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 17:37:17 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 17:37:17 +0000
Content-Type: multipart/signed;
 boundary=60af808087422ffa755830f462faf762a172cb8b41a5c81dff6a55022946;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 26 Jun 2024 13:37:15 -0400
Message-Id: <D2A4QLLXOM9N.1YK9YRDXMWJPX@nvidia.com>
To: "David Hildenbrand" <david@redhat.com>, "Huang Ying"
 <ying.huang@intel.com>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH v1 2/2] mm/migrate: move NUMA hinting fault folio
 isolation + checks under PTL
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, "Andrew Morton"
 <akpm@linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240620212935.656243-1-david@redhat.com>
 <20240620212935.656243-3-david@redhat.com>
 <B726B923-E023-4E56-BED1-BFA5CEF644A1@nvidia.com>
 <c8f9d6fd-310d-4b13-9871-556b6b9a47e1@redhat.com>
 <0F4ABC1D-7A26-4AE2-BCAA-3EA906FB13A7@nvidia.com>
 <9af34a6b-ca56-4a64-8aa6-ade65f109288@redhat.com>
In-Reply-To: <9af34a6b-ca56-4a64-8aa6-ade65f109288@redhat.com>
X-ClientProxiedBy: MN2PR22CA0007.namprd22.prod.outlook.com
 (2603:10b6:208:238::12) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH7PR12MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: dbe61888-0e06-49ea-34eb-08dc96069f7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|376012|366014|1800799022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEVVa1ZUejFnb2VJSmN0S3F5UW1RZkFtWDM1cUJiVHZZYWM0SGg4YXJBL3ZF?=
 =?utf-8?B?NDFJZDNNSDI0U3RrRzV1ck9Cd2tKaENvL1BtUE55MmRmTFBKWVBacjV3RDUy?=
 =?utf-8?B?bHA3bW1La1FHaFA3Q21ua2duRTQ5SFVrb3doZ25XVDlJT1dpOEtJS2VUVDdU?=
 =?utf-8?B?K0ozZmRUcXlSUXU2MDhKRjB5em5rcnBZeEk0ZHVzeUZJeGs5bVd5MmNhTG1V?=
 =?utf-8?B?c2swK0NUSTlCV1cyb0tqcDFHMzNFTittNDJ1YnFOU0lubG9LcmdWdXcwY1RF?=
 =?utf-8?B?VXV3R1FJS1ZxZHQ2UFZaKzIwSmpYWWpSdWVjOHEyd1REQWxyRGRRN1RpdG84?=
 =?utf-8?B?WnhFK2VHODc2dEE1ZTFLYUNuSGkwTVE0VStmTnl0NkdyZ3BRNUFLR1FMOHVa?=
 =?utf-8?B?UWVDaHp1UjZUMlRCN1BBblVsUGZnU3hCNGQrd2FtT1ovSUFvVDM5NUt6by9R?=
 =?utf-8?B?dHBzcFB3aHFjRFlZdXY1eGtRdjRETGpIRjRWOVFzRDlIaHprdTU4Ym40N2Yx?=
 =?utf-8?B?UlM5bXp4RTF1aE9tQzNxdWJybU9GbWFFL2RMWUkyQTkxbjNORWM2WTducEtV?=
 =?utf-8?B?UUU4T2dIcU1jQlo5K1RVVStoVDJEVE1wN0NIdUNBZjRteW9lcDg3MUZ0a1J4?=
 =?utf-8?B?bFZoOVZHTjBMd2pXL0I0V00zQVdjQTB4UzBqRHdWWEtaTXYrZWlSWDlUYWMv?=
 =?utf-8?B?d1NSMm43NXVZMWU4emd2em5ETzJvWVBXN3UrdFVHVWNSbGZqeFlwVlUwTUw4?=
 =?utf-8?B?elJsS0VHRmJIRXg4VHdpeHBkL000UTJaWEUyczNlaFJKaVFyQkkrMkMzRDVx?=
 =?utf-8?B?NmtKNjhUQjcxL0ZpU1daYXVpeGsyOGVpdmZIcHJUNWJMdTFNQlV3bVE2b0Np?=
 =?utf-8?B?K2ovTHNyVzNiNWNXR3Npb3pOYm1Jall1Q2M3c3FKTWVSSTlnTTQxYk1rNm1E?=
 =?utf-8?B?aEpyMEpCaGNsSUR5OVR1UG9kY0dkZkxFRWg1Wlgrd1JFMEY2clE3Q29NQXlQ?=
 =?utf-8?B?bUYwbXQ0S2ZTT003WTdGYTN1eFh6Q1kzeFJiZ2t3UUhhWEhYbWhXbWdwR0Zq?=
 =?utf-8?B?b09hTkFxUlR2c0dpK1UwSkJyalZ6aUo1VGZpc1Y2UXhaUmhaQjlSeVFjL05s?=
 =?utf-8?B?RmJPNFBnVHVLT3hPVE5QM3k0UzhMWDhYTXpRRE13ZFZpZjdmb2EyK1NQdE8y?=
 =?utf-8?B?UVRjWFQweFlvZVpsOXpUcGZNYmZPamF3dkNlZlZ5ZVBRdHhxU05mdzlaWTI1?=
 =?utf-8?B?MW0rS3hZaExUbnhXTW9mRmd0dGllbm5tZXMwblN1Z0ZEVyt2YVVNWnZ1Z2ly?=
 =?utf-8?B?M2U0NkQ2c2luSmRjTFFXNDZDc2NYdEpGUWdZLzh6UjE1QUpleXdxd1QyeE9K?=
 =?utf-8?B?UWtLVU9OamtQL04zeUp3eHM0bU80dTlYRkNMU0hxNEwrZE5oS2VTeGM5d0N0?=
 =?utf-8?B?Q1V5RlA2WmltOFRqem5MMnVuVjJnWnNDRmFGeEgxT0VCTXM3K3R1dEc5RVFJ?=
 =?utf-8?B?eis5ZHF3eTNpRFRpSTNKZng3SVovVE1odU5wSUhvbHljQlkzVUhqVnV0R04x?=
 =?utf-8?B?ZVNqWVg3ZWtqUnRBN2NZZElUUEJna0dqM0M5cDg0K04vcTNWbEFBN2Z0cmox?=
 =?utf-8?B?RERJM0RMbUxhSHRpMm5Kdm9JN3JtYVdjWVRRTkRxeXhCZTJoNzRuRHhRVWt4?=
 =?utf-8?B?Qml6Tkw4QXJOc2tFOFUxS3ZFK2NKbFFQbnVTSVFqRURLNXhlQUxmbW5ncHIx?=
 =?utf-8?B?UjdLcXJFL0U4aEduMFlVNnFIS3ROUHZrTmg1V3VmcUthL1N4OVNYakZxeDAx?=
 =?utf-8?B?WHB1MTQ0aTBBZk9XV0hlUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(376012)(366014)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkFPN3RUV0YzRitCOVlVL3hYbGVhdmRSMS92M0tNYkdiTFBqS3lJQTVDVzA1?=
 =?utf-8?B?OEF6WHdydmZSN3ZwWVhXU09uVXhHMjQyZXhOdnE1aUo4RVhZaDB4aTBEUG84?=
 =?utf-8?B?bnJKckdmZ2xVbEZtblMra1l3TUNqR0loYTNTbEdHSmxNTExyTjJGeWNJcndB?=
 =?utf-8?B?cTdPQWhzZHA0YWNtTk1DZDRHWjdTeUZabkhKdWcxckxuT3NnNDBYa1hHYjh5?=
 =?utf-8?B?enNVdXdUbDdYVy9KTVZLaFZlQ0pTdzNQODh5WlQ1VUhBRnZGWGFyV0NTdVE1?=
 =?utf-8?B?bjRTd3l5OHk1YmRhU2NpVkZieFJDMDdGM1F3bk91QllnUEQyQjdhNEVKMkxj?=
 =?utf-8?B?TER4a3Jsa0hHOUZUMGs4TEZjK1RzQms4Z21OVHNrRjdNdnhCQ3JQd2t3OUtq?=
 =?utf-8?B?cThqenB5WWZWWXlqV0Q4S0hiMnNWOUhDU29LcHVhQndqL2g3bFprdUlIT0dr?=
 =?utf-8?B?NTVncDU1WEgzMk51NjhWTVFza2Jtdy85TnBvSHNFbzhkcE5Jazg1WUtscDhm?=
 =?utf-8?B?bGxSVlpSTlpUaEtQZENHT2FPalJOVzhoYWcvanVvaDF3aWk3aXZ6TUZhWjFP?=
 =?utf-8?B?dmJUQWJWWHh1OG56SmR1aGc1b0d5eFBFekZiM0RpNS9oYklReWEvK01IU2hn?=
 =?utf-8?B?RVVabE5rMDdYUU9NMml6Tnh1anltN1JUNzEyZDhRQUM2UWZUTnlPZ1hDWTQ3?=
 =?utf-8?B?QjhvSWdpZ2g3c1hWUkNWQjJzRU9RR0pBczhxVFZ5R1hiTDFlUm9HY2xRb3VW?=
 =?utf-8?B?V0NLUWZwOXJUdFMrZUJXYjEyUGx3ajUvV3Rwa1BSTElrdENXT2R2TVY1ZXhy?=
 =?utf-8?B?ckJyS2hEQmZLTDlsbkxyVzBrNUFZVFZEMnRtVVVueFJLRDJtb2dWSlcrS0t5?=
 =?utf-8?B?RGhpQU1qOTJRTG5jTEI1a0VWSmpZb2ltM1U4cU1LeUhqajdIMEVneHFoYUs5?=
 =?utf-8?B?YTF1Y0FMa01JSmtDMU56QlJQZC82RStaTXZQWGRCU0x4anpDYUZyL3ZaQkFI?=
 =?utf-8?B?SVowb0tPa3UvWDNBeDJ4aDhxZUZJaDMyVW5iWnBtcUx4K1NIbVYwM1YrdGlG?=
 =?utf-8?B?YzVqWDJIWEQ4V2FNR0g5amhOY0VLdEV3OFFlREVmRWRaUzhjSzhIaHFJVy9E?=
 =?utf-8?B?a0Z1UVNxUnNaQi8ycWgxZVB5Qk9HNHZVc0xYcm1uUTE1ZzVuWFp1MWJabXVQ?=
 =?utf-8?B?ZnJxbGR6R2FScWdyQ2Zkb2tsekF1L29ydFZGYzZwUXZTNUpiSXZOalpTekIy?=
 =?utf-8?B?WUNIb0VkSmRSWHBpemJHZmdDMmg2T1FmNWc0bE4vUndEK3ZSTlE1emJ3blF4?=
 =?utf-8?B?ZE1uOU1lTSswTm43MUl1L1lZdlFtMHQ2blJnL2lGWmM3WGU2Mk10V0g3L3Jn?=
 =?utf-8?B?UWtlWVkrWWtlN2lzcjNNNDE2WEVSZy9rTDRSVDhKMkEyWDZSTlhyNjFublBj?=
 =?utf-8?B?bkxveWRhVVRvNXpYc2tHdjdTUDhWT2NZSGJlKzB2RTd3Q1dQUGQvdHl0T2dB?=
 =?utf-8?B?dm1VaktPS0NrMHBxOWQ5dS9GU2JFa216RUNJZDlJQ01Ec0IyWWtJcnlQQmln?=
 =?utf-8?B?WkJBQjlsZmQ5SG4welBFbE1EWHgyYy80OUV4QnZ2Ym9pNXEvZmpKbzZMQ3Z4?=
 =?utf-8?B?SHNtTGw5WXRXOGZ4Y1hpcVlIWnY1REVvem0vK0QvZ2xhYnJQN2JaNGZ2K3VP?=
 =?utf-8?B?NVFtRndYOEQyT0swd3V2aWZRbElJakl4OFkreFdENHJ2aGRKNDZGNVpoNlFz?=
 =?utf-8?B?bkFSV1hmUHp0aStYTUhyUnd0SEVBcVFwY0c1Z293Q21ZWmlyNStkTlFYOWdt?=
 =?utf-8?B?WXJyWVNrTWFYWGt2QlZDanJ5bms2S2xVMXF2SmdQZDdHeU1EUmI2cW84ZS9m?=
 =?utf-8?B?SC82VGV0dGZzTTd0N1ZVbFU2RzZpQ0xBSWFyZ2tlTXRQb1dwRUZJNnk4bUsz?=
 =?utf-8?B?YlZTSkhGL0tMZ05HVEQ1NXdQWU1pZU5KSkMwazJJSHlTTlFYL2Zhell1dG9s?=
 =?utf-8?B?dzF4TnJNZTd6Q0JqWjczV1V2aFVzNlBBSlgzYlc1VFEzMDQ5d1ZpZnQ4NHVj?=
 =?utf-8?B?K004QUdwM1FnaVRXQWJFZW83SHZsbXB6VmEvZSsxbWRVeXJuYWNIY3RONzNr?=
 =?utf-8?Q?dD6g=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe61888-0e06-49ea-34eb-08dc96069f7f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 17:37:17.1219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qh17E1qA8qiCJySkTbqLH/d3P0UavfwnYLEOwj8Kk9ELVORzAsqpuxwt78dQMYVQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7234

--60af808087422ffa755830f462faf762a172cb8b41a5c81dff6a55022946
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Jun 26, 2024 at 12:49 PM EDT, David Hildenbrand wrote:
> On 21.06.24 22:48, Zi Yan wrote:
> > On 21 Jun 2024, at 16:18, David Hildenbrand wrote:
> >=20
> >> On 21.06.24 15:44, Zi Yan wrote:
> >>> On 20 Jun 2024, at 17:29, David Hildenbrand wrote:
> >>>
> >>>> Currently we always take a folio reference even if migration will no=
t
> >>>> even be tried or isolation failed, requiring us to grab+drop an addi=
tional
> >>>> reference.
> >>>>
> >>>> Further, we end up calling folio_likely_mapped_shared() while the fo=
lio
> >>>> might have already been unmapped, because after we dropped the PTL, =
that
> >>>> can easily happen. We want to stop touching mapcounts and friends fr=
om
> >>>> such context, and only call folio_likely_mapped_shared() while the f=
olio
> >>>> is still mapped: mapcount information is pretty much stale and unrel=
iable
> >>>> otherwise.
> >>>>
> >>>> So let's move checks into numamigrate_isolate_folio(), rename that
> >>>> function to migrate_misplaced_folio_prepare(), and call that functio=
n
> >>>> from callsites where we call migrate_misplaced_folio(), but still wi=
th
> >>>> the PTL held.
> >>>>
> >>>> We can now stop taking temporary folio references, and really only t=
ake
> >>>> a reference if folio isolation succeeded. Doing the
> >>>> folio_likely_mapped_shared() + golio isolation under PT lock is now =
similar
> >>>> to how we handle MADV_PAGEOUT.
> >>>>
> >>>> While at it, combine the folio_is_file_lru() checks.
> >>>>
> >>>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>>> ---
> >>>>    include/linux/migrate.h |  7 ++++
> >>>>    mm/huge_memory.c        |  8 ++--
> >>>>    mm/memory.c             |  9 +++--
> >>>>    mm/migrate.c            | 81 +++++++++++++++++++-----------------=
-----
> >>>>    4 files changed, 55 insertions(+), 50 deletions(-)
> >>>
> >>> LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>
> >>>
> >>> One nit below:
> >>>
> >>> <snip>
> >>>
> >>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>> index fc27dabcd8e3..4b2817bb2c7d 100644
> >>>> --- a/mm/huge_memory.c
> >>>> +++ b/mm/huge_memory.c
> >>>> @@ -1688,11 +1688,13 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_f=
ault *vmf)
> >>>>    	if (node_is_toptier(nid))
> >>>>    		last_cpupid =3D folio_last_cpupid(folio);
> >>>>    	target_nid =3D numa_migrate_prep(folio, vmf, haddr, nid, &flags)=
;
> >>>> -	if (target_nid =3D=3D NUMA_NO_NODE) {
> >>>> -		folio_put(folio);
> >>>> +	if (target_nid =3D=3D NUMA_NO_NODE)
> >>>> +		goto out_map;
> >>>> +	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
> >>>> +		flags |=3D TNF_MIGRATE_FAIL;
> >>>>    		goto out_map;
> >>>>    	}
> >>>> -
> >>>> +	/* The folio is isolated and isolation code holds a folio referenc=
e. */
> >>>>    	spin_unlock(vmf->ptl);
> >>>>    	writable =3D false;
> >>>>
> >>>> diff --git a/mm/memory.c b/mm/memory.c
> >>>> index 118660de5bcc..4fd1ecfced4d 100644
> >>>> --- a/mm/memory.c
> >>>> +++ b/mm/memory.c
> >>>
> >>> <snip>
> >>>
> >>>> @@ -5345,10 +5343,13 @@ static vm_fault_t do_numa_page(struct vm_fau=
lt *vmf)
> >>>>    	else
> >>>>    		last_cpupid =3D folio_last_cpupid(folio);
> >>>>    	target_nid =3D numa_migrate_prep(folio, vmf, vmf->address, nid, =
&flags);
> >>>> -	if (target_nid =3D=3D NUMA_NO_NODE) {
> >>>> -		folio_put(folio);
> >>>> +	if (target_nid =3D=3D NUMA_NO_NODE)
> >>>> +		goto out_map;
> >>>> +	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
> >>>> +		flags |=3D TNF_MIGRATE_FAIL;
> >>>>    		goto out_map;
> >>>>    	}
> >>>
> >>> These two locations are repeated code, maybe just merge the ifs into
> >>> numa_migrate_prep(). Feel free to ignore if you are not going to send
> >>> another version. :)
> >>
> >> I went back and forth a couple of times and
> >>
> >> a) Didn't want to move numa_migrate_prep() into
> >>     migrate_misplaced_folio_prepare(), because having that code in
> >>     mm/migrate.c felt a bit odd.
> >=20
> > I agree after checking the actual code, since the code is just
> > updating NUMA fault stats and checking where the folio should be.
> >=20
> >>
> >> b) Didn't want to move migrate_misplaced_folio_prepare() because I enj=
oy
> >>     seeing the migrate_misplaced_folio_prepare() and
> >>     migrate_misplaced_folio() calls in the same callercontext.
> >>
> >> I also considered renaming numa_migrate_prep(), but wasn't really able=
 to come up with a good name.
> >=20
> > How about numa_migrate_check()? Since it tells whether a folio should b=
e
> > migrated or not.
> >=20
> >>
> >> But maybe a) is not too bad?
> >>
> >> We'd have migrate_misplaced_folio_prepare() consume &flags and &target=
_nid, and perform the "flags |=3D TNF_MIGRATE_FAIL;" internally.
> >>
> >> What would be your take?
> >=20
> > I would either rename numa_migrate_prep() or just do nothing. I have to=
 admit
> > that the "prep" and "prepare" in both function names motivated me to pr=
opose
> > the merge, but now the actual code tells me they should be separate.
>
> Let's leave it like that for now. Renaming to numa_migrate_check() makes=
=20
> sense, and likely moving more numa handling stuff in there.
>
> Bit I yet have to figure out why some of the memory.c vs. huge_memory.c=
=20
> code differences exist, so we can unify them.
>
> For example, why did 33024536bafd9 introduce slightly different=20
> last_cpupid handling in do_huge_pmd_numa_page(), whereby it seems like=20
> some subtle difference in handling NUMA_BALANCING_MEMORY_TIERING? Maybe=
=20
> I am missing something obvious. :)

It seems to me that a sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TI=
ERING
check is missing in do_huge_pmd_numa_page(). So the

if (node_is_toptier(nid))

should be

if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
node_is_toptier(nid))

to be consistent with other checks. Add Ying to confirm.

I also think a function like

bool folio_has_cpupid(folio)
{
    return !(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
    || node_is_toptier(folio_nid(folio));
}

would be better than the existing checks.

--=20
Best Regards,
Yan, Zi


--60af808087422ffa755830f462faf762a172cb8b41a5c81dff6a55022946
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAABCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmZ8UcwPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUOLoP/AgBYKQPuTzYL0zlehVpM7PJuqIuk57ePJP+
j0cKlU1gIKXWyBhZ4q+gvirXoBa1syoLdmsOA4NWzZQrtys1HvbjmMEMyxjdsYPm
/Wt9NsBfa295mFzN4uDBWlA6oB21/IqBd7DYgI/OEMKzsV58MCLjQSq5cDJSl3bn
5x7for1sdXZEqLociwRK1400QyqT4FjUasvP3sGlEz6zLeK6zzVSpU/XdMrCByWK
N+LLUGIo9EVdUh/YnfrE6l8tGLjbeT8ofkCeHmkGuQvXd3IersriPxcXGVQ0bQjH
6HMP8cC9YgEMRCbEC7rE0grA/namhUR+Tt00e0y6l8Y1TKS+3Cjvp/K4C2wV3vkA
abYFivV1XWdbZiZWv9iIxeq0+A0vUBM4IbDLZ9AqfE87fLyFzf3g42D/KUHD3lSD
grM8BVHahiksdeuYQ6SQUIf9Ue1LkBp8p2pcnvzD3WDK7K6kY+6hNIuPDj9wFrmg
wz+V7lFAX1HnMbexBS6DJ2NQn17XvgMD6JeIBQQAw4ErfLn6QZIG98M9C8g6uANJ
W67jJnFYGoVKr15F8gqkpr0i9WUfCcm7Q6+CefsEQLqnEAI3OrFS83+zSRx+dIAo
NET09S8lnSQtiiWKC32Tc+oZASC0Svpd8Wga2FUEFo8GeX108HqcV6WYdbzaYR0/
A38HsUcs
=/XtE
-----END PGP SIGNATURE-----

--60af808087422ffa755830f462faf762a172cb8b41a5c81dff6a55022946--

