Return-Path: <linux-kernel+bounces-360025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5944999939B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 22:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AB33B21D67
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225081D31B2;
	Thu, 10 Oct 2024 20:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RAVBb88j"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C561CCB2D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728591832; cv=fail; b=r/XO+9dFU4K+Xnw/4LLTIGoxI068/180haLUlyUhKRBbdBu/usJy+Sc3cZHbTv+d0lHeyNSBX7FmOspNZ+htoDKgiWFx9L4Gpl8yQz20So5D0GH9Fg/JS0clIumSyNanyJlZfJOrK/X/oNtF6jKi50PGUPuuQfjLhR2Q+EgKCFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728591832; c=relaxed/simple;
	bh=mW6moP4MOQo0b5qm6ciIONHJhkovMQGnoB9iMX/T6ho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UFqKlCmMaVFofcjF+KJknzlVeev2k7UZPJ+xeiH60BJfvEkB4yvBzCQgFSSExFmmnDA43xbbJDaR0ZN9xYlRYjbAYnENbX/GQKpdi5GBt35iVpjNSXkeiggxuEdN48PdkZYFmkRrIN0Mk3AC3l41YpnoOSi3fGJ+kAPDyxLMQBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RAVBb88j; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIZXJNL6fqC27QUtaLeSiuPg0wJCP7tHyA1kLne473esm6bAkUM0c6sCJqURHIjSZYsdK6uQfCxdb6XnjHeGOKucYsboc5n2G9kxa8UzhY+uF+LWE2sfickBVj95x3enesS/QO0gPBm3oU1d+NF5zY8OlJ2yhk1Aj70coq2M+gOCMrtE87WUq2UhWA8SpZbGLsn+7WcnVZQ4lwmg9y7QSC3NiGhdJu+t9YjITWBPeJ/opea1VdZyE+WpxFi5xd7N6k+pbMRIswFwLYrSSx6X5h8BRgUBU978iv8TKvxuTiM9nwphRC3Hijjy56qHDWDFGcgUAkibnOeSDQOBJhRq9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mW6moP4MOQo0b5qm6ciIONHJhkovMQGnoB9iMX/T6ho=;
 b=x2NT+drSAqe20xkHa9VHf8XhCgnaM6pT4YwYJiC9ElD0ryY7HWbdQiCazwZZ/f76FSrvwoZNoEyp9bbb8nFLE1SFaVs/pBO3h3cmi0xEdFbTXEPPyWk1w9hM/rmYh/T93PJ8PXmpBZDImTi4j4FMpXhBSbQc5cl+SSJ9lYJzqB7QtdsQ/lWKJfnpaSzRGE1WPRDvbQANhPotTdthokRcLxf3tMS+rve0emla8PtOpH2phmP3tfdnSW1b818P/XKtyRTES/k8roF5CjcWW3hx3JrIVespIYLELeovvHtrIwODQFxPyzyNU1qDWBvC0cq90xIezGs48yF478yXE9OUAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mW6moP4MOQo0b5qm6ciIONHJhkovMQGnoB9iMX/T6ho=;
 b=RAVBb88jogtFJLwRiRX16/15S0btbfPz8E6yPWs8QYyYOGXU/WrJWOp2Em1I1A83ff7bvcs/uhZyeTuXkIn+mI3GJrRZj+5qAaV/LE7QgfRz90N43H4am2FVzx9KhwWAV+eYON0L4cMlMfRqp0WRqaUT0z/G8Q2FWH3YZVzbF88=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by SA1PR12MB6821.namprd12.prod.outlook.com (2603:10b6:806:25c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Thu, 10 Oct
 2024 20:23:48 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::9edb:7f9f:29f8:7123]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::9edb:7f9f:29f8:7123%5]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 20:23:48 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "Colin King (gmail)" <colin.i.king@gmail.com>, "Zhuo, Lillian"
	<Qingqing.Zhuo@amd.com>, "Zheng, Austin" <Austin.Zheng@amd.com>
CC: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Deucher, Alexander"
	<Alexander.Deucher@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, amd-gfx mailing list
	<amd-gfx@lists.freedesktop.org>, amd-gfx mailing list
	<amd-gfx@lists.freedesktop.org>
