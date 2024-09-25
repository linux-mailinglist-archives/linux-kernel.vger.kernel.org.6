Return-Path: <linux-kernel+bounces-339384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB182986448
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198E81C26DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A07D1BC58;
	Wed, 25 Sep 2024 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nnZxmSwV"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21351B963;
	Wed, 25 Sep 2024 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727279855; cv=fail; b=IfS1pabzqMY95l/GJe/bTvHLda9tdu85Bkvs+HLg7jY+kKRwV/hqIWBjh4vRpf8LhO26lv8oyIBHJFPr99HjSnqGIyKSnJTgC6NWnRN/d5ZMPxfNS9XnQckpWwlEXdU5Z9VdOWfCGvpEvgd8lZS1yYHip/1GSFYVAS/1lg5mNa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727279855; c=relaxed/simple;
	bh=iQXVI4vDfEw72wOWxJ3CNZq8Ew0uEMjLZG8jzLliMSY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WtSauSkS6RRe0n4bUxFnw7z3Tmbn+fOt7XpP33jmLGEdRBgepD8q//0OBbQCU01cwHLhbVrR0d9A/7nTl9PaKQ32RcDNiS5m7zSSMX1R1TqOX5ReFWtyGz3m35OLWlss4xaPFtbSYmpCV/BW8yEbYMC/6n3xflbMGpn2esPonYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nnZxmSwV; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRNAzQPNqybPbWxvDp4W5XxtwStXtNtRPN+FWrWLKAwdNPSFLX636bwonEyrq3KnKztKqZivC0P8d+E9k7CZQhFC1SaJF8D5/Ofva4d7yiGWzC+idE3sk0B4+xSLzBMMfAcJ8cmjTgplPLdAetL88Io9QeatsQwlTrlwxiJiFI3M8VOS4RFawnPY58Btu8PztSczaRDGGYb35umpxPFnqNsOABjT0UF7h3g8fFs8kZo3OP73Mk6iXonDGK5TnhwQCHmq2AdcX/xhrmtviDoeN9r0tISU5ljTV9GbPOozmkFVmBgU5JitNFUMHBublcEcnDxqWNHux6LbF6Lw2vc7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/aJ4cly4XHgrwUhEDa8hrHARyI17Y2eGwooBAiUfmI=;
 b=ixHFuf9IFFr2GM1qIR3Q3JbCfbEJFresKqhiX5SkuaHcYFn6h5qMKOrukA/lNFrvOCdqozEO//HInqpDNUXNBfUmWPunCDR43Ua4GOrxvYfic8J4XKyMXD5B14RrayhUtiPu44bje2GwhWsMY5r508esKemIdgNE7IxZKkZcC3SVkqThhwZCFiBmkwUZDiQK10FCLK/BbNIqIV1VBssSoF7o5zVrhQkuvyPmEsGMUgkjtQ848lx7ZgKJNmTTxU5sD7v8lFFB9ec+mV/DfFgE4yIZot0DN94/31AydywXc1xCAbhQtvgkcaE/WzWsjX2zkTCqNkvRNyVcW7ohzeg73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/aJ4cly4XHgrwUhEDa8hrHARyI17Y2eGwooBAiUfmI=;
 b=nnZxmSwVyQxfmc3nCy7KZh9qH162p/K76tECjjwwj896w6J4DMHgp3+/5rcj5r61cIR779QXT2kzm0l3+N+q/0JfN1yFXa8iYM/xUgoZs5jlhejZKiUyweSdfkXDv2vWlxmiORSkBRRJob/ktI6I2frohhv3QqczC+/BbPZutVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 15:57:31 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 15:57:31 +0000
Message-ID: <776effda-641b-d504-9aab-f56d862b79dc@amd.com>
Date: Wed, 25 Sep 2024 10:57:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 1/2] x86, KVM:SVM: Move sev specific parsing into
 arch/x86/virt/svm
To: Pavan Kumar Paluri <papaluri@amd.com>, linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Eric Van Tassell <Eric.VanTassell@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
References: <20240922033626.29038-1-papaluri@amd.com>
 <20240922033626.29038-2-papaluri@amd.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240922033626.29038-2-papaluri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0131.namprd05.prod.outlook.com
 (2603:10b6:803:42::48) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DM6PR12MB4217:EE_
