Return-Path: <linux-kernel+bounces-334663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3C397DA2D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 23:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E865B22974
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 21:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630D317DFFA;
	Fri, 20 Sep 2024 21:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RYcsmEBJ"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44E5B663;
	Fri, 20 Sep 2024 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726866314; cv=fail; b=F785zX5vmDPSJL9qiIKG0tG757Bgm/2ZFgyK1ht2azyFtCoIBlaqegSjNi1b4ghDEGn5Ne62i+yjibfVAX9RwBCnWuUFfNjQS1UwLNaxvI0wwMeCaUBzzcZTacYmzCwu8B9fcSB1XGVMk9YkhBeeJe7UCt5ikVgfkCQLUmCtKFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726866314; c=relaxed/simple;
	bh=rgAowyt04nWTEyyiOoh1stJy2I0EKfhb0FTCMIb9FXY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FjVNdwhWP+0aX9KuMS4C9evxdrUw7liY5Q+HtufFmk4bBANN7VDvP0//Q59oY5NFPBGf1DOo0kMsmFtIxS85nQE8++sEn3aJuZpSU4wJFxY8CTBJGdWJGc/65+UnaDY5sPmqZ6ko+Ma6Lkb+pmMj89ZbrF6II8CN7ersh5ry7mY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RYcsmEBJ; arc=fail smtp.client-ip=40.107.96.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPhzBy8aCIIExuo4bG/M5+qTmfkUZsPelQho471rp46QR1k0lQkVKdYVg1U43Q65pA5xtoxiRazB0qwnDKT6dTIyXUpOU111Rz7YZ2OaYaODe5qMmJ7d4Dv7yG2glbvKcLg3y8MivZSIH5F88B0V4L+nBFptZpXg2KpO+xBIJoBcZsgX5r4N4H6+vDFSa98VRAcd+7FDy3sPw2f2gucd4EpIwgNBHenfBNU1pbWhjO0fNWg+jJBtvNM65x8E7Y7c3DmXW+J7+20LDO94W5GDHzhDJDzDumrR9Gmbw/iPTKYJA9uVfLBuK6Y5BVjw/kHC+5xt/DPj3bjIw/DoijP67w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/s5i4OTraew+035czohAbEE5HLUzlNBkDfnroyNeHbA=;
 b=dFChBJliq411gcc3hy9bRq2gNV+dlTW6tBW7Kq2MUyV9q5TtOSHNZMojiz3xsGnLNaOzTciChyYzeu8yKNOxbf3IojYgWqic+m9ArhwnBE8UlD6sv8dGb+mC+OcpJvO5+o495oaP92Pltt+JTlTK6JJ4ECarfSxYMZCX/V67qjvUc22GFSVxo9jpbmNxqCK2iZLAAsrjhFgFeBI3F0WPfzT2n+RD1zBhBiKWrQGBoYJb4ALYdaU0n0zKcLUaSK3djZDsRCLhXLTnLz9dGDbvI5xppti5JxTT/fe+ZdVUN4vLtbIwr3SNODhvJk67E4ARl6vOGAgt0uh1R/jjzl/wUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/s5i4OTraew+035czohAbEE5HLUzlNBkDfnroyNeHbA=;
 b=RYcsmEBJveDPMEFOIW97nLwpi7XK7gBXsqIT6c7Ih/l8FVsjcBWi+XOZRTmbTlrY5i0gO4VUZAsAsFx7/slFbNKA73NtEVITJ2U90qjsrJL2hc+vM648BDIRvPcmJghfJwXkOH7gb0QUEGUycPOVx+fAr7muX+HKC/rb5WQ7ZKU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 21:05:10 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7982.022; Fri, 20 Sep 2024
 21:05:10 +0000
Message-ID: <da455b76-bb97-aeb3-82b7-7f6140a7d79e@amd.com>
Date: Fri, 20 Sep 2024 16:05:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 3/7] x86/resctrl: Introduce sdciae_capable in rdt_resource
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org
Cc: fenghua.yu@intel.com, hpa@zytor.com, paulmck@kernel.org,
 thuth@redhat.com, xiongwei.song@windriver.com, ardb@kernel.org,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 sandipan.das@amd.com, kai.huang@intel.com, peterz@infradead.org,
 kan.liang@linux.intel.com, pbonzini@redhat.com, xin3.li@intel.com,
 ebiggers@google.com, alexandre.chartre@oracle.com, perry.yuan@amd.com,
 tan.shaopeng@fujitsu.com, james.morse@arm.com, tony.luck@intel.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com
