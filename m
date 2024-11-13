Return-Path: <linux-kernel+bounces-407222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 037D79C6A68
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBDC02829F5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC99F189F47;
	Wed, 13 Nov 2024 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SMltYxsx"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28656189BAE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731485626; cv=fail; b=rfJMXTwb1rNOlaSwvmxGD+GCHThoWZtwWvWr5l2RUMXKxXs7OXHayS8uoxu8Wre/ZJTMg0C0XWuOCBpmVSUwwwaWS3vqsCaouaQPAbD8EvsSA/kBp725h5PYCzE+SLoYi9Br5htv291uKgcGNuQpSEvT3Vr+VAlx8rJYTlBuSWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731485626; c=relaxed/simple;
	bh=bPEpNyyFKDcnyoqxEz1qVvEMC63fkwedsGWolHnKpV8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RaWQ2Sv/13E3TAHeNh64+yYNKXRsm30f14zkh9g79sjvSpNzRigLighPXQ1KV43/UIXCwL8h2jeoIIW2S3iQnaUUHSdsYPpramvXq8IfNuN+tQG2UatxCyTpQqXKdvYZblZgbn1NnBJlRo2PqVQE7FYW/wrMsGBa5EqeyF+SmxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SMltYxsx; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1aP4KDqrbSSYI6k1+qhbqQZolziEqNMSVewxqDV83Le3LrlHDfMSEXvOkwurhQJccAZCVhOewgnhz+J2JOMt4gZ7fLtDm97ecyNibI/pUixqwscGUb6XgxRuF/FcJX+C0H30Xkcn2ufE7ubn6EFxYjZxhHjowopqmvYk/BaN99Dm56kG1UfddbeOVlwwfTatu81RmAlZUPG0CRDYFcMR1J5xzY7CMYSyPVor53j51wN+2AFcornUjOsD6KF7zQsP06R9niYNWpQ3QoE2aMfStdhTghfCbyLnS5vj3we9rhWdErJh05fGFTHfJELFT9MS3WC13gnZK+7Tdzyi38F6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPEpNyyFKDcnyoqxEz1qVvEMC63fkwedsGWolHnKpV8=;
 b=aCNInxSjamjIf92ZBMVNifZ3zzJdQAtIBorhl6SZDG3gPKdp3L9QMofPmpJ/IfSdipmZfW3tDwyegTAM5+k7spyTu0XIIpD1QLG8jYRjLO+D12ARgrfzBHvghAoNzLN7ltz95auXzkcTrJwA7ZiwjNAI03/ulFgMnKKMrrO6J3NM9Ikone7vLXUkZOiPJORST2YqCH2ZIpTKItoNPHZ3uJiSZjOCK6Rjhz+JNKL+mXIg+H1TpPTjxdoqRsc+l21M5BZpkYvBt2aT7bFEXKI+T/vMZ3vb9K7SWyQIcmOulATDyfoIcYVAUdxwbzFzS/eKBxRFuOjukwZedYmtIt1KIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPEpNyyFKDcnyoqxEz1qVvEMC63fkwedsGWolHnKpV8=;
 b=SMltYxsx1pX8xpNZ864HEthqygBO2VbvysI61tRnwvB7Y0FdJRz2OIorKa9zI85P0EWwFxI6Sr0M3DDfc4LPNYQe/jfeEOR07M8uFmLnXDwOOXsuZHJnl4EWW6i5qo77sclQVm7pEr8a+jjkskG5WeHsoZs0zKP1BEws/hT9H1M=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by DS0PR12MB8220.namprd12.prod.outlook.com (2603:10b6:8:f5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 08:13:42 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285%3]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 08:13:42 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
	<Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: set passthrough mode for xen pvh/hvm
