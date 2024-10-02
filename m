Return-Path: <linux-kernel+bounces-348176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BFC98E3B8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91D99B23B93
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BC3216A05;
	Wed,  2 Oct 2024 19:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ZK6qwwhW"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020121.outbound.protection.outlook.com [52.101.61.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEBB81720
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727898660; cv=fail; b=mRigZ5cvwqB1CsMM14Ysw/2P7YtNfIA2eSCuD5LlYwtU/FrzSf0AnVC8t9jgO7n7/syqYWvrYY2fCXQb9Xn07pE8ScK2InCTBb56nufVvcGEaR3FY+DLG22Xtf3AUDah7jiQL3okhqzncm9NjHMTQh9G5w8yiLtECMU++FI+IhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727898660; c=relaxed/simple;
	bh=fZ5MqXOV+EAt04eZ7fmfx4+el8wGwSF/5w94Zlo4THE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lIjceIUpQltmPIHF0MZwJwJmq9slwoNsGHjI/VkLSfonxUKJYRXWw749q7i0Mmeo6nhPLV0jzqkTU29r9pGT5s44z7JjhHb6up5+Dr7VeVdUElntKjIiVAUXdPp66cL+kZKbiKc3M8w1gjp+KechnRpyNszzBBATqFny9iquAfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ZK6qwwhW; arc=fail smtp.client-ip=52.101.61.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dL6Yja5yAmsmWbZKIBUebXdQlrQ8SI+5R6LTufncoWcXvub2fr5aFQCgC1gfm/c74Y53rzYh2im0U/lI3ay+RHZNwhLvINT78qKzAbEHMAc1VkwZhZLYwrrnDFp1THarBrTu3JpU5xBDdBBWqsKaL68c5Ez9YXgwjKrDWnTkR1b0WdwifZn+zEodY5fz9zlCiNnjN6sBgRFiisjM67M1TxHZ0FPt4DF/rKx8/jMmquYIRDyg234oEB+Z5/c2wBiaE6CTQybKOdHrubdWTZ6M+JJi1i9Z+q3irR9d6JJEDuOn/8U9QiUMRDBytP+LVFzvMeM9w+K8/5uhthR6hzMojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoPsV9GKX8UkroLQ62nuvRnJAay9zvfnNdurKIhqe2g=;
 b=hIHxreeEAckNwYMAvYR+SWVByqJPzUQ6bFrm2tLUatrQ8FZafqZjJ18qfsPcWDgmMJuodGLARB5BwUlnKOtyLZ8DLQ1qtbpTsjN0adRgcChFion+9Iok3Lx1N5n+yxrMSFode7Fsb5qEISNtsJ28s/AnPDApn9wvhbz4yCT7A34jR1p8FWZJ03Wrx6ZcBPOWWxH2ExbGbHzTlBeMarIUy4hpExgJscsfQVWuJZJdI7p4m97184sP3vw9DqFYF/Fq+FESFV6Dj/bYSWzp7eIVFtlxnHDJJCsH+JcZRS326GL8O2DgfTLmU965kS/FsztuJsAJvzFq6qecK+UhoRSqWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoPsV9GKX8UkroLQ62nuvRnJAay9zvfnNdurKIhqe2g=;
 b=ZK6qwwhW0IN8RHrr63O0vYE62hjdU/uVqcWlAJQcgNRnydvAZJVg7EWZb3tjchs//fB4XYnbrkN/b2eC2NwCRW0A6I3cSJmEfozcJ9YtOC+jbq1aNZEy9wsTnPLu1T4BWoEi/oypsqWC5IPfa4yb3iyPrUFMm4HUstq8DOWBxF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CO1PR01MB9081.prod.exchangelabs.com (2603:10b6:303:26f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.31; Wed, 2 Oct 2024 19:50:55 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.022; Wed, 2 Oct 2024
 19:50:54 +0000
