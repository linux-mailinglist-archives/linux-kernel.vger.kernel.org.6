Return-Path: <linux-kernel+bounces-340811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356A6987825
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2EEE2859BA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A194158205;
	Thu, 26 Sep 2024 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FGWALZGQ"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87252837F;
	Thu, 26 Sep 2024 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727370421; cv=fail; b=J14Id1TJdZqYg5W4P1zGM6zT3NVjxjRifHznMQmY8FvVJ9EDRNZzUd6H9cs5cKkA5so6le7OwbRulIJsqaTcIN/RbNF5QUHkPLKaSxYX+l0ZNQ48AlDlkxilpasdmYk9FkSK9J0AzeCx2oC7VjlHD0L0NHsfYT0P7UwWzUVOczA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727370421; c=relaxed/simple;
	bh=lyqP3JL/Mu0HN/Y73OiJKFTWXzYL1UYW/TQz5HgVZj4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T5pZ/PShszfSQy2l61BOx0Cz9qM2c1d9dzbNmGNPEOgca+Fk+t4H6Bnz+UCrcK5vrzG1NDXmNmhTXJJMPp6//QYLpWwVtnRc8VNxU8n0VAqzQMY0ovMjL73rm8xi3oX4+Y0mvxVJDb2vHalD50w9xo11oOd1t2AF9taopnCDkSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FGWALZGQ; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kn37Bo/ZJlJGLD82Ct01YWqA+FI2qEQ+K3cH73O1XgaWF2HcR6qS2jC95AXRt6f0eL5rpxUCXexfO2RmbGjbpWC2iNjTX5YDN69ApkSA1dL0olfG9gStqZpEBfxe8Oq1BaWQnYbMo6KvGPkVbAbmkw6nui52+69sYsDQCbfggXK7F9tBm8gCwPc+AeEasozyrndOQK11fBzvLPbJLr1AnN5f/bj7IOPDdOHivMQMMeYj2e9fhWqusbK6nLE2cXJZWty+i68p+yJft80ooYiIRbYmXnXzvZ++ygahjwBakzrLhmRk1QHCmzxXZjSNT4lVB/uaaYgB355JFEDN3jyxNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oF5XRgrEkA5a+G507hr0QO+RLmSq0NbOKo6QMS6HC0=;
 b=yY/5w3HDw8VKtXL4PAU53CsgLnBsAaZF+F/hDqz2/+TyjIzRgQyP8K1c8AFRpsdFtg75Nq93EwIczv3FGfw61gJ545ARaXN0tWMDLBBya3i+aROxkde7oWQNSs4BlJTi51d/cog7hv6nc0WlgaxZzk3yOvKmnNEUI1gVXTre6n2dDkjsb4CB0i/eXGSv30Yc9N6a77RzwrknC+iIxic/JOjS/WkcfMupSgr4mfrWIVbxt5XZVZYjcRnxC1CIHot3jqpi7adtjF9KHq09gBxOND9817u7RRzZ3Dxegiu+VqsxkUteXSC0lJne7wG1bH6VUzwyLAM4dpmOM+Ur84J5sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oF5XRgrEkA5a+G507hr0QO+RLmSq0NbOKo6QMS6HC0=;
 b=FGWALZGQ1ZqVzmlwQEEohcPNXLFGKHLeAyW4uX3FkF3WY7XccidQkOk1YAbc30mNoZstLBPQAbFPZ4osCzSQHxg9p243cxyQuHPG6gV4C545P96ftxKi8au/qB+tbZ4d0GjJIBsUCIwN9F1f6dZm6c7mrIjEaStGLJ2c8z/0g0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23)
 by CH2PR12MB4072.namprd12.prod.outlook.com (2603:10b6:610:7e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Thu, 26 Sep
 2024 17:06:57 +0000
Received: from SA0PR12MB4447.namprd12.prod.outlook.com
 ([fe80::b4ba:6991:ab76:86d2]) by SA0PR12MB4447.namprd12.prod.outlook.com
 ([fe80::b4ba:6991:ab76:86d2%5]) with mapi id 15.20.8005.020; Thu, 26 Sep 2024
 17:06:56 +0000
Message-ID: <52753566-147a-6862-b059-622ec2b7de41@amd.com>
Date: Thu, 26 Sep 2024 12:06:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 1/2] x86, KVM:SVM: Move sev specific parsing into
 arch/x86/virt/svm
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Eric Van Tassell <Eric.VanTassell@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
References: <20240922033626.29038-1-papaluri@amd.com>
 <20240922033626.29038-2-papaluri@amd.com>
 <776effda-641b-d504-9aab-f56d862b79dc@amd.com>
