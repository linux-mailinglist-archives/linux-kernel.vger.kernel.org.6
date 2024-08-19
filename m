Return-Path: <linux-kernel+bounces-292707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7867E957343
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0C61C22AFC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E8C1898E7;
	Mon, 19 Aug 2024 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WsfUxF7/"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880EA1891D1
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092207; cv=fail; b=TjuDjzdvAB3PX6VUZIHx86sXR7rBQTQdl7+3dP1N+oOkLQtHZcoF9jRdI85cbSmb05eGoW1szYPl8YsRL3T2vCutkb9xFG+DPrsVbzyvH0/1+/x93lkGneulWzaexS46AaztnptAa4OG0x3KI6qu6+YsQPZAAzWqhRfe9RtjvCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092207; c=relaxed/simple;
	bh=z3q2ujrm/XFQq0Mc8iV7Z/kyiS1IfjjNECs/IHHMpIc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GW1fD02XcNnDudGnDjmmIakweJYZTh7KVdQqjx2K1jJbIRE/BNLRY0ltZF9qWSdwLWReoLfbMkH5CmtSzHRbxgUuCCr9DVMaZdLtjeTOIcX5vAk3bajPyzM7CKewPMycIF6WxXWL3kSXRBkCm8sLOjlQpdnN4PLBoLoKaVoRFK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WsfUxF7/; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrRzf8OJ8vvUNqjSLtuspiX1U9czNd1DccO/W1HBpOQfKtXT8GhUOOdxti2Bs/NsJVO+UJAT185QoTrrIlIZzk2VDy814LrJkFRzamBEOlUTlYjXvf4fElnu0dw5F//gWvNl6vjiChktPreTGkHBdi6PfJ4wa1HhRaurwIBuvl6hF6/0FA7zdf6oU1bspZ73V3d9hIilVBVqZadqTh0bBp9n/vViL0KHcAZ0fLDwrCZGHD9C48knVF2YgbuSSVgFmvX/cxwp/LWZvsE/OTxgvq7TQNlxmwY/XNLyYqptCIeBkVBiKcXdhAoqAWBzPR2m8HK2dC1e9A5F+OgkD+QeoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWFVZIh3YE/EmO1pcDgkBNyso4z89lmf15FgJAIPA3s=;
 b=cp1PeT3FVMf1h6bhPlBpUvC5QRVae0AAUg3pHlIyFY1y/a+n9de9w8U+eD3m82aaX2RrWOLX6KozdkN4kIIYesi8L06Xjd2sOxE0RwTAAeZTneCBH6kNCAK4HiGbYQ8u43yToYqpvLGcEJsR8zb+16rl85eoQ/8TJtqIlCDj+qPO7FQ+l/Dqp8f4qIR3lMX8k7/20uuhPNDJKU/aW+YaUJsyPoMMsH9XJ69jsDHbd5F6wFV1+pB7TEOtBg1HLOHze9JwHQwpEmgxOUGvc9Ez9v0bkqyz82IBVh7RDomQYJlaRMZ1q4U+7VG3ikUeOfK+1QaWlbQuQPc2yO9n9wCFkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWFVZIh3YE/EmO1pcDgkBNyso4z89lmf15FgJAIPA3s=;
 b=WsfUxF7/CRrkn2dTyiqjcRw2iHcxZGXVlHrobRkAyLqrfTQ5iljT/Xne6kt+LQ9yxn94ivpLXsRjPKA89J+UsT2CUlfIFVZ1/mHN9LOuUMr+aLD4dsXcL3Lzn8y1vM6K1xobIOZp9zUPRl5C/JpdZoXLsbsdvuIv27VYyew2GPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 18:30:02 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 18:30:02 +0000
Message-ID: <8e0f8371-095b-dab1-8acd-957fbac7046c@amd.com>
Date: Mon, 19 Aug 2024 13:30:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/sev: ensure that RMP table fixups are reserved for
 memblock