Message-ID: <2e76c13a-16bc-4f2b-be45-a4161bfe6136@os.amperecomputing.com>
Date: Wed, 2 Oct 2024 12:50:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@ziepe.ca, james.morse@arm.com, will@kernel.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241002175514.1165299-1-yang@os.amperecomputing.com>
 <Zv2ONA2b3+kMAizm@Asurada-Nvidia>
 <1c9767e1-4d05-4650-bc14-65a18fc63cc2@os.amperecomputing.com>
 <Zv2diJDU6v60hKtU@Asurada-Nvidia>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <Zv2diJDU6v60hKtU@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:74::24) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CO1PR01MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b542e2d-2b5b-4e1e-133a-08dce31b86f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2h4WS9Sakp6ZEF0aCsxTkZLaTVpbjcyN25UYS90ODgrQWZKTmhwajUvMGNq?=
 =?utf-8?B?Q0F5aFZoQlRKbjVuMnRZQ1BnV0drNGgyNTZ5TFhnVU9kVVc1Si8yVTZ5Vzdj?=
 =?utf-8?B?bHl2TUZpc3psbk1YcEpUSy9RUTlmOXZ6ZVBncTR2bm1UbjVOK0RuVVhUWU1a?=
 =?utf-8?B?cnoyRmplMG1SNlhQN1gyckkrMlk0OVlWWmZjOU0wc3NjZXFpdzJqaVpORzhH?=
 =?utf-8?B?RGFkc01ueWc5WlVkTExUTjhxOGx4dCtHMTVPemt6ZzlTVWdDVHJzK3FQWm5p?=
 =?utf-8?B?YS96U2RHWkdRbW5xR0lML05XOTZoczZpSkRpWHRmQzltalpaWkgyaGhFWXV1?=
 =?utf-8?B?STd0cW9RZHpKWW1HNG5wZDEwdFNHdG5iOEZwNlhXeWp0eUNxVGJEWm1nMnht?=
 =?utf-8?B?R3BPTlNndEFCNU55cjBWWE9QVXlSSnpiWEZoMmF3Tjl6OW5sQVNQVEkxeVlV?=
 =?utf-8?B?ZjF0RnJRTTZMUCs0UWJDUW8zWnBOQmZuRmgvSjJnNzZZbjl4dVpvcTdYb0xn?=
 =?utf-8?B?SS9hdkFicm1QSVBaOXFVN3RrUm9zWEM5eElLZWN2U3BLa1JoT2tLbGh2L3Nn?=
 =?utf-8?B?c0ZZSHNrSU5ycHk1bkJhMUd3WEszSk1nTk54cUNlcndkKytFK2hBY0pWbUM5?=
 =?utf-8?B?S1c4OVEzcGJLRWJFdGFsOGpCMExlV3l0Yk9Gb0tNWkxYMGpCOFF0M2lqNDFw?=
 =?utf-8?B?ZFNPQTdyNU1wTitnRVQ1RGxSbDN1Z0JoSUJDc0FwZTRlTk9yRmxqWEN2ZlU2?=
 =?utf-8?B?YW5aTDNZUEVuZFo5Rk5ReXZzNVdFdTJuU1BGYWc1M0o5bGdZNXhjc1gxQWFj?=
 =?utf-8?B?dW4vRm84SkxyZCtWb1A1YndRcVNxRDB3dm80cDJVY3ZidzdEWXZPVmVkb0Vs?=
 =?utf-8?B?aldzeVhVUmxOR1dBdm9yMFV4V0pvaGlkc3VOMk1FNUR3ZVJDbXFSWEZoVU9V?=
 =?utf-8?B?aW1JOGl0YlZtL29Tblh2dGxmaVFYOVNOZE9LOGtuUW9pUXpFM2lKb2Q4dVBK?=
 =?utf-8?B?VC9mRDVxQ1JwSmxkSEJFS3BQVHh0RnMvb2c1bXZvcWdRUFBUM0FRSnNSdC95?=
 =?utf-8?B?RUltaHNPTFJrREw2ejV2aGFYUFA0YnNHK3Q5ZS9jQlU5eW5YMktyR2U4MG5l?=
 =?utf-8?B?dDlwKyt6Z09ZMUJ4cmsrb2lqRHBnZXA4dVJDNlI1Mk1xN014TkcwdUJ6dWlS?=
 =?utf-8?B?OHBMbXFSMThOSlhyOUNTY3JjRXZhVDNkQnc3a2RCV0Q4S0Z5aTlHUUZtQWJ0?=
 =?utf-8?B?RHFrYk1Rd2d5R1cxQWUydmJVMU1UVkpBSjdwTVNOMnhtY3ZlZ29YRXc0K08y?=
 =?utf-8?B?UDFOQU5RcnJFckJyS2lKL3p3aGJiSzJpNHVZVE03YmZQcUk5emJUcVFtZHhM?=
 =?utf-8?B?clI0TEpnRkxrakxMMHJQZDZUUktYZDFhbTFKOHdCMWo4bDJIUWRXRTF4VGNS?=
 =?utf-8?B?dUZ4T2J6aHE1dm51TEJGYXFxRzFkK25wZmNtM1c2YkJSMWE1ZUJMVk95cE96?=
 =?utf-8?B?OStqcGVIc0g0dmNzYWM0REVMQXRsUDB1a0FmSlVUbmk4NlFzQzBVYktSOG9W?=
 =?utf-8?B?RXZ2c3lnbWlNRG1YK3FrUUJCTXJnTzZhajNITUROVG43ZkRvazN2cUZiRXdI?=
 =?utf-8?B?SXFCNWVWMFlsK0dWZTk3UjFQbEptYXRUYUlvUXJhcjhubnlJTTBORm1DYUc1?=
 =?utf-8?B?MjZmZ0xmNXNDWnh2VktqT0pYRzFTcUtwUUE0T3JXUnc5dURYdmNETWR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWx1TVBPUW15RHJyODFCN0MyNmJZWERnN1Jia3Nha1pGMStJc3NDY2lFSHl2?=
 =?utf-8?B?UDZTK2l3SlhEVHRPYldzVzAyWHNKS2dMMGgxOTRuTzZmNFYwVWRjTjVwTlpD?=
 =?utf-8?B?blUvN2p1NFhjVzRZamRKU1BhOEFnc3YwNVpMcUR5TzBlY21wcVY3MW9vWUNL?=
 =?utf-8?B?Sy9DVTlDTGdnNXUyWFUxMWpMOGIwamQyeHNBcU9HS0dPUnVOMytVUjJuOU5l?=
 =?utf-8?B?ekswb25hckRWTkZzTG1tVU1JYmd1M2F1eEdZYUdEL0RDZnE4MXFwQTBGV1VE?=
 =?utf-8?B?UWFKN3pyOG5IcUJtUlFoc2d3TFBRVnNUVDkxQzRFRjU0VUhnQlR6VFJyYXpp?=
 =?utf-8?B?eFY1dSswMERDUmc1cEd2dk9rRXJESmFMN2U3M0RCN1hLR0lpVlh6eVdxVk1l?=
 =?utf-8?B?R3VpMldkWW52cnNzS0h4VTR1WDY3cEtlVFF4SlVONFBEUXdJKzZWN2NLcFNI?=
 =?utf-8?B?VStZeGRGck0yenpIZnpXMFRVNDA2MXhVY05ITTNPYWZieGpDRGJhNjdqcDN3?=
 =?utf-8?B?aU16Um9vMGtiY3lzVGNBMUJIb2E5ZXhTSS93Q25lVngwalZvY1g5N3c4TzEx?=
 =?utf-8?B?S2tRc0kwOHpwZjFMbUVBdDUrVk9ZSEJKUHpuRVNwbkdzdFhmd3RNR1pabW51?=
 =?utf-8?B?TmdkeHM2ZEg0VFhxTTVEY1UwbUJyS0hDcHJVQ3BITGE2dzFoYUcwUUg3UlU1?=
 =?utf-8?B?STQxOVdwZ1hPMjBZZnFVaWxZQ3lTNUdlVng5QmtlSGZ5NzFGc09lYWZRRHRU?=
 =?utf-8?B?Snh3TFRRaGx0b21sVEk5R1VlL0dGY016VVBsQUdKYnViUDNmS3NHWUpXV1Mr?=
 =?utf-8?B?a1dtNHpDaFNBZTl6bURZbGNEeWFUUm92Q2hVSjR0QTFQSERpbXlDZUlNeFN1?=
 =?utf-8?B?cEd5TVJhYU5OL3hRM3BCVkE2eGh0VUsxV3RTbmRKY1NudG95VW9USWU4OWcz?=
 =?utf-8?B?eHNJOE9wUmxuVmZFUWdWSS8wNDdjd21jcnhRSUhaS0pycUFoZiswc2JJS0E1?=
 =?utf-8?B?U2E2R1o4bW04N0dVN1p2b1dJbGFkZUIrWS80cW1vTWNJa09sMDRkdHI1U09r?=
 =?utf-8?B?dzVCN3F0N3hSc2hpK0xSWkNXVzQvL3U4VExvZ0VmODB6S2tlUFlFenUxb0hw?=
 =?utf-8?B?VXEwcEt4VlVuQ3Fha293QlZMNHpPcDlLL1NHbkQwb29yblAzSk5lL3k3UmQw?=
 =?utf-8?B?bm9zZmhEd25YSlhIQm10UkVWVExUQTNoa3Q3QlUwbVRtdUg4MEgvSHdtZExM?=
 =?utf-8?B?M2EwTERBYURibEFudkIvTktwYkVuSVJQcnk2U1V0RTlWN1JiQWlxYVVLNm5m?=
 =?utf-8?B?WFVqbzZrS05IbTBNdzV5bzFqWVFsclpUbXBDR0lNZUY2N09CYlNqYmtpQnIz?=
 =?utf-8?B?bkVnVG45TzBzK0gvM3djenFlL2ZRSDl0SUszSnJnK2ZhMVpQWEJ5Rmg2UFkr?=
 =?utf-8?B?Qk1uWjFiaDl5alhBRmtyOEFoUm9jbEdudzdqajQyQk93OEhPV3BaN2xlWE1H?=
 =?utf-8?B?NkJvbExxY2Q3T3YyV0RuVEhwb04yVmVrem5QeEhiRlYvRDVxejFNcTVlSWR4?=
 =?utf-8?B?bU5xaDVBbCtUUVpXeHNkQ1VGdmU5MHBSRmFYYktDSjV0TVlIRTVYZ280M2Jt?=
 =?utf-8?B?MFlKQ3o4YVh1aGxRNk5ORjlqWnF3QTZuVTA0VHJUMEhjNzZEV3JDd0tyNEN4?=
 =?utf-8?B?OFVBU3NpUTNwQ0lrWDNCVjdqbUxraGVhR0xYYjZ0OFJnS3hweklVNEFIcW4x?=
 =?utf-8?B?anFSeC9VMTFSODJYL3g4QnFrQTlqZ0pUWnBQUnlsRGo2TnI0cHIzdWN6bU5I?=
 =?utf-8?B?VnNzcXF1Vmhaa1hsZmtIQ1hiaWxpMVBETG9LMzBiVzhOaThPYzBNU3FoUXpp?=
 =?utf-8?B?cGtWQlo2d05rMmVBK0RQVmlCWG9jdXlsU1dRdnpweEFOSThuQVduRlA3dzR1?=
 =?utf-8?B?c0hHbWxCZHdKSFV2OFRPSms1UDlGR3JwclNrZ2hZUzdzZ2dzMlN1K1JJazhU?=
 =?utf-8?B?aXFEalJaUFpMOFppVzJRTzFRQ04wMExBU0lmdWM2ZXdwOTdTZEt6bC8yODNQ?=
 =?utf-8?B?ZmZCREE1QUViUmZTM2dET1p1d3duN2U1clZ0VzVORUJMSk9GZkVHZGdEcG53?=
 =?utf-8?B?OWdrY3U3dU9BZmZwNGlyQ0U2bVV4WS9RLzFWLzFvRm9TbHBTblV0WC9DOVBh?=
 =?utf-8?Q?mI4SIUQiMhZtvGD/Al/sZEg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b542e2d-2b5b-4e1e-133a-08dce31b86f8
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 19:50:54.8872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSMOXpYkb4OAsgurx72ldRxLWY1vTJGSeqx15jDbffop8TjhrAQyTEkHq8XI7ztpo/+Hv4RahIHzS1qtL6T0ILLPh/c7KvQRMu/pfgL2mds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB9081