References: <cover.1723824984.git.babu.moger@amd.com>
 <cf9e47bbd66dbbdb76f0124620fad2f1b06e977e.1723824984.git.babu.moger@amd.com>
 <254da029-81b2-4745-bc78-5aefeb33adb0@intel.com>
 <b96e5de8-75ce-4a7a-8788-f5d3a959d771@amd.com>
 <89da43fd-69fb-48a6-830e-e157360aeab6@amd.com>
 <dbe8a012-eb21-426f-a8e4-46efee26da62@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <dbe8a012-eb21-426f-a8e4-46efee26da62@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0235.namprd04.prod.outlook.com
 (2603:10b6:806:127::30) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN2PR12MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd55572-0589-4edd-a02d-08dcd9b7e96c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUllL1cwaFk4Ry9NVXltTHhlWnovWkRWdUpHcFNWTEZmNXlNN3NPZWNFT1dB?=
 =?utf-8?B?TC9tdFFTKzRkRkhTQm5HS3htZ3U4VjNpKzZBcmpYdU0zbEgyMnoxOXdIem95?=
 =?utf-8?B?VEZFajlwamdCSU5peDg0STA4NnZ2c2lpMFFWcVdxOUJPakhjOTk2cFd1Mlcr?=
 =?utf-8?B?TGludEtXdk9FQ2xKdFMzcFdBY1hZQTM3LzVtdkxMQUQxQm8vcjcyMWZOak01?=
 =?utf-8?B?U2gzS005SytwK1FIWTJaS1lxUGgwMm56T1BvcXlZV0k4RTg5dUVVN2ZkYjZy?=
 =?utf-8?B?SkVhMVl4ZHpUNmJxOWFoc2hlN1hpcjlvRDBkd3VlTkExNDdYaXp1RStaTE92?=
 =?utf-8?B?TzgxZ3RDSzVLNncwSlljZnFGQ1hGRHlZRURlbk9EdC9yR0tZOHZFcmg1QWFL?=
 =?utf-8?B?MUpSaWdtUkpEQW1wandLbzBSQStRNzFrWHhweW1xZWtHRzF4bzR6Mzhwdmlv?=
 =?utf-8?B?c3cwd0hNaEJSdVFocEI0eFRnRnNIeHlWeTYxdGdRakNNcW5jOE00dGhwcFBp?=
 =?utf-8?B?UERBdVVOUVU2ZHBwemNkcHdYeUdvcE1FRXZBVzNoUnFHK3hRMmVneDNqeEhq?=
 =?utf-8?B?d3IrWEF3MUFsZTR3M09meUpTbUdhWC81NXNqeXdVdGt5VnhqcDZ2VkdBVlMv?=
 =?utf-8?B?SlVWNkhUdzRqN0EvWE1aMW01VTNiQVJYOTdMSTV2NzZKQ2hkWlNYb2NEcmlk?=
 =?utf-8?B?aHhZVHoySmJKVlVRaWVCeXVzZmdpLzI5NnVPVzlWRVIwRXNzK0RES2R3V2RW?=
 =?utf-8?B?ajFxOGZrcUtjZmp4bEpocjM2cFdRYXVsVWRERHdwOWdoaTgwbU9SNTNCNGVB?=
 =?utf-8?B?ZC80YW5vbHlVd1YyTE5CMTlMbXFxOTUyYTR3K1JjVmk1cUFSVTlXUi9zV2R6?=
 =?utf-8?B?SGcya0JGSW4rNGVaQmhodjZMSm1XQ2x5K2dDc0tpaDdTM0tXdG5QSTlaWXF5?=
 =?utf-8?B?YzFqUjdIRzhzV2JHcjdvZFR1NTQwVXExOFc4Y3pnM0kzVmtjWExLWUg3Sk1s?=
 =?utf-8?B?VExwWGZ5dzZrQXhpS00zV0N5NG9TZVMxRllmMmxLTEZJVkVJVnNmKzhzL2E2?=
 =?utf-8?B?ZkdLVXhlVmorUHJXS2RGRVFHYnpKaUltTlptc2Vkd1VnUE8xQmZOU0V3a0pz?=
 =?utf-8?B?NndtU3BKWXp2cDJPaWJ5aDlyZUszb2lOTWFvd095NmpBWmxRYjdzdnlYeVk5?=
 =?utf-8?B?Ui92NXh0cVMyVU9Ndm56MTNWUXhreEwyUnR6ZjlKWkd1akJZbzNYMEE4bEVF?=
 =?utf-8?B?cXZkVmErUmN3bXJzakR5Z25KSXltS0dMdDIzdGM0a0FBZmduT25HSWl4angz?=
 =?utf-8?B?MDU3dk90a1oyOEwxUzQwRXFXMkU1V1o3eVJLdTRmUFdKeFNaNS92TzY0QWFB?=
 =?utf-8?B?bmpYTFlZV3pNSi93M3JFdnBRZmUyQU45Uzc1dS8ybUovaDcxdllKRWxnSHdU?=
 =?utf-8?B?aG1uVGpkVGlhNWliM25GYkFTdzM5UGpNd3dqOHlnQWlJWVJ5S2x4dUR2ekxl?=
 =?utf-8?B?K29CZkljbmlCOTJsakFwcDNEK3ZVYnpIUk1jeHlJdmpGQnNOWjNZS2dzSUtO?=
 =?utf-8?B?a3N3OGZXNWRyT2MxSzJ3WjJMN1hVd2M5Y3R5dEZ6VU13U3hQd3RMZjRUL0gz?=
 =?utf-8?B?NmEvbjVWMGxQRmZEVC80L041OVR4Y2ZXZjFEOTFyMmtYbk9JN0xXZVFQcC9l?=
 =?utf-8?B?YVZRZFlZQU9BbVQySjd2eWZjcWR4N1dhWlhMUlBzMGJFaTlDcGhJUWtWV2c3?=
 =?utf-8?B?QnlLMFo2UXFHaTU4VmUvZWpoQ2N2eTRPRXQxZTZ1TUoxTWVhckNFZHhSaHla?=
 =?utf-8?B?RlBPN3pYR0pZUDdFTWRKUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkFKVmhlRS9pWWRvRUtBYkxaMlZLcWd1d1dVdlNwYWRXa25RUFh0V1d3VGdZ?=
 =?utf-8?B?YkYxTWhEdVUrVXJqNW1keCs1UENRbll5MWhZazM3T2oyMmQ2UE0wdVJNN0FV?=
 =?utf-8?B?QlRhQVlmVnZpOU00ckx4aTdvV3FpOG9VV09mb3VQelRsODFRKzlZOEdobUNP?=
 =?utf-8?B?VjZ4YllXRzVpQy9RZy9PN05oMlpuNmU1WXNYR0xXUmY1Rmk3b2xVU1hxdGh1?=
 =?utf-8?B?N2lmclVMVWltaTRJaVJDcnVCZ2xseEg2dTBlSXhNcnFkT3BzKzJsaGVUSUJM?=
 =?utf-8?B?eUFVcFYweDB1c1pRSjBvMUZQejlsNHpPbkt3SDIyd2MyNThyYml2VkJQWkwx?=
 =?utf-8?B?UFRzWWY4dnJhT2x0NGlZTUhPTnV3V3A1MmFtNldHdUxvUGw1Mm13Qk13cWNI?=
 =?utf-8?B?M3NUOUNQVGg0WE83WEJhazFueXZkL0FPTFNkM1g4ZnRFM0RNL2lSM1lJcUZH?=
 =?utf-8?B?UklOQVV6V0N1RWh1Skc0ejNQNVdIUzVtTDlqUExoVEFSZ2I5TjV6V0IyUUhW?=
 =?utf-8?B?VHBuVUFNOStMbW9aMUxVQmdYMlRRc1FBR2FwMXFVNmhLcU5nQmM0cVR5VDZ2?=
 =?utf-8?B?ZTRyZ3dzZmR2cUp2ZysvZXN0N1FKTlMzenYxc1plQW9ZR2w4ZkxIc2IvNlRh?=
 =?utf-8?B?WldNVXZjUy9WUXhJd1VTeWxVLzZKcVlBS2l4cnBZdm9VOFBGZ2RTRENzRXoz?=
 =?utf-8?B?bW4zYmNSNGs5OXU2Uitmcm5pQVF0VzVGLzZxU243NFZPNHVwOXdwSHIyS1hK?=
 =?utf-8?B?UFdiVWxEVVdaV01oRTJZVGFJbFRsWWhxWSsrQVIxNU02MmdDdlNxVFNMOUd5?=
 =?utf-8?B?WFJRQi9zZnNWb1FIV2tkeUN0bUc3NGtqYjVxS3FVOFZFeURzNmJHWFNKNC9v?=
 =?utf-8?B?d0FpMnVKMk9yNE5jNmtmRmZybmsreGJMMTFBbmlURDNMZmZ6YlZpNFpvTmtF?=
 =?utf-8?B?b1c3cGxleit6R3IxVGpCdTdOeG1rTzg3Nk9JbFpnWVA2Zy9ubTNsd0FtZlJE?=
 =?utf-8?B?aHR5d0lqSkI1RTU4K1ZZRUZ2clpkajZ1STVTU0MzL1E0UnJYTTBhVE1ldlJD?=
 =?utf-8?B?dXNqNDkzRXV6QXE3OER2UFJKYnhKY0VqeDBUTDU3My9oZVBhL005UUFVUnll?=
 =?utf-8?B?ZDZBYjlFNGVhUzJ3WjVPY2krQ2hvcXg3aml0akhxZ2lsZUcremVoYWY3eVZK?=
 =?utf-8?B?eFkrSUJQaENhbkVNODd1K3cwRml2eW0zOUpGZ0hyL1FUTlBsMERtZTFwVkFt?=
 =?utf-8?B?M0FRUHJvYnlaVlovNytaYS9tSEdIY0lyZmp5bk1CdlpsL1RIaTFqZ21BTFBD?=
 =?utf-8?B?V0pCMUhpUHRUTk4xWWl1R0ZMdTFpK2N6SEUxUyt5SytRVzhxN3g0NkVMc0lt?=
 =?utf-8?B?UEpsTzVkWHAva1RONFFkTTVtcjRnUkxIb2JHOUYxOFFWRXFTZ0RWWHE4L2xa?=
 =?utf-8?B?Nms5WUU0MzRTa1Q0aTZwK3Q3LzMrZDdBT0swSUpmQXFDS0Zka2hUVklBRnV2?=
 =?utf-8?B?K04yRkJZbjFYZElrMHR4SkxoMnZPY2xuakhNbFkyclJIa0lZR3c2V2EvalVa?=
 =?utf-8?B?V0h4ZGV1QjJpSktIb1B1UkE2dE5sYkRtc1plZkJRV1J5SGdKNC9IeDJLVk9O?=
 =?utf-8?B?ZFMzWmppY2grdWtnWE5MTWFNRXFUV0pYMTFNV2dKamU4eXk4b2lkc29LNE5H?=
 =?utf-8?B?dWJqQWU2TEZlUkVSL3VqckFiRzJ6Mkh0L1RZa255YWFzMS9UMm5MMytBbm14?=
 =?utf-8?B?NDVSUFBVRWlLQ0dwYy94RWsxK2dhZ29sdkRCck9kSUcrVlZCZkpTb2ZhQXlS?=
 =?utf-8?B?c0wrVmd0dUFmZitZU0tpOGtzcEFHT2wyMnFTRlA4NndneDhQSjladnp2OWsw?=
 =?utf-8?B?RE5KTHJ2VFNxbThKMnZCK2xGN0I1dk9EdjQ0SUxpNE13YUQ4dktlQWlRTGs3?=
 =?utf-8?B?RXhyNXZ4czhDbm02V0pnU2FOK3dsNFpiVk9JWDd0RE1RVWtqTnN6S3hjcUh0?=
 =?utf-8?B?RUROWmp4Tk9IRUhDVThROUxRTnJxNTVTTmVIRWhyTjJ5SkhobkZrOVVNRUI1?=
 =?utf-8?B?aS92MW5aOUpDRUx5Ky9VUDNIS2ozclRhTU55MjE4YnFmSVY4QmVHN28yNlJn?=
 =?utf-8?Q?mtiI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd55572-0589-4edd-a02d-08dcd9b7e96c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 21:05:10.0259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZIs5WSdoX5YNN4gQ3D/Fkz8OHfCZexzEOToQDD66LNSZYi+z5jqNG3oxSGtL4ce
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472

