Return-Path: <linux-kernel+bounces-223474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8F4911396
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC208B20E6A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC305F874;
	Thu, 20 Jun 2024 20:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vTpT3bfR"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2E13D3B8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718916465; cv=fail; b=pe42SL4Dgp0sWZprnoWzLxENfpgENyNIeCTS/LDXBQFFTbaSs0m++9waPBBUD5B6Ns602Dq/150HEIbyiy/nu8ipbMtkea/JF7lwUgy4FZgjv73PYsCcH5gF3yf9LnDAJLIBC6OVu42z/eIps3QKJIqAZbLsjBLWELANuFqt+fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718916465; c=relaxed/simple;
	bh=ruCLmdYG9vV+KuyklInGz3ufe3JtPUYgZ0orhn958vw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jqFymWvJL/c/BV3eXjeFSBu0Z0QHylK4jkMQwXyBn/+yfkylPvBxCrHx20rtgIdrUV9IabtewQe+wczcuoN4bkGeIkLMEn0tw59ruGd65X8MUyS1QlV00KzdV0TSMNSlHb+6jqQ2igFgOSFtwZUiYB/Xsf8I28+I7W/8AlJHJ70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vTpT3bfR; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2nQFkk23ZZwyvnSjcJ5KlML8rPCH8369hlveIUHbOMC6bmRmO6GeUFrYUfDRf+88kuGR2al9IWfKlkSMtkjQcjlwf2tzzuI9AYlzYgY0ghKyLCe28KLxm00ltsTJM9BlOfFUg6fBzCx4pGMwJCACeEsMPprBSPDNkGR8z2pd5NV1ts7X+ip/GfKyP3kekzZNeTD1HVMU/w9LrFLHTey+2bznfLU9yIHuiZUO6fRVdCp+lbnNdsWwhvsr24SrkYp+mQ3N6d8vnpYA6RYosP4BthsSubmSxxp9IkB5ZRBTe8FLaWYNm1c16tet1HI7hwqtrhJiHU4h15bYAwufA6vKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXfiq49TFLb6Ke4poAoFdRWpoxa2xKwmu8dZ4wTKsRg=;
 b=NiBqVaqv9HMbBplvpx3Mp21wL5O84uLt/s2AfUlqK2XwXV7iiiVdb0Db0Iixw+Cf3V+ELyC9sGBAImE6yrbR/OD+DL7pN0cBGn75HU+xrjZJRQCabfxnhbjOAl8ezd2GzSN7mEpidao6CmbJWkz8zX8CAJ+HjGfeGeaCyfWaCRRCwk0t8KvHu+klGI2tnhaobns8FmPlBTp/9XnMRfn87W3A2TjCYj3ijSMPxsCyrdUNx7GRM8ODl/dbNVZ/EUhnEJikLCvdwhn9cO8emNTxDakBW0WinWK3VYIRz8iwe6SK44MIbNArJwV52AKe9goO9r0Ze/xNYBiqoOkw9FUk/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXfiq49TFLb6Ke4poAoFdRWpoxa2xKwmu8dZ4wTKsRg=;
 b=vTpT3bfR+u4Anp3lANBAQ9R7etB9Jn0mO/KONL3Vy7Tpir+chBRrV9o1/ieIln8Z5uqfJ4XLLz9LSIyRRxBu3+ljjB/ulMCrgr6dASq6oR2xNaTVhNpMFzTnm/xwJ5ifFawzOkUQCyTAmwamgzz9tixDJmD+RqiWv1lkuK0nwOU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.31; Thu, 20 Jun 2024 20:47:37 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7%5]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 20:47:37 +0000
Message-ID: <c0eb7bf9-0ca1-4289-b8d3-36b5e15a43a9@amd.com>
Date: Thu, 20 Jun 2024 15:47:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/sev: Move SEV compilation units
Content-Language: en-US
To: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Borislav Petkov (AMD)"
 <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
 Michael Roth <michael.roth@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>
