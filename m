Return-Path: <linux-kernel+bounces-574734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F279EA6E93F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 06:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 110CA3AA33E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 05:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266021A5BB3;
	Tue, 25 Mar 2025 05:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5LOxKKvT"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821AF64D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 05:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742880056; cv=fail; b=MPCs9cX4Db+SiM6qAQdpDnpm23SERoSXSGbN3k8MmNnGuvroJydX4Asyk2cagt96IV0XotE+jMKKTRwyLUd47MeUUhJ2T0T+cgggyHZSCBi+lD9HGscjw+ZJaw36OVrN15PoMh036fLG5rJ8D76l8MmtGezncev/8PmCbRpSAr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742880056; c=relaxed/simple;
	bh=tlUld4QAWiaLr9g3ewYwVWt71QOoXV85NHRtfaJAlGg=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rYJjXe1OsXyC49Iu3vdb9FwAEW8g0KVZQaVbrmd7QBDpjapywFX3+fgtRdkoTCHUKCHRdSDKj+ZpQ6moCdoADvOKO4l55VKvHqWN9otQEZ0Zv1Tjai+PDxn5Qed5ueaSBFRWZiCyCzZWBOLaxRkqo7kSw4cqC8HeJTWI6CFzKsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5LOxKKvT; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2szNmD+ETD7rwjAVBfmF/XfxHn1qOJkwWhLFv3hLGeNfgeRZ8chkpNsptvy5APiNVStMhsO2OIIfTkazkPO/qAKrK5cmEZWLSjhJivwPRKLpsFwV72AYMhf4k6BnhA02olNzX+0SDKLziCEue3s4kDqn5nxP1yYuEd01pryW16BP9x6/x6lOtHSnicgGDtNrkQUq3aSXlqkINSUeqRNlEJXfGXJPSdBSiGxxgdOiTTeEE1yvnlQ8WSrSpJ7QJG4Js1/Lpa7l7NqME1hYzubzcJxzo0HZvq85pUrfQ2kqfCocSDIxNxoFKq+XHy6ybnRWSqpHMigeoT4RexlXZEEYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJLzNy+0T194klZKJw2/J7hUGW1yhZjOp/XLblAyLMg=;
 b=pVOiNw43k0hK+bvnc1LoUMMB+dQLzw8iu/oSRECUaMeT4YgWJBgHIUTHMvFToOhk/LmCG9xF1ms9Ee/Vu9owTsdaoabfbhfHOIBi5QaSTuL8u0u6E4OzO1zY0/R9x0vRr7Fvs33tYZAcVNAiCMSoBL53ZzWnja1LMB2l/6KYZB3OoTjG3hI7SQahxxLI4rYFXiV2KcUEw5eEwiXlcyNJC4CRZg26fg+XcP1rsKVeXAeGtkItLJuPX/+D0hWUZb5wkQu4wjMCZaoIJ5U8+J5L8QuDFkrTBJ7CmWb2jZ1jP0gZpuTIaEW7I6v57usyIvtBdQSJkBp+bpjTtqA5V0jMXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJLzNy+0T194klZKJw2/J7hUGW1yhZjOp/XLblAyLMg=;
 b=5LOxKKvToRl8Om6H6RNJYsaQvl16Et2/smqP21uweYGPL23iYe+lPgF2mQt/6G1nQnK+lwyeXUlzuqjBXnQZ8SRWexe29rqw6DybybcCS2HRmh9ZG5S//nJ3mxFOvrNWlMsprcz2ZfZ83nIwu0olRywrFRha6aPHaIs7Sy/MLus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by LV8PR12MB9408.namprd12.prod.outlook.com (2603:10b6:408:208::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 05:20:51 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 05:20:51 +0000
Message-ID: <02548b27-2442-4172-8f4f-a6fb7588d705@amd.com>
Date: Tue, 25 Mar 2025 10:50:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Enhancements to Page Migration with
 Multi-threading and Batch Offloading to DMA
From: Shivank Garg <shivankg@amd.com>
To: akpm@linux-foundation.org, lsf-pc@lists.linux-foundation.org,
 linux-mm@kvack.org, ziy@nvidia.com
