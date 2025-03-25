Return-Path: <linux-kernel+bounces-575917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B621EA708DF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E13188D784
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67795264A6B;
	Tue, 25 Mar 2025 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zJwtbt8x"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33BA26463F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742926485; cv=fail; b=HajoX88rdlN9RgNCucCfAa0S+p+4qasAScfuG6iCYg9C6eDGsUtKgNTOHrV/yfejzzfP9HuHcv1tFdiFDYn64CNoG+nJPN0gLbkbqF7Ua7qHF24x+zb/ojcVUJ04PUoVK0Tm1+yWKykHcIrDsDDDfQI435VPrKUqYgl2IASRZjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742926485; c=relaxed/simple;
	bh=dbTF3QvWJb7n7NDfNEO1xSal5eBCLHmgrNVZhThPXvY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=C5D4dMrNqLYIFOjkCYhjzw9vlkZLlQNOhWzeZ3WLDgHAQq5Ta5b+d67bzH5Css6Twsdo8cS8TXYXe/EjHKgdfqKx17j3GnJaDzS9zi8q57Rjs92BrS1RtORgVzAcuAot97cQ3ZodiSgAoIxW80hoJ61haRskdn/LB5LYgBkmR5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zJwtbt8x; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9i09883rbc/lNJguehCedqfeZ6B0vdnc/nZnSIY6nb+TMedeWmqn0j9lvhv4qeDLuPrygk+VyXZaEXBos9ndKK+rTSqpiopohS8YPdwX2N3+rSuuqbET8cjH8E6hyY/hJNt9l92tfsGCsEE62xA6r25WFXkJf3VkAweIdqGNsrDSplq5mhOdiwENEvOsdy9io27wyOwlQmPzLECT1oWrHMxNK57XdB+vTTf/YhGi4HTSeNnSn9F9KMlt4c1fuzKFh2ByB3o2T+IEJCqVpStAYrtA4j4Aq6b4Tq9V/SRcn0ENSFdBJrbXKhidht451DPNCQ/oQ+/Ymz4fYk7phUsSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8O4KklsvbrgZciJrAuHmdZK8TtM2eCEQ04LXZrf5MFI=;
 b=k1AhzUKf9Toy9xnY0RLimC/cIWV3ssGcKifnSYcKISuonLte6WiMdDKmiA8mdr4zboE8VWDimz7NiDunn98072yO4CLnjbKqTqSZvpGpuwqobwZNSeziizwRPPfiZHAeUfGOQVBYhGRDUPpybxusYXXRFqO4UQPBMKMj8yZjzuMOLb6jqlYb0+Y8JANNmdjUMYEfakwigJvRjYripwDnLF9f8FAhS666u382mvOEX821Di7QTgMvjWv2czA7Fws8aY23r4YWcsep4R+/c4m5PnlBeEFESIVFocN6rgVMDVfIXMPdEcMCYN8HD0fMfEYeAVnIDdX2qq0n0YVNzniywQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8O4KklsvbrgZciJrAuHmdZK8TtM2eCEQ04LXZrf5MFI=;
 b=zJwtbt8xD0RnuCYAom1mKUaq5rynV34bseMnLNB8VFXId4498eC8KWROltQBlSDeHKYsTzGqjNgRybK93AmA06K3bq5oXCVIoqIYFRTP31Q+0l2xDgjlJKudExrLy1gRIvMXFctC3jir/7AiaSE+UcYRjUXjNM7Bifoh3qyr9cg=
