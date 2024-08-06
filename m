Return-Path: <linux-kernel+bounces-276646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CD894968A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 438531F2408A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60114AEF4;
	Tue,  6 Aug 2024 17:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mEEp4y7W"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3229B57CB6
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964718; cv=fail; b=B6ZndRlv1tc7qQCgzmPU7YcutV1TP2O7mqZJunvpIRKdL126Sf6aokz4mXJB3UXABBh4h5w+dsd31/OJFKHqcpVg7FR4COe+KWJvRHq0CzJtQeOARJ1EBCDxyjkeSsqfs2fSMVDAzhzLqp9t8QbjhrEg2ADwkyzetvcvGuiqCz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964718; c=relaxed/simple;
	bh=J9IXX0x0kYTLlmmZLEoCR74DFgd/+/4XCYT6qz/XhNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c7Nnw/6XziuKGgnMWRSp+WCjxTS5aHFm02CB1fLFKI7dJl+UMahuo5B9BQ+gruNjKXts+WcJeTwKiview8c0R8QePJjClzn2id2+oFO97JRm0cn8Gq7sHJ1RGaokKfOSQRUta1/oObD5NEDWPukzyHjDAdhA6dCLWqhgQEkIN0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mEEp4y7W; arc=fail smtp.client-ip=40.107.95.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4RJv2LV/hBBTCP87a+mgw3XUphJrvntq604X3SO8TV2XF66feHiZtaAPidswpNaiuLB3RZOBEY9mfwpieq1g5oHLDBR++l6ctBYbk5c+brWa+misCxA1V2v2GqAuSzkH1XHI091nEYrhAGfkRAOPGQuaiZApsVjrziqWBB4MfP9+EIypf8wa1pGov7swobCWz02AcQcg3tftGoMqNSZYGJCrDFrSQHZ9PwvL4Mgc0Sw6zBPEfc4TUIb7JtMoptgOH6N1h5FS3cDJGxIQhPzkXnGkL0NX81gsGqbP/QDDS6qlsVbNqXqdimbAm14ZxlNbXUhlRWhulMa68OA+nWEoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jACyDJRntLzZcpKyIq/gchE45UlDTfr7YXGgB+3DQKs=;
 b=lXU2HA3DhGiLEEjy9t9NuMmdhEejKmgGGNtJW7FPjMfj++0/u4RG79MY9IHjxbAQ5/GApSAAuwWuErYagZ8f0wSUPX8nEBfos9wadyrIGlMFQF/BkkufzKDsZpU+BPfgu9FutpWYvLDCVOuDb5eNfnt/KzqTP0kjPuzAKyCY9lgbv5dgEa/Y4iscwhlvWKEcNBC7lW0fP6M4WiXtiDF19t55Tz/nlYYKpgT+jtPE6zvwCXogfezgoEoJtkmJWDMYsptV5cULUPGm3xaFGCg2+OYmV+c6N5scZRdrhJPH0hjT2kzCc/Dq1Zx/FIMOJIhMyH9rGREuwShBe/N6T3fBJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=web.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jACyDJRntLzZcpKyIq/gchE45UlDTfr7YXGgB+3DQKs=;
 b=mEEp4y7WmG0fQFX6wiwFkyuYLCG3put/RGBQ2qdqxHDQdeeUzsQFlK/uqIX53GxXX10JVvZolXAkExKyMP4dHDxFo/bNIN61HmMUyC57njiNFH7LgmeJR9bOQGbIfA46CVCjp6npuMDAlHdA8tBeEu8ORsl68DJfPTMIPSBmZYk=