Cc: AneeshKumar.KizhakeVeetil@arm.com, baolin.wang@linux.alibaba.com,
 bharata@amd.com, david@redhat.com, gregory.price@memverge.com,
 honggyu.kim@sk.com, jane.chu@oracle.com, jhubbard@nvidia.com,
 jon.grimm@amd.com, k.shutemov@gmail.com, leesuyeon0506@gmail.com,
 leillc@google.com, liam.howlett@oracle.com, linux-kernel@vger.kernel.org,
 mel.gorman@gmail.com, Michael.Day@amd.com,
 Raghavendra.KodsaraThimmappa@amd.com, riel@surriel.com, rientjes@google.com,
 santosh.shukla@amd.com, shy828301@gmail.com, sj@kernel.org,
 wangkefeng.wang@huawei.com, weixugc@google.com, willy@infradead.org,
 ying.huang@linux.alibaba.com, wei.huang2@amd.com,
 Jonathan.Cameron@huawei.com, byungchul@sk.com
References: <cf6fc05d-c0b0-4de3-985e-5403977aa3aa@amd.com>
 <0f9e697e-d01c-4559-9c1c-7dd2ce76045b@amd.com>
Content-Language: en-US
In-Reply-To: <0f9e697e-d01c-4559-9c1c-7dd2ce76045b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::12) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|LV8PR12MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: c41cc8b5-1e10-427c-e792-08dd6b5ccefd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cml2ZDZHOVZjYVpqMW52d1UvTk9JNWF5WUZ2VlVwNHpLMnNNcE1LTjNMYnRI?=
 =?utf-8?B?ZjRXa3Y2UC9CZ0NYNXJPZ3NuWnI4bEtXZkFDL2VvQy9Sb04xeStqTXFQajhp?=
 =?utf-8?B?Lzh3RVc4MGdtUDBmQ3c5VjRsdFhaOUo0dWJiODNTS3o2dmZxVnlMbk5WZXBH?=
 =?utf-8?B?Kytva05DT0VmMHZSR2pTWTZWU3VZb05JNVpwMmtZRkd3alFvRkRyUUkzdWRB?=
 =?utf-8?B?QXRNRE1VNW1jVUlrVjU2Z0NXNEZBZ0dndVUzbVpORUg1RXFKeGFoc2k3USs4?=
 =?utf-8?B?cTB3ME4vME1CSkwxK0FCR2xKM2MvOVVGSjZNUGxFMy9zdWdacHZ4ZXhLMTdm?=
 =?utf-8?B?K2VuR05SYzVoamFmdjhubm5OaWtIZVNJcXJvcXRsdUF6VUhuKytUQS9va29S?=
 =?utf-8?B?UlpvRmlvRGFTSUp6TEo2WTI4am9UYXpNaTNVeXdCWndpeEtPdmdvODQ1dXUv?=
 =?utf-8?B?ZnVKTmdPdTVDc2VFVTRKWU55b3g0Q2dxUTlHV1NId200a2NDb1Z6Rk5KYk82?=
 =?utf-8?B?VHAzVkdHc2pKKytJRUtZMTdQS0R1U3BHWjJZMS85M1F3bTZXdjVwM21BNk9X?=
 =?utf-8?B?QmlnUXVKcHRkbm9aMTE1amQyaHRxcStnQ3dCNVJqWklmczZpbVgxNENodkhC?=
 =?utf-8?B?RzFObUZQZ2VIOFNNSjFSamRQcUtSTlIxNTd4QnpveTVxam5RSm05Mk5KUHJ5?=
 =?utf-8?B?NlE4bUh1eldPWGEweGN6OGlCdjlDZkJrQk5MWXE0SXN4cUVkL2NKMlcvQlRJ?=
 =?utf-8?B?WlpySUwxSytkQjZuU1VQeGdIaVpLWUgyYXhwaXdXLzlnSHFZQmtqdWoyQjR1?=
 =?utf-8?B?Qnpkd3ovZ1Awb2FsVTMyd0VMQlM5SktpOHZvK3hLTkJTcmRXMysrQW1MaXZr?=
 =?utf-8?B?SkNsdGlMK1Z2RmpwSTFydGYvenlsS216Q0VaQldlMW90cnN0cW1iUzJUTEM2?=
 =?utf-8?B?MFhUT1Z4QnZCZlFWeHdWZzhpMWFLNHJsQ0V0L01hK3NjMW03VDRhcTlYK0ZQ?=
 =?utf-8?B?eGR2WndYUXJCdnhOa3VVeFU2aDVSSFEvU1pzeldmYndtRUdRcGRGczhUUGhy?=
 =?utf-8?B?RjVNOUZiYkkzckEwMEcvVE90elJsLzI2Rk1iM2VaU0FKK1VpK0NWSlBhV05v?=
 =?utf-8?B?QmxlYkdCek1VT3doMCtTK0NiRVBObE5Ecyt6Q3htSzZzNjVwcHVaeEdGVEZu?=
 =?utf-8?B?azJGWmdaZnlHcGE4M1UrSWtsKytBSGxGcWZuajh1ZGkrL0hvNGV0MFRnc1BY?=
 =?utf-8?B?RUtSTEo1Y25CaUNHc2dQVXUrNjgvTjltL3FoQno5R2srRHVDelNFZS81Qll5?=
 =?utf-8?B?TUpyZWVNblRrVmJPQVZqL29UZmpObnE0cFp0eE5yb2haK25DYVhZbTAySE5E?=
 =?utf-8?B?ZkxFMjV0U2ZqWXVySnZyQUNuRENKSmdvazVnMW5IaVkyUTRaZ2d0UlVqWnR5?=
 =?utf-8?B?U0l4U1djREFtcWo1UlJCQjBNekl3dzNZcG5QcHNjNkgrcUE1REp5RWRnaXpt?=
 =?utf-8?B?eGxLQWl0ZEZxc1hmQ0FoY0lYNVd2d1BldVgxZEFsaE9IcTZJWVo1RlhocGl4?=
 =?utf-8?B?R0lnemdvaXI4b1RUclJzSmFOYW5ITXJaZEd4MTlua0JQTVRaQ3l5MC85bW9Z?=
 =?utf-8?B?UWdSNjZMazNhaUFIbVBLSEZPbkVwK1JWQ2ZYb3VNM0U2NERtWTVIN0d2UGNj?=
 =?utf-8?B?djNTNUliRDhzRmRDUDZJQlVMaWhOQUN1SWY4MnhpWDlCNlFiZldPR2xzR2lP?=
 =?utf-8?B?UWpzUStDNHA1aDRObld5WmdvZWRPWWNuUVJ2djNYTXh5ejRHMy9LQnlWaWdX?=
 =?utf-8?B?RWc3eTJLRHY2S3F3TXl4dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXB0bGpSa2dGV1FFSURDNEVGWCtmRTlQejVyR1hLd2V2aU40RnlwNXFNS3Za?=
 =?utf-8?B?QUdHcnhvdlhsdVV5TVVMY2tPaHV3blVwUzBNWlg3ZGFmNzFQa3J5bWtUOGVw?=
 =?utf-8?B?bWNBL2lrdlRveUFPMUhBK284eUJQT016ZitWNlhOT3hCUkRuQlhFUmtPeWNF?=
 =?utf-8?B?Z2hwMWlEcm1qcWJvTjVOTmFNRVdWa3d6cUpnNXRkdExjRTd5b0VjOVZ5eWhi?=
 =?utf-8?B?aE1IcXhkSThSSFRseHpZa0Vua2NSTjlRMkdOWWNVbTE3Q3ZtcmhwenRmdXpR?=
 =?utf-8?B?K3NtOVh4clFxTk5JK0haWVZlZTc0cWtma1J6WnNQYzZVVUdpc0ZiU1drdE4x?=
 =?utf-8?B?aUtSSGk1aGpXdmFCdWFET3lJd090dUdPU3ZUWk5sWEdEWXVCYmY2TkNKVStu?=
 =?utf-8?B?Vk42aHlhdFFLaC9jbDAxT2hFSW5hVWlEdWlOSVh6VXgvL1pBeU1VMHFQS3A1?=
 =?utf-8?B?RzN5dUZ5RG9FSFR5eVBHelIvNjZTUlFvamRyekl1c3BuYWIrdkV1T280ZTVv?=
 =?utf-8?B?ZlNwMXNsZk0za2ROeTRUai9nOWk0UzlnbWl4Sk5GYlA0MFAyOVZFRUYwVS93?=
 =?utf-8?B?RUltR0NLczBxUWJGeWV4czd0UXBCSUVLVXpxN1VWU2RRdWE3dTlhWXdtUCtl?=
 =?utf-8?B?Z0l6YXhaVWNKOWM2SEROdjdlMG1udkRQWENVU1cySW9pSkdhVmd4c25wdUR2?=
 =?utf-8?B?b2RmdW9NMUtWdlZmTjlTT1hhb1FwVUlYSVVZTk5jMzhsaThWdURTOExnbjN3?=
 =?utf-8?B?S1l0Mm1rcENNOFJ2MHVHMFgvTXlhREpvS1ZkMXhvZ1FzcU9FenAwUU9Bbkcy?=
 =?utf-8?B?aFJEbWpXYmo5d2NTTFhHWWJmcTcrbVZ2MW5uMGpqNHlKejJOR3A1MjNWeHBG?=
 =?utf-8?B?RExqZ0daSEl4VWQ2bzd1VmRNMHVRQ2R5SXVCUXJVTmlhdkpBR25nWktZaGxv?=
 =?utf-8?B?QkVSNnhIYmdJU1VzaVVpRlRiTDJzcjh3TmtmaksxdVV0ZUQxWE5sODVOWG5x?=
 =?utf-8?B?Wnpjb2g2eDlOQndLWXBvSkt3Rjh0RFVTdnBwWFN1MWY0ZmNBdUlJbVQydSt6?=
 =?utf-8?B?RWd3WDZoSUZxdWo2NTJLOURmUHppd3ZCZHJoeVRCdGN4ZjJ1aVM3MFlETDVE?=
 =?utf-8?B?SFhLUmxzSkxLdVhucjNOYnlyV1RTK0xPdFgzcjlPajNObUVlOVZxQ25WZzR5?=
 =?utf-8?B?dnlCekQ3L2xsRDU1dUVqa3A3b0pKNFBwMlBQbGVheFJDWWxKckV2amw5VGQy?=
 =?utf-8?B?R01tSHdONnRJOTdSdFh3bWZMMnFDUmNrUVBNaFF3ZGNDNDFHSllsVzNCUW9L?=
 =?utf-8?B?YW50NExCUFI0VUVzRm5BUkh5SDhMb1NWVEZ0V0lQZGp1aUJybThlb04rYk9S?=
 =?utf-8?B?b050eDFDNnMrOEdmemF6S095UjcySFNQcWJCcldtKzA4eWR0SWRtZ2luRFJG?=
 =?utf-8?B?aUQwYUYrNzJBUWY5ZnF2eUtNb0hyMi9ONUFVZUpnZkVHUnBmTHZHMUJKaHhK?=
 =?utf-8?B?Q0JaWWJIOGJvWnRTdmJZRGZtUjlrM3A1YTFEK3FFNXJtaXZkbEkydTFoUzdi?=
 =?utf-8?B?YnIvdTRzVnNMRWJCdGhJZnBtb2ttU21OSE1iaWR6cW1JV3RTMXdsUzF3YmUz?=
 =?utf-8?B?SmhRWVZHUlEzdGZPNE9xM1Z0dUprcFBTMDA2aHhEYXJpSU4zR2xTRmhIYU5k?=
 =?utf-8?B?N3RTc0dBam0rWHRzZkM0T3U5TWR0ODRReVUvQzNpTjZyd2M2TDRhbkZtOGM1?=
 =?utf-8?B?TDlmZCtuWEVWdW9jdXNZZUluMGVyU1ppQ2hvNDhHdmhNTzZPNEUwcmx4M3Nq?=
 =?utf-8?B?c014c3F1QWVhOHN3OWF5dGdtYlR4L2VvV3ZURHplb0o4Mlkzc2xoTUtHYWkx?=
 =?utf-8?B?SThnNFR4YWhaOXdMVUZGV0xheWlycUdaSXZyS01TN2lGQklJNm1uOXhEZTFZ?=
 =?utf-8?B?aTlDQ3RzSGhWdWJTZVMya25hRjdIYmQ0MWlic2pzbmkxUnZtSFIzdmV1NG5v?=
 =?utf-8?B?RDdpNHo5R2dCek1QVXhTNUdaZDRFM0h0T1F5SWpTWUJtVXdjMlE0NDJGSDZL?=
 =?utf-8?B?VXUyZlRYekxReUd2ZzdHbk8vR1lXenE2VmpxaFhuNmNVamhsYzZIY09ybE5n?=
 =?utf-8?Q?5hKi0yOfRLofK0ooJ5PT7+hz5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41cc8b5-1e10-427c-e792-08dd6b5ccefd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 05:20:51.4110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OP+RycWkkwB0kIuqmFgfVubIqBMgrWEOpXdr3IRAS1sBCKNrTbeGmwLPvTToblYLRzd0fuqT7wxhp0HgNsYLIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9408