X-MS-Office365-Filtering-Correlation-Id: c12d2bd8-d1b5-4da4-2a55-08dcdd7ac30d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K29mSCtlY0dTMmV3T09LdDJJKytLeWdDdHVEcjg3dTl1L0pPZ2FIa2FNNURo?=
 =?utf-8?B?dENXMVVvUUtmVHkwWDhLWUIyUm8wK2N2aWhwOEx2aTJ0RkYzdWsySkl2aFky?=
 =?utf-8?B?VmdDUytIdGtOQ21tSWpVTFI4SUJER3huTjhmQ3FLdEhOc1lZVWIwSGRPRlJS?=
 =?utf-8?B?YmYzT0sxNXRyaEpkbG1TWEc0dzNaYlJxQmgwQXJWUFdpVWxIbi81TG53U1pM?=
 =?utf-8?B?SDBBVHFqR2dNaytsRTY1V24yS01xOGpGUC93YStPWHplaTJyNjEzTWpUNVV6?=
 =?utf-8?B?b2J5SWdqRk5ZbDU0NFlqME5Ea0h2akNpY1BPdjNhVjUxU3JWQjREQ1grdmx1?=
 =?utf-8?B?WmxSYi9uK043QnVBaXNubm4zbUdQNnVIMS95NXI5R2Z3UGdqYlBRUEhqcXhW?=
 =?utf-8?B?Y0hSNDNoQm5ROTFobk1ZM2c4dEhnSzQ1dW1mSHR1T2pkMkhkRnhqdm5MM1Nr?=
 =?utf-8?B?dTZsMlRqUytieUFPWWUyeHRuNGc2NGwxUEJYNDJNY3p6ck9yOC95Z1Y3blVL?=
 =?utf-8?B?elFyZXRoTGJlSVNwYVhNVzlOd0NWQWpkNWlMenp3QXZzT3d1dlgyM1RGVFl0?=
 =?utf-8?B?NkpwdFBwTWtWNmVKcFI3dzJlemU3VTJBb3dkMmlUN01aa0dIbEZVYWNRa01r?=
 =?utf-8?B?VUxBL0FlSkF5VVg1ODVyb0VSMmNISWJvNDljUnJyeGJZS01KUVlvdnpLTTM0?=
 =?utf-8?B?UWFHaXNDTGxuMGtWNUlaUi9wcjlGb294WFhJMFZ2TExpd0swN25JS1ZNVkJo?=
 =?utf-8?B?SDdTZkdLcC9CeUdWcU9jb2ZldnAwaytGbm51ek80aHBPbnUzYVlkNlVQcGI2?=
 =?utf-8?B?NGJxSzJTaXRKRFVjT2dQTnM3Nnlzb2MwNjRTbW4zdE44dUx4a2JEaTRrRGdh?=
 =?utf-8?B?ZjF0Z2g2Unl0NnhHeXJQMzBscW5XNGFxVjNWT0xrT2psVFNDSjdyNzl0OURz?=
 =?utf-8?B?S2JZcXQ4SVFOV0l6ZHpVNHlvVWtBWWJsSkxLelVUc3JTV29lWGVydTNSZm1Q?=
 =?utf-8?B?ZmIvdGxIQnRyRW4zRHNHd2NlUVV3R1AzNCtqK3BwcUs1WUNQNm0ydUpiVHBH?=
 =?utf-8?B?eXc5MHJLQVBaOHliL1VpVDF5WnlBcnlIenVoY0FhQTNsOEtyNHNJWlFoWnFq?=
 =?utf-8?B?VXB5dzdkWHhGYTM5QjNQM1pMdzJDWmpWMk9ucUdQMElhOHUyMHNrYi9EWFcr?=
 =?utf-8?B?bzBKc3NXREpmRGtlbmRvMTZydGMrWW53aHU2bHpVeVJHbXUrN2ZVVFRLUkdP?=
 =?utf-8?B?YVgvWFZONWtheEVmWWN6VlhTZndXVHhqdWNJU05GQkRiVHo0cmQvaXhKczRK?=
 =?utf-8?B?TE9ka080cno0V0tpNm5GbWVtZGlUTXNCYTlxR0p0N0lNNnE4NkRkT05qckVu?=
 =?utf-8?B?MitLdURhMkVJeWFRZ0hFazNBdkVyZ1FQVVpSbzVhWWl1NDlGQ0d4ZGY2WGVF?=
 =?utf-8?B?MVZvT25weXp2T3h3aWZHMmV3U0drR0RzL0pxWU5TZVo4a3QyRFB6a0I0U3ZX?=
 =?utf-8?B?QmZtdDVlL3JvaklWbUZNb3VlSkwvdTY1ejVSdXZQU2ZEbEk5WjBCaktmZ2pw?=
 =?utf-8?B?cVFlZmxjMms2dnV1K2RGeGQ4TTNjVHZtL09JdzBsNG9zSFdmNkttczZkaVRk?=
 =?utf-8?B?ODc3YzQyTTJDbWd3ZjA0bXhyVE1KYnVPajB0SnlHeTYrcW42QmxRclIzay91?=
 =?utf-8?B?R2VJQTYyWDFtb25tZ0pSaU1xYWNqT2s3dTk0K29MTGVxWjBxN3ZYeHp3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFQ3VGJWQjEwd0lFK3JNRENEOVdPbzdUTzUrREpYVnhoRnpLUFdVdVRFVXdP?=
 =?utf-8?B?aWhTc2pXUkJpUlhnRW1Gb3BUTklvdVJ3bFNYaDgrV0J6YU9XZ0FrY2dQZDJC?=
 =?utf-8?B?U3BKWEFIeXR0aW9VWERTMzlTSE54elk1cVp5TEZLRThvT25nSDNtYTlQMzdO?=
 =?utf-8?B?bGNrNUEzN2E0NkJPdlZSZG1xK29aZ0dJUUt2a1hpcERpTU1Ka01veVFYaUlP?=
 =?utf-8?B?dGVUd0pEdzVKeGdDN1lTd0ZudWs2cDV5V2JWSW1EQktnSDlUOGZqZlFzTkdE?=
 =?utf-8?B?WnZXZWNwOHB1eENNV0c1cVo3dUtjSzVHZnZsVUUxNTA3SzE5RkNTcG5zR2d5?=
 =?utf-8?B?cDVVNkJtUXdVTGZCS1Zma3I1dmpQRlhldmpXc0N6OXNxU093TW03T3VmY012?=
 =?utf-8?B?QzhjZjFuMWMwK0MvSkpHbUg4b254RGk1TVhUN2ZxaUEra3RkZDFkV2pVM0dV?=
 =?utf-8?B?ZHdXc3hRK1dRSWlSZTRGWWRsdW9BVVoxZUFqekV1K1o3NTZzemtsMWo1UlFh?=
 =?utf-8?B?SDlHV2RtQVprTkFNcEFJblRRWlJIVWVqSmR4ai9tTktncjZqcTNhVlU4TUVl?=
 =?utf-8?B?QTBlbWtydmJ3NWRlYkdtM1I1MTluZDQ3eGcyeW1zSlNVQWF3NUdUSGdIR2Vt?=
 =?utf-8?B?VFdaVXB5L25BNFpnWUVicDBESi8vZENLRENLUFRRbndZTk9OazFYSDkzRXZu?=
 =?utf-8?B?MzNNT0NVb2I3eEdwbDFrNFJGTUdwWVE1UXFCZEdqUVhjdDVwOXFkN2hYcWk5?=
 =?utf-8?B?SUtaallyemZLbSthVGVQQ0tpV2RKRlNIVjlWL2dJSGFER3l1ei9rRHdBV29C?=
 =?utf-8?B?OXNCSGtXM3J4V0FQSHFoOEVuNG5OMnorZHZSb0ZhbjEvLy8zc2s5R0hJYUw3?=
 =?utf-8?B?akc1TEVSRUZOMlJCd1J5Y01BdEoxamJJK1ZPWGRJWHk4QWF2QnVDQVFVMzh4?=
 =?utf-8?B?aTNUT3V6Y0NXUnF3cVk5MG5yMzBMVjhqaHJwN0lhMyszMkJCZDFDYlJnWkJY?=
 =?utf-8?B?ZWI1VDE1SmpvMUh2amh0UHc3YmNaMjN3cXI4UHU2MkxsWkVrdExaL004Mm5k?=
 =?utf-8?B?TmpFZFlOQ2N2dkF6Y2xxdEdOOVFDVk50R2wvcCtudXg5bU5ZMXVrQ1pucGVu?=
 =?utf-8?B?bXplWHRTVlNBOWpkNDVnM0lSU0huU3FUdlNMbU0yYytPbDdzYlN2cWh0cVZ2?=
 =?utf-8?B?UUVwRTd1Yk1rVUw4TWhTbzZnYUlZb2pVdEhxcEw4OHFyeE9FVUtYbTR0YUZJ?=
 =?utf-8?B?a2pNS09Ld0VqSFVhOUh0UHB1dkNnajlrNEtnT1RnVjAxaHhiR3NmLzN6VGtP?=
 =?utf-8?B?eUtZVGZValVLWXppbWRJSi9LVXNaZGRjOTRhSUhjRUtyS1g0Z1NFV3l2S2N5?=
 =?utf-8?B?Mm1XZjFPOUtab1g1UGdIT292MnUyUnhIdGt2bTJUTUNRQ2NKZklRN0ZlU1oz?=
 =?utf-8?B?NUMrbm1YbGNQc2Z4UjdhYUZGbGFoRkhJVEF4NTZGcHZFWG9KMkNIZU82Nzk1?=
 =?utf-8?B?OVl6SFlpU3BGNS9obXZNS3V5TkRrREZoY0Y1Wm91amh3TjhwbFAzYm1NWlJL?=
 =?utf-8?B?TW9QdnozVVZzUXh6QVhnYlE4dHVCV0F3WUJ1c1Y4YkZWUVhWbkx1RVB5QWpT?=
 =?utf-8?B?djNoenNoOGhnVit6T3hxdFhJenZud05Jc0RpK2pqeldKT1RpWVNFRnhNeCtO?=
 =?utf-8?B?aTFzb2FvWllwOGg4djh0VGlTM0JlQnpTMmlaZ044c3dhUDQzUkd2L2JydUF3?=
 =?utf-8?B?cGE5RXV3bk9IWmkzRGEvYXJQajJ6Z1U5TEZIMUU0WmZ0MjFpQ0xnNFp3eWlQ?=
 =?utf-8?B?OVRzdFgzemIzdUkveUk0Q2lTK1dzcnN0ZUFoN0pOTHN6VzR4WGhYNlBUcDZo?=
 =?utf-8?B?TDRod1c4KzBaUFA0UWp2cFZrTFFQcDE3cEFoNXpqRHpKcEpXZFZoK2M4YW9Z?=
 =?utf-8?B?SWZZbFMvdGFXUjFwMkRVWEdqVWdtM1hRUGpmMW1sYXRQTnMwMENJUTBKLzBR?=
 =?utf-8?B?QVhXdTVpc1dRSm9LK0ZQSC95dnZSMkt2TkpmcU5QalYyam8zM21tbDF6VWF1?=
 =?utf-8?B?K0luc2RXR3U1NGNldVd1UHBhaWpEM0gyQVdpcm05OS9PVnY1Zmpld1lPQWZR?=
 =?utf-8?Q?c8Acky8a8UDQUCGDPN4Lj1s2/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c12d2bd8-d1b5-4da4-2a55-08dcdd7ac30d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 15:57:30.9606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYQV64bt7KY8pk8S14a9Nprq3ma0YdqpPDByrtsFLnz6Xwzl0BuoRKcESzJF8PfdiPoXOyAW13/bSTKk+hPbzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217