On 10/2/24 12:22 PM, Nicolin Chen wrote:
> On Wed, Oct 02, 2024 at 12:04:32PM -0700, Yang Shi wrote:
>>> On Wed, Oct 02, 2024 at 10:55:14AM -0700, Yang Shi wrote:
>>>> +static inline unsigned int arm_smmu_strtab_max_sid(struct arm_smmu_device *smmu)
>>>> +{
>>>> +       return (1ULL << smmu->sid_bits);
>>>> +}
>>>> +
>>> Hmm, why ULL gets truncated to unsigned int here?
>> No particular reason, but it should be better to not truncate here. Will
>> fix it.
> Yea, and looks like we are going to do with:
> static inline u64 arm_smmu_strtab_num_sids(struct arm_smmu_device *smmu);

Since this is an inline function, so the truncate should actually 
happens when it is used. But anyway using the correct type does make the 
code less confusing.

>
> Then let's be careful at those return-value holders too:
> -----------------------------------------------------------
> static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
> {
> 	u32 size;
> 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
>
> 	size = (1 << smmu->sid_bits) * sizeof(struct arm_smmu_ste);
>          ^^^^
>          overflow?
> [...]
> 	cfg->linear.num_ents = 1 << smmu->sid_bits;
>                      ^^^^^^^^
>                      This is u32
> -----------------------------------------------------------
>
> Thanks
> Nicolin