Received: from SJ0PR03CA0360.namprd03.prod.outlook.com (2603:10b6:a03:39c::35)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 18:14:39 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::3b) by SJ0PR03CA0360.outlook.office365.com
 (2603:10b6:a03:39c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 18:14:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 18:14:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 13:14:38 -0500
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Mar 2025 13:14:35 -0500
Message-ID: <925fda15-fb21-f42f-f3e4-9284959696be@amd.com>
Date: Tue, 25 Mar 2025 11:14:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Add BO import and export
Content-Language: en-US
From: Lizhi Hou <lizhi.hou@amd.com>
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>, <ogabbay@kernel.org>,
	<jacek.lawrynowicz@linux.intel.com>, <mario.limonciello@amd.com>,
	<dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
	<sonal.santan@amd.com>, <king.tam@amd.com>
References: <20250306180334.3843850-1-lizhi.hou@amd.com>
 <d2d6b84b-7463-483a-a634-396b5099ef56@oss.qualcomm.com>
 <e7358027-6a8b-85b0-3ccd-cb09b3a9ce7d@amd.com>
In-Reply-To: <e7358027-6a8b-85b0-3ccd-cb09b3a9ce7d@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e63f1a-2bc7-4b75-6b65-08dd6bc8e873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1RKM2VmMWttajJuOFpKbjgzM0JKVVBsWmRRMFRUWTFJMXNzSkRXVGtIVXNQ?=
 =?utf-8?B?QVpjZ2NFSERSd2kyV3JUWFhJQkRveldsUDBiVHhLUWlzNG51MUpBbzdBYVdF?=
 =?utf-8?B?UXpDMEJJWWVma3BGRTBGZlAyRnlKRWJZZitjMHk2clpINGRyUUtZT2VOL1JO?=
 =?utf-8?B?aUJVME1iOCtaUGhFUFNXZjdZOXk1OTlEY0h6WEhZL3d0ZHpZZTFZNTlmYUE5?=
 =?utf-8?B?b3ZpTWNaampRb2M1a1pqNUc5R3pkQUlUWHFiZXpFMGd3QjhvN3VtYjRqYnRH?=
 =?utf-8?B?VURxNTVlMW5udS9uSWpiMzVZVzgyRTU4dUNXVUgwNGpmYTZRTFVaUFhQQldl?=
 =?utf-8?B?V2M1SjZyeXZBWnBpSXpLTFFCZHc4TkFyb3BYOGRyei9mK3prRTdYNmVha3lK?=
 =?utf-8?B?OCtnVmY1NGV4ZU9OTWV4Z1Y1ZzI4YTR2KytSd0RpWE9hUm1TVkVUOFZJUGJk?=
 =?utf-8?B?dCtUalUyWndSNkJGT1o3TXZOS1Y2Yjc0YTdIQTk5NXJ0SW9NVnhPS3ZpVXNT?=
 =?utf-8?B?VVk3SVNaR1I0NXJkeHQyUkFHY0VpWlFKQzRyc3R0VGs3WENTMUJmSnBWbzdB?=
 =?utf-8?B?SHpyZ3pmcFNrWmppcldpdFZ4OUpuYnNkYnZiTXBUdkpFU2lmQXhFaXFiQUc3?=
 =?utf-8?B?VGJ5Y3VXZ3ZXbmF5b0l1MmlFMktSazdkTjYxbVAwUDlSVnZuc29DQ2phRzJq?=
 =?utf-8?B?dERiK0hBN2p5cWFhR0dza3duV0dWbWEvQ210NlM1QjEvWk9GTGNpV1VEeXFy?=
 =?utf-8?B?STU4Z1FhbWZTUkZvVmtxdStwQUM5TTVwSzBUbzRwVkxoQ3BzMlBFTXFWQlF1?=
 =?utf-8?B?a2JlaHp2clJMTmNQa0FNOUJJenV3VlMyNUd1WjhUaVAwRFBsaVdKZUpYTExu?=
 =?utf-8?B?dS9sOEptUTZkemQrM01TV010YmN1OXJrakIyTnlZcEJMSXFLS1pYZUtFOGx4?=
 =?utf-8?B?dTV4UTZGVFlPd3pMSExhQkY2UFRPQlB4ZlZTdnArRlpUbVJIZ3VQU25RK0FY?=
 =?utf-8?B?YVVONW84RWJ3ZnEyQnRqdGZlWlhsSWZoeWZDWDlFS09GdWJRd2JjSHJjVWZI?=
 =?utf-8?B?eVV0YzkvL3dvbU9ZN2FZL25pb29YbllxSmptL3hDbjFwZjc2K3kvVFM2ZEcx?=
 =?utf-8?B?TDlPTEhkMDhUelZicGJHdUE4WXdsT0JLNk91SjhXeUdBRTBvbUZheC9FUjFR?=
 =?utf-8?B?cXUxUHpxTGhSSVkyM1k2enh1ZTY2ajFKK1VCWnhIcGxNOStCS3Y5anhWeGky?=
 =?utf-8?B?UmQyUjhTYkl4eHdIcFdJRXloQzdSSi9yd0N4RlBXa2RiN0I2VWZtUFdOQkxt?=
 =?utf-8?B?SEluMEhhazN1Z2JPMlNKUXpHMkRVNnkwNit4UkdqK2kxTmdsWWhwOHc0TnhB?=
 =?utf-8?B?VUlTem9PK05IUXJHWEFqTWVMZDNvV3dBY0hSaStQMG12cjlOT21WQVdKTzVS?=
 =?utf-8?B?cjBrQmVHdzNEU3J2T3dOSS9YeXo0dm80Vi96cDIzcHVZeThUR1QzMHdUam1N?=
 =?utf-8?B?ejJ1NXg5cGszZFpIRGdxK2RzZGdqZFF1clR3Y2JJMXBqcWpKWnZmeDE5UHU5?=
 =?utf-8?B?eXNuUUpLUzZjQSsxNHZPTXdlYTg1aG5lYzdzdkVsOXNWcVFncnk1SWVuR2JZ?=
 =?utf-8?B?UjhJeHVyem5uaVliRE9PRmhXS3VhMWlqMkpDTWlNMFpQRGtwY3RNcFd1Tmg3?=
 =?utf-8?B?ZTU5eHhZeGRNTmI1SzRaMWUxNkVzSUc1MFRuSk0xNFFjdGN3V0hKOUIxcWx2?=
 =?utf-8?B?MVFabGJwV0JWZW5jWmJRenBPRmhpbGpWU08vSm8zOFhrVFlTUW56Z0lLQVBP?=
 =?utf-8?B?QnkreVdjeXU4azUveWtabXZrRkVGRVh3MEJ1Q0ZGNXNXU0RUU3R3U1k3Yy82?=
 =?utf-8?B?U2ZLZktMTGZweENVejBDWVAzUkpoUUNXaDZnZkdiay8xWW8wOVAwZnNuKzRq?=
 =?utf-8?B?a2dxSXdvaGNKbDNNNmQ0enlJRVFiamNQMGRJdXlkemdMdll3bmlOL3hhYm51?=
 =?utf-8?Q?DhfrXa+rIGggZwFc8XjA9UIVTpFd1s=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 18:14:39.2581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e63f1a-2bc7-4b75-6b65-08dd6bc8e873
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340

Hi Jeff,


Just noticed that the driver should not use import_attach. 
https://lore.kernel.org/all/20250317131923.238374-1-tzimmermann@suse.de/

I will remove the import_attach usage and send V3 patch.


Thanks

Lizhi

On 3/21/25 12:52, Lizhi Hou wrote:
>
> On 3/21/25 08:15, Jeff Hugo wrote:
>> On 3/6/2025 11:03 AM, Lizhi Hou wrote:
>>> +struct drm_gem_object *
>>> +amdxdna_gem_prime_import(struct drm_device *dev, struct dma_buf 
>>> *dma_buf)
>>> +{
>>> +    struct dma_buf_attachment *attach;
>>> +    struct drm_gem_object *gobj;
>>> +    struct sg_table *sgt;
>>> +    int ret;
>>> +
>>> +    attach = dma_buf_attach(dma_buf, dev->dev);
>>> +    if (IS_ERR(attach))
>>> +        return ERR_CAST(attach);
>>> +
>>> +    get_dma_buf(dma_buf);
>>> +
>>> +    sgt = dma_buf_map_attachment_unlocked(attach, DMA_BIDIRECTIONAL);
>>> +    if (IS_ERR(sgt)) {
>>> +        ret = PTR_ERR(sgt);
>>> +        goto fail_detach;
>>> +    }
>>> +
>>> +    gobj = drm_gem_shmem_prime_import_sg_table(dev, attach, sgt);
>>> +    if (IS_ERR(gobj)) {
>>> +        ret = PTR_ERR(gobj);
>>> +        goto fail_unmap;
>>> +    }
>>> +
>>> +    gobj->import_attach = attach;
>>> +    gobj->resv = dma_buf->resv;
>>> +
>>> +    return gobj;
>>> +
>>> +fail_unmap:
>>> +    dma_buf_unmap_attachment_unlocked(attach, sgt, DMA_BIDIRECTIONAL);
>>> +fail_detach:
>>> +    dma_buf_detach(dma_buf, attach);
>>> +    dma_buf_put(dma_buf);
>>
>> You attach() and then get(), so normal "reverse order" cleanup would 
>> be put(), then detach(). That is not what you do here. Should this be 
>> reordered, or should you get() then attach() first?
>
> I referred drm_gem_prime_import_dev(). And I agree with you. It looks 
> better to get() before attach(). I will respin V2 which will also 
> contain another small update for this patch.
>
>
> Thanks,
>
> Lizhi
>
>>
>>