On 9/21/24 22:36, Pavan Kumar Paluri wrote:
> Move SEV specific kernel command line option parsing support from
> arch/x86/coco/sev/core.c to arch/x86/virt/svm/cmdline.c so that both
> host and guest related SEV command line options can be supported.
> 
> No functional changes intended.
> 
> Signed-off-by: Pavan Kumar Paluri <papaluri@amd.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/coco/sev/core.c          | 44 -------------------------------
>  arch/x86/include/asm/sev-common.h | 29 ++++++++++++++++++++
>  arch/x86/virt/svm/Makefile        |  1 +
>  arch/x86/virt/svm/cmdline.c       | 32 ++++++++++++++++++++++
>  4 files changed, 62 insertions(+), 44 deletions(-)
>  create mode 100644 arch/x86/virt/svm/cmdline.c
> 

...

> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index 98726c2b04f8..adddcf3edaf0 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -8,6 +8,8 @@
>  #ifndef __ASM_X86_SEV_COMMON_H
>  #define __ASM_X86_SEV_COMMON_H
>  
> +#include <asm/cache.h>
> +
>  #define GHCB_MSR_INFO_POS		0
>  #define GHCB_DATA_LOW			12
>  #define GHCB_MSR_INFO_MASK		(BIT_ULL(GHCB_DATA_LOW) - 1)
> @@ -220,4 +222,31 @@ struct snp_psc_desc {
>  #define GHCB_ERR_INVALID_INPUT		5
>  #define GHCB_ERR_INVALID_EVENT		6
>  
> +struct sev_config {
> +	__u64 debug		: 1,
> +
> +	      /*
> +	       * Indicates when the per-CPU GHCB has been created and registered
> +	       * and thus can be used by the BSP instead of the early boot GHCB.
> +	       *
> +	       * For APs, the per-CPU GHCB is created before they are started
> +	       * and registered upon startup, so this flag can be used globally
> +	       * for the BSP and APs.
> +	       */
> +	      ghcbs_initialized	: 1,
> +
> +	      /*
> +	       * Indicates when the per-CPU SVSM CA is to be used instead of the
> +	       * boot SVSM CA.
> +	       *
> +	       * For APs, the per-CPU SVSM CA is created as part of the AP
> +	       * bringup, so this flag can be used globally for the BSP and APs.
> +	       */
> +	      use_cas		: 1,
> +
> +	      __reserved	: 61;
> +};
> +
> +extern struct sev_config sev_cfg __read_mostly;

So I believe the "__read_mostly" attribute really needs to be on the
actual declaration of the struct, below, in cmdline.c, right?

You can check and see which section the sev_cfg struct ends up being
placed after a build to verify.

Thanks,
Tom

> +
>  #endif
> diff --git a/arch/x86/virt/svm/Makefile b/arch/x86/virt/svm/Makefile
> index ef2a31bdcc70..eca6d71355fa 100644
> --- a/arch/x86/virt/svm/Makefile
> +++ b/arch/x86/virt/svm/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  obj-$(CONFIG_KVM_AMD_SEV) += sev.o
> +obj-$(CONFIG_CPU_SUP_AMD) += cmdline.o
> diff --git a/arch/x86/virt/svm/cmdline.c b/arch/x86/virt/svm/cmdline.c
> new file mode 100644
> index 000000000000..964677ab02d6
> --- /dev/null
> +++ b/arch/x86/virt/svm/cmdline.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * AMD SVM-SEV command line parsing support
> + *
> + * Copyright (C) 2023 - 2024 Advanced Micro Devices, Inc.
> + *
> + * Author: Michael Roth <michael.roth@amd.com>
> + */
> +
> +#include <linux/string.h>
> +#include <linux/printk.h>
> +
> +#include <asm/sev-common.h>
> +
> +struct sev_config sev_cfg;
> +
> +static int __init init_sev_config(char *str)
> +{
> +	char *s;
> +
> +	while ((s = strsep(&str, ","))) {
> +		if (!strcmp(s, "debug")) {
> +			sev_cfg.debug = true;
> +			continue;
> +		}
> +
> +		pr_info("SEV command-line option '%s' was not recognized\n", s);
> +	}
> +
> +	return 1;
> +}
> +__setup("sev=", init_sev_config);

