Return-Path: <linux-kernel+bounces-548706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBD3A5486A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E113B1895966
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4C6204699;
	Thu,  6 Mar 2025 10:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nDw0xTKf"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150922045A1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258319; cv=fail; b=lAdkWCWhf3VP0zGjLJhf9/H5uxYXtCWFLIxv72sR8zZJ0Y/ro2K2RsmbAqax/7NbPz69v1qrd0uN62/FNYdyNaKGa45VuAnE4ahYwzGHNXrRCtTDYHV/UTqLXFAJPYasS8s8Sc7qFCIpIzhypz4WTcls6q+bie4jMaVfpC3uRqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258319; c=relaxed/simple;
	bh=+tkmDZ/X38/CdgKQMj0Yarp/pJR2VzS8GuO4yJQTa88=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QZPGnKe8jGmrF4tjlRSLaiY603r+dy0PREoDD1NhmYfCt9AuA6nSmkgyj2k09n3T8oNpi2z5IN9g9zS1zIl91iG7FXgM7c15m5NZ4Qye7JjpVXaqFUl2OZBSHf9ZNJikq3ucvmCprre+qZSgrE3E1m51KBpRWAtqLPyNTbxi1Lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nDw0xTKf; arc=fail smtp.client-ip=40.107.102.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7Q99OQF4a995kAfHUwVNcKGXfkG2GohwSxp1tNJePen8y7E+KBOyxwA3DF+4+uV+m4bOe5yYeE7sQTZ5sylM1hdhEmy6QfRYhaTSGNFbRU++4CCkOKuoRjA5HBbfLhYUuvs+yOWAq+sHMMGb7+IO15khlhalz63zl37lTQgbyEqm+LXdt1tq/W0L0bKBiTavfnbMsAgevCTWPvX04h7sLVlMEiaNZOtnopaLb69hQDOiSEN8QEiv5WQICgL3PKK9tG/OO+XSJhFI/KX64R9Vo8TZVjOTtFs4c787PIlP8DaH15yq89GNK8tiZxaOx3PbhLfQWk4yWUKEGDkkJ7hEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgCTFUGE3dUuZMrTTUeqKR4icmhCsn50MiG6wF9e83k=;
 b=DeyENR4jWE6DIsEnbptYa4IGARP845qcjvaOZNulU3Wa4QvK0LRw92wAX9NsLES1TXd5iMmWtEAZq27d+ecKrIHx0ZgA2yQkkOZCub3lyRCyGRHkJEw1SnaX+wZzcBUoGKGvQl4AxEsMzNwn+C3ozyDP6eHlNpAd0WmjeK1ctWKyKLAeJFB/LReTER7YMic5jWMgtESC8UsxCjfLywmtXdiXfw6NwE7RDSl6TsNq+zssjK46Yvixax1p5DeX6WuaItPBSDMTdBwPEozOTrUXKJIqZo0Sw6ktwe9P4zYbRXgWt/EQkB2PKe+WblCoEGGBpF2DnI9FXJc/30EYksMquw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgCTFUGE3dUuZMrTTUeqKR4icmhCsn50MiG6wF9e83k=;
 b=nDw0xTKfjQ/aoPUHKGme3HPLCjIdP2QKKCkJ3P0Mq0PdqneEAF2IMj4/ww82uwgG2+BfJNy+ysKpIgVrBdpyNt7NT8ZJ+WQI7xoAYK8cSBXtIdUiYUHFNza+aOLi+Cz0Wmbfoy580x0DNWAqUvohv7XIjELBulA9T7ItbzzEPEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6430.namprd12.prod.outlook.com (2603:10b6:930:3a::12)
 by DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 10:51:55 +0000
