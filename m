Return-Path: <linux-kernel+bounces-388966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7681A9B66B4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950CF1C21160
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA7B1F4715;
	Wed, 30 Oct 2024 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="OS897nEa"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2120.outbound.protection.outlook.com [40.107.237.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C879513FEE
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300331; cv=fail; b=Lr6YAvYdwa4ioQt+INpC0U7KxVdfYEGQwdSj9pQovRVX93jLSf1iSMj+g/fabJIHIEERanWB0Lrwfas4VxcF4tEs58SfawjR1ClvepbR1hgsJ4V4didOsp3TV05fRWjmSpZy+HEywE0uL5/qbrYFDOiouhX3QPg5psOcnCBuv1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300331; c=relaxed/simple;
	bh=qFsAhPRznINHik6mcb0RiD0s9O7SjFQWSQej1lzhEmk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B4LBRkLUU5j1Bxu9IMxYokfwv9DWzyr442t7/9sTZMhHH1IYtDDPL6tqgD0A7TyzNfTfMWKvmFM/kPX6NYddqJGq8CFaiCOQs8PKOkUqlShJ4izKhenWCrTj5SGmOP6vD2m6fr17bxgLgAQT+N87W22xtF7CwJfUUG+KXWtJjig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=OS897nEa; arc=fail smtp.client-ip=40.107.237.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5UnRVB3kQ0qXhj4VDg4/egg5PAgtOVX7X563UuVFtliMCjatgbXnS1seJBsAzrO9UL3CNWoOghKNyZBr7eOnV4CiMueTGR31g+NZszsIuVWruK2FwVuSFDb9ZkLIjVe3b9/DZDWLr0xUkTTcj7xewYnhOKKjV+rBUXPgeP00pCl0Vaxg2Ouvj1M/r1pdvMkqCpk0q6ZPoyx55QyAwcclkEtJGd8FCw33p3kcv3Q7JYtthAB8sw+0HBgut+vjpONavpcspvxAtS+lSy+skJ24pfykP/vxDauYh+304qPUrwuMa/tmNhbH9gfYlZfkgwNDlh4Ur7zpmtz4fjwZqYCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kG+k+jCmAqvv11ISG43hu3ThN3+ZHTwRgUw8L+sO6U=;
 b=lTAYnme5ewOCyiyVo6LmZwmHQjlXVHbSZ+EpHv0LjnX77DR3lyIAfjbSVz2cQpU25inRLyhdth7ZGvqSnbubyRAfo9kN1WZOpbgeOaV8+cFLarPjw2pGOSlPbOi6exBc3BR0IHR8zK3aPZtcOMGHEA+TtKRmOoOrK8SQChulZFQ51ynZP57tYWzuVBwyPXQ18JBdoFpA/8whGvFZTorsrF1Ev4CMaDBFfGTi7gcftqzZ6+kd9FB5ZAW3ERCmuLMiToCzS6uVt1kE0DSEhOgzJiq4LiN+bJ/dE34pQ9wOyOKGBNzB45lA61hZBHZ+Bh0DUje94xUWJuBIG5aFb/GUew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kG+k+jCmAqvv11ISG43hu3ThN3+ZHTwRgUw8L+sO6U=;
 b=OS897nEabzUqDWdTQpKkW/+VY+lVvDOgNmD3ca9apJrduihjFuJZlz2sA7i5np76yXPR337Z9pjdDQSLXVC0jg9UEXODInDyD7XGukvvR7aXwW+3E1RV8E51ByHj9Vybwy4L3P7Gm118W/YxApWhG8FRbio6AeU5U3AmZYFjdhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CH0PR01MB6969.prod.exchangelabs.com (2603:10b6:610:106::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.20; Wed, 30 Oct 2024 14:58:38 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 14:58:37 +0000
Message-ID: <a2c1e121-91ea-4868-bb01-ac6ee43257c2@os.amperecomputing.com>
Date: Wed, 30 Oct 2024 07:58:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix 6.12 v4 4/5] mm: refactor arch_calc_vm_flag_bits()
 and arm64 MTE handling
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn <jannh@google.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Peter Xu
 <peterx@redhat.com>, Will Deacon <will@kernel.org>,
 Mark Brown <broonie@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>
References: <cover.1730224667.git.lorenzo.stoakes@oracle.com>
 <ec251b20ba1964fb64cf1607d2ad80c47f3873df.1730224667.git.lorenzo.stoakes@oracle.com>
 <f5495714-19ba-40b8-a3ac-fe395c075a36@suse.cz> <ZyIRbbA-_8duD2hH@arm.com>
 <c8760d0e-acbd-4fd6-b077-58b5c374cad3@suse.cz>
 <3f184fad-e0da-470a-888e-70a17419e206@lucifer.local>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <3f184fad-e0da-470a-888e-70a17419e206@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::34) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CH0PR01MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: c2eedf54-711f-4d35-d7ff-08dcf8f3557f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDNrRFRBT1RlcFVFMWFMbDJOMGsrbkVLdU5zQzBGQ21tRnB3SjJCSW1nQm80?=
 =?utf-8?B?ajF1cm00NGZwbnJjbC8yd0FwR2dRVndYeFR6YTgwSUh4TXFOMCtNK0gvVW9a?=
 =?utf-8?B?WEEyQS92T2NnU1Z3WThvUjl5T2k0VTY0dzA3N0FDcXdCeWs0ZHFMcFlZNzhp?=
 =?utf-8?B?c1RQU1ZxR1Q0Q0NYNklUYmRCUjRaRWdiajBjMy9hMDBZZklyeDhBZWhpVVZ3?=
 =?utf-8?B?eW1xdUFtWW1XUTFxMzc4RmRKcDZ4KzVYa1RhSll0MGpHSm9YR1Zhcmp1NkND?=
 =?utf-8?B?L3FMVFlJV1ozWFJZMlFBazJiRVVYdGdnOFdHbVA1SCtKMjMvaGh6VnRoajM3?=
 =?utf-8?B?SDBJdXFxN3RCZS9WaSs1Q3U2SVNaS2RSRTE2VDNpL0dOUldNUzJOTkk3K3k0?=
 =?utf-8?B?QlEwOEVlRFFkYmh1aDlpZkQ1VFN2UGlWWVRFcEZxSXFKdGt6YmxPRXVCUlFC?=
 =?utf-8?B?ZnZWSUZiWnpCK3QwS3BudUM5VHo4QWRTYnYrV3lLc2lFblRHajBKV3RhMFk3?=
 =?utf-8?B?U3BjRC90cDVQM25CTjNRLzRLbmx0VTk2U0dhUUgwRDNjSDJTbnozQnQzN0xl?=
 =?utf-8?B?b3V5UlI3b1JoaG9tK3k4TFhpcTN1cys0QjNyRHE4elFzUzErSmZvZlJjUERm?=
 =?utf-8?B?WXIrUTNQT3ZiWSszbHkxbm14azh0MDFGUGs0SndoWFQvM045aUpPb1FKWDNU?=
 =?utf-8?B?Wk1VZ2dxa3kzTHBnMlBlR096Z2lTK3NNWlF2WmpmY3Q1M3B0d1ozT0pJVTNl?=
 =?utf-8?B?M2RaUmFWMDR2Qy9YS3kySklkR3lhSklKUFRiTDZNUUIwTFRZYTREWWcxd2dM?=
 =?utf-8?B?b2h4NEQ2NU1ZeUVvS3FFNU1BcDNxcEJJWmNXQmFrOGVEYVFuSjRKNlhtK3JT?=
 =?utf-8?B?TGEwWFlWaHV5Y3R1RzZxSWtiMHpFVi9Lbml4SWNIamtjcW93bjQ1d2NJL3py?=
 =?utf-8?B?OFZEdDlZL0FRRXJPVFduT294dEtYb2NPUTVRVGh1RTdvcU1XZHFadFI1SnVV?=
 =?utf-8?B?cEhWeEFLNnZFVkh1aU9wWWl6cEVEQmt3MlcyeUhwdkFCY3FUNDhRQno3S1BU?=
 =?utf-8?B?TFdYYTVpY1FEMHhhbUdPRG9BRXBtZEhuWUtZRVlrM3Z4Mk5BZUtXc2FKL24x?=
 =?utf-8?B?UnFrZkpnU3krRnJpbFdzQm9HZFdsVS80S3ExQW04Y1MwZDlxeVFyZVUzT004?=
 =?utf-8?B?bkQyQURlWFp0Zjl3R3Vhd2lYYlpuQW54dWRzUWl2dlhwTEd3cXhFY1pkNWd3?=
 =?utf-8?B?NDB6cms0NDZWS0ZYZmsxQzRibHNGcCt5ZnBXWS9jVmlvUXpsK3dOVVg1R0dm?=
 =?utf-8?B?ZlRmcmVndjNTV3RCc2VVSU9BUlpBQVZ3K0RmdVAxR1hkZzV3QzcrQjR5c3E0?=
 =?utf-8?B?OFpKVGtWMEV3eGtUSFNrM1ExaVhTSXFERVJGVXBvM24vV1hDWk1nd1paNUpz?=
 =?utf-8?B?SVFCQnBOSTRqWkFLZDVrY2I4T3RRV3lyMjVxR3pHQ05DcGdSNEFlaXk4cUcz?=
 =?utf-8?B?eEdVUVI1RkFjcEg3TlBSUHMrNDEvWTFWNzZFZDQ0cnJIbHNxeHBJYkNzcmRa?=
 =?utf-8?B?RmdaUzhYd2ZDYUNYZXI2dEYxQWZnbnpVbkhCOHRTck5zM2VsU3lnNFJMU1hJ?=
 =?utf-8?B?RzBlaTlqbmE1bjk1TDZyTU4vOTdNR2NYeDRCM05VcUlmNE9rNGxwbjVDajZt?=
 =?utf-8?B?OEJyWDZyNTFPNGJGeUJ3QXFZTTNYQ2x0UEhhYmZKWXpaWmI0dTVoMGhrRlVo?=
 =?utf-8?Q?yJraxaKXRvLKh67iZpL1SQFLa7qYZ5FtK3i7W8e?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1A2TUdJZHJ3bHQ4K2ovUEFyNXR4YUsxZVNzYnQwK1VwbGFlUHRiWElFaTlt?=
 =?utf-8?B?cEFrYWhpbndOd0ZsMzkwa1pSVEN0YlV6Lzhjeml4dWNVaHVWVEgvN0Q2bDdZ?=
 =?utf-8?B?WnRZRC9LdU9PMnFnUUdLcFcxN1kzdE5vWDc1ZUhybHpTUjRabnFGSDRKbU5U?=
 =?utf-8?B?N29IL0dKWVVWR3VvcWFYVjN2Y3I3MmRkQjl0YlZlVnJqYmtQc2kvUnZVazZE?=
 =?utf-8?B?d3RHL3BTR05wcS80Q2JqNFdyR1FibUt0TkR2b3FRb0gzQmJ5ZE5GZjJJRGVZ?=
 =?utf-8?B?N2p2aGI5S0ZtODdMR3YzcTJhSE1FN0svbVFkL0gxUDk0V3podFpyQkx5eVcy?=
 =?utf-8?B?dnlZTXNvdENBVGI4dlVZd1NuRXg3SVlKQ0t3YTdiL1E5VWwwNjVHZHFRMTFq?=
 =?utf-8?B?QUxJRVV5L1BaejlYTm5TNU5NSXBxWmhhbXhIQkFVZlpUOUpLMjZWcEtIU0RC?=
 =?utf-8?B?Rmg5cGlpVHVjNk5PSmxOVU93QlFzUUVOdFRoOEhmd2ZhYnV1Y3JxYkVKZitJ?=
 =?utf-8?B?ZDRyZzJBZitxeWpKY1hPMlc4TXlnRXJHQTRoQzBZVVZ4SmtHZE9JZXp2VjRB?=
 =?utf-8?B?VFRJMTY4SWQrbk1Fc1V0bmVUbDBxTVpnSmVaeUw0cmJPV2d5ZXVQU0R1em9w?=
 =?utf-8?B?ZXBLUXI3Rlg5WWVzZjhza3lmazN0dkRxVi9hY0tkUzdBME5Valg0WWV3R0Q5?=
 =?utf-8?B?bFBoYUtpdUpYcTRMenFhd0pLa2lOdytUOUNrcDkvdkxkK2EyVFFmOUhzZERl?=
 =?utf-8?B?NnpPdWlDN3RVcFlEUXlpa1UvTGMwR054ekt0TjV6OU82Ui8rNnRoYlFxYnFM?=
 =?utf-8?B?cHVXR0xsSkdMemFMN0dhdUFST1ZNUDJmOWtvQk4wNWw4WDhoNTcxaWo5V0xI?=
 =?utf-8?B?UFNrTWVlWUZEMmtSTllrUmFiYXJZMWdjV1RyS1l3eE11N0RVM0thTk81UVcr?=
 =?utf-8?B?b0p4ekE3blp1ZVg0RkZLMkZYZGpqM3NWQVlvSW9FbWRGYnN6RmltT25NN3k0?=
 =?utf-8?B?MnZpbWNoQllHcUJCUTlXcFo2UFlCRXdYNmhVcmdtamRnYk55VDFaakNCR0c4?=
 =?utf-8?B?TzQxS1hXZEtPYXMva2I1bzBBUERnQzhmS0RSQzhPRjRaQ3JHZ0dJaGxwbm41?=
 =?utf-8?B?RVdPRjB3QlJURFZmVHdNb0t2cE5Tc2wxTVg0QVBlamZRUHdBajNKWUkvWUFm?=
 =?utf-8?B?dTIwWnJpWjhrRXFseGY2bm9ZaXlEQndnZERiZmZWYjdVV29ackhmbmkzNFhE?=
 =?utf-8?B?dS9Yb1ZkcDA1RFF2MEE2STBVRFRIajlXbFNpdW53Y2JvOGtDMzRnQzkzL1Yx?=
 =?utf-8?B?akZtbWRENngxSWxUL0xMMTVZa1o0aWU4dG5LOXpCMThFenlSWE5JVytrbVNl?=
 =?utf-8?B?aCtDSHRuMmZ1aTdWWTcvL3Jjc1Jmb3J0Qlk2ZVlUYWJLaHRoYkY4Q0ZZUHNU?=
 =?utf-8?B?WWZvMXYzVVdmMG5kNzJUWS9WOVR5QURXZUJEMk9PTW0vQXhEMHhOeXlKR0ZF?=
 =?utf-8?B?eURlQXkyZDRlUW5VUHY5VFZ4MEpjcW1HaE5LRTdkMWEwcHVOTjVtRW9ZN0xz?=
 =?utf-8?B?NFZDSC9ZWlRqTDNWWWRDRmhQUVIraElzdGNYMFlLMnN3S3NNNW9XTURXZ1dz?=
 =?utf-8?B?TG5SMDZHV2JJb3FRUlpEWWJTazlwOVFyV3Ivbi9ZVGtzUUJ0VmZvQkcrZE95?=
 =?utf-8?B?TW1iUGkxK0ZmSkR6SkI1NFpHOFhlWXQ4ODhzeVNTRVI0ZjdjWU1CanlkWFpl?=
 =?utf-8?B?dWtRNkJiVnJzUE1xbmQxTWpFZXV6UWF2ck1va1FZQis2cEFSd3JZYWtpclF6?=
 =?utf-8?B?TlJyb0tyWkdMeWQ2ckVmUFFYNkxzN0FjcG1YbkdMWFh1Q1Y4MVk4UUhxeTBI?=
 =?utf-8?B?TGdEQmdFMHB2aGNxam1WWVV1SVIxbW5jNW0yeGI3NlpWZFdTZm5SQ2lsT25z?=
 =?utf-8?B?V0EzSE80K2U0WTN3RUFYaFlNdnBoVGJtK2ZJN1FkZWhHM09lTlJHeTY3NDk2?=
 =?utf-8?B?UHhLUVFqVHBEejZFRHc3WWVpaFIrc1lQS3UwY0lQRFBwLzFyMFNDOW1QOW1C?=
 =?utf-8?B?Y2s0cDJVZ0hQbWxOODBCajRGOExjKzN2TFRjRWpmenJvKzJHcTMxMW5VNFI4?=
 =?utf-8?B?bU5JY2hOOUFzNFVSYjBFZnc3anhIVHVLYWhRbTZBUmIvelVwSXB3Q0hmOUF0?=
 =?utf-8?Q?wh+d62YPdxC0wOL+w7YjvC4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2eedf54-711f-4d35-d7ff-08dcf8f3557f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 14:58:37.7486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ENTkDJskqn8HDHAn/KYT7ke9hKdeK69JYqHv8jKj1r+posso+mw1Q9hcACg5DLV0lvSgyK6AIlj9Ye2IuErdxqvGj2Mx9HbPj4X8wxAjY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6969