Thread-Topic: [PATCH 1/2] drm/amdgpu: set passthrough mode for xen pvh/hvm
Thread-Index: AQHbL0jm3UEePSCKkkenk2kiUagDhrK1bywA
Date: Wed, 13 Nov 2024 08:13:42 +0000
Message-ID:
 <BL1PR12MB5849050822DACADF5273CD26E75A2@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20241105060531.3503788-1-Jiqian.Chen@amd.com>
 <20241105060531.3503788-2-Jiqian.Chen@amd.com>
In-Reply-To: <20241105060531.3503788-2-Jiqian.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: BL1PR12MB5849.namprd12.prod.outlook.com
 (15.20.8158.013)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|DS0PR12MB8220:EE_
x-ms-office365-filtering-correlation-id: 5b86d7a5-6e35-4c99-2598-08dd03bb164c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZlQ1Wi93QlY5UjhsTlYyb1YrbzZuL3NXd3JNM1FOOURsNlc4ZVBWS0p1amdV?=
 =?utf-8?B?QlVRbEpRSldlL2VlVWVFSzZNTlkzbkt4ZSs3MldmOWxKak9oYmttcGxLNERC?=
 =?utf-8?B?V2ZuNEhJR2xPMDF3WnViTmEzZklBb01PSHo5NFprVzdCR2s0ek9QOEdJbUIv?=
 =?utf-8?B?NWRwVXhDTE9qdTROQzlrNHovS0RESy9EUkRTa2VyYm1IRlBwY2hrZlJEUENv?=
 =?utf-8?B?ZVZHNGlGU2pjRG1LRmFFYTFZNEpkY3NMVnNyQlBJbDY5eW9ZVi9nR3pKUmRI?=
 =?utf-8?B?RGtManREYVBFOVVuRkR3VzVVMC9paEdhczFTWFZTM1ZMTTFUWjBVZk5ldzJX?=
 =?utf-8?B?UnRSaHl6dk9JZVpwR2VjWitJeVJEa3NiNGlZVEVMQlROL2dHU2lteTRhNDdt?=
 =?utf-8?B?LzV1L05mUWhQMVNZYWpsVUF2MGNoSnpzQVpyajJjNW93UWdRTStjdVFDa0t0?=
 =?utf-8?B?Nk5VVTlDNjJaek5MQnNxdXRtWmZtS1NhNVhiYmZDeW5DcWRwckxmcXdIWlpE?=
 =?utf-8?B?QVdycER3ZGNLRUVNZGo5azJuWklOU0UyeTFhcVRZMWQ2M2xsWWlXcVR5UXl1?=
 =?utf-8?B?dCtlREIxa1EzRmxEUTI3RGt3dDlGNmRzUjlRckFrSVhQcmVZN0xKclJ6eHpR?=
 =?utf-8?B?SHhLR3plTytldGx5K3p5M3RxZ21hMzMyS0lsL1hiOXhQZU0wbTVVQVdNRVlO?=
 =?utf-8?B?SWRDV0hwNm1hZ0dRMEl5UGhRMldkU1hVR2VGNnhzUlg2OEtRemtpY1VPLzIz?=
 =?utf-8?B?allqN0xDSmNtNHhmUWhwZzJKNSttSUZQRW9aTGN1UERlWHFoMEM4RGdtUjRm?=
 =?utf-8?B?bTdJNkVhOVJ6UUllZ092M2ZpZ0JKNUNkNHgxa2F2VHJUeHVVU3U4ZFlYdFQx?=
 =?utf-8?B?OGxpM3F2aDgvT2o3ZFEvV0V0aHBlT1FucjVHUjJYK0dRUXl4aFN6bzVIOWJX?=
 =?utf-8?B?L1ZzUHFIbUxONnQ5VXVnMUR2cjVrTFl6QkIzN2hBTURqeG5wajNkdHBndk1R?=
 =?utf-8?B?a0x5aXcyWGhkRWMzbHpueEpGVUF5Znk5VlhtTnlQK2FEVi9uSHVtWFBpZ0M5?=
 =?utf-8?B?TjE3L2VDdkhRK3EwZ2t1bkdJaG5TbVROYjg2a2NvV1JvVit3dThTMEphUVF3?=
 =?utf-8?B?WXFOZ3BOS2UvVWhxK2taOWs3bzRHQW4vRm1kaGVCR3NULzAxbUlaaUpkUlUr?=
 =?utf-8?B?YnEzY1oxMlZvYXlGS2NSMnowbmRxQkNKcUJQYnlxT2h0KzVQb3BSQnlwdkZH?=
 =?utf-8?B?dGRudSt6STZnQXRjVTFyNS84T0Q1djQ2b3hVVDh5KzJtaGZTcFg4UDBrL1RF?=
 =?utf-8?B?U0N2Umc4YlpGdzNzVHNZa2NoV1daODl0M0hOSXB4dXNrTTFhYVorSVk5RzF6?=
 =?utf-8?B?NXRkQWJNemM1NWcrQmRlcjhYRDZUN0FhYTFlOVVvbUdWWll5RlQrbkNsak5q?=
 =?utf-8?B?cHo3b1E3VGtSc3JUSG50TlBTN1p1SVFzdmw3UERDb3VlbzJoYTJFMnFXU05n?=
 =?utf-8?B?cUJWSFB4TGpCdzdjYWQ4NU5VOGc0a0ozVm13djRxZ3lzTmhsa0pncDdrMnBQ?=
 =?utf-8?B?ajhKOUdaSHAzaUdPLzZ0UU42NHBFbnE4MUNpM0locTcrdllXdFpFd01Qc2dQ?=
 =?utf-8?B?aVd0ajI5WGxNMno5eHM3Rk5NdTkyVXRZSUlHZzNEdnZVNk5UMnV3K09xKzdu?=
 =?utf-8?B?T25GV3J5ckdZUTFSdTBiNGlSN1Aya25CYWxDWVNwUG95eVAwOVhjOWUwejds?=
 =?utf-8?B?YUZySEVnMmtXalFqVm1kMmJodElIVnRqSWZzNzBvcDRkSnF3QVNtclA3enpt?=
 =?utf-8?Q?zPyBLWD6W5tE7aCFqGs7oZdkBmRZpg7GfPuGk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Zm9nWWlWbkVNK3UzSklmUldxNE5vTUkxeTNES0tpRXlxeGlhT3lXWnI2Smc5?=
 =?utf-8?B?SFF5bWNXTmlSU2dWMlRVRWtjNG5ZdG13ZXJ6QlQ2cXNNMUdIRmRqUTJxNlhX?=
 =?utf-8?B?cXFBVkpiWHdvUVZMT2txL1kzMzdkZEhhV05YY0UwSmNOWmlQdGhYM3lqUVd4?=
 =?utf-8?B?VTJBNlVxVzNseElSUFpLbnU1RW1pZVZETklvK3d6NWZienZZZ3NhUDNZeXpE?=
 =?utf-8?B?aktoa0Q3Q2dSd25BR2haK00yQTJOcEF0NGthRGtZUFlGSDluUkRESzBha2NP?=
 =?utf-8?B?V2kvMnFQa3F5V0liRGQ4WVFDWXk5NEJJdDJZdzdyaisrRGpFQmtFUnJQNlVO?=
 =?utf-8?B?ZDVIejhrN1pjdUxXSlpROFlzNzRUbUcrSzNxK3VXMjFLMFZORHRjVmpOdGRW?=
 =?utf-8?B?Wk5ZM3MxWXVSMUY5SkdOWGdjVmFJbE1BZXQrOGp0eUlQUVZHVnpkc1ZScVNR?=
 =?utf-8?B?LzNzU1Y2dG14cW53OC9ucTV2NkJTeXpHR2NaczA5djVORTMwWmF4N3F0SC83?=
 =?utf-8?B?cFNEUVF3NEM3dk5xVG0xVFQ5TFhQSTNOcndKWVZOaGJZeXAvSXMxQzVmZno5?=
 =?utf-8?B?RTl5ZGFZTDhXLzVPdUY1OEJ1UHhYd0Nobnk0WGc1S2x5aTVDb2xLbzRLVEts?=
 =?utf-8?B?RGQrZG5NOHFVTFc0NFkxSHliNnNrL1pFRk1ZM1ovcVU1VFRYeVVBOW91TVhN?=
 =?utf-8?B?dlllbnM5bm5iYm5TQTdKcEhTT3J2MmZXcGxLdVJYdWxldGVnUSt6WXBuTVMy?=
 =?utf-8?B?cXIyT2RESkM2U3BXazNqYXVuSlRBVGRBWFF0Y0tFa1FScDNmc2FsYktXblo1?=
 =?utf-8?B?a3hqWTRsNDhZRVhZRmtoenZtc2szS01GMXpYbVk0Y1djR21SZkdJSDJmYW15?=
 =?utf-8?B?cmpXbTF5bE16THZkdC91T21iRVJVeUFvK1Q4SHhiSUhpa1N5Y21kOEpJM3hE?=
 =?utf-8?B?NWd6dHdIMnV3U2RoUHU0cGZjUFJRUVNLWDJSemN4S0NtT0VZNTJkdnpDU0o0?=
 =?utf-8?B?dnVQdmNKaVZ3K2lDblNQTS9KRDFjZGtvN3NPVHlYZXRYajFSYlFUbTBHZ2Mz?=
 =?utf-8?B?cHVORFNoM2w2WVdqeVF6V1ZRRS9RUmwwbWd4dWFBeVVQYy9xanNoRWxLVzA3?=
 =?utf-8?B?S2pXYUhXRGViL1Q3ZkpIZVRXOHFMUU80bGl6dkFINTFRNXBVZjQxeW4zU0ZO?=
 =?utf-8?B?UERrOFZ2MmkwRVN6TG9pd2YxZ1FwSnJqYW13cFZhZUU5RjJ4MEFkNVVOb0JH?=
 =?utf-8?B?THE0OS9kSnVOeTF1UlUwQytmLzEzcVNOZEFHcUUzSlYrL090azV2VUk4S2xE?=
 =?utf-8?B?L0JQL29IL1pmOGFJMEpWOHlYa3dLdEtYTFY3VWdaaU56MzNlSnNqUjNtMURZ?=
 =?utf-8?B?b2U2MzFMTGExeTFKVGlDUTlhVUxTN291c2c2Q1lFbXVvY0hCV1AwU3pzM0ts?=
 =?utf-8?B?ODZpQzNhZUxSaXN4ckg5NXc3b1JtODBuZzhRSFYrbCtMRmlkeDV3Ukpaak5R?=
 =?utf-8?B?ZG5sSHplM3FLaFVlOHdoTlplUm5ONW9aUStNWGp6MWg5ZnhESW9HVTdqREpy?=
 =?utf-8?B?RmhFN2FyZHBqSER5QW82bnFqQll0MVJaVFo5SW9nckZlVmI1WG1kWHVKWXBW?=
 =?utf-8?B?OFdPZ2RzT3Z0Q1ZoUXFDMXVFMEZhUXBPNkxWeURZV2ovRnQ0MlVhZW9jckZW?=
 =?utf-8?B?bjI3cW94OGNuWCtYd0V2STJhbHVKK05xMjhPaVR0NlVOS2ZmL0E1TC82ZzV0?=
 =?utf-8?B?bnRpMFBzaUJpNWxudGhWOGZHQVBMR3dPQmpIVkZLc1JvUnlDMzdMY3JYSi9u?=
 =?utf-8?B?Z25nQjN3YlBYV3BqckdvdTFSZUZGM3VDZGlzVklKZHdFZk1OTC9PcFBuMjgz?=
 =?utf-8?B?L2dnTEdCaWNIWGN3TUxucnhyZkdacVYzN2FTOTJsR2s2QU5LRlRjUDUrckNE?=
 =?utf-8?B?SE5ZbDRxT1BzdmpieTdoV2FXWjZWMVZ0Y3NEdEJJTXUwQ1hkbUJJUDV3NWVk?=
 =?utf-8?B?cWg0RENZZ1lWdkV2WXVyUnNhbnVZNVFFVGZ4ZmxwaWxrVGxYckVBSGVoWlhq?=
 =?utf-8?B?R2tJMkxEeUw2L3k4clNoZHVJZ29BRWtFdXE1aGcycDFic2VUWEFraDM2VUtE?=
 =?utf-8?Q?cfRI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3900711B8A7D644C846AF96837B87449@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b86d7a5-6e35-4c99-2598-08dd03bb164c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 08:13:42.4066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KEQ/ba6SiGS0jSchqN1g7WTmU3pt/MuFZ3blU6QjBqmzc1eBHgusNkGhghnQ8no/+tnd8OKYgzBzZThHnKCePw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8220