Received: from PH8PR22CA0008.namprd22.prod.outlook.com (2603:10b6:510:2d1::20)
 by DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 17:18:34 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:2d1:cafe::a1) by PH8PR22CA0008.outlook.office365.com
 (2603:10b6:510:2d1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13 via Frontend
 Transport; Tue, 6 Aug 2024 17:18:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 17:18:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 12:18:33 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 12:18:32 -0500
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 6 Aug 2024 12:18:32 -0500
Message-ID: <23f5f0ea-305c-15c0-4578-ef1307621d07@amd.com>
Date: Tue, 6 Aug 2024 10:18:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2 00/10] AMD XDNA driver
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>, <dri-devel@lists.freedesktop.org>,
	Oded Gabbay <ogabbay@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, George Yang <George.Yang@amd.com>,
	<king.tam@amd.com>, Max Zhen <max.zhen@amd.com>, Min Ma <min.ma@amd.com>,
	Narendra Gutta <VenkataNarendraKumar.Gutta@amd.com>, Sonal Santan
	<sonal.santan@amd.com>
References: <20240805173959.3181199-1-lizhi.hou@amd.com>
 <f66e2016-d2c8-4a86-9a6f-267770f7fed5@web.de>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <f66e2016-d2c8-4a86-9a6f-267770f7fed5@web.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|DM6PR12MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a73a7d2-750a-45a9-6152-08dcb63bccf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzJEU1Jrc2IxZHoxNEozRERQNXVQcWsvbVgvN1dScWhCRXdxbHNMUGl0QlEx?=
 =?utf-8?B?YVFlNFZVMFIrTjVjUzBnNHlid3dFd1pTWWFCbkVVVFJESFdPb0JaM3FldTlB?=
 =?utf-8?B?a0lXK2NqUnQ5c2VkemJwMGM5VlJ2SjRQWFNlVW1yZTZ3TkxBdStNUi9vQWtU?=
 =?utf-8?B?WkRmTXNONjFlTFFHbG5Cdm9vQTljdlR1bEpIMStkc1pmRG4zZnMySmkybjl1?=
 =?utf-8?B?YXRxZDhlMWZOa20zY3JkL2lsWjlDcFd0cnV6T01ISU9wdDhXNldnMnJaMndm?=
 =?utf-8?B?dzBjbUV0YVk1cFFKNzBOOEhZN1dwaDBZaXNCVjhFMzlGelBsL0l1V25tMFJZ?=
 =?utf-8?B?MzM0ZDJIdUs1ZEtmUnMyT2g4OUNsdlhpR3FIN0lDclB3d2dibnF3S2VOSjlM?=
 =?utf-8?B?ZUpjSTcvK3MrNjhMaWhKYzRGZHhTUnZUR0s5bXdLd20veWhkT1dTb1lVcG9o?=
 =?utf-8?B?UGZMa3lGaDlFcVZ1TEFIdXFObythWGQ2TXVqUWM5MXBqWmplWDlUYTZkc0NY?=
 =?utf-8?B?RnhmV25YR0xpcUQzamRYc0FyQ0VGWFh6eWZPNXVBR3BiUVVHTjdSMHZVOXJv?=
 =?utf-8?B?SmR2b25yU1N1VkVBRXNKYjZ1U1Zoc3dteVJRYW5JU1JEWDBCWlloajR2bnRo?=
 =?utf-8?B?eVIxV05lbVhLNXNZZGorTHZUbC90bTF1VUh5WitUNVFjOGptZ3gxakZ0RTRQ?=
 =?utf-8?B?d3dZRFlBZ1RGc1JHUVpIMkt4bVRkUzhIWno0NmxyYVBUV3VEUk5kcVVDeHRF?=
 =?utf-8?B?ejFRbG5LVG1vc3ROUUdiejkzNk9DTnVpV1lOMWp3NEIyNDcwL3ArTW5VR1dk?=
 =?utf-8?B?UklGcGJWY2g4ZjUzSGhxMnBXUHdJbm8wK2t5eUdzY0swOXdxaTkrZHpyOUlO?=
 =?utf-8?B?ckpIaXZDWWtnQnIvTXVHbXZFWlpIOHlURnJiZU0yQmxVdjdBWkRhczdFSjA3?=
 =?utf-8?B?VUR5NkhhOEdXTjhiUSthZXFpZ3BYS3BxZUc2NkkwNUpJRDV5SFhsK1B2ZStO?=
 =?utf-8?B?bmZCMUVYTVBDakx0ZnFZU1dtTGRQbGk0QWovcWlhZUVveDdlY0ZzQjg0cTBE?=
 =?utf-8?B?SStOUUxpdEovNVFPTzE1RTNoOERaeFdJdTlvQWZvaEdmdEZPUE9McjlEMktP?=
 =?utf-8?B?eCt5V1VYWVprU0VkamlKWE5MRDVTVmhZWHdMMElsbGRJNmpYT0EzTEVwL1Jm?=
 =?utf-8?B?dTFHYWxDeCtYNHgxaWw1eUtFOHh4anJjSStvblI4SUJISTU0c3YyZTJLd1VN?=
 =?utf-8?B?eXFKa3E2Mnp3STNoZ2pSSFFyOTJLY2trSEJZUGFRREpIN1pSeUdlRlhJUzJs?=
 =?utf-8?B?ckJvTWZQMHl6R28yQ1Nha0M4ZmJHVkNwc1ROVWhGU0ZzOU1YTlpRdkFJTHlF?=
 =?utf-8?B?RHh0Ykx1L1F6SWJzbGh5Qm44Q1c4VHZKN2RnUVYzUTJlSkFzdW9zVHBFVWhi?=
 =?utf-8?B?ZmRTbHRGUDV4YXJMbmJYdS9OdWRWWTFxUGpjZzd3elUvRmZnN0N5MGFtb0dV?=
 =?utf-8?B?dmN3SE16TTg3U0JoNzRRVmpwdG5XT0pQb3NNS05oaVFFYzNUSktoZnltYU1B?=
 =?utf-8?B?bTNmQnVtY1MxbmVkSExZN0tUcjEzanZGWWVycUpHc2xLR05VVTJrQnQyVkJu?=
 =?utf-8?B?by9sOUdzbmFXVGxrWmFkYXRpQU01NGt6NHZPcDdMdEVjMXRHa0RyNkFhaWNP?=
 =?utf-8?B?UnVweVU2U0h3QklKVmNNVXd0SW42SExvSEVoYWtkVW5TNjJ5aHpUNE1kcWtm?=
 =?utf-8?B?dTBGQm9DK091bi80TUFpTm0zSlM3bjk5bGtlaUVNRVlpVWdzYm9mSHk2Rk9t?=
 =?utf-8?B?V0lBRmRNd3Frci9QRmIrUWFmNWp2V3lDdHcrNGVtd1E0WEUvbzNpNllMeVN4?=
 =?utf-8?Q?USjLqXycmRYWG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 17:18:33.6683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a73a7d2-750a-45a9-6152-08dcb63bccf1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091


On 8/6/24 01:05, Markus Elfring wrote:
> …
>> Changes since v1:
>> - Remove some inline defines
>> - Minor changes based code review comments
> …
>
> How “good” does such a version description fit to previous
> patch review feedback (like the following)?
>
> https://lkml.org/lkml/2024/7/19/803
> https://lore.kernel.org/linux-kernel/010a46ba-9dc4-e3e3-7894-b28b312c6ab1@amd.com/
> [01/10] accel/amdxdna: Add a new driver for AMD AI Engine
> “guard looks cleaner. We will use it.”
We reconsidered this request and searched accel and drm subsystem. I did 
not see it was used. This does not look like a required change for 
upstream at this moment. We would keep the current code for this patch 
series.
>
>
> Can further adjustment suggestions be taken better into account?

I went through all your comments. I made the required changes which are 
defined in coding style document. And thanks for pointing those out. 
Please understand we would only make required change at this moment. For 
the nice to have changes, we may consider to change in the future patches.


Thanks,

Lizhi

>
> Regards,
> Markus

