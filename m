Return-Path: <linux-kernel+bounces-176597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D03D98C320C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 17:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644C21F21797
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 15:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E3B56452;
	Sat, 11 May 2024 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NceUx6S4"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348194431;
	Sat, 11 May 2024 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715440382; cv=fail; b=FkdMLnuzVDN7CGnsHWofjn9qrECnz02aAHk3i9wvoklfrELCYHEDdLEGvi+VeotCvcfslZ9kd4/aBxVEAtlkK4fHAo28ZiiLUNLjx7RkZH8AHMXKqiXt+E967ozE5AAeWvHbHles2oJ5fJag4uYXhtrD/u/W/Q3PFXfdTjxheLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715440382; c=relaxed/simple;
	bh=N/F32oCVw8XNVCL7DOoiWwSmWQDo1XO5AX5KJaViZQM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Su30X7P9Nk0/BChmT0NIlljdX7CrAbBWYuwMHdclPdJi8XqjOdYp0mIi2H0+BklQcw+fhDWItFBYEzJujAcuHeBoUQOqEJwkGU08S+oxXOaURwor4i1lq78WW+FllgDOrIEWQxTa33hxNOFfnISqnoHqX4oqv7pKZk/djq6cYus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NceUx6S4; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWJ+aAyBy/C3iX4e04svhgJOaEy2LcYk+FmdTna21ymi2ttmLahn/AHIVvlGYmdHx435lxeL8ic+MlCL4ubVovAjtZLvZ7KPTZInUlkQy2bYu36XfP+u+TLw1SyP+53Q6vzKtg+i/gVX9VXCBQBwHdOBm6fjalvkspjpvDucbNScchEI7Un3PtuOMuKm/K0gwH0L9K2PGNOVJwSPknYggKvTfO9KD3wR5ctHqc+/vHkoHiaz0jTzlRIy9q9pc/sDu7URbGDGLXyaCyKm5gfkeIx3NfweIEStExqeJ53iA/fVm6kVDfL6OrkOzP41DwQmZjeOgQOkTosTJh9OXqQngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22KswzgjOa62/K/K9jc3bzvbQckL5rSNn72XhOC0GI4=;
 b=Z533gr9s4PPoMBGUOs8v7vJOGTVjJhIpDJfk5Ff7/ALUmAkLfkbGWIbtsz5Z5mNG3vNBV58xZGzeNccl+aEAz7avJrW9wypH+8Aa/VDHit/PfSToatjy5Fk56RI8Uadf3TP10zJkwZqyNOCnlu9zxIluG4sywNfJvS2b0pKsHPXXW8Qi9SumxUrvH77kXGoUwpSBj9/t19IDs0BgaR1d4WWJld9RPuBHa0uCoAON80jhbFCa0w4Z6CZZ4XZW2sQuBRDolCyHRtYC+SWMGqBNUDBqbpa1OKaC/xPcH/3BNLM1CubZyPrtcpARny9AcjHNSlSx5v02qDFM8m99rwKRAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22KswzgjOa62/K/K9jc3bzvbQckL5rSNn72XhOC0GI4=;
 b=NceUx6S4pAw99j7xNz3jITbxndUnmCHxH9Xp/utaTZJZcFNPz5N+jUIjghmK1ehmlcAMxYy5oJWy0BeMyfogyIADCcI/FJkhthDgCelVp982fnTkl0wuqZXovWnAv0UyjerrIXqL6QlFxYlq84bF1edcD8LZEO8VPDHU2/yOTbM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sat, 11 May
 2024 15:12:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7544.052; Sat, 11 May 2024
 15:12:54 +0000