Received: from CY5PR12MB6430.namprd12.prod.outlook.com
 ([fe80::6bfd:fed:d96:c7da]) by CY5PR12MB6430.namprd12.prod.outlook.com
 ([fe80::6bfd:fed:d96:c7da%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 10:51:55 +0000
Message-ID: <c2d1334f-6f5a-493f-bbf0-3e92789f128a@amd.com>
Date: Thu, 6 Mar 2025 18:51:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/7] virtio-gpu api: add blob userptr resource
To: Demi Marie Obenour <demiobenour@gmail.com>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>,
 Huang Rui <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20250228053650.393646-1-honglei1.huang@amd.com>
 <20250228053650.393646-2-honglei1.huang@amd.com>
 <cd9f85a5-0d99-4007-bba2-d792ac9d84da@gmail.com>
Content-Language: en-US
From: "Huang, Honglei1" <Honglei1.Huang@amd.com>
In-Reply-To: <cd9f85a5-0d99-4007-bba2-d792ac9d84da@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:404:a6::30) To CY5PR12MB6430.namprd12.prod.outlook.com
 (2603:10b6:930:3a::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6430:EE_|DS0PR12MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: e08b15ae-4b42-436c-c6d5-08dd5c9ce94d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3dGbzJyYmF0aG11N3djaDlGWWkreXVyd1d1dGF6dk14M1ErOEQvZW9Pa1M4?=
 =?utf-8?B?czdTLzVmbW9XVVpuRFQ1ZkhCNHJSOXdrTHBZZVJad0ZYNHY4R2dDbWlOYUN5?=
 =?utf-8?B?cXdXYWdHVUhaNW1sTFUxS2Fka3N2MHloVGJUWW5aSXBHSnZlQmVQRVlTT0NC?=
 =?utf-8?B?TEdaVlJPODFETktkOTJCWnZETWFLZ2hia205aXkzeVBtb0FqdGlCRkFoaDA2?=
 =?utf-8?B?ZWE3cnljUkhZQ1ZpSHNnY3hkdXhLZkMrMFNsMGlMOEpsSkJsNUhoTUFzSGN6?=
 =?utf-8?B?TDRhVnlPS3VFakVrQmRCaFBRZHRvaDdON2FoaEUrWU8rOS9OaUUyRXRBV2U2?=
 =?utf-8?B?d2ljdVQySG9lQmJ2UUhqUjJubkk4ODkvMXpwL2dkVnh2c1BFUlpRa01aODA3?=
 =?utf-8?B?OEh3dXUySUxKaEFlclJ1ZFVGVWRMVEQrN0VDa1gzOUtzZlh1WDZ4R1BrLzJR?=
 =?utf-8?B?MlovdlZpUUowOHRBU3Fsb2lINXoycTQ0em9NaXVkS2NWOHhXcjRxT0lsKzhF?=
 =?utf-8?B?NG1jWHM0QVNXTExmOThUcEFFNXpRYTVkUFBLY2xJUzR4OStQdHFXRnBMejdC?=
 =?utf-8?B?dGNrSSsyVVV6UG9ZOWRWQ2g3cVpRMFFWcmhGZURRRzlBczhLd0VpL2lMOTJp?=
 =?utf-8?B?b1NGdmVTWnB0NDNpeG9CWHZ3RnFNMzlyZUhmRUQvYVVrQVJhUXJhQTVQZWtJ?=
 =?utf-8?B?aVZuSTBUYU56ZzBKN0pHNE5lbG1RbWdPVVBNQWVhckQ4VWVlVVpUU0diSmxp?=
 =?utf-8?B?WlgwSWg2R3NVajNiTmFPK0ZQeUxpKytHSUQrcXYxbStodUtIck1zQm0vd2NB?=
 =?utf-8?B?WTFOYkw4bWFNVlcxU2RFY0dzclkxVWdlTm82UUFnRVNlNmVDY0V1WWVaY1Ja?=
 =?utf-8?B?VlJkaFNFMklaOHFndEd6SnJXanc5RFh0dWROMjlXY04rdUpCcTQxZzV1V0lI?=
 =?utf-8?B?amNGV24yQmc0dlhWUU1EQ0JwV0FPaVhDa3JPOWt5ZWNFeE9xdzhWdXp1N0Zq?=
 =?utf-8?B?LzB6U1ZIdmd5QUFvZWRrZnpweUY2WnNnZ1FUUXI1RmdnUWdpWlkxUUsrQlBX?=
 =?utf-8?B?WG40QTNuS0xzd25IU05PeTJhaTFZaSs5WUU2V1BWQ3lFOERvQ0ZnMHEyVlY3?=
 =?utf-8?B?c0IyRUMyY0NXZDRaMVZBUS9mdElaK1hDSXJoelNQU2hvbHZ1L2RacVA3RjA5?=
 =?utf-8?B?RWRGVU4yaVJWLzM0dGRTdGtSeHlTK0ZFQXg4TGd1VmFielJXMjJUaGt1dWg4?=
 =?utf-8?B?UnppdHlQVVlCUVBLbWZkQ0hLaDc5ZFRRNWJNZmRHTVJYUXRVQmduT3drWXB5?=
 =?utf-8?B?QU1ZTHU2Nkw0RzFKbS9mT2kxaFp6OGFUV3g2eGJLOVVDS2J1N1RqUVFPUHQ1?=
 =?utf-8?B?ZmtVVFI4OEovUUlrblErMlBrUXRWeE5YQ0tBZXdtM3VzVFcwV2xUNmpEbE5Q?=
 =?utf-8?B?NlBrUGdON3lDdkZJdnpVakpvY3draDRscEtMczBCU29RTVByRmVDOEgweEJh?=
 =?utf-8?B?STJTaWZsT3d6UC9zTmhVYjg0SXBWZXd6c0I0VEJ1Q1FKYmQ3VmNDa0hjTk50?=
 =?utf-8?B?S1dId3oxSUl0OTFhRk82dEJpWWdjYVhHQUpSZnhLM0RNVTRFVVdQZFNucWZs?=
 =?utf-8?B?eUxhdHNiUFZNcExsY2FGdUxGVThFbTNOMHkxcXBMeGxYV0lpSXBpbjBzTzhx?=
 =?utf-8?B?NFNxN3Q3NlFOdU15NU1vcWZpQUpyZzhJaDVBU0lXMUJ3RlJUdy9wWDhEOGJG?=
 =?utf-8?B?V215dFZMcGdxc2pRV2N5aVdoUE9BRFRXZy9BcEJnV1k1eHJnY04rbkFDQ1NI?=
 =?utf-8?B?SnR5QjM2aGdtWlVwdy8wVGFZdzFsS3F4ekhzekxIdmlucWJsRzNQYUMzeEpp?=
 =?utf-8?B?L3IwdGtxTW5xVENmNUMwNGtkSEc5ajc3bVE1MG9HeGYxODM2cWVBUzRvWmFi?=
 =?utf-8?Q?q2O7hQHXzTg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1JrVVVJWXdjUUt0TiszT01ZZXFyUWZlSk9Hc0tONkw3WTdseit3dWM1c1pY?=
 =?utf-8?B?RnFGeHFsQXVzaUJtcWhXU1EyZVh0RW5YUHF2N2VxYXNUMnVSckIvMVFUaC9Z?=
 =?utf-8?B?Sk84aWtVZHNvM3V0bVVTUEt1Mnd1N2NFZjFtNlpXcEM4NzVDQVZxakdGSFIw?=
 =?utf-8?B?eHFYRU1ldlpVRHpqT2srWFN5RU9xN1NLU3NKbG1Sb01yRWp0ZGdCMmxiTmxZ?=
 =?utf-8?B?aENWMkhyMDVRZUVnVDA3Z2tYa0N2aHd3VTRDamZPT1ZlTDlXMjZqalYyVHBt?=
 =?utf-8?B?R1FVQTNrSmZsREpoU3Y4TSsyUEdVZi9tNGc5UE56U0xMNENqelB1citDdlQy?=
 =?utf-8?B?dklPbFYyTnBqdk9MNXI1bG5QNys5RFE5VzFQKzBtL2wxVFZBdTlsVFZkVUFI?=
 =?utf-8?B?MzFOTTNSUWpmUmVUd2NBUTh5RElkekg3c1hwcnJJcVlSbmRhTmJKbnlROXdx?=
 =?utf-8?B?NmNtc1BNeUk2bU44SENhZ1BZWHArbDNjaWNxazRTUFdwdERUYUE1ZTFrNVVK?=
 =?utf-8?B?ZkkrSUdEeWZjN3dVM2hDTk1oeDRpTkRTWHMyVFZQNU5McDNCeXB5Vktmblg1?=
 =?utf-8?B?RlNyTnlXSEhxNllLZVpzbWhyQ2c3bFBCdysrSEFNZlMxQndzZTJJZFFtOFVU?=
 =?utf-8?B?eHZTY2lIcW03UWVWN09lNGR3WHdUOGpYMGlNUkJnckpwdlRNZ2drUGNobjBq?=
 =?utf-8?B?T1NkWDEyMVVDVFBLbUx4c3BCdFdCSngyUGZINXR0YTFaVmhHZnlOSVl0M2N0?=
 =?utf-8?B?QzlQMG1vazhkR2hMZmVMNS91YXJxdEFNOE0vSFgzeEhmTE5tRktNVG9jSFUy?=
 =?utf-8?B?VmdWaXdFK2t4d1Zxc2Y1ZUJkaVFNNlA0N1pVdDJGcU5xdjc2Z251U1ZYaHVQ?=
 =?utf-8?B?WjJ5YVVkcGQ4N2pUeitHb3NUM2NkdjZCODBFNWJ4NVNHZVJ4UFlvcjFsL2Fi?=
 =?utf-8?B?a1J3aEw0aGVuK2F1bGU4NXpnc0tHK01JRk1IMnJjU3VmcWZFOGQxaFIvbmdW?=
 =?utf-8?B?MnB5cXRxekQ5NEV0dGloOVhJTDlZYXNHMitjMTdZTWY4dnBTaWl2VTRtMzJk?=
 =?utf-8?B?TmcvaDdpNzVEb1FieE5oVnpvUkhsK2tnY3ZzN2tiZXZQZTFtMmpWT0hMMDJo?=
 =?utf-8?B?RmsvRzhZcjNDTFZjc2wxNWtibHpvZFFOZjlQb3gvam1vL0lJRW9LdGZ4UllX?=
 =?utf-8?B?eW9GQmp6bVlkK0FpUEpCcDZKaEJjREZScWtpbDgzVlkvaER0YXFncHQ1b2Jz?=
 =?utf-8?B?N0xaVER6VnRnNERocXNxckR3ekFKaTlTSGFPdS8rbzZFeHBpS0NvNWxvcDBK?=
 =?utf-8?B?SFhaT05VQUFjU2RjZ2dOaldBWk1lUWozNmpLRFpQdzVjdzhYOGNwaG00ZUxL?=
 =?utf-8?B?Zjh6STBZYVlXcU52MS9RMTZ1M09qTWlFNjlHZ2tSZnJ1SkVxWXF2ejBMVVp0?=
 =?utf-8?B?MEtVRk9COXd1THU3dmc5M3VUY2VlMzEza1Z2TjNQcmlTU1lnOWYvajNUaEZL?=
 =?utf-8?B?UTIzbmk3dFRFeG1jYXZ0Y2RlT1dYeXhlVFJYMmFpeWs3bkxFT3FBVjl2dW1J?=
 =?utf-8?B?OStuVndIWnhHNTZNb0FDNjdVUzdaRm5obk9STHBGRTBRZzU5b043Z09DZitn?=
 =?utf-8?B?U0Z1R3h0aUdld290SyszamtQT092bThSTWtzL1dLMDVDc2E4WFJ4QUE0MFFr?=
 =?utf-8?B?SW5oT2txcHQ1SUw3SjlCR2NkOWt2RE12WGJFRFE2eERhd1VabjNSaVMzR2k4?=
 =?utf-8?B?cjBKamtZcDlMYUx4b1lQYi9Na0R3ejMzeVE2SDNHVk5hRkhLRHBtaG41RXR2?=
 =?utf-8?B?QkRmU0h5bEJpTVpLWmpuRDFSc1F1NXJtU0JNaG0va2ZsT2xOV00wMGhER3Rm?=
 =?utf-8?B?ekZvTjUrT0Z5TDRWSkc1eDUrMk83MCtJeW1qZkVEM0pWMDdnRWVGeGdRN25X?=
 =?utf-8?B?ZEVMTS9GY0lkbzJwOWNGVWFQMWRNbUxEZ21zRitKeTI5VlJWdklIdjVnSDBz?=
 =?utf-8?B?bk1UeHlVN1BSb0V4ak9QQzF3cEZlV1gyci90WWxvWHgzYmxQdGx2QnlLQTht?=
 =?utf-8?B?YWQ3cjRGQzJ0V29jWXM0VlVRUFREdlJZVk5EazhhYnI4NUQxbFZ3THk1Z2do?=
 =?utf-8?Q?rgNEyxkiTG2w2iUOm28pDZZ0U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08b15ae-4b42-436c-c6d5-08dd5c9ce94d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 10:51:55.7510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9diDobcI++5RAfLUYkQinK1ojrUc38yhgYJZ9BAPeDJX+3TSHW8Bp/9RycQ0tP3HtMXbK4bnkX/OAkpWiVShLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043


On 2025/3/1 5:21, Demi Marie Obenour wrote:
> On 2/28/25 12:36 AM, Honglei Huang wrote:
>> From: Honglei Huang <Honglei1.Huang@amd.com>
>>
>> Add a new resource for blob resource, called userptr, used for let
>> host access guest user space memory, to acquire buffer based userptr
>> feature in virtio GPU.
>>
>> - The capset VIRTIO_GPU_CAPSET_HSAKMT used for context init,
>> in this series patches only HSAKMT context can use the userptr
>> feature. HSAKMT is a GPU compute library in HSA stack, like
>> the role libdrm in mesa stack.
> 
> Userptr should not be limited to HSMKMT contexts.  Userptr can
> accelerate shm buffers by avoiding a copy from guest to host, and
> it can be implemented using grant tables on Xen.

Yes, I totally agree userptr can accelerate shm buffers, but I currently
don't know if there are any other projects working on similar features,
or if maintainers have any opinions or better ways to implement them, so
I temporarily limit this feature to HSAKMT context only.

I am waiting for everyone's opinions, please provide your thoughts.

Regards,
Honglei