On 10/30/24 4:53 AM, Lorenzo Stoakes wrote:
> On Wed, Oct 30, 2024 at 12:09:43PM +0100, Vlastimil Babka wrote:
>> On 10/30/24 11:58, Catalin Marinas wrote:
>>> On Wed, Oct 30, 2024 at 10:18:27AM +0100, Vlastimil Babka wrote:
>>>> On 10/29/24 19:11, Lorenzo Stoakes wrote:
>>>>> --- a/arch/arm64/include/asm/mman.h
>>>>> +++ b/arch/arm64/include/asm/mman.h
>>>>> @@ -6,6 +6,8 @@
>>>>>
>>>>>   #ifndef BUILD_VDSO
>>>>>   #include <linux/compiler.h>
>>>>> +#include <linux/fs.h>
>>>>> +#include <linux/shmem_fs.h>
>>>>>   #include <linux/types.h>
>>>>>
>>>>>   static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
>>>>> @@ -31,19 +33,21 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
>>>>>   }
>>>>>   #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
>>>>>
>>>>> -static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
>>>>> +static inline unsigned long arch_calc_vm_flag_bits(struct file *file,
>>>>> +						   unsigned long flags)
>>>>>   {
>>>>>   	/*
>>>>>   	 * Only allow MTE on anonymous mappings as these are guaranteed to be
>>>>>   	 * backed by tags-capable memory. The vm_flags may be overridden by a
>>>>>   	 * filesystem supporting MTE (RAM-based).
>>>> We should also eventually remove the last sentence or even replace it with
>>>> its negation, or somebody might try reintroducing the pattern that won't
>>>> work anymore (wasn't there such a hugetlbfs thing in -next?).
>>> I agree, we should update this comment as well though as a fix this
>>> patch is fine for now.
>>>
>>> There is indeed a hugetlbfs change in -next adding VM_MTE_ALLOWED. It
>>> should still work after the above change but we'd need to move it over
>> I guess it will work after the above change, but not after 5/5?
>>
>>> here (and fix the comment at the same time). We'll probably do it around
>>> -rc1 or maybe earlier once this fix hits mainline.
>> I assume this will hopefully go to rc7.
> To be clear - this is a CRITICAL fix that MUST land for 6.12. I'd be inclined to
> try to get it to an earlier rc-.
>
>>> I don't think we have
>>> an equivalent of shmem_file() for hugetlbfs, we'll need to figure
>>> something out.
>> I've found is_file_hugepages(), could work? And while adding the hugetlbfs
>> change here, the comment could be adjusted too, right?
> Right but the MAP_HUGETLB should work to? Can we save such changes that
> alter any kind of existing behaviour to later series?

We should need both because mmap hugetlbfs file may not use MAP_HUGETLB.

>
> As this is going to be backported (by me...!) and I don't want to risk
> inadvertant changes.
>
>>>>>   	 */
>>>>> -	if (system_supports_mte() && (flags & MAP_ANONYMOUS))
>>>>> +	if (system_supports_mte() &&
>>>>> +	    ((flags & MAP_ANONYMOUS) || shmem_file(file)))
>>>>>   		return VM_MTE_ALLOWED;
>>>>>
>>>>>   	return 0;
>>>>>   }
>>> This will conflict with the arm64 for-next/core tree as it's adding
>>> a MAP_HUGETLB check. Trivial resolution though, Stephen will handle it.
> Thanks!
>