References: <20240619093014.17962-1-bp@kernel.org>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240619093014.17962-1-bp@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0078.namprd12.prod.outlook.com
 (2603:10b6:802:20::49) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: e3aba14d-a421-40dd-cc7a-08dc916a3806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEJzMndPZXA4Nm5qNjhXZUl6ZmtrYUUxaUtQRUxNbTRLc251d1RqSzhZeUN5?=
 =?utf-8?B?cWdzTnd2NVFqOUN1clJWNnF2dE1CNjJIMzBPNWxsTjVLb25DdFdLVmgzaGNk?=
 =?utf-8?B?SDJRTjRvK0xkclRwWnVTc0I5cHlmVENtL0NSUDVGeFYwbmo0WHVhNklkVzNa?=
 =?utf-8?B?RVhoczJxRzNJWU5iR1ZKaWpWNW9WdXZzNWt6VkZYcVBiWUdRVDFqTy9jckVX?=
 =?utf-8?B?d08vWjR2ajY1T0kwL1NCVWtNemJsSEg5VkM3TElRcnZ5NGl4TjM1azloSG5O?=
 =?utf-8?B?d0JhTTFTL2F5OTZ4V0JpU01aVVh0RHRMSk5taXQ5bExQMGFjMEE4M3BPakg0?=
 =?utf-8?B?V0xVa0tTVkZ3MUhvbWNNUzZkM0R1TVg4UFllYU1qRWFhUHFDSW9NTW1nUkZw?=
 =?utf-8?B?K0l4Q2dGOU1RV0VOdXNPZG1Mb3Jla01qajBSTHQyQ1c2YTgzcmZTK2xQajl0?=
 =?utf-8?B?b21WM3VVcEdzNmdJYWVQQVg5MTgyYXp6Yk9zZU1TRFd0N1ZaWEhLaGdaampS?=
 =?utf-8?B?M1N5L2VoR2N5aHdQUFBqekQ4amk2ZE5XZXJHZjJGN3REa05CSStmbXFiR0cv?=
 =?utf-8?B?SDJIVS96RHNFNXIrek02TGxJMnFHYW1rcE9QVUIvL2JoWHlHYkdZWlN5eHJp?=
 =?utf-8?B?Y2pmRDdyZXZSb00xUCtKUFBkTUErRDNQRDN4QzJSZkJjejYvWVpqU1BUUHFI?=
 =?utf-8?B?cVlwVllhNS9vZHh0NkhlNndjR0l5OW8yYkNibFBLOFFvdGxUSUFpNFNvYS9S?=
 =?utf-8?B?a3J1WkZWb0dad1FrVXo0eEhhMjdRd3hUVkc4OGh2NzdIczZSTnFIenNaUzJU?=
 =?utf-8?B?b0NRQWdtcGRlTEdMcDlqYlVHUzdGazRxR3JIQzJXc1lWOGJMZThoaEt1UDRY?=
 =?utf-8?B?RzFXZVZWbEhuN2tFL1BjL3lqQnVkQ1l6OVJPSEVNN29ZUXBySGpPRi83bWQw?=
 =?utf-8?B?M0JzYWVZZHhrQWJGMVZNVDJKSVlKZHNIQ0RqUEpVV2ZqUElUYnVQMkM0Nk5D?=
 =?utf-8?B?RmpYZnJZcG1aSWFsZllyRTNZaDBaRkI0ZCt5MFFTNFJWcmJCSlppT2cyVE1j?=
 =?utf-8?B?dUw1ZGlOYVYvZWx3bTM1L0VvT0MzRTVGV1lMUFR2Z1p4WFFtaGR1RFkrVUtO?=
 =?utf-8?B?RnV6dEp3ZUZjTEJmWG9RaXJ3empTVFp6eFpkb1YwUUZpVE9INXVGbWxpbm1Q?=
 =?utf-8?B?SG1OWXEraGtyWkEyQmNIWlNUUjZoZGZGTi8yb1BsUnRSZVozUmpCQ2JkNWVl?=
 =?utf-8?B?b1hCOHhvQU1aYlE4c0VvcWRKVE5PeHk1RGorOFNHUk00Q0FEdWljVEM0WHRh?=
 =?utf-8?B?NHZzUGJTS2pCSGFYQ0JFYWd4TzBKbzhRUnFqQ0tEYTJYdWYzektueDZZMnZR?=
 =?utf-8?B?TERVY0ZSTFh5UENIRm5GOU5CR2g0aHh0a09jT1J2cHV4Y2JRNDBkT0RBZjNG?=
 =?utf-8?B?VmJBQ29RcEZ3R1JHWFdsaDQzUnlQREY1dDU2QVNXZUxzS2tNWXJuZmtYZWRB?=
 =?utf-8?B?aVY3cjhrOEZKU25TWHRlZ2YrdXpxQ3VBbkozdVBSWHJxWFZ4c3ZYcXFvWnJ1?=
 =?utf-8?B?eVdMbnFLSWk2dnNvWUpwdDRWNE1Tb0lLTDU4R2hCSjd6M2tWcFNJdktlcVBi?=
 =?utf-8?B?N2laZXVKdE5mL3NDWFRsZ1ZvQ0ptL1VPSmgwMlVBRnZwd2RYdk4ySG5JQXNH?=
 =?utf-8?Q?gXydZJ20LTYru9gJ5JGO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R21YREkvWWd0ZVpaMml0ditFMjBOczRkRzFVWEZhYW40b3ZGY2VHdUNYSnBn?=
 =?utf-8?B?Q0EzVGRuOEcwTXRRN3lJSmFwWWxZUEUzK21jTDFMSXJtQ0M3N1M4MmtzSFFj?=
 =?utf-8?B?MFM3YVFwelp0UTdlUVZ4NmI3RHhhY3VReUZxYWsrMHZsOFlxZW1Xc1RMNC9C?=
 =?utf-8?B?TVdIWG4zY3JxTUc1TWtkekR6czhhWC93UzFNQ3BaeGRqVXcwZWY4RTRUTTdC?=
 =?utf-8?B?OTI1M2NDZXdkWHBIUDB0TWlPNGFHOW5PU2orNTdjVU1GaHZMSE1teEdNcWdG?=
 =?utf-8?B?b09TWVRzM0RUM0k3cWdDRHRiVmQyaUphVEZSM1RQT3gwaWlNdVdhb0dFejU3?=
 =?utf-8?B?ZUtFSkp2d2trVCtHMkgzakRaV1RObjdkQTZZRWVTakVjNjMwc2Z2TytNZFJ4?=
 =?utf-8?B?WVkvMUxyZFgyVldUN09SZ0EzN3N5OTdXbU51S0prcHFkSnhQczM0ekwvbUZk?=
 =?utf-8?B?TWlpVjdVaDFGZ2FjL1dCTDNFUkdDR0ROZ3BaMnhhckxJTjI0cVZMN3hFZW0r?=
 =?utf-8?B?RmNqR2l3SExWUktFUndXdmQ4Sjl3ZGZkVFh1MEpVK1FYWUk5S1ErVWR4TnVR?=
 =?utf-8?B?OVdhZWRhcnZjVWlHYk5uOXZ6MmZWYWl6RkJzKzUxam5qL0xmUFVEeURZNUdl?=
 =?utf-8?B?Zk1ROUtpUklwSVQrbGtPUE82WGdRMEhVWVdoNWtvZEsvUFVjaW5Ed0J6OW53?=
 =?utf-8?B?b01uMFF4YzVDOVZlYTlXRmlqbHh1Q3Y1cVFsZTNMMGxjNGFXZ3orL1B2aDNq?=
 =?utf-8?B?SUxRL1h6djJONzJGRm05OUtGTWxGYTdIUjVxbGhVVy9iYkowdEljSm1KNXNW?=
 =?utf-8?B?ek8vVllmdXBmbGpGOXJUUUNwYm42YkF3ZFZuQmFZbmtRLzJRdXBLUG9ZUEZl?=
 =?utf-8?B?aGI1MFN0Q0tnS2o3WDBFMjZScy93NjM0cU1GVm1Xalp4cnZPSEdxd253TkhD?=
 =?utf-8?B?UnVPdGJGeTFEU0FXZlFSZXNPazEzYWZVSHFPc1UrYStEVWxOOWV0NngrYTZ3?=
 =?utf-8?B?SDJUQUhlTlNoaEd1ZW9wUmpjOVBmbEJGNDJIQUtMMVFjYUdSeDRsKzh0ODV1?=
 =?utf-8?B?Y1g4eWlBbEVYY0wvKzZJb3d0RVhNcnNSNTEvbHBUUDBPcFhObEZobXpaZ29L?=
 =?utf-8?B?NXRXbTJTeEFPZEJCM3dqdVN4MUU4Qk9FSU9WTlp6dThweEZwcmtqVHcwTnRj?=
 =?utf-8?B?blgxbnRHNDJCczBWcjVJOW9qalhNQmpsZ25qdVhpbGxGdDRVWThGZkhQQUMv?=
 =?utf-8?B?anVlQ05sb0I3TytkZTNqSGZPNE9WdklOc1lMRFlmUU9UakxDQXplRktVSW9V?=
 =?utf-8?B?ZWlIQ0tFYktkUnlCbmh2Z2VwYWFCSEZFVGtmc2JOOHVFcS9JTFFudHFDN0dw?=
 =?utf-8?B?azdmT0lMRHpRNDZwTUJmcDljK2JYb3hGd2NIa2hJUjJjU0NoSmF6QWlvb0h2?=
 =?utf-8?B?Sm5Ebkp2bXdtUzZrZG04elUwYVpaZTRIY1EwcjJKOEFQdjZuelRtTGYzVUJT?=
 =?utf-8?B?S1FWWkFGWEpVQzE3cmFTVkhhVnhMWGJ0Snh6TkE3Z21hcFpCYm8zS21rbjNN?=
 =?utf-8?B?MHlOdXFYQWtNRDZnTWg5dldPUHduTERzb2FyLzd0VTVhOC9yczVnZTZxTFlX?=
 =?utf-8?B?enEyMGJsMDRTWDVnZUN0Q1lRZ1hoN3lQTWVqUUNvbUpxdWxJTm5yUTZtc0JI?=
 =?utf-8?B?Nm1kMlc3bFpZVjFkTy9WSDZsN3VocG5WN2NDM2pRQ25KZmZlN3FVdkZlQjZW?=
 =?utf-8?B?ZnpIQTBGbjZtVTUzTVh3Y2E3ak9McTVmNTRTM1RxcGVQb2pDSzRnMVFmUWE2?=
 =?utf-8?B?ajZSNEpMUE9HZng5TXlCRi91Ykxxck4xOEc2Yno0MTh1aURscDhXTFpsMlVW?=
 =?utf-8?B?VjRyakhzS3diVXF5WGo0THlwdWQ5Ty9ZS21BUExOTktoc0NzdWMyR2h1WVFH?=
 =?utf-8?B?NGRRdVI2cGROV2NHU3FpUUFKdlVENnhVQmlZaHJOQXlBS2tYdVcvd3JQc3h2?=
 =?utf-8?B?RHdZVUtBRWFqVmpETTVDNFpUcE9pWEx2VXpFN3dQMGVPZUk2V0doMXZ2RGxX?=
 =?utf-8?B?aDFSTWVPenlEaXhnZ1Q5ZWVqMUZkTGhQajQySkNXa2xwd1RBV1kxNkdHalg0?=
 =?utf-8?Q?aB01Lm4jmTedkH3xnuoKPMOCd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3aba14d-a421-40dd-cc7a-08dc916a3806
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 20:47:37.3417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6J7FlK4LFD008zNuCCqgRcZGrruSASkI1QlHfN4SJYqJVqVpamGW+QOhWopcfSCbCzrPj9Hyysr+b3rBvYhU9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392