Hi Reinette,

On 9/19/2024 10:33 AM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/18/24 11:22 AM, Moger, Babu wrote:
>>
>>
>> On 9/18/24 10:27, Moger, Babu wrote:
>>> Hi Reinette,
>>>
>>> On 9/13/24 15:45, Reinette Chatre wrote:
>>>> Hi Babu,
>>>>
>>>> On 8/16/24 9:16 AM, Babu Moger wrote:
>>>>> Detect SDCIAE`(L3 Smart Data Cache Injection Allocation Enforcement)
>>>>
>>>> (stray ` char)
>>>
>>> Sure.
>>>
>>>>
>>>>> feature and initialize sdciae_capable.
>>>>
>>>> (This is a repeat of the discussion we had surrounding the ABMC feature.)
>>>>
>>>> By adding "sdciae_capable" to struct rdt_resource the "sdciae" feature
>>>> becomes a resctrl fs feature. Any other architecture that has a "similar
>>>> but perhaps not identical feature to AMD's SDCIAE" will be forced to also
>>>> call it "sdciae" ... sdciae seems like a marketing name to me and resctrl
>>>> needs something generic that could later be built on (if needed) by other
>>>> architectures.
>>>
>>> How about "cache_inject_capable" ?
>>>
>>> This seems generic. I will change the description also.
>>>
>>
>> Basically, this feature reserves specific CLOS for SDCI cache.
>>
>> We can also name "clos_reserve_capable".
> 
> Naming is always complicated. I think we should try to stay away from
> "clos" in a generic name since that creates problem when trying to
> apply it to Arm and is very specific to how AMD implements this
> feature. "cache_inject_capable" does sound much better to me ...

ok, Sure.

> it also looks like this may be more appropriate as a property
> of struct resctrl_cache?
> 
Yes. Sure. We can do that.

-- 
- Babu Moger