SGksDQoNCk9uIDIwMjQvMTEvNSAxNDowNSwgSmlxaWFuIENoZW4gd3JvdGU6DQo+IEZyb206IEh1
YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+DQo+IA0KPiBUaGVyZSBpcyBhbiBzZWNvbmQgc3Rh
Z2UgdHJhbnNsYXRpb24gYmV0d2VlbiB0aGUgZ3Vlc3QgbWFjaGluZSBhZGRyZXNzDQo+IGFuZCBo
b3N0IG1hY2hpbmUgYWRkcmVzcyBpbiBYZW4gUFZIL0hWTS4gVGhlIFBDSSBiYXIgYWRkcmVzcyBp
biB0aGUgeGVuDQo+IGd1ZXN0IGtlcm5lbCBhcmUgbm90IHRyYW5zbGF0ZWQgYXQgdGhlIHNlY29u
ZCBzdGFnZSBvbiBYZW4gUFZIL0hWTSwgc28NCj4gaXQncyBub3QgdGhlIHJlYWwgcGh5c2ljYWwg
YWRkcmVzcyB0aGF0IGhhcmR3YXJlIHdvdWxkIGxpa2UgdG8ga25vdywgc28NCj4gd2UgbmVlZCB0
byBzZXQgcGFzc3Rocm91Z2ggbW9kZSBmb3IgWGVuIFBWSC9IVk0gYXMgd2VsbC4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IEppcWlhbiBDaGVuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmMgfCAzICsrLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdmlydC5jDQo+IGluZGV4IGI2Mzk3ZDMyMjllMS4uMDgzNmZiNzdi
MjYzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmly
dC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmMNCj4g
QEAgLTc2NCw3ICs3NjQsOCBAQCB2b2lkIGFtZGdwdV9kZXRlY3RfdmlydHVhbGl6YXRpb24oc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICANCj4gIAlpZiAoIXJlZykgew0KPiAgCQkvKiBw
YXNzdGhyb3VnaCBtb2RlIGV4Y2x1cyBzcmlvdiBtb2QgKi8NCj4gLQkJaWYgKGlzX3ZpcnR1YWxf
bWFjaGluZSgpICYmICF4ZW5faW5pdGlhbF9kb21haW4oKSkNCj4gKwkJaWYgKGlzX3ZpcnR1YWxf
bWFjaGluZSgpICYmDQo+ICsJCSAgICAhKHhlbl9pbml0aWFsX2RvbWFpbigpICYmIHhlbl9wdl9k
b21haW4oKSkpDQo+ICAJCQlhZGV2LT52aXJ0LmNhcHMgfD0gQU1ER1BVX1BBU1NUSFJPVUdIX01P
REU7DQo+ICAJfQ0KPiAgDQoNCkRvIHlvdSBoYXZlIGFueSBjb21tZW50cyBvbiB0aGlzIHBhdGNo
Pw0KDQotLSANCkJlc3QgcmVnYXJkcywNCkppcWlhbiBDaGVuLg0K