Message-ID: <a1306ffa-c0ea-4ce6-8692-76bf37850e8a@amd.com>
Date: Sat, 11 May 2024 10:12:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] platform/x86: dell-laptop: Implement platform_profile
To: "Shen, Yijun" <Yijun.Shen@dell.com>, Lyndon Sanche <lsanche@lyndeno.ca>
Cc: "pali@kernel.org" <pali@kernel.org>, "W_Armin@gmx.de" <W_Armin@gmx.de>,
 "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "lkp@intel.com" <lkp@intel.com>, Hans de Goede <hdegoede@redhat.com>,
 Matthew Garrett <mjg59@srcf.ucam.org>, Jonathan Corbet <corbet@lwn.net>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Vegard Nossum <vegard.nossum@oracle.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dell Client Kernel <Dell.Client.Kernel@dell.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240501215829.4991-2-lsanche@lyndeno.ca>
 <BY5PR19MB392256C65661E76FC292C0889AE52@BY5PR19MB3922.namprd19.prod.outlook.com>
 <63894ef1-c482-4646-8351-4d6cfc6c528f@amd.com>
 <BY5PR19MB392299916A85FF06387DC9C19AE02@BY5PR19MB3922.namprd19.prod.outlook.com>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <BY5PR19MB392299916A85FF06387DC9C19AE02@BY5PR19MB3922.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:610:b3::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b6254cf-4a12-4515-5bc1-08dc71ccd55d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDlWOFpWTHVNbGc1N25POXVsMkllMWhhTE8rVlVRVXVpamlHWGluT1FPZXhn?=
 =?utf-8?B?ckRUbDh2TldpRTFUZ1RDR0hYTjVyZTFuTXNXUk43U09xTmY3blc3S3JLbXhF?=
 =?utf-8?B?K0hxRjFIN2IrUlZvK1VmNGpGQ2RieldvSjYwZUQ4dzcwL2ZSZGw3ME1aYWJi?=
 =?utf-8?B?Ukh1U01Ea1ZKMnhzTitHOVlFWUswMjdaeUUrdTBCWkxTbEJGZWg1N2kzRFV4?=
 =?utf-8?B?QVRvT1o4K1lCb05sL3VOOE40dzFRQ1RCV1RDa1JkRzRWQVdONkloby9nU2xR?=
 =?utf-8?B?S1pza1pQY3REcjVkNG0zSXJ1cHJuQzIrMmRIRmlWanlHUTdGdGZqZHBrdHZl?=
 =?utf-8?B?Q0ludDYya3VIV0w5U2NDVCt6TTVNUkgxa2duR3dTSDd3WGRzd1RoN1lFSXdG?=
 =?utf-8?B?bmlPc3BxcHVUemhEZWp0Mjk5SkhtU3dSU0RMOExPMkREVGNNNmg5Q2s3TlZE?=
 =?utf-8?B?RFZWYS9yZHA3YXJiNDd5cllQYW0vdWxMNFR1WVcvb25aMFZlODhsQUo0TVI0?=
 =?utf-8?B?aUFzU21lc1o0OGtDaFpuMTFCZW8zdEp2NzJkcENOUEI1SHhGVUdqSytVcWlh?=
 =?utf-8?B?N0NpbDE5OVlOR1F5Q0N5ZUlvOU0rb1FaSm8yb0l1alplMUtSYytRL2ozdFVC?=
 =?utf-8?B?cnZDWGVyZThxaXVUb21kczhjVjE3Q0JTZ0d1OXgxaEJLcHE3OEFCYnFwTVJX?=
 =?utf-8?B?ajdzR3VCTFQ0cXpOblA4ZERsRTFMVGkva2t5cTZMY1l1azBhNXJRQzE4THJY?=
 =?utf-8?B?Y09MZGdYRzB5eUo5OHhMSEtkUGZvdDhob1QrYW02ZU9FZ2c4NWFnYlJPZnVt?=
 =?utf-8?B?TkZFT3FJMDY3a281aTFpT0Rrc2JWVE1Xd2FiQS9QUlFvb25XOVFXRlY2aVJo?=
 =?utf-8?B?d3krV1g0NnhmRmpmL0lmUUF3Q0p0djJCZ0V3b0hJRDBzbm5Qc0lPcVIrbGl4?=
 =?utf-8?B?K08yMjZZdFFtelNuZ2Q0a3FERVA3SlpsNFEzMEpIdjRaMDd1OFN6UUsrbGZF?=
 =?utf-8?B?Ukp5RVBUMlQ2cGNDbStCTStJajRUcmptZEQrbzJLV3ZHZitwYWtpMk1RV1BS?=
 =?utf-8?B?b2g1Y1pMSjhWQ0JpWk1obnhaVlM2ckgvWUg0MFE2dEJJNEUxZDR4U01tTW1y?=
 =?utf-8?B?N2FlQVd3cENQaVY4TjYvMjJhQjlkeUc1RXk1WUVVb3RyQ21yRUlpeHljQUVW?=
 =?utf-8?B?Zmk5VzM0T051N3ltSHBUR250akVFQnBRTVhTZEQ0YW0vN2x3R0h2a1YzVkZr?=
 =?utf-8?B?TmlrVlVpeUF5bHBUQ2NMeDZiT2JHZ1BheWpDYW1jTytaTnV1UFpScUpzWmdo?=
 =?utf-8?B?WjV1ZGduMHhnaEp2dVE3OEZ0bm1YZWVPMGhZaWh3Ykd1dlpndzRybFB4TFU4?=
 =?utf-8?B?cEl0RDdvMG10c3AwMzVXc3JpNDR2SVdINkZ2UDAyZlREZnI3RENuLzhDMjVa?=
 =?utf-8?B?OSttM2xWcXVHU0gzdTE3VkZoOHdSMlM0b3g3WkQ2RWkydmV5b1V5RlVCMmpF?=
 =?utf-8?B?OHg3WWlpT1UyanhQUTcxWGw0Z050YU1oVlR2NVJOWXlCRWZLV1kyZ3gvK3J6?=
 =?utf-8?B?R09kUUlDY2xOZjBHcWtBUXVUVjdQSXpEeHF5eEg2cGg1U29nNnlrcHQzV0Rk?=
 =?utf-8?B?Ung2eXpXdzNITVhhVEw5bFVWZ2lDWDNSclMzQ0wrN0tXbjJ2ZnVHa21ESE12?=
 =?utf-8?B?MzdUZHZqQ0wwdXJBMFR4OFQyb0MyMFo0WVlObHhBKzIvNG42RnlKcnB3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1h0TlRucVczc0o0MHVDblpXVzd6dlBmVG1UMDY4MFdQeUt3dDRGa1dwRkZD?=
 =?utf-8?B?RWFPamoxR3hwQlVObWpVZmRrZzV4MitCdVFObmVmTG1TY0JZVTdsTGhPbUFS?=
 =?utf-8?B?YXgxUWZvcmR0SEFZL1ZXQzgyUC9JdmJTaW90cUplK1JzNDJDOXN5SVpGdkZI?=
 =?utf-8?B?VHI0NUhqR1RZSlJXR25iR0N4U2pGL1FPc0dXNnZ1SWpzZlFBY3VqYU1SU0Zz?=
 =?utf-8?B?WmxGRlZ0TG5qaUt4VVIvWHhEY01nZzBmbnkrK09pRTB1VHp4VE9aQldGRktx?=
 =?utf-8?B?Vk11bGhIdkJBYk5PY05OWXJUQ25DQzcrR3NIbzFTb3EwYWJTd2FOY3B5SU1S?=
 =?utf-8?B?VmlRNnlKLzlEMmtOK0VtMVhaaHU4ZXZZNk9HZlhVdlA0TWlmalIrandJYklQ?=
 =?utf-8?B?NU9kTzkzSkExaCs0RHQ1SkJibnVqSDk4U1BqVnJ3MkNhWHlabGE5djF6cUg3?=
 =?utf-8?B?QklyVlpIengrYnFnVEtzV0lUanovQTY4VG1zamk3L0F5ODJwVHFnNDYxQ2p1?=
 =?utf-8?B?VldaekQ3cG5EOHlHUjNHWWJ5SWVVZDNmd0NFRmFUbFNKalZzdTJXby8vS2JY?=
 =?utf-8?B?SkdFN2pibFpPUjZFRE4zRTBVcEN5cGc3UU9iS1hUVm41VzRnelB5dkJKaWdQ?=
 =?utf-8?B?S1JaMXQwL1AzeDlxZC9oUEFrNFBpc0YyanNMb0ErUDAzQmozcXpWMTVmaXpL?=
 =?utf-8?B?NDVQZGlTcGVET3pRbWNPLzJ6bkZ1cDR4RzZ5S3NCT2pSYlgzT1Vzd3kyczEw?=
 =?utf-8?B?N0FTcTBDa1dDdFdPRENFdXp1Z21Ed3VKcFZRMGgyUVYyYnZGRTh2akIwcVVQ?=
 =?utf-8?B?aDd5VTR0OUd3TlQwbzB4bGlFOEt1ZklIcXl5UkJEeGExWHlZY0J3WlV1RmVV?=
 =?utf-8?B?NGgzdzhlM04rbDZINk5ZdDJScFk4Zm1IVVBuaUNpbWtrbFF2WDJxQkYzSXNT?=
 =?utf-8?B?b29rcVIzRWNXRGZzbC9VNE1ndkgrUEpVSHlHZDF6UjdIV1Q3RVVLRTdRcS9t?=
 =?utf-8?B?NEUwbkdNQi90cXExNDhOVUFJUjJtamFxYTZqV2dzNDlLZHVTQ3dLZS9nUGo1?=
 =?utf-8?B?VUF2OGRHY3RWWWtKY3VZbFJSamJDQlNkeFZMb3FwaVo4Y0dLWnNhN2Z2ZkVB?=
 =?utf-8?B?R1RCTW1XSllQcXdNa3NhL21HOWVZUTdONENxMk10QnhQbHdSS3BtRHFYQUhm?=
 =?utf-8?B?SUJ1emNnTHBLSzRGdG1XLyt5WHlkNUp0ZU1YVjNQU2JuQnU3VDl0WGJreEo5?=
 =?utf-8?B?ZzNFVnh5UFpzWmxhSmhFcEtVRG5GRC9GZEEwNGgwY2FhRkttQndHZURwcDRh?=
 =?utf-8?B?Mm1RdUpMVTdxUGFuUGZueTVQb0NmbEh2bjNUZFBqeEJsdlRFQVlwQ0R0UFhQ?=
 =?utf-8?B?c1BRekM4bk9ZenhZNVB0TFhtMFh1QS81UEI5QytuZGl5MlU4ekpsZUlmbUdD?=
 =?utf-8?B?VXNvUHJnVUlSZjU3RzlWZThDQXNUYkZvd3FXL2tBeXpXTytOd3VhNENHTW5S?=
 =?utf-8?B?dGZtWkxJVi9vbWl2dTcvNjBEOXpoNnRUOE9OTW96dUljZlFXeHpXYUxCajdG?=
 =?utf-8?B?WGFrZEU0WDFFQjZlaDg5REJ6bEhTRTdBelR5bG5aZUpHQ0ZjcGx3SnR6WjJU?=
 =?utf-8?B?WjN0NzQ0YWFLUUlNTWtMRGJqZHVZbzk1ankxUng0cFEwMmNnVGdCaC9sbG00?=
 =?utf-8?B?YVowRjlVckxxWUNMaEJKRWVBRDJkaG1rMVFZYWdYc043N2dZT2xhQWVHN0ZM?=
 =?utf-8?B?VklQNWUrNmFGYUpPS3pCaTVmV0trTTlncGRHMWRwZGZmK0gxTXQxQVI5eVRN?=
 =?utf-8?B?eVdseWpLZzlpRnhaVWNCRzZKaWV1SmRMeXNKMGpQV29la3BIN2FqVVVQd2pm?=
 =?utf-8?B?b0FDMndhcStaVTBRQ1Y5QzBjcWVML1owd3J1am5mc29IOTh1UFRvYVlidzJs?=
 =?utf-8?B?T2swNmd0NmQ5dEozVTZsWDBlSTdIMkJhYnlPbEtzYzZHemtHQ04yY2xsbnRI?=
 =?utf-8?B?Vkh1bDB1bnF6WjA2RmdGOWdjNXB6UWwyd05FTlJwbVpjWFRLbVdTcm4rcWhk?=
 =?utf-8?B?TUlrNlZieCsxZkpDU0VwQnhNWkU0QWVqZWJvYXg0SHp2dWk4R0hMUCtXd2M2?=
 =?utf-8?Q?DzwyH2CG0SRAhghoAu/RgVbBM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6254cf-4a12-4515-5bc1-08dc71ccd55d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2024 15:12:54.7651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hiephPb6cpc7cxd3d3biA2FQRXpcZBr/R3pitc/m6NWOx00u2s8zfyL1kEebTIP1e326u8dh9VzOi/+jJPv0SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706