On 3/24/2025 11:31 AM, Shivank Garg wrote:
> 
> 
> On 1/23/2025 11:25 AM, Shivank Garg wrote:
>> Hi all,
>>
>> Zi Yan and I would like to propose the topic: Enhancements to Page
>> Migration with Multi-threading and Batch Offloading to DMA.
>>
>> Page migration is a critical operation in NUMA systems that can incur
>> significant overheads, affecting memory management performance across
>> various workloads. For example, copying folios between DRAM NUMA nodes
>> can take ~25% of the total migration cost for migrating 256MB of data.
>>
>> Modern systems are equipped with powerful DMA engines for bulk data
>> copying, GPUs, and high CPU core counts. Leveraging these hardware
>> capabilities becomes essential for systems where frequent page promotion
>> and demotion occur - from large-scale tiered-memory systems with CXL nodes
>> to CPU-GPU coherent system with GPU memory exposed as NUMA nodes.
>>
>> Existing page migration performs sequential page copying, underutilizing
>> modern CPU architectures and high-bandwidth memory subsystems.
>>
>> We have proposed and posted RFCs to enhance page migration through three
>> key techniques:
>> 1. Batching migration operations for bulk copying data [1]
>> 2. Multi-threaded folio copying [2]
>> 3. DMA offloading to hardware accelerators [1]
>>
>> By employing batching and multi-threaded folio copying, we are able to
>> achieve significant improvements in page migration throughput for large
>> pages.
>>
>> Discussion points:
>> 1. Performance:
>>    a. Policy decision for DMA and CPU selection
>>    b. Platform-specific scheduling of folio-copy worker threads for better
>>       bandwidth utilization
>>    c. Using Non-temporal instructions for CPU-based memcpy
>>    d. Upscaling/downscaling worker threads based on migration size, CPU
>>       availability (system load), bandwidth saturation, etc.
>> 2. Interface requirements with DMA hardware:
>>    a. Standardizing APIs for DMA drivers and support for different DMA
>>       drivers
>>    b. Enhancing DMA drivers for bulk copying (e.g., SDXi Engine)
>> 3. Resources Accounting:
>>    a. CPU cgroups accounting and fairness [3]
>>    b. Who bears migration cost? - (Migration cost attribution)
>>
> 
> Hi all,
> 
> For reference, here is the link to the latest RFC v2:
> 
> https://lore.kernel.org/linux-mm/20250319192211.10092-1-shivankg@amd.com
> 
> This version combines the ideas discussed in [1] and [2] and includes details
> on performance improvements and experimental findings to provide more context
> for discussion.

Sharing the slides from today’s presentation:

Main Slide Deck: https://docs.google.com/presentation/d/1mjl5-jiz-TMVRK9bQcQ_IsSXrIP82CqWS8Q6em3mJi0/edit?usp=sharing
Multi-threading Slide Deck: https://docs.google.com/presentation/d/10czypcUbRMOUn6knp340Cwv4bf83Ha2gUX8TwNXUwCs/edit#slide=id.p6

Thanks,
Shivank

> 
>> References:
>> [1] https://lore.kernel.org/all/20240614221525.19170-1-shivankg@amd.com
>> [2] https://lore.kernel.org/all/20250103172419.4148674-1-ziy@nvidia.com
>> [3] https://lore.kernel.org/all/CAHbLzkpoKP0fVZP5b10wdzAMDLWysDy7oH0qaUssiUXj80R6bw@mail.gmail.com
> 
> Looking forward to your feedback!
> 
> Thanks,
> Shivank
>  