Hello Boris,

On 6/19/2024 4:30 AM, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
>
> A long time ago we said that we're going to move the coco stuff where it
> belongs
>
>   https://lore.kernel.org/all/Yg5nh1RknPRwIrb8@zn.tnic
>
> and not keep it in arch/x86/kernel. TDX did that and SEV can't find time
> to do so. So lemme do it. If people have trouble converting their
> ongoing featuritis patches, ask me for a sed script.
>
> No functional changes.
>
> Cc: Ashish Kalra <Ashish.Kalra@amd.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Michael Roth <michael.roth@amd.com>
> Cc: Nikunj A Dadhania <nikunj@amd.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  arch/x86/boot/compressed/sev.c                      | 2 +-
>  arch/x86/coco/Makefile                              | 1 +
>  arch/x86/coco/sev/Makefile                          | 3 +++
>  arch/x86/{kernel/sev.c => coco/sev/core.c}          | 2 +-
>  arch/x86/{kernel/sev-shared.c => coco/sev/shared.c} | 0
>  arch/x86/kernel/Makefile                            | 2 --
>  6 files changed, 6 insertions(+), 4 deletions(-)
>  create mode 100644 arch/x86/coco/sev/Makefile
>  rename arch/x86/{kernel/sev.c => coco/sev/core.c} (99%)
>  rename arch/x86/{kernel/sev-shared.c => coco/sev/shared.c} (100%)
>
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 697057250faa..cd44e120fe53 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -127,7 +127,7 @@ static bool fault_in_kernel_space(unsigned long address)
>  #include "../../lib/insn.c"
>  
>  /* Include code for early handlers */
> -#include "../../kernel/sev-shared.c"
> +#include "../../coco/sev/shared.c"
>  
>  static struct svsm_ca *svsm_get_caa(void)
>  {
> diff --git a/arch/x86/coco/Makefile b/arch/x86/coco/Makefile
> index c816acf78b6a..eabdc7486538 100644
> --- a/arch/x86/coco/Makefile
> +++ b/arch/x86/coco/Makefile
> @@ -6,3 +6,4 @@ CFLAGS_core.o		+= -fno-stack-protector
>  obj-y += core.o
>  
>  obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx/
> +obj-$(CONFIG_AMD_MEM_ENCRYPT)   += sev/
> diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
> new file mode 100644
> index 000000000000..b89ba3fba343
> --- /dev/null
> +++ b/arch/x86/coco/sev/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-y += core.o
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/coco/sev/core.c
> similarity index 99%
> rename from arch/x86/kernel/sev.c
> rename to arch/x86/coco/sev/core.c
> index 726d9df505e7..082d61d85dfc 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -613,7 +613,7 @@ static __always_inline void vc_forward_exception(struct es_em_ctxt *ctxt)
>  }
>  
>  /* Include code shared with pre-decompression boot stage */
> -#include "sev-shared.c"
> +#include "shared.c"
>  
>  static inline struct svsm_ca *svsm_get_caa(void)
>  {
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/coco/sev/shared.c
> similarity index 100%
> rename from arch/x86/kernel/sev-shared.c
> rename to arch/x86/coco/sev/shared.c
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 20a0dd51700a..b22ceb9fdf57 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -142,8 +142,6 @@ obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
>  obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
>  obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
>  
> -obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
> -
>  obj-$(CONFIG_CFI_CLANG)			+= cfi.o
>  
>  obj-$(CONFIG_CALL_THUNKS)		+= callthunks.o

Reviewed-by: Ashish Kalra <ashish.kalra@amd.com>

I have rebased SNP guest kexec and kdump patches on top of this patch and they work without any issues with this patch applied.

Will be posting SNP guest kexec and kdump rebased on top of this patch.

Thanks, Ashish