Subject: RE: drm/amd/display: Introduce DML2
Thread-Topic: drm/amd/display: Introduce DML2
Thread-Index: AQHbGy1fUzMMKs4Rg0GJ2IJ70GgSibKAaRCg
Date: Thu, 10 Oct 2024 20:23:48 +0000
Message-ID:
 <CY8PR12MB81933C5E682F4DCA754501CA89782@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <ec6a9eff-89b0-4fd6-b3b3-5b234ee79f92@gmail.com>
In-Reply-To: <ec6a9eff-89b0-4fd6-b3b3-5b234ee79f92@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=467ee6e0-c360-4fb2-bb72-f6420ffce856;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-10-10T20:06:05Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|SA1PR12MB6821:EE_
x-ms-office365-filtering-correlation-id: d92c88cb-3ac9-462e-8d24-08dce9697287
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q3lHQ3Vlb01sTzBCSHpXRDB1RXBqaVFIclFhRnNOeEZLeUVTdDkvcEhxYkZQ?=
 =?utf-8?B?L3REWWVUREZ0TGxtNGtCTkg5S1JXRlpjcFk5Y3F4Q0tOd3JHS3NXM0tCNDIz?=
 =?utf-8?B?aGlSa1Ywc2dhZ0tqbGZuaHFIWHNmRkx0NkUydVVMR01sMXRNRGl4bWFkWElq?=
 =?utf-8?B?WTF0MmJ5bEEzaXF5WGxhZUpXVzB2WDdnWmNxd1dDMndwZHplMWp1OEhYV0Ev?=
 =?utf-8?B?eVA5VTlxcVAwcVVnUUxVTWZ3WHdpMHVCNy94dm4xK2xHV1k3YUFETFA0UEQr?=
 =?utf-8?B?VVhCQnQwL25HWGhDcHdjUGlrbFREQks3SWt1U1Z4YkUwYkptd3FOZW1WazBz?=
 =?utf-8?B?M0RVSWo1cURiNS9UNDhhdkg1dTRvT0JpNk1lbDdzMll2VG5nS241c1FTcDE4?=
 =?utf-8?B?STJmWVVnNnZtQmg5SzJRTk1BMnViQW1QVm8xSnF2L0FBQ0I2WlpIcUJsNW5k?=
 =?utf-8?B?Zzh3MnczUEc1M1BtMWVQWWdSKzcwTmlDOXcyY0Q1MUppTERub1M2NGVwZ2FZ?=
 =?utf-8?B?ZzBrZVlOMDE4KytLRG4xSjl4ZkdsMDAwY3dtNnFEWVhTMXJ4NDVwOFp0a1I0?=
 =?utf-8?B?UWRHRHNHY0o1WGlDNDF6WXpRMGozUUR0N2JzVk83UENQd2ROYVRIaFRwSmZY?=
 =?utf-8?B?OEN3UVp1cEcrNi9zRGtPMjhURytEcFR3eC9TV21MWnZJMnhxSzF2R1BvUjAw?=
 =?utf-8?B?M0t5eStuZ25KNlRkQjFxRkFUNlZremNiYW1NVlExMEdMRStmOWF4Wk9kbWkr?=
 =?utf-8?B?NDdkTEZrUVpTTE5WaTNma0pOb3h1THVsR3FTUi9jV1NYRHZsODkyTTVNS2ZG?=
 =?utf-8?B?ZXlJdzFWM2YvbE9ybGdRM1JhNFFBWW9hVEdMUTh3YXhPQ3FsamVIWTJSdnZR?=
 =?utf-8?B?bUhmNWtjVkpxT3ZkNGpUc0R6dmVITTN5V2xFbndHUUdhdzFYV3p0RW5uaXo5?=
 =?utf-8?B?a0dmbHdlZnR4dDBtVE1qZHRpQ2RnT0tkOXhrU0M0aDlGcEpKZjlwMko3alhZ?=
 =?utf-8?B?dnVPcEhBeVJWRlNpNnZpeGYvQnJBSkNhSEZ6NDcreTkvSWRMdHFKdnZVczBw?=
 =?utf-8?B?UVM5YkJCNjkyTGk0YzVuSm9zZnNMSnlNWlZrSWplZnp0Ym5wSXF6QWtGQ0ND?=
 =?utf-8?B?Uy9BVWhLWGxXTkZNMnZLc0JSUjlJZnppRnlucW5NM2FNQUV4QnRNTnlnT21W?=
 =?utf-8?B?eDNRdFEzQTBEMDZHOFQ5SHZsVmt5VDVsVzZ1MUp3WDcrbmg4d3phdHc2WUFW?=
 =?utf-8?B?UHdrdE9Ja2lOYkJxUngvUUlQS0d0UU5YR00rajMxREQzK0gzQ0tGUGtMM255?=
 =?utf-8?B?bTBQSyt4eEhJSHUrdHZ3VUQrVVhHUXdpUWNCNHU4WDJhc1VRYWk0UDVENDVH?=
 =?utf-8?B?eFlrYWRTYmg3R1FXMjVva0luRTRQdzA2VVN4UkR6ZkZUZWZMcUhGM3M3WGhB?=
 =?utf-8?B?dmtuZStIZzFLMjBPNzNxZ2RqL0h1dGh2d0lvVUhpbW1WTEo3a3huaGMzQVpX?=
 =?utf-8?B?R1hmSnovQmpSTFJEbjhHNTR6OW1meWYrTCtqR0dkTTVRM21uS2VKcjFZc1JE?=
 =?utf-8?B?c0cxWEdEeitTTjlrd0YvY09SSDZwclBzRDN3d1hYTTNjK1hzQS9Ua0N2V0NJ?=
 =?utf-8?B?SFd4TnZONmQ4RDZEaTdZeHM4QksyUEtWSGxmZ3ByakVXaUpEZUNVM05YWHNE?=
 =?utf-8?B?SjlLR1h4YlFYOUY5V2JiMngzakdKRUsvK3BqcDA5UWRiZ1RSdkRXQ2pLajls?=
 =?utf-8?B?NDhLM0pBYlFKbFhtaC9rQTdyenp3TGdPTmFpYktJR0JOS1g3SGtpR2VqYTNP?=
 =?utf-8?B?VnFSeUdLUlJQVmxpQm9Zdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8193.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T1J6b2dXVkludDJyTk5aTzJrVnRuMDd3am5Ha3BzSVpsUDJCSnN5UFdWQUY4?=
 =?utf-8?B?Z3dlcHNJWExLWCs2SGM3RFFGUnFzQWFiZGdoemkvRDZoektWRWp5NkIvVWt6?=
 =?utf-8?B?c2FTRWdsNElNK2o5S05WQjNGRW0rdW1EUW4zc1RhMXdoVVZud0laeG13Skl5?=
 =?utf-8?B?SzlTbTBUd1M2c2lGTEVMN1lkSVJ5aERzOVFGbjJiR1pRT1NuVXpUeWNqRnd2?=
 =?utf-8?B?L2V1eVgwN2ZpSTkraER2dEhicWVNTlNaWjU4dCtTb2ZVaFJ4NzJnOVlJN0V6?=
 =?utf-8?B?ZG9aMFF2bENGS3k3K3lOYmhxdXpUc3RWMnVRdTZLQjFrMDJPM2w3cW1uVW92?=
 =?utf-8?B?WVVxNFptL1FCeHg3c2ZNanRWT0ZvYzJ6M2tlSWZOVVIvZWIzNGJvTHZhVnpZ?=
 =?utf-8?B?dHRSamNaNTgzQktuR1BBRi8vK2lPaDZXZGpWRXAxTGtmSTQ2Y1hOMVhiV0V3?=
 =?utf-8?B?b3N5TjlvL3NXSnAwMVdLQ1pvSU5lUDdIMy9zUDY5NnE2UldUemNyT0U5czU4?=
 =?utf-8?B?cGxYZFVNU1ZlRFprZDBSZXpxcEhCVVY0WVJFRGEzbENIelhYcUZRQkp1VTJv?=
 =?utf-8?B?ZHZKRUxqT1pKd2h4R1I3eEZsUlI2a3UrYlQ5cVpoT2hRL1BaRmlWdldVRTUw?=
 =?utf-8?B?QXIyRnFMSXRTZzdnUlRDSGlvOFNZQS9IZmFxeGpmL1J0QjE2cC9GSjNBdm1h?=
 =?utf-8?B?UWF1SisxV21sTW8ydDRMUzJUekNtcnRMa1phVWRrbXo0U3l5bXo3UU1Qa0ta?=
 =?utf-8?B?ZUw5Mk5JVXlvS0w5UEpoNUpCd2xiV2VQVGp5L1AxNFNCRkhxSnR3ZWxES2VM?=
 =?utf-8?B?R1Y3UVZPWjVRYWZZUERIclg0T0VzUTFyNmUySnZSN1VtY05lZVVJUnBRQXlm?=
 =?utf-8?B?WGdOeCtKMlVNV2RlRC9Ld252cWhTZE9xUzlReDNkVmNIRjNBNVVjcURLUXZS?=
 =?utf-8?B?YW84ZGE1Y1lZZWZKbk81cWNERzd1Qk91RlpKeWQyUkNDd1BueHRicXBzMkhh?=
 =?utf-8?B?NGdxV1paems5N1BFTzE1UlNVWk1zek5TUUUrQzhIUUF0anVETmdsMHNqRmg5?=
 =?utf-8?B?bjRLMDZPZEdXNnhndnVKV3hkcUVTV2ZhbEFHaWlLeTR1S3U3dzZaaUpiUEFl?=
 =?utf-8?B?a2V5YVVIdTgweVN0NDlxSnc4MEplSHgvaU5kRzBTNVF4d3dJVUJiNldtVUVS?=
 =?utf-8?B?RXpQZHJKVHJCY2hNdVBZc2szYkp0S3VieVFydm4xVmFGZjRqa3J2M0lFQVJp?=
 =?utf-8?B?RmNGakdyT2lNeFJYYTVEZksrQTVBWXR6WkRweFN5WUhTTVJtWVV1cDlaMFU4?=
 =?utf-8?B?SFREa2dlWmRRcWwvMGtjZEJQSnhHN2FKSlYrODVoZlFhS21EKy9GNG8zS0dt?=
 =?utf-8?B?SEhFQ0ZNMzBCNXdUNCtOZDR3L2E2K0s4VXlkRjVVRFEvNFFBQ0UyaXM1Rnh6?=
 =?utf-8?B?ZEY4czVrS3hGcE5Fb0lLNWhtUndrT0VhNzhZeGRnMmVPdCtqNFdSc0JINGps?=
 =?utf-8?B?VTZzN3V6WjJuZ3JZcTZMVkNmbVM4TlRwRE9ZZkdHSHlHU0VzekxhWWVGMDlO?=
 =?utf-8?B?QzZDQjNSRnQrYWJKaERIQzJCNFgvck42MHQ5OVVkOW5BVVp1K0wrUXJZUnFz?=
 =?utf-8?B?NFFrMVdROVdZYlhheTB3SFU3WFkvdFVWOE1zVC9TUkVFWjhsNHdEcGNHcHp5?=
 =?utf-8?B?OGVrV1pIcnNKLytHc0lkbXc0SjZneXA4dlBnWnVkazBxeUxHNWZlTE01UUJH?=
 =?utf-8?B?dHVpYjVIM2Z5SEZWbjVWYnpDMFhaYTltVkRWaHRJR0hUQVA3c2xDaUtjYWRw?=
 =?utf-8?B?THV1TlAzdFp3SWxCa3E2SHRnU0ZDbFF5Y1FSV0RhY2hPODF2bjlicHV3YUNj?=
 =?utf-8?B?Sm5OZDZGcDVwcEc4bFgwREU1OHo4N0s4anVQQ3UzZWh0WnVmNEF1eDg4ckJT?=
 =?utf-8?B?Ym80dkFFRXlucmkrdG9CV3hndlZqaUMvditudlczV1VVYmJDZTBRdis0WUd1?=
 =?utf-8?B?clZuQ2NwOTRKck5JeDE1VnIzd0NhL2Z1aHdiQ1J3RSthVTJTblAzcG9qSVZi?=
 =?utf-8?B?U3g2eHh0TlQvRXhKSWtDekx1eGJrTlU4dGJya2x1VnVPWWVQRzRSTHZuY2tn?=
 =?utf-8?Q?T8eY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d92c88cb-3ac9-462e-8d24-08dce9697287
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 20:23:48.1663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nUJERaRk70YU54WfgLI2LfYF4maNDm6414uzDeFxyKkJDueUqe/EBI3VNwEvs7BI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6821