Content-Language: en-US
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com
Cc: michael.roth@amd.com, linux-kernel@vger.kernel.org
References: <20240815221630.131133-1-Ashish.Kalra@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240815221630.131133-1-Ashish.Kalra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0120.namprd04.prod.outlook.com
 (2603:10b6:806:122::35) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|BL1PR12MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a85b52a-61d2-44e4-594d-08dcc07cf073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDlrNHpzRGRuSUw4djFpRXVCTlpyRW1FRlh5MUE1ZERMaEhSQkIybDk4Tk5E?=
 =?utf-8?B?b21zR3RjQXhDTXVOSHhtd0xXK2VhOFFwcEtPcVpjMnhqVVZMSTNOVDBHRTQy?=
 =?utf-8?B?L0VuR0VCaTdzdmxBb28rSHUyQ3N0bk9QVEFlbmVxd2VveTQrc2FMZnFWU3lk?=
 =?utf-8?B?UzJqSTA0VlZRYUNwOXlHbi93K2p2enFvV2RzbXExeGlSSFJpaFdjN0VubXZU?=
 =?utf-8?B?dWdja2R5QlJnaHd5cnREMW4xQnIwajJ1YjJHcWxKR1RtZy9FZFVHZUhCQkFO?=
 =?utf-8?B?VGJjUVBFb0RFM3ZNUmxlM0VvNndTQnpBQnR5YmpwdmZsY0xMak9ZMHA3bko5?=
 =?utf-8?B?VkphWE9zWkxQeUxVSTFtMU04QzJZMUdIQTl0Ujhqdzl0S0NYRmdPbmw2N3h0?=
 =?utf-8?B?YnU5czBNRCtRMXRzdE91Rmpna3czTFhvMzlERHg5aWR1Z3F2N1RqZFJpOTBF?=
 =?utf-8?B?RithNmtPc1UyWkFlaEViS0tOSEtpd2c1Mmt6WmUzbElabW56Sk1Zb2JaVzQz?=
 =?utf-8?B?aXFTK0tBcjRFdHA2K3YxTHlWMUFxb3laR0pwYUg0bXVTNHNoWnM1U2NGdllN?=
 =?utf-8?B?ZmExQ2p6SVNPMUt0VndTL3cvaU1JUEZFTkhRdXA2aTNwd3JFVDk0czEwMUx1?=
 =?utf-8?B?c01qeDczWGxMT2xwUjhSSTZNUVk3NVpkSDRnSjV0KzF4V0F6NGJTWnBUaHE2?=
 =?utf-8?B?NER3WjhZU0tTRTJ5WnlNQno3bHRhTlhrTWdGSGNSL1o5b0ZQbjJUb0pwTTBD?=
 =?utf-8?B?V0RNYjQ3YnlyNXFTSWFiQWc1c1A2MG5zaWduU3A4aCtsS1lqYXM5bFQ3WXJn?=
 =?utf-8?B?L3hMaEU4alZISFY2V3JrUzZPd0ZUWkJzRW1Vc1pKWTBpNmJUUzJvSEpsUExo?=
 =?utf-8?B?TmdOVGk1ZHp5dHBDc2g5QXkrUDdHeklmUmZlUnJmQVhLd2ZvNnVrajZqM0ov?=
 =?utf-8?B?ejdwdkFhNHpDeDdiUFRUTnNFODJKTXhxQTV3VWQ3RVpNQ3M1TXVpUnJYa2Vs?=
 =?utf-8?B?UE1Nb3ZQL1cxclRucE1CN0wyRDFxUnhiZVJGMlBuM2tDWDdvZ01VeXVmOGha?=
 =?utf-8?B?dVZabzVJVHlTN1JuWDEyWENva2RuZitpdlFaZFM2U3dYa3ArWG1HK2lBbldZ?=
 =?utf-8?B?OU9FbTEvdk9xMFl3dzNjQ0NxUm9OZGUrUjFUMTJiMTltTkkrWXBSbGtsRWxi?=
 =?utf-8?B?cWR3SU9kM2ZGS3BFNmw0VEZmaUttRnphNXhvZlNpTGNSQ1A2WmZFZzYvWWUv?=
 =?utf-8?B?VHAxRWliK0ZsWk1xb1Q0ZmZhbWVuLy9vcHlqZFJJVXlIYXdmN0hDd1h3bm82?=
 =?utf-8?B?bStaTEZXNENLMlE5SGJRVW5qOUpDZXp2czNiTHQ4L2FvL1YrOEMzVnZUZnJr?=
 =?utf-8?B?RjhpYmpJT1Z1d0RUU0N6N2NvLzRmcXhHMnM1N0xaUmVDRlVDYVFodTBXTTFz?=
 =?utf-8?B?SVZWeko5enFVRUJwQ0lQR2lJN2trOERIOXo3TFNEbU9DSmNIVnpXZXMwZWk2?=
 =?utf-8?B?SEEzOTgwZTNsVm04SUFPRGVpeUEreWVtMG9SV0t4cjAvVjByWU9aS1FacEFE?=
 =?utf-8?B?aHZjS2lYcjQwam9XbGRBeTF4OHFXa09YVXNsMEVTdkt0RXdKS0VSbjB3THE2?=
 =?utf-8?B?M0o2L1NFZHJLRjAyVFZUQnozck96OFZUczZjMkV5YUhjOWV5eE1odU9HTUgw?=
 =?utf-8?B?c0huaU51aUczaVN3UjBpOEl1VVZ1TWs4RTBPd01iYVI2YVdiWnZucGwwb0h5?=
 =?utf-8?B?NUJrNTR5MXRaSVl6aHVkbmN2UGEzZVg1ZTNZZWV1bVdWTEl5Mk54cEpiMHJm?=
 =?utf-8?B?MnV1N2x0b08xRjVwUVpFZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFBmVHRPSXdCSXNuc3dNR3E5dUZNVzlHZ2UrbVVETFM1bHlZRENUMlpMSUR0?=
 =?utf-8?B?OG12azlNRDVPd3kvMDBOaFJ0VUFQMUh5U0ZPK2JzTG4vSnIyTUxFZWZKUHBv?=
 =?utf-8?B?TGIzWEI1OFBXdm81SHlzT2hnTGtTcFZ4cVBiYUcrbFRkMDF6MVBZWkdmYTZD?=
 =?utf-8?B?T3g2VVBNOTRzV1pYcUVmek5WTnhOMFFCNCtyN1BNWEFyTSsvSG9rQ3Z2SXR0?=
 =?utf-8?B?YWZ0bitYNU9PSFdmakJzS0lRZ0FHOXdEaVJhdzhhTkVzaXZ1a1dMdUlrT0h6?=
 =?utf-8?B?enVCMnJBdEhqUU01dFpvcko3bEtYWlNJcjBQMUgyVUg0UjZGYm1mVXlYMWlv?=
 =?utf-8?B?UmJxUXF1OWVmSGlrU1dUbUFWTWNHRzdHVVFTS0QrV096V1l2Y0taRmdlL2RV?=
 =?utf-8?B?U0JpMEtkMzBObFlnNmtIYmdkOGdaOU1CREpJRUljcTRVZU1LQTdWQm8zUitt?=
 =?utf-8?B?K21qa2Vxbk1ZdDkrSkpQMXVYTWkxTWszbHorSGtudzZVUGxCOVpLWFVjUzR0?=
 =?utf-8?B?RHBvOC9UVmZjM1ZubWxoUVRXSWs5TXIzbHJhZ0prWXZ3bkFHOGhuc1hHY0Z2?=
 =?utf-8?B?c0hJZDI1RlNLTlJLNVk4L3hKNmcyRVhsaHN3RFdXemhCQkIxQ1FDTU1Dc1Zy?=
 =?utf-8?B?RWhVTFgvYSs1STJxQlR1cWhLT0VRaDJ3NlVqYVBMVmlIZ3cwckZYN3A5S2o4?=
 =?utf-8?B?OVZVTVpEMGRUdi9CNmRVM1lOMTErR2ZWZHZsWVR4Uyt3NTJTdjNYK3A2U21B?=
 =?utf-8?B?OHBUUnhFamQ3QnozR1BVa1dSVUdjQU9vOUd6Nk44bThUMy9sNVQzdXVNYkd5?=
 =?utf-8?B?bm9UdUxLczlIN1RZblZ6dGg1cjNtTFYvYmRqOUc2cE83UDIvMDhSd2pzR3px?=
 =?utf-8?B?UlFUR0E0enVRcE03Y1V0RTBBZitvM3kzWHIxY3ozOEtUKzZhb1lmM2cwVEZY?=
 =?utf-8?B?MGZOUG9oQXZnUENENGU0eG5GYmlud0szYmdVUDJEL0ZKejlQMHZTV0RiWDlE?=
 =?utf-8?B?ZGY0dm9OZ3J4dHFESHgvTUhPNXhoamxWQ3FKTVR0K01BVGpTNzR1VU8yZmZ5?=
 =?utf-8?B?N0I0d0pXMXU1Z0pPNUZidEVjTURyTG9oNWl2eFpvMjZHd0RTenJKclN2QUtV?=
 =?utf-8?B?TnAyQ2FpRHNBYnZnSkh0Y1JSb1pIRDg4V2VrUU5OOHF4RWZXY1RwOE1vb2NE?=
 =?utf-8?B?WDA2azRseUk3a1dlNTBzTUlxZGIvTmFUbTFFb2d6eSs4dHY2UnhBUklEdkd4?=
 =?utf-8?B?YmhEMUxXL3ZZQ0tRckREY09BSjh2QVZPWFNSSmhIeThMQXViTlIwcFRWemxj?=
 =?utf-8?B?KzF0VFNxVVdFeWlnb2F1Ynh1SVlXd0VqdnNORlBWMVZEQkN0dHZMK1hNa2Ry?=
 =?utf-8?B?SFVXbXhIOHNWZ05NejBObENNRU5sTDB4dUZmYjZ6dXozNEpFSVdPTXFFOFJK?=
 =?utf-8?B?Z1VkUlpCZWRuaWNUR1JsS0hXN25BUk5kNjZVZGtHTGw4NXNnZkp6b1lQVS8y?=
 =?utf-8?B?L2xHZTlsMS9WSVphbDc2S3FXbDJ6ZEgwRWNibXJteWhjbEgzYzVPK08vVWVV?=
 =?utf-8?B?N0R4T1ZNY2ZvWkcwVEt3RmtQTVR6MW1EekNKUjh0NUpPQUdTMTBkVUVlMmNE?=
 =?utf-8?B?cnpPdVgwK1hSbTMxYVgwVTZ6TWlHcS9KZmlobmxNSnBHdzlmYSttRzdIYkZw?=
 =?utf-8?B?THlmVE42dHVSUS9LY3pzZ3dmUUhLZjJOMUFscW5OdWp3dnNxVkxGL2wyeU81?=
 =?utf-8?B?d09BYW93QVpDTVpEbHBQbXVieU94UlN2aUVoVEgyV3ozZEk1TW9EQkVWcytE?=
 =?utf-8?B?bnc3QW4xd3V0NzFoZktIMmRQT2g2cFdlYThYNjhYZjZ6WXpJclFnSmwybjFn?=
 =?utf-8?B?YjdkU3haUncyNXZPOE5YNVBrSTdUa1FySDhiSEJXRWlZc3ppMlhmZjF4NEZ2?=
 =?utf-8?B?SUFvdVVJRVF0WUo2MCswYm00MU51WlBvaUJ0Rm5PbFFMQnNJVnFUcEdvbFZF?=
 =?utf-8?B?Ym5XaEh6ZHFodHMvcTVnV2JCVFk4emk0bnBocEhKd0YxdmJzQW5xNGZMODZk?=
 =?utf-8?B?ckgvUmd0WGg5c0RMTXc3TXYvdEt6cmpnRndJdk9BN05YN2cxY3dLQ29HUUJm?=
 =?utf-8?Q?UU13oBS8JPYwe+OtKyMyt8Lj3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a85b52a-61d2-44e4-594d-08dcc07cf073
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 18:30:02.4019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1IdEYgdGwJ/sWWCZEOuVeudUM+XQ+Qycg10XptcbG27SG7Y1cQvgxOE16zccngYog7U2KBeKHKiq3aJyUlLtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802