Content-Language: en-US
From: "Paluri, PavanKumar" <papaluri@amd.com>
In-Reply-To: <776effda-641b-d504-9aab-f56d862b79dc@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:806:21::28) To SA0PR12MB4447.namprd12.prod.outlook.com
 (2603:10b6:806:9b::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4447:EE_|CH2PR12MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: 45977ee1-2284-49ba-9fa1-08dcde4da014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnU5NkdJOWs1aC9aK3hPdDFwQ0JLcGFRdjZSK2hUQ08zSU9HdnRuUXU4cEs0?=
 =?utf-8?B?RnF2R2xBSzNiSmIxN2l4QWk3UThvbUlZbldoL2d4a1VqWVhjQ05ZNFBvSEtR?=
 =?utf-8?B?cDA3bXdtSXEySDV5b1R2THNQTUVIdGhKRnhOc2NZbHp3R3FqRUlKQ3dSTExp?=
 =?utf-8?B?eFZ0WEZZUnNadzZhSlJNazJVSkhvaCtJeXRxMmlCbHBKUW5RNDdMVHVHU2Np?=
 =?utf-8?B?T0hVSHRVWW5jeEFLaGlhcStES3o0WmtWeFFrMi9lb2JTZGdlY1ozeEZLdlFy?=
 =?utf-8?B?bFJINGJFNFh3cVNxMS9MTWZ4WDZyNzdiUDRuQmd4OVYvNndjbnRVTnlHYnlX?=
 =?utf-8?B?cTVvcWJBNkF5bFlVUXNrMDVnUDI3WTUyZlo0eVlGTUYxREtZWGZBdm13cXBp?=
 =?utf-8?B?VklrWXUyTUUyZUx4R2t2TGNmRmFWbVdFVzNha1M0L0F1Qjl2WG85Y2Vac251?=
 =?utf-8?B?UXVPTVR0ak1LUzdhT0JHcjIvV1FXbTh1UUgxZHVHcm5SampWK3VGdGxRT3dE?=
 =?utf-8?B?c2VLQ2huUldHNE5Kck9BQUdnNWtML2FlM3RNM1ZtVFJ0UWNDZ0FaamFONlFa?=
 =?utf-8?B?VGhkYitwYnZSRThaNWQ5Yk5aTGI1NEkvK09ZVGlsQWo0QzhHcFBJcDJFUUNl?=
 =?utf-8?B?UHN4OHBpa1lGWE8reWJUVlBxSFBXRi9xZ1pqVXhpdzRWbkVyTXQxdjI3Zjll?=
 =?utf-8?B?dFkvVThrRlNLOVdxakRMODRVSHlEWVZ0U1dCZnppZXdLMjdsMTRKRFBZWGdx?=
 =?utf-8?B?ZlR1NkpsZTZNd1VnUnpDQUwvQjk4akRJMWNwN1kxbFRSQmkzekthamhCaFg0?=
 =?utf-8?B?MEtFUm9TNFBMQWxKQWVJTFVwTjIzOUhaNU4waE01UnUyRFZ5dUR4WmRjUjcz?=
 =?utf-8?B?TU9uTWZ0NWYxOTJDSjVnUWF6dVRaREZjRzFhbU04RFM0dzlZQ29mQVZDakt4?=
 =?utf-8?B?QmdyLzBFOU9MV3FERXg4YUpPM25EUVNqQitHNVdrKyszUUhZNnNFTE5FSytw?=
 =?utf-8?B?QjU0NzRPR3dNcmhTM0pHRkRBb2ZBV3dFMkZ2MkhRTk5TQXByUnBTL2FXR0t5?=
 =?utf-8?B?aUZtSWE3N1VKVTJqZnNEMTBSVHFIaEtmOCs2My9OTVBEYUhIbUF6YzF2RDd3?=
 =?utf-8?B?aVZRaHdsc2w4eHBzVXNTTTBpaTZGM2dZUUllbWFuNndEVjhGYlhnK3VXdDVh?=
 =?utf-8?B?Y3pXbUViT1EzbUt2eFBPZFVuTmRCdFY4R0dTc0FJdVU3a0JLaGU2ZlZvRnhq?=
 =?utf-8?B?YjJRVDJTVEJESTJCZWRIWmZhcDd5VmoxOE5mWDd3TUhXKzVnOFhWLzEwUzdx?=
 =?utf-8?B?Q3phUDQwZVIyMUh5cTQ0STZBdGxrZzZkU1VicndsaXFVbmNsdkdPeERicjRi?=
 =?utf-8?B?L21Vb0Fhb29HNDZOVWlIVnE0SW9vLzVhZytQamRudFZ1QVZNYkNTSk45Qk1w?=
 =?utf-8?B?dDJnV0ZrTzBzMGYvQVJNamp3OXBLQ3ZnNm1ZUWJadEQyL3ZDM3VmeWdsVWRQ?=
 =?utf-8?B?VUtQTGFyK3JjcXhuWVcvNERuSEsxMEg2NkkyYjVYRDN0THllUTQrY0pBY0pE?=
 =?utf-8?B?Z0NQNWdRNCtIN3NXU1BpRWo0R2w0bkpGVW5mTTZGVkE3S3JkMDFWZ3RMQzRF?=
 =?utf-8?B?YThET3haMTRGU0p5Um04L3NubkdBTzNPTVE4T3I0OHpYSFJhZXhnYWVGOFFH?=
 =?utf-8?B?ZU9BSmE5dnhBeGUraWtQRDVEbHI2bkUwNjlkcXBCeExRTEFyUXp2UmhkUjI1?=
 =?utf-8?B?d2xVZXZ0TkorSEVxNHpybGw0NnFKK3ZKc0N1Y01qbWU0ZFNQQXM5VDk3Rlly?=
 =?utf-8?B?ald3d2FoL3hlVEJXdHBNdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4447.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXhqWUF5TUltTi85MDJ4b3hSUXU2d1Q5L2JwS3VVWlBYSGJ3Q3B0R0FmSnpq?=
 =?utf-8?B?OHZidkxiRXA3RnJrWGFxdTByYThUVmV2Uk1ETkMxZ2lJQ0ZBaEMxQ3hnSDA0?=
 =?utf-8?B?YUNXMDBaVXhWOEtXZDRZaitTUkNra1BQOHdjbHdJVVVLVmVzU20rT3lZOGxR?=
 =?utf-8?B?Z2cvV2tPZDAzMnQ2d3k5eDE4blJwRmt0dlZ3SXM1ck1UVUZRRnFacjJQYjVk?=
 =?utf-8?B?ZXFXdW5HSHNYdXhDTFZWb2ozK0tCVGt6VzR0VURGaW1aWStWN2w4bFdLK0gr?=
 =?utf-8?B?bE40dTAzVXJXd09aNGRtVkRaRTNNbkt1SHE1RW4wS3RjNWM1bExxMG4wR3ps?=
 =?utf-8?B?K1BLNGF3ZzM4OFo0ZEp2VnhaTTdHSnpibkVMbkJ3SGt6TjVTTTBwV3NkVWZV?=
 =?utf-8?B?V1kzQU1wajYvTGhvOTF3ZTJMQXRwc2dXTUpkcUVtaUhUd1Nnd01JNElYQW9B?=
 =?utf-8?B?S0t4ajc2VEo4cVpVRXM0MDVYaVZXdk5pcTFMYVNsMzZXUVlzQ1Rnc1lTNHNC?=
 =?utf-8?B?dnlGMTdEZkVqd3J4QXFmMEdXT0ZRSWFKbkY0cHVRNEtHOTRDYnlzT3FBeXNh?=
 =?utf-8?B?VGk5VTBFMzdkT1NJOEszcXVHTVcrK2FaYUl1dzBiWnRWWERrUHRxdFFzaFlO?=
 =?utf-8?B?M0kveEp2MS83WGEvSXJrdFpwd2VJUktTMDFTNyt0UXU3QW0vR2g5YjZta3Jr?=
 =?utf-8?B?dTcyTkZwYUZubFJXWWVQYjRuWHZUajFjV3B3NmxUWGdDR0o1MEt5OEpEcm1L?=
 =?utf-8?B?Vi9ucVVvQStRTEtIclZydTlNQ1ZMeXd4QWZFRzZ3VUZySVJVWmN1RWQ3UE5o?=
 =?utf-8?B?NUpTOTV1V3YvYnA5Ly9lVXpuM3cvWkpKUWlLeWd1NEl0VVNSTDNFeUZJMTl5?=
 =?utf-8?B?Nm5uUEpzWDB2K0lTcCtYSDF6Y3hCNkVCU0hyVTNTeXlJNWU5aENFeVhsYXQx?=
 =?utf-8?B?a1ZIcFlOM3Axc2w0UEVYRGd6SElXMXZnclFJNy9heWx6TENXeUZ4YW1pQytu?=
 =?utf-8?B?N21namw2N0RwVVEyaExJdWFpLzZ1VHJpczBpTERlT3VxaWdyS0I4b1JwRmFQ?=
 =?utf-8?B?VWxManRFaTZGUlJxb0hQUzJyWHlSZDhpVWhFK09GYkNuLytSZURGenZxa2RF?=
 =?utf-8?B?MHJQbUdkN25OOHAwN1VqOXBTZ0NnZU93L1ZLOWlSaGR3Z2VORk4xMUZoTUxk?=
 =?utf-8?B?RXBzVEhVc3ZCY1lTS1crd0hXY3VYN2VZeUo1ZU52dXNvbXF2N2NobEVpMUxk?=
 =?utf-8?B?azdzcVR6aWFxVERqVnBXZWhWdzM5bFJraU9URFl2dWsvZU1lbWd3TG16enEz?=
 =?utf-8?B?UXlOYXdaSGZjR1FlVVdsM3lxV2M5QlFPNFlSbGlaSWFKbmFTbkVTY3hQUlBW?=
 =?utf-8?B?T2hTMlpKYURoNkw4Si9LanJKOXQvZWROT3M0eDJnV0FiMEYzMmsrdnVkaWcx?=
 =?utf-8?B?Yml1TjQ2U2FZZko0V3FaOHhHUGlZdXNHRTA3VTdxdnFEWXg2a2xrcDhpQlY1?=
 =?utf-8?B?cEU4V0tOUFJZQWt5U3dpVUI0Z1ovZUY4eGpENzVrcWR2em1TZ0ZUaXVMUHVN?=
 =?utf-8?B?clI1NkxGMDFEeGF6azVBbG9IdWEveWM2SWJ5Q0FmRFFPMzUzSVpSZ3ZBTElq?=
 =?utf-8?B?MDdiNWpLZXYwa3RmNVV3RHB2WXE1Rk1wZmw3RzVJVU80ZHkzVTZDenZiemt1?=
 =?utf-8?B?d2Fkd2pXQUgrUzM0RUdYRHBoK0E2ZUxuL0FKWGtjcFVvZnZwN3BnZnZDSTI3?=
 =?utf-8?B?bmZnUVc5UGQ5TDZUb0N4SElVZW9BZ2RWdkx5U1ozUjFXbytBbmgwLzZqamNF?=
 =?utf-8?B?dllXVzNuTHJoY1RscUhldU5SRGdqdzdDSWE3ZWlTMkw2V2M5NDI0RkVETmpU?=
 =?utf-8?B?NWExbGtZY0JDRlJMYXZJdURUM2lZaThraFNRaFg2UnR2MGxVN3lwb1d2Nndy?=
 =?utf-8?B?RXAwbXJSRVluRkFnclpRUlgxbnRJOEdHRzRIVVJWYVpRc2dNQUlrR3NDazJs?=
 =?utf-8?B?VEs4UjdLcnUrcmlHelhzWWFwMlN1Ulc0SHZESXVBVDVXNHkydEdGako2UmV3?=
 =?utf-8?B?RWM0MHB1SUwvOEFIckFuY2xpT0VsWUlqakdtZmh4aDBGNFNWLzRPMndqenpT?=
 =?utf-8?Q?+0WJGZA70t+E8FHAQwENGwaFI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45977ee1-2284-49ba-9fa1-08dcde4da014
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4447.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 17:06:56.8910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1OuQYYEGco+EvL6Wuy5nkSxj+S+vt+FOyUQB9KxqjFegx8G4hTXsaxjIpUbaf7BS0zvsQ1yUYY4A8XRLkLa8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072

Hello Tom,

On 9/25/2024 10:57 AM, Tom Lendacky wrote:
> On 9/21/24 22:36, Pavan Kumar Paluri wrote:
>> Move SEV specific kernel command line option parsing support from
>> arch/x86/coco/sev/core.c to arch/x86/virt/svm/cmdline.c so that both
>> host and guest related SEV command line options can be supported.
>>
>> No functional changes intended.
>>
>> Signed-off-by: Pavan Kumar Paluri <papaluri@amd.com>
>> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>  arch/x86/coco/sev/core.c          | 44 -------------------------------
>>  arch/x86/include/asm/sev-common.h | 29 ++++++++++++++++++++
>>  arch/x86/virt/svm/Makefile        |  1 +
>>  arch/x86/virt/svm/cmdline.c       | 32 ++++++++++++++++++++++
>>  4 files changed, 62 insertions(+), 44 deletions(-)
>>  create mode 100644 arch/x86/virt/svm/cmdline.c
>>
> 

...
>> +extern struct sev_config sev_cfg __read_mostly;
> 
> So I believe the "__read_mostly" attribute really needs to be on the
> actual declaration of the struct, below, in cmdline.c, right?
> 

Yes, I will move this attribute to cmdline.c

> You can check and see which section the sev_cfg struct ends up being
> placed after a build to verify.
>

It is placed in .data.readmostly section.
0000000000000000 g     O .data..read_mostly     0000000000000008 sev_cfg

> Thanks,
> Tom
> 
Thanks for the review,
Pavan

>> +
>>  #endif
>> diff --git a/arch/x86/virt/svm/Makefile b/arch/x86/virt/svm/Makefile
>> index ef2a31bdcc70..eca6d71355fa 100644
>> --- a/arch/x86/virt/svm/Makefile
>> +++ b/arch/x86/virt/svm/Makefile
>> @@ -1,3 +1,4 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  
>>  obj-$(CONFIG_KVM_AMD_SEV) += sev.o
>> +obj-$(CONFIG_CPU_SUP_AMD) += cmdline.o
>> diff --git a/arch/x86/virt/svm/cmdline.c b/arch/x86/virt/svm/cmdline.c
>> new file mode 100644
>> index 000000000000..964677ab02d6
>> --- /dev/null
>> +++ b/arch/x86/virt/svm/cmdline.c
>> @@ -0,0 +1,32 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * AMD SVM-SEV command line parsing support
>> + *
>> + * Copyright (C) 2023 - 2024 Advanced Micro Devices, Inc.
>> + *
>> + * Author: Michael Roth <michael.roth@amd.com>
>> + */
>> +
>> +#include <linux/string.h>
>> +#include <linux/printk.h>
>> +
>> +#include <asm/sev-common.h>
>> +
>> +struct sev_config sev_cfg;
>> +
>> +static int __init init_sev_config(char *str)
>> +{
>> +	char *s;
>> +
>> +	while ((s = strsep(&str, ","))) {
>> +		if (!strcmp(s, "debug")) {
>> +			sev_cfg.debug = true;
>> +			continue;
>> +		}
>> +
>> +		pr_info("SEV command-line option '%s' was not recognized\n", s);
>> +	}
>> +
>> +	return 1;
>> +}
>> +__setup("sev=", init_sev_config);