W1B1YmxpY10NCg0KSGkgQ29saW4sDQoNCkl0J3Mgbm90IGNyaXRpY2FsIHNpbmNlIGJlZm9yZSB0
aGUgY2hlY2s6DQpwMV9taW5fbWV0YV9jaHVua19ieXRlcyA9ICBtaW5fbWV0YV9jaHVua19ieXRl
czsNCg0KVGhhbmtzLA0KUm9tYW4NCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IENvbGluIEtpbmcgKGdtYWlsKSA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT4NCj4gU2Vu
dDogVGh1cnNkYXksIE9jdG9iZXIgMTAsIDIwMjQgMTE6NTkgQU0NCj4gVG86IFpodW8sIExpbGxp
YW4gPFFpbmdxaW5nLlpodW9AYW1kLmNvbT4NCj4gQ2M6IFNpcXVlaXJhLCBSb2RyaWdvIDxSb2Ry
aWdvLlNpcXVlaXJhQGFtZC5jb20+OyBMaSwgUm9tYW4NCj4gPFJvbWFuLkxpQGFtZC5jb20+OyBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+Ow0KPiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBhbWQtZ2Z4IG1haWxpbmcgbGlzdCA8YW1kLQ0KPiBnZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnPjsgYW1kLWdmeCBtYWlsaW5nIGxpc3QgPGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnPg0KPiBTdWJqZWN0OiByZTogZHJtL2FtZC9kaXNwbGF5OiBJbnRy
b2R1Y2UgRE1MMg0KPg0KPiBIaSwNCj4NCj4gU3RhdGljIGFuYWx5c2lzIG9uIGxpbnV4LW5leHQg
aGFzIGZvdW5kIGEgcG90ZW50aWFsIGlzc3VlIGluIGZ1bmN0aW9uDQo+IGRtbF9ycV9kbGdfZ2V0
X3JxX3JlZyBpbg0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sMi9kbWxfZGlz
cGxheV9ycV9kbGdfY2FsYy5jDQo+DQo+IFRoZSBpc3N1ZSBpcyBhcyBmb2xsb3dzOg0KPg0KPiAg
ICAgICAgICBpZiAobWluX21ldGFfY2h1bmtfYnl0ZXMgPT0gMCkNCj4gICAgICAgICAgICAgICAg
ICBycV9yZWdzLT5ycV9yZWdzX2wubWluX21ldGFfY2h1bmtfc2l6ZSA9IDA7DQo+ICAgICAgICAg
IGVsc2UNCj4gICAgICAgICAgICAgICAgICBycV9yZWdzLT5ycV9yZWdzX2wubWluX21ldGFfY2h1
bmtfc2l6ZSA9DQo+IChkbWxfdWludF90KShkbWxfbG9nMigoZG1sX2Zsb2F0X3QpIG1pbl9tZXRh
X2NodW5rX2J5dGVzKSAtIDYgKyAxKTsNCj4NCj4gICAgICAgICAgaWYgKCA9PSAwKQ0KPiAgICAg
ICAgICAgICAgICAgIHJxX3JlZ3MtPnJxX3JlZ3NfYy5taW5fbWV0YV9jaHVua19zaXplID0gMDsN
Cj4gICAgICAgICAgZWxzZQ0KPiAgICAgICAgICAgICAgICAgIHJxX3JlZ3MtPnJxX3JlZ3NfYy5t
aW5fbWV0YV9jaHVua19zaXplID0NCj4gKGRtbF91aW50X3QpKGRtbF9sb2cyKChkbWxfZmxvYXRf
dCkgcDFfbWluX21ldGFfY2h1bmtfYnl0ZXMpIC0gNiArIDEpOw0KPg0KPiBpdCBhcHBlYXJzIHRo
YXQgdGhlIHNlY29uZCBpZiBzdGF0ZW1lbnQgaXMgY2hlY2tpbmcgZm9yIG1pbl9tZXRhX2NodW5r
X2J5dGVzID09IDANCj4gYW5kIEkgdGhpbmsgaXQgc2hvdWxkIGJlIGluIGZhY3QgY2hlY2tpbmcg
Zm9yIHAxX21pbl9tZXRhX2NodW5rX2J5dGVzID09IDANCj4gaW5zdGVhZC4gSSBkb24ndCBoYXZl
IHRoZSBoYXJkd2FyZSBzbyBJIGNhbid0IHRlc3QgdGhpcyBoeXBvdGhlc2lzLg0KPg0KPiBSZWdh
cmRzLA0KPg0KPiBDb2xpbg0K