On 5/11/2024 10:05 AM, Shen, Yijun wrote:
> 
> Internal Use - Confidential
>> -----Original Message-----
>> From: Mario Limonciello <mario.limonciello@amd.com>
>> Sent: Wednesday, May 8, 2024 11:53 PM
>> To: Shen, Yijun <Yijun_Shen@Dell.com>; Lyndon Sanche
>> <lsanche@lyndeno.ca>
>> Cc: pali@kernel.org; W_Armin@gmx.de;
>> srinivas.pandruvada@linux.intel.com; ilpo.jarvinen@linux.intel.com;
>> lkp@intel.com; Hans de Goede <hdegoede@redhat.com>; Matthew Garrett
>> <mjg59@srcf.ucam.org>; Jonathan Corbet <corbet@lwn.net>; Heiner Kallweit
>> <hkallweit1@gmail.com>; Vegard Nossum <vegard.nossum@oracle.com>;
>> platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org; Dell Client
>> Kernel <Dell.Client.Kernel@dell.com>
>> Subject: Re: RE: [PATCH v5] platform/x86: dell-laptop: Implement
>> platform_profile
>>
>>
>> [EXTERNAL EMAIL]
>>
>> On 5/8/2024 09:24, Shen, Yijun wrote:
>>> Hi Lyndon,
>>>
>>>    Thanks for working on this patch.
>>>
>>>>
>>>    Dell side has an initial testing with this patch on some laptops, it looks
>> good. While changing the platform profile:
>>> 1. The corresponding USTT option in BIOS will be changed.
>>> 2. thermald will not be impacted. The related PSVT and ITMT will be loaded.
>>>    Some Dell DTs does not have the USTT, Dell'll have a check if nothing is
>> broken.
>>
>> Hi Alex!
>>
>> Have you had a check both on both your AMD laptops and workstations too,
>> or just the Intel ones?  I think it would be good to make sure it's getting the
>> correct experience in both cases.
>>
> Hi Mario,
> 
>   I've a check for this, for both laptop and workstation, the dell_laptop module will not be loaded. So, AMD platform will not be impacted by this patch series.
> Follow is one example output with workstation.
>   #lsmod | grep dell
>     dell_wmi               28672  0
>     dell_smbios            32768  1 dell_wmi
>     dcdbas                 20480  1 dell_smbios
>     dell_wmi_descriptor    20480  2 dell_wmi,dell_smbios
>     sparse_keymap          12288  1 dell_wmi
>     ledtrig_audio          12288  3 snd_ctl_led,snd_hda_codec_generic,dell_wmi
>     video                  73728  2 dell_wmi,nvidia_modeset
>     wmi                    40960  5 video,dell_wmi,wmi_bmof,dell_smbios,dell_wmi_descriptor
> 