On 8/15/24 17:16, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> The BIOS reserves RMP table memory via e820 reservations, but since this
> can still lead to RMP page faults during kexec if the host tries to access
> memory within the same 2MB region, commit 400fea4b9651 ("x86/sev: Add
> callback to apply RMP table fixups for kexec") was added to adjust the
> e820 reservations for the RMP table so that the entire 2MB range at the
> start/end of the RMP table is marked reserved. The e820 reservations are
> then later passed to firmware via SNP_INIT where they get marked HV-Fixed.
> 
> The RMP table fixups are done after the e820 ranges have been added to
> memblock, allowing the fixup ranges to still be allocated and used by
> the system. The problem is that this memory range is now marked reserved
> in the e820 tables and during SNP initialization these reserved ranges
> are made HV-Fixed. This means that the pages cannot be used by an SNP
> guest, only by the hypervisor. However, the memory management subsystem
> does not make this distinction and can allocate one of those pages to an
> SNP guest. This will ultimately result in RMPUPDATE failures associated
> with the guest, causing it to fail to start or terminate when accessing
> the HV-Fixed page.
> 
> The issue is captured below with memblock=debug:
> 
> [    0.000000] SEV-SNP: *** DEBUG: snp_probe_rmptable_info:352 - rmp_base=0x280d4800000, rmp_end=0x28357efffff
> ...
> [    0.000000] BIOS-provided physical RAM map:
> ...
> [    0.000000] BIOS-e820: [mem 0x00000280d4800000-0x0000028357efffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000028357f00000-0x0000028357ffffff] usable
> ...
> ...
> [    0.183593] memblock add: [0x0000028357f00000-0x0000028357ffffff] e820__memblock_setup+0x74/0xb0
> ...
> [    0.203179] MEMBLOCK configuration:
> [    0.207057]  memory size = 0x0000027d0d194000 reserved size = 0x0000000009ed2c00
> [    0.215299]  memory.cnt  = 0xb
> ...
> [    0.311192]  memory[0x9]     [0x0000028357f00000-0x0000028357ffffff], 0x0000000000100000 bytes flags: 0x0
> ...
> ...
> [    0.419110] SEV-SNP: Reserving start/end of RMP table on a 2MB boundary [0x0000028357e00000]
> [    0.428514] e820: update [mem 0x28357e00000-0x28357ffffff] usable ==> reserved
> [    0.428517] e820: update [mem 0x28357e00000-0x28357ffffff] usable ==> reserved
> [    0.428520] e820: update [mem 0x28357e00000-0x28357ffffff] usable ==> reserved
> ...
> ...
> [    5.604051] MEMBLOCK configuration:
> [    5.607922]  memory size = 0x0000027d0d194000 reserved size = 0x0000000011faae02
> [    5.616163]  memory.cnt  = 0xe
> ...
> [    5.754525]  memory[0xc]     [0x0000028357f00000-0x0000028357ffffff], 0x0000000000100000 bytes on node 0 flags: 0x0
> ...
> ...
> [   10.080295] Early memory node ranges[   10.168065]
> ...
> node   0: [mem 0x0000028357f00000-0x0000028357ffffff]
> ...
> ...
> [ 8149.348948] SEV-SNP: RMPUPDATE failed for PFN 28357f7c, pg_level: 1, ret: 2
> 
> As shown above, the memblock allocations show 1MB after the end of the RMP
> as available for allocation, which is what the RMP table fixups has made
> reserved. This memory range subsequently gets allocated as SNP guest
> memory, resulting in an RMPUPDATE failure.
> 
> This can potentially be fixed by not reserving the memory range in the
> e820 table, but that causes kexec failures when using the
> KEXEC_FILE_LOAD syscall.
> 
> The solution is to use memblock_reserve() to mark the memory reserved
> for the system, ensuring that it cannot be allocated to an SNP guest.
> 
> Since HV-Fixed memory is still readable/writable by the host,
> this only ends up being a problem if the memory in this range requires
> a page state change, which generally will only happen when allocating
> memory in this range to be used for running SNP guests, which is now
> possible with the SNP hypervisor support in kernel 6.11.
> 
> For this reason, this patch is not being marked for stable, even though
> it fixes handling that was introduced in kernel 6.9.
> 
> Fixes: 400fea4b9651 ("x86/sev: Add callback to apply RMP table fixups for kexec")
> Suggested-by: Thomas Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/virt/svm/sev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 0ce17766c0e5..9a6a943d8e41 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -173,6 +173,8 @@ static void __init __snp_fixup_e820_tables(u64 pa)
>  		e820__range_update(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
>  		e820__range_update_table(e820_table_kexec, pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
>  		e820__range_update_table(e820_table_firmware, pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
> +		if (!memblock_is_region_reserved(pa, PMD_SIZE))
> +			memblock_reserve(pa, PMD_SIZE);
>  	}
>  }
>  

