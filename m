Return-Path: <linux-kernel+bounces-560129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97245A5FE47
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1BA18927F8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B891DB125;
	Thu, 13 Mar 2025 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="m2IZ91E1"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2121.outbound.protection.outlook.com [40.107.223.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1014E1714B7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887608; cv=fail; b=tD7OxZa0Ug6M1zKXlodvDMkiWeM9hIC6biUUkjpTBTGVMHZdy83UqcqIHO3QfF844PJE2DvnYt6iXJYAQTe+o3nxQU11WYc9tGw2D982Gx7lUJ8zsMxqcE4NCvtA0un6CGRm9rMCsAA5wSqNJitCylBa4dCwlLbo/CE/9+LA2Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887608; c=relaxed/simple;
	bh=BSOFf+KpN4KLfQwqR4EzLLxr1dIc/WljyPAUfLiu6OM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d+5SKQ6IBfwGrYYQXvVdV7m303UEj2/oCwpoxAQhlTOpyQhN4mpeMSiIbRCv+0WwQPhobhdn4i98HHImDOnWiluRCST/65o3jJzvI4bmX2rKbW6F2/SMB6b3gKnNXzWdKuF6q3Uw9fCRHE5KaWWnVuBbk5TrjRqFSBsizxJRS7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=m2IZ91E1; arc=fail smtp.client-ip=40.107.223.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/MpFDWbHdFbegdU/I4PjdJ7lBmcycVVzj5oBBMME8M6fDACmi5Qm7Fq47jXCc/NuCLnDhDKOjr63acY1HDh9UByI8Q+v8VK6d8AlKFMK29ZEE7Ssk6Yl6iTnQ9AoVvoFtMRFOwkHYpbm4L2vOubZ0KhY4cd/XeitF7CecgZfeBu4Y/JU7cbh2wfqW3JL3eTPueaJhtPZ7j5ZxpKH/OC6rShT3wnB8vOvvVSeliwVY66cbcW7u/ETUDeBACJ8RJ5IUhvuyhd/Nc7EBUaaROpveUDbqJWx61kuFH70SRi1BrPEsB+eDenwgcY7wJjmI8BihqDI+NwwIHQv13TbyaK9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOH1QR7hmSXdBEl61xNct5k1RCTrldiP1K/mgZiEPDI=;
 b=q4d2jqa+LTzQtGxyMnoid91zOwktEMBXUdFEHQaFnnxwh9x/zx7457M0yQj/rPD7TepB9z+rko6cJMnZFLcW3NGPE91nTNKYp4rPIj88CiG+T8z3bkkS4XMXhdYhoLzw5lu/Hp/eMjgO09VPC/gSRTt3Fj+HikI9wtmep3AXqmcSYEKMai0cell7Ci+VKf+w8rgimUDSSqu5XBRleFPMmMI2W3O9OYiqHHXtYWL+m+hDTV+E6aCNsg+CJA8DcEnX4lVQannwh7ZPKhBe0uUKJTIF9pFpF1AfqXRXWiqRjaqvIWVcIlUpqsndUesRydOLVFAKumxsUqDMcE2ugeE16g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOH1QR7hmSXdBEl61xNct5k1RCTrldiP1K/mgZiEPDI=;
 b=m2IZ91E1QOmlOcfGKlkUKEF6/BssAZY4TZoXrQjjaMxKpMEEZjyIqXb1BtEpFCCqTedamwQ9Pi8dfVCBwtXBV0O29afcE/x73nQjWZCe7JkCBmBRnRG1kLAfKBsEcPVGPsdh/+tEbRh8UUXO+FwzUAP6hLGhq2Yf34jlcykQY3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CY1PR01MB9266.prod.exchangelabs.com (2603:10b6:930:105::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.28; Thu, 13 Mar 2025 17:40:04 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 17:40:04 +0000
Message-ID: <22b53cff-00db-48f1-b1e8-b11a54ebb147@os.amperecomputing.com>
Date: Thu, 13 Mar 2025 10:40:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 PATCH 0/6] arm64: support FEAT_BBM level 2 and large block
 mapping when rodata=full
To: Ryan Roberts <ryan.roberts@arm.com>, will@kernel.org,
 catalin.marinas@arm.com, Miko.Lenczewski@arm.com,
 scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250304222018.615808-1-yang@os.amperecomputing.com>
 <3750d3f8-17c6-4bb8-8107-215d442e4ec3@os.amperecomputing.com>
 <2fb974bb-1470-4a5f-90d5-97456140c98f@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <2fb974bb-1470-4a5f-90d5-97456140c98f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR15CA0205.namprd15.prod.outlook.com
 (2603:10b6:930:82::23) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CY1PR01MB9266:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f0979e-0d72-40e3-d545-08dd6256166d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2VuUHFxdllyRlB1RkhhQUJWQk1rbG5yOGFmS2RPaFpiRDNUUXZXbkRTTVpL?=
 =?utf-8?B?eC9kV05iQ0RYYWVwYmsrWmFPUkU2VVRwVTdObXQrOGJCN25XZVcyckNNbkR6?=
 =?utf-8?B?a2lqOWFnWmR3RzB1eGdMeFZaK2hjRDdKcFcxalY4OWRINkNBakpTTEZaRm1z?=
 =?utf-8?B?TW1zL0d6N1dwWDE0SldZaEFlZ1BGbjlZVjNYSXhYeWNwRkVyWk9KaU9jcndW?=
 =?utf-8?B?WjBPa2hTdGF3K0t2bGo4NUNYamQvK3dRbW4xNVBCbXFxd2o0T2JyWFVNSHRW?=
 =?utf-8?B?Y0hiNEcvV2ZMeFM3SFVFV3BpWGx6azFzVVdqditHN3lJREtBQ3BaSlEydGxw?=
 =?utf-8?B?Z0lhbmI0bUhaOFFMRElEL2J1c3M0M240cGNYUGVYUGszZ1VnQ09CY1hWeENZ?=
 =?utf-8?B?RFVUT1gxYWtNS1BoVGRrRmh0bDRHdzJDR1AyeDUreXBHaEZwaU55c0FESHli?=
 =?utf-8?B?Q3JlMURnM2djMUdERGVibmw5czFOKzUvVS9IT3IxQnpUSDV0MDFyRmp0VjNj?=
 =?utf-8?B?TExJTEN6NmZkRWU5ZG00ZFVsWDFCOXZYcXpqektmSXpGUjhkSjVoVXYydjNE?=
 =?utf-8?B?TjBoTm5XTmI4QlIxb25zaU0zTm5oQ21XeW5hUFBhSW5FemI5VjNMak1Gdksx?=
 =?utf-8?B?MXBGT2xsZTkxKyt0cUxSOG40cHVVam9PM25lazJtTWZST3hOT0hqK3RGR0Va?=
 =?utf-8?B?cEF2SkhDYlZqdmNyVWx5d3ZxWFM2NUxXTGhiRGpGV0VlN2FmcHdJc1ZVd0pp?=
 =?utf-8?B?NEcwMVdqWkhBcGdMMVFWeU8vaW5CZ3I5VkFYVy9tMU94YTdscnlKUFM0bS9v?=
 =?utf-8?B?T3RieEZSSlNwZDFTNWNRdWxEN2gvbSs4bnFoQ21TL2NYVEphUURkY21GN3pX?=
 =?utf-8?B?UlpXL256ZzhPTXNJYjdCMzB1VUh3eG5NeU4zUy85eUtsZXQ3akp4bUEwNmJC?=
 =?utf-8?B?Y2VXbDdxaGNzYnlQbS9Ramd6L3ZTQ0NlRnYrSmYyMzlmdCtzS3FYRWIwOHZG?=
 =?utf-8?B?dkVzVTk3eGRPY3V0RzAxUDc1SUNqNVJKU0hLQWVUUzRRbjN6SVZnQmt5aFcx?=
 =?utf-8?B?OENwU2xEbnY0UjRvbWxTWDRqb0tmUy85a1JTcFNpOEt5MVB6Z0VnclFHR1py?=
 =?utf-8?B?WDRnTEJxSCtuWWFWVWZXMHlPa2E1MXdWbkFDbU1naXRNTjlkaHA4TSs3ZlZv?=
 =?utf-8?B?NlhqeE1zTEVBck03dFVIbTBGVlE0NE4wNngxWitkeXY5UFpPVTVuMmY2d2hy?=
 =?utf-8?B?SW8zNk9aaXhVcE1RMnBGdG9tUkx2UkNzODEwSGExcmhOSjNGZnJsRlBTZUNQ?=
 =?utf-8?B?U1J1VXoyNWxMeVM0MGZZUW51ektvcGlUelJrZ0hOSHNpU1c5eFBueVU5YUk5?=
 =?utf-8?B?YzZYRFlpVmpIUSthSWNpSGlrTzRzWkFhcnZxY3hSNTl4cG15Q1VwOGhPOTM3?=
 =?utf-8?B?eGZjVUFkN2MzVjd5c0d2M1NhN0dYaTVLZnRoMGVDZk9NalA3TWZKUURQR0JD?=
 =?utf-8?B?UXVwSURxRDQ5Ymp0NmQrZEFjb1lDM21uQkdvMTR6V0I0cTA3ZkVzUEN4d01W?=
 =?utf-8?B?MFNyeVA1cW15Y1JMNmxiaDRiVmRMVWJqOWM0K01PdktNZHV1S055MnVMOXU4?=
 =?utf-8?B?V3RTUkdyaUp5Z0NnM0hrQ0ViYnFlN3hkVXNCeTZPc1g5WFl3b0M3Q3JvOHlj?=
 =?utf-8?B?Z1JPNWFzNUNaSmwzU0tyS0R6NytlcSs4Z0JJbHZCdVhPM3hNTUkrZTdNL2Y5?=
 =?utf-8?B?ZEc1WklmMldNd3RxWWJmd0dWSVFpYkNZYmVIV2p5bThyeEtJcGptYXowRXB4?=
 =?utf-8?B?N2EzNVNKNSt4SGJVaFhrMXFQUS9uT2tvTzkzKzRHb2Jlbm0vNExYTnRwMG94?=
 =?utf-8?Q?CmrHHhBS8XQtd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHQvd0hySllWT1dlaXg3VmhLOUlMWkhtSkpkd29UbzU0N1hNS0tnQlR4ZEtU?=
 =?utf-8?B?WlZiN3RqWHhIZ2lVMU5RN1RUVWtjaDN6YWFnVDN1cG13WFlibTk2N1NBTFhx?=
 =?utf-8?B?TWNFYnkvYzYremNvbmIrZmN5Yjc4b3ozcit3WVp2YXhlUW14TE5FK3UwUm5i?=
 =?utf-8?B?WElPTlhMbkNSalg5anRNODB4eEdHaFJSS1JkTDU3ci9WVmlzV1lsQlRsU1NM?=
 =?utf-8?B?V2NncDlhVWFIcEdDODlvSGRESE1XS2Q4YmFpakJoSDAwWjZJMkRKQmtuVmRi?=
 =?utf-8?B?blQvWUZWYzBuZThYV1RoZWlDZks4cUhJUlJSaXRESVY5VjM1UWtLT2VYV042?=
 =?utf-8?B?dGNyVzFkRnpwcVZOenVHcURHZWFpQUNyOWdyeVFVa2VlU1NQUUl3eWN0MERZ?=
 =?utf-8?B?WWxxcDNuQVgzUHJrTVB5ak1uazcvcURWR1F2Z0VRYlVvNnBqVThhY2VpTVJV?=
 =?utf-8?B?cEhiQVZ1LzJYL2dFQTFtOUE2Sko1MDNtKzFwcHlFZGxhb3k4bXc1WFVsSjg5?=
 =?utf-8?B?d1hlZmkyQ3NUSXpDS3l3WU1TS3dzNWoxOVBMWkQ1L3ZRaU5DYnkvN2N0R1l3?=
 =?utf-8?B?OS94Y0I2aW5IUmduSytwbU5mbHRvVDRYV1FSTWFQS3JabTJ4RjFWYkpLLzFz?=
 =?utf-8?B?QnVSZ2MzYkhLdndBbkVRMTBnWHlOZHdjcmRBc0lFWVhzRE5QUVJMNk8vYmZ0?=
 =?utf-8?B?bDFZRDI0dHB2U2E2bml5KzhJWndUTS9KbjJIa3BuWE5TT1pjUWhoYmhlWWlJ?=
 =?utf-8?B?M3Eyd3Jxc1BramdaZzlTNVpiS3lHcXQzYTBsRStQdTBFTzRRdVQ4RFlZaUo0?=
 =?utf-8?B?MW5Wb0QzZ3lXM0t5TXJVMElCOGRwLytTWXJESE1iU1hnZHd5ODlhWk1rS0J4?=
 =?utf-8?B?VithOVhEWTFUMHU3d0h3RCsra0o2Y3hiQmtqZVlTWXRVVDVrR3krdEJ1MFo4?=
 =?utf-8?B?TnFpc0JzWW5rVllZV0ZrZjNpdkl4dzhpaGI3YkFzQWZaZkNsTE9kemE2UW9p?=
 =?utf-8?B?eUFGeWlYSXl0N3MrR3V4SzQ1VTNWOVlEbXAwaHFSYlBjUGpXcTdCZFkwaG9R?=
 =?utf-8?B?dnprZmJkaktzYUh2MHFpMkV0TFlrVmlnK3V5dm1uM05FdFpCeGJBTloySWN0?=
 =?utf-8?B?K1ovbHdaSFdmZG9KYTFDemxUd3JwOFVuZ3JmcDNzbEJzRlcyMjdOR0xmRU5q?=
 =?utf-8?B?MEU2UXExM3AzWVFxRFp4UEw5QTJDV0U1WTJmdWdaS3hUczNackExWXVCRVIz?=
 =?utf-8?B?a3BoVTJnYk5ZRmFjT3dnTnpNRDZiZkVZb1hmc2d4Zk8yWGEzYTJxbklEbDM1?=
 =?utf-8?B?bHBmMDhacXl6NGRpcEVPa0RYeGhjeTRPSXhteTJ1L3JnUFN1RkhHcmV6SFF2?=
 =?utf-8?B?SzVsVTNNUFBOWVFuWHBkdWpFYXlZMHhkYVM4RnByY0pVdG9QaUlZRTMyWXYx?=
 =?utf-8?B?QUNQSlM4UW1HN0hzQnhGaTl0VXlkalVNSmZHNG9jcGNDYldpUmxkU0V6Kzg0?=
 =?utf-8?B?MS9yekVKSU1Za1RPMXhlTG0zSTJJbmN0ZkRzMXBzNEc3dFZWQi9hM2x1eUhC?=
 =?utf-8?B?ZGJvWWkxa1FEaUVpcUI0SGtHRnZHYit2MUcvWXNGM0JhTjgxc28xNWZKYzNQ?=
 =?utf-8?B?dWNrRnlBTjRGZzIyallxS09HdjA4bFhEc0Qrb0VKaXZQSDY5U1orMDc5dUJl?=
 =?utf-8?B?cGtvTytSQ2E2RUQ3WDErOEYxVGk1WWwzdU9paFAvaWs1OEtGaVd6Tkd4RjVq?=
 =?utf-8?B?aXQrYlRaZXdWSUdYbURqZzVqT1ZncFZmdkwrVkZ2MzhFK1VzL1F4bVRHL3Zo?=
 =?utf-8?B?VWlPSVhGWDV0NmlqN2dqWU1OMDJRZC9UMDJmZHVmdDJwYjZnSDNRT1c4MzBY?=
 =?utf-8?B?QUM4UFR3UThWU0FKa1paUi9jWStMM3krbmxCbVBkOStnQ1ZSSFdVelJSK0pQ?=
 =?utf-8?B?U0t3aHJ2WUcvMXFSZk5kZGlxaUYrMkFmWDVhTnJIMS85OUFPVzJqaFlmVzlQ?=
 =?utf-8?B?aXdmS1ZpbHgyK04vb0ptM1d2U0tuVUJ0RTJIT09IN2JEZ29SYkZZN3ZGWDMw?=
 =?utf-8?B?dHpFNXVXbDQ4NmZNZ3R1aGRKRTdZTE8yYnAvQWl3MGNXS3IwY2xhYzFqaXN2?=
 =?utf-8?B?dzN6OXdJMWFQL3djR1NtblZSZCthdTFCNnJ1WU1oNW1ZbTMwbVE5aVdrMDJM?=
 =?utf-8?Q?dxcS/QM9o2nXCjxelm9cJPI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f0979e-0d72-40e3-d545-08dd6256166d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 17:40:04.0579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: woJ9XMeFaalQYziWtIYm3igopb/uSaK9qREPe88owrBY9RrGj8uGmBc/K8zZX2RfjIbv4JrIy9dtfbpwCydunW1XqlATS+dZ+9WybbBjugo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR01MB9266



On 3/13/25 10:36 AM, Ryan Roberts wrote:
> On 13/03/2025 17:28, Yang Shi wrote:
>> Hi Ryan,
>>
>> I saw Miko posted a new spin of his patches. There are some slight changes that
>> have impact to my patches (basically check the new boot parameter). Do you
>> prefer I rebase my patches on top of his new spin right now then restart review
>> from the new spin or review the current patches then solve the new review
>> comments and rebase to Miko's new spin together?
> Hi Yang,
>
> Sorry I haven't got to reviewing this version yet, it's in my queue!
>
> I'm happy to review against v3 as it is. I'm familiar with Miko's series and am
> not too bothered about the integration with that; I think it's pretty straight
> forward. I'm more interested in how you are handling the splitting, which I
> think is the bulk of the effort.

Yeah, sure, thank you.

>
> I'm hoping to get to this next week before heading out to LSF/MM the following
> week (might I see you there?)

Unfortunately I can't make it this year. Have a fun!

Thanks,
Yang

>
> Thanks,
> Ryan
>
>
>> Thanks,
>> Yang
>>
>>
>> On 3/4/25 2:19 PM, Yang Shi wrote:
>>> Changelog
>>> =========
>>> v3:
>>>     * Rebased to v6.14-rc4.
>>>     * Based on Miko's BBML2 cpufeature patch (https://lore.kernel.org/linux-
>>> arm-kernel/20250228182403.6269-3-miko.lenczewski@arm.com/).
>>>       Also included in this series in order to have the complete patchset.
>>>     * Enhanced __create_pgd_mapping() to handle split as well per Ryan.
>>>     * Supported CONT mappings per Ryan.
>>>     * Supported asymmetric system by splitting kernel linear mapping if such
>>>       system is detected per Ryan. I don't have such system to test, so the
>>>       testing is done by hacking kernel to call linear mapping repainting
>>>       unconditionally. The linear mapping doesn't have any block and cont
>>>       mappings after booting.
>>>
>>> RFC v2:
>>>     * Used allowlist to advertise BBM lv2 on the CPUs which can handle TLB
>>>       conflict gracefully per Will Deacon
>>>     * Rebased onto v6.13-rc5
>>>     * https://lore.kernel.org/linux-arm-kernel/20250103011822.1257189-1-
>>> yang@os.amperecomputing.com/
>>>
>>> RFC v1: https://lore.kernel.org/lkml/20241118181711.962576-1-
>>> yang@os.amperecomputing.com/
>>>
>>> Description
>>> ===========
>>> When rodata=full kernel linear mapping is mapped by PTE due to arm's
>>> break-before-make rule.
>>>
>>> A number of performance issues arise when the kernel linear map is using
>>> PTE entries due to arm's break-before-make rule:
>>>     - performance degradation
>>>     - more TLB pressure
>>>     - memory waste for kernel page table
>>>
>>> These issues can be avoided by specifying rodata=on the kernel command
>>> line but this disables the alias checks on page table permissions and
>>> therefore compromises security somewhat.
>>>
>>> With FEAT_BBM level 2 support it is no longer necessary to invalidate the
>>> page table entry when changing page sizes.  This allows the kernel to
>>> split large mappings after boot is complete.
>>>
>>> This patch adds support for splitting large mappings when FEAT_BBM level 2
>>> is available and rodata=full is used. This functionality will be used
>>> when modifying page permissions for individual page frames.
>>>
>>> Without FEAT_BBM level 2 we will keep the kernel linear map using PTEs
>>> only.
>>>
>>> If the system is asymmetric, the kernel linear mapping may be repainted once
>>> the BBML2 capability is finalized on all CPUs.  See patch #6 for more details.
>>>
>>> We saw significant performance increases in some benchmarks with
>>> rodata=full without compromising the security features of the kernel.
>>>
>>> Testing
>>> =======
>>> The test was done on AmpereOne machine (192 cores, 1P) with 256GB memory and
>>> 4K page size + 48 bit VA.
>>>
>>> Function test (4K/16K/64K page size)
>>>     - Kernel boot.  Kernel needs change kernel linear mapping permission at
>>>       boot stage, if the patch didn't work, kernel typically didn't boot.
>>>     - Module stress from stress-ng. Kernel module load change permission for
>>>       linear mapping.
>>>     - A test kernel module which allocates 80% of total memory via vmalloc(),
>>>       then change the vmalloc area permission to RO, this also change linear
>>>       mapping permission to RO, then change it back before vfree(). Then launch
>>>       a VM which consumes almost all physical memory.
>>>     - VM with the patchset applied in guest kernel too.
>>>     - Kernel build in VM with guest kernel which has this series applied.
>>>     - rodata=on. Make sure other rodata mode is not broken.
>>>     - Boot on the machine which doesn't support BBML2.
>>>
>>> Performance
>>> ===========
>>> Memory consumption
>>> Before:
>>> MemTotal:       258988984 kB
>>> MemFree:        254821700 kB
>>>
>>> After:
>>> MemTotal:       259505132 kB
>>> MemFree:        255410264 kB
>>>
>>> Around 500MB more memory are free to use.  The larger the machine, the
>>> more memory saved.
>>>
>>> Performance benchmarking
>>> * Memcached
>>> We saw performance degradation when running Memcached benchmark with
>>> rodata=full vs rodata=on.  Our profiling pointed to kernel TLB pressure.
>>> With this patchset we saw ops/sec is increased by around 3.5%, P99
>>> latency is reduced by around 9.6%.
>>> The gain mainly came from reduced kernel TLB misses.  The kernel TLB
>>> MPKI is reduced by 28.5%.
>>>
>>> The benchmark data is now on par with rodata=on too.
>>>
>>> * Disk encryption (dm-crypt) benchmark
>>> Ran fio benchmark with the below command on a 128G ramdisk (ext4) with disk
>>> encryption (by dm-crypt).
>>> fio --directory=/data --random_generator=lfsr --norandommap --randrepeat 1 \
>>>       --status-interval=999 --rw=write --bs=4k --loops=1 --ioengine=sync \
>>>       --iodepth=1 --numjobs=1 --fsync_on_close=1 --group_reporting --thread \
>>>       --name=iops-test-job --eta-newline=1 --size 100G
>>>
>>> The IOPS is increased by 90% - 150% (the variance is high, but the worst
>>> number of good case is around 90% more than the best number of bad case).
>>> The bandwidth is increased and the avg clat is reduced proportionally.
>>>
>>> * Sequential file read
>>> Read 100G file sequentially on XFS (xfs_io read with page cache populated).
>>> The bandwidth is increased by 150%.
>>>
>>>
>>> Mikołaj Lenczewski (1):
>>>         arm64: Add BBM Level 2 cpu feature
>>>
>>> Yang Shi (5):
>>>         arm64: cpufeature: add AmpereOne to BBML2 allow list
>>>         arm64: mm: make __create_pgd_mapping() and helpers non-void
>>>         arm64: mm: support large block mapping when rodata=full
>>>         arm64: mm: support split CONT mappings
>>>         arm64: mm: split linear mapping if BBML2 is not supported on secondary
>>> CPUs
>>>
>>>    arch/arm64/Kconfig                  |  11 +++++
>>>    arch/arm64/include/asm/cpucaps.h    |   2 +
>>>    arch/arm64/include/asm/cpufeature.h |  15 ++++++
>>>    arch/arm64/include/asm/mmu.h        |   4 ++
>>>    arch/arm64/include/asm/pgtable.h    |  12 ++++-
>>>    arch/arm64/kernel/cpufeature.c      |  95 +++++++++++++++++++++++++++++++++++++
>>>    arch/arm64/mm/mmu.c                 | 397 ++++++++++++++++++++++++++++++++++
>>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>> ++++++++++++++++++++++-------------------
>>>    arch/arm64/mm/pageattr.c            |  37 ++++++++++++---
>>>    arch/arm64/tools/cpucaps            |   1 +
>>>    9 files changed, 518 insertions(+), 56 deletions(-)
>>>
>>>