Ah; right that makes sense.  In that case, is dell-laptop even the right 
place for this patch series?  I would think the same policies for the 
platform profile should be able to apply to desktop/workstation.

The v6 of this series would block smbios-thermal-ctl from working on a 
workstation too.

>>>
>>>     Additional, with this patch, follow behavior is found:
>>>    1. For example, the platform profile is quiet.
>>>    2. Reboot the system and change the USTT to performance.
>>>    3. Boot to desktop, the platform profile is "quiet", the USTT will be
>> changed back to "quiet".
>>>    This looks like not a proper user experience. The platform profile should
>> honor the BIOS setting, aka, the platform profile should be switched to
>> "performance".
>>>
>>
>> I agree, this sounds like the initial profile needs to be read from the BIOS
>> settings too.
>>
>> Furthermore I wanted to ask is there also a WMI setting that corresponds to
>> this that dell-wmi-sysman offers?
>   Yes, Mario, you're right. This thermal setting could also be toggled by dell-wmi-sysman.
> But, for the Dell consumer AMD laptops, like Alienware, the BIOS is another variant which is different with the workstation one.
> With this variant BIOS, there is no USTT and also no dell_wmi/dell-wmi-sysman.
> 
>> I'm wondering if both should be probed in case the SMBIOS one goes away one day.
>   Yep, I think this is a good suggestion.
> 

Great! Although something I wonder is if the policy when changed with 
dell-wmi-sysman is immediate or requires a reboot.  A lot of the 
settings in there aren't effective until after a reboot.

If this is one of them then it might not be a good idea to make it work 
for both.

