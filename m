Return-Path: <linux-kernel+bounces-525897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4C4A3F706
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A6A3A1D57
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B3F1DA53;
	Fri, 21 Feb 2025 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyberus-technology.de header.i=@cyberus-technology.de header.b="NiL/Vht0"
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022072.outbound.protection.outlook.com [40.107.149.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858CC1C1AAA;
	Fri, 21 Feb 2025 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740147397; cv=fail; b=DN5kPhh351jq/xMR4zjzGIRrMfup9qYvxH2THvB1WhnQs77mzk6Np2fV35al3ZwVjmUc09csxXE2nqcYuwnKToZkxTgorrfivF9ZSW/tIJEmbzYLOzkhHpIp2XpnvBPblTIpdHjhqT4vfDOYDhV8yGNX0D2TV5phVjr4sEEoH6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740147397; c=relaxed/simple;
	bh=dsspFLhLB4m3lle6Di5b4JtvcjqdXbQsAHO8DbqNyqU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QJU62VbCJ2GKCvB0R0fG5rRjsla1HLqutrIwedXFI8tFzEVCodjfk2QQ+ZyYIbMfBTTOTNeqjRjs3g8Zk4lKTBAn3R+Hyvaykkre8ANoxVIjLaFXM6ioBrCG4U2siE6TQkRSOyEVnBwFUGsCr5Y7mi8PG8Q3WjQt3jxe9l0eGDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cyberus-technology.de; spf=pass smtp.mailfrom=cyberus-technology.de; dkim=pass (2048-bit key) header.d=cyberus-technology.de header.i=@cyberus-technology.de header.b=NiL/Vht0; arc=fail smtp.client-ip=40.107.149.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cyberus-technology.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberus-technology.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUMMHgxZczEDm9Ab/KkV2VLVSfFbgRe2XjKZPG8w+bjRQYYCfyrZMsT0oLYlmTBt16flrv+8v4CreHkbWAAYCJ9bhOXS07wKdG1Xnxr5apNku5xYsd4948TDmzk/LI2YaUMiSc1V6mM1TQrJxZvFzFsKNELfRcC60oeOnYUrnxLGIM75/kArZ6XPNASgOcsxbvqjVYRalrg6dNO7c+kKvulWviDuDA+etXb2SYKrCS0zMz85DKN4761QSA8N6MeEnyd1pm14gzeAy3hIObaGU9uxl/DY2IjZE78UATucS8R65JvWcdrXDRBtavUKrT/t9SysMJxrcXkXRE9IRWafjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsspFLhLB4m3lle6Di5b4JtvcjqdXbQsAHO8DbqNyqU=;
 b=t8IkFjz7PvpvZSruawHcc4/dap0VYbKJEzNBgpHcbAaoJhAmDU+QF+bDfvm1GPB2tmQDxYKiT+AfiEECtrEaCUEsJv1CqPB4kq+CafGKiMwgjwh1eXOt3+KSSL1vsJJysMpWIpHx2tTT1iKYF3JK5U7TE67H6UevBaRJgfQnqO4DwqglYtGBcerhUGr1qQeJLBFVkub0/6GfZWcvMO2jCuHJa+WVmk7awvWUP+aE0U3U7Gm15TP1tsgffsWppqlfYFd8PEHeDKOCevNGqBVvpBLNTFs6VPBN41vIReG1tbJrDGG259s4S9MwA5r8ofoER/ZEHowa3jULkFDVgR/Y3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cyberus-technology.de; dmarc=pass action=none
 header.from=cyberus-technology.de; dkim=pass header.d=cyberus-technology.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberus-technology.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsspFLhLB4m3lle6Di5b4JtvcjqdXbQsAHO8DbqNyqU=;
 b=NiL/Vht02RnmSKKQzCZXF/G1VCzgUPBI4RwAPObjus6olxy2ZgIHb/Z/C1PM+GpwaI49eVQVPnygPjofR8/gmpJ73wnoG7FWEb71lzxWxprdiuWx8VhbT4os2BsIJgcssRYlhMAjp8gAuLkMBmioSK465H2zNUXiNA81tA7Yprx+n4heE4EZkJuN1fsj3fa9HGuZUVEqdZStHQ2fZzufEGlz4VTskra3HBU4t58SZrBDk+vYxbZFP6CQiYAGFd5lpjoAug5q9uhV6j5O6U+T97sSkqot1nju9V75W2r/BYSSZILYkdphptQa7aZmBOutlEzdOHLZODD67R6Q4+jY3Q==
Received: from BEZP281MB2149.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:52::6) by
 FR3P281MB2909.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.17; Fri, 21 Feb 2025 14:16:31 +0000
Received: from BEZP281MB2149.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2268:e9bc:a80f:9fba]) by BEZP281MB2149.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2268:e9bc:a80f:9fba%4]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 14:16:31 +0000
From: Thomas Prescher <thomas.prescher@cyberus-technology.de>
To: "willy@infradead.org" <willy@infradead.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "muchun.song@linux.dev" <muchun.song@linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] mm: hugetlb: add hugetlb_alloc_threads cmdline option
Thread-Topic: [PATCH 1/2] mm: hugetlb: add hugetlb_alloc_threads cmdline
 option
Thread-Index: AQHbhGdjWeAtnKeFHUuk5+rD3de1V7NRxuMAgAAGtQA=
Date: Fri, 21 Feb 2025 14:16:31 +0000
Message-ID:
 <eeb9d580a41cb314aba6ad21e751b506dc9cc434.camel@cyberus-technology.de>
References:
 <20250221-hugepage-parameter-v1-0-fa49a77c87c8@cyberus-technology.de>
	 <20250221-hugepage-parameter-v1-1-fa49a77c87c8@cyberus-technology.de>
	 <Z7iFHkybeT4v8Jbo@casper.infradead.org>
In-Reply-To: <Z7iFHkybeT4v8Jbo@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cyberus-technology.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2149:EE_|FR3P281MB2909:EE_
x-ms-office365-filtering-correlation-id: 990cac7d-0cad-4d78-1f9e-08dd528256ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V2tCQU9CTXljeXFYUXhNeVRaYmFzSDFnLzRQMER1N3MyTEk3L0pNK012ekU0?=
 =?utf-8?B?SGdyMG5YdktsZ2ZQYU81dnNaRllFRUYrYVR1eVZjV2FHOTdob25tUjVaSjJp?=
 =?utf-8?B?OWY5anY1dUpvcVRta0xuT3ZRZ3pxdjZwY0ZvaWMyY3pJcjRwMUJ2Q01OcTlx?=
 =?utf-8?B?bnhCajBQcXgrT05GdzhNQkM4eUZTL2VZNUJEbGNZZ21pR1lGU2JWQzhlaElJ?=
 =?utf-8?B?NDZmSzdxU21YSnZOWjRDM3VLZkEwS0NDbS8ydyt0a0JGTExoSjl1YWFhRlFk?=
 =?utf-8?B?RzBUblBKM1l0QXlRT0tnRmN1eWdtcmdrU2huZFc0UGYvdFBITjR0L0Nua0RB?=
 =?utf-8?B?VC9KTnpseS9DeHVmTTBzNFYvVFpONXNwWExLa0lPM0hIazd0WHBFYVVhMDY1?=
 =?utf-8?B?UDk0TDBEam5NQ2FnckwzR2RUZEMwSGcvYW1RdkdVY203SXQ3RFMyTHFqZjM5?=
 =?utf-8?B?QkZPUUdEOHVoVi9HUFF6YzY4dURmWTBObUtlYUZzcDB3K3BCZTk1bGQ0TmM2?=
 =?utf-8?B?QnNESkhCaE5LckpieXRLRCtnZ2lUOXZoV1M4TERoaFpOKzNyZjVLQVB2akF4?=
 =?utf-8?B?cmpwM0tWdERyS0hmNTlqa3dFZ1VuWUNnZkhvOGhoQVdzNE42N3U4OCt5V1JM?=
 =?utf-8?B?VHg1L2RpSjN5TEwrbUgyTXhDMjh1K3RiZFRpVU43YnJ6TFFNSW9FV3djVXpu?=
 =?utf-8?B?SjFQOTdBU01HTXpqYXNESDZhdXNXeksrdnErUGU3WVVHNWVuQXViUm1IT2F5?=
 =?utf-8?B?TDlnUUhSRXAydStXNjFSOTlHbW13VURJYlRySHU4SDhCZjJvamRsSWhQcnBk?=
 =?utf-8?B?cVo5dTJnNkJmc3gvZ2dsa1dZT0xCQngrQWFpeGV2ODBMWU9UTjdLQnNGZ3VP?=
 =?utf-8?B?ejRZM3pvN2ppZUo3SVpyVEthT2k1U1E0ZmxuYUdVdXFSMXBsTGIyUVl0TlNC?=
 =?utf-8?B?b3czMGZQV3BicmlrVWx5L3BpTkFsOG5jTE1OMUpDQkwvZS9OWUwyWXRiV3pN?=
 =?utf-8?B?d0oxSFJ5SXZFQjdTbnlWNmdFRzljdlgwZ2NwU3RaVHptblZmWkdOd1NIZTNi?=
 =?utf-8?B?ZVdySWRiRnlnMDhnZzVSWkQyL3VRc1c3QzZjcnJYSWRkWm53Y0MwUDlzaXFr?=
 =?utf-8?B?U1JGbUUrU3MvekxsUk8vMXRFNkpPU0ZtYklHM2lucjU3TWpYbEpWK0s5cnc3?=
 =?utf-8?B?YVcvVUVQNnRETFprWTViN0JIRWxqSnd0MmhUbVAyWE9GeVdFSktzcGlEdVJY?=
 =?utf-8?B?RW9ZdjNFNFkvdVVqZXE4SmxOZTJOYVl3Z1FCU2JIR1VRNjlFaVdLajdWRk1E?=
 =?utf-8?B?dWhjbklFUDJEcDJxVkh2VE5QQ0pCaFk3SXBKYTFkTEw4R3hEaUE1U25iQUNV?=
 =?utf-8?B?VmdaUGhZOWFlZjBMdkJrdENiVkJsRGlESVIrZXRCUHhrV01tZzdtWFBHcHVB?=
 =?utf-8?B?Yk9hY1MyeXJqV0pzRmRZU3FTT3h6Qkl5bUhwaFF0YWRvQjZ3L0tUZDhkWDNG?=
 =?utf-8?B?RlY3RDlyL0s0R25lRGE3ZnVEY24wUUlSNFIvdnR1OG90WkRCMkRMTXRYU09L?=
 =?utf-8?B?aHFWbEpSM2lCeWIyZE1VcDdONTFvVUp2U1cyTGxpZ0ZCNnM4dmZEdzlkY2FI?=
 =?utf-8?B?R3piVFYraythQ2cvUXJBZ1dTcGh3eVRhMi9qVHZKNEttbitFSEZRa09QZktT?=
 =?utf-8?B?ZGk5SWF5eVR6MG14UlNENWNNdm01T3AxMUhzTjZjR3NwcHRRRVRuOHZOazFr?=
 =?utf-8?B?SVJHNklGK1crQ0p3dHVvSHp0a2x0OHMvT1lHWUd0QzhYVGRnSTVCOVI3b0Fm?=
 =?utf-8?B?MUlma2RXd2JVTHlVRklrTVV2dzlTbXZOOWlKYUI5Tno3VkxEdWZFTzZlVENm?=
 =?utf-8?B?UDlCU01yNFYxUGNETzFvMkhvM2NMbXRNYnVwVTl4dkZlK2lqRjBtY2RKSmJj?=
 =?utf-8?Q?OGAYAunT1sVukiY/PnkI5nP0ybYH5jWg?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2149.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QnM4N0MvY1VhYmtLOFA5aEdSMHVZeE5yaGFsMmRDUlE5WHh4bWZSejhGTG93?=
 =?utf-8?B?eUhTY0czRzA2QWdLaFVBY2RHNG03QlVMU1pSRFJMVWFOaG0wb2FRRXZaMFhp?=
 =?utf-8?B?WlFYYndBSnRIWTh2SlJ4VExTaWpURG1WRDNSWk14amVFSldTSytjMEhlbTcv?=
 =?utf-8?B?MlpLbXQ3OGJoQlhJMEF1OGc0ZnI2OTJ3dTZQd2tTR1NtbVhocFBEYytRbUcy?=
 =?utf-8?B?VTVmYjBieVpxRFNudVNlOTdrVUxuMVl1MjlUSkhoTmZXTFFmdE5jc2NxY1Rz?=
 =?utf-8?B?TS9BTmxTU2NEakNtYjgwSTY1TS9aNk8zdGdvZk9qWmRxdnMzc2xFdEozNEZL?=
 =?utf-8?B?RlUzTktoUkJLWEVQQXdBNDZxaFpTbWFSY05xaW54T0N1Y2ZuMXN1WGpSK1Vu?=
 =?utf-8?B?Y3o2aWQrTmQyMWZjN2FDUSthU0VHeUpkMUdlY3JUdHhwOU1YVXBXNGxFc1lE?=
 =?utf-8?B?cHpscmp4RStoMXVpY0tGWGxrV29xNWV0YjQvMHBkZ1RkZy9YQ1FzUFFxa29x?=
 =?utf-8?B?cWJEYkZuVk1rL0o0czZPS1ZIaTk1KzFkUkJaZTlrR3hnem56cnYzSk51MkIx?=
 =?utf-8?B?cTM2ZzE4azNPampxMmR3dGNXY1N2dDFQbjI4WGdjekhjbFd6SkRURnVHVGx6?=
 =?utf-8?B?Q243Qk9KUk85UGdCRVU3TjhpdUlnSjNRZXNzQU9yVzhYb1d3WDFUd1ZDMkNv?=
 =?utf-8?B?bXRWc3BnL3YyZ1Y2bHh6SjdYR1RSSjdaQ3U1SFhXY2J0eGtEOUZBNXFkN0tX?=
 =?utf-8?B?anRDRGdGbG5mQUZYcUxuN1RxdzAvdDl0aVRnUWZnbEVPOGIxNkdWVGpsVVU1?=
 =?utf-8?B?N0xmRGFtN0Y1bmdlUVowcFlTMjZJOFE2T0pDVXlmR01LcEhhNDZXOW5BaFNv?=
 =?utf-8?B?b2FSWWwvNzBnSklHSFNjRHgyeGdSSzZHQmJqU1NuamJLc25RRW15RUxTZHNK?=
 =?utf-8?B?OVJzdGZxWDBkMndvVWM4OFByOXhKWFhlMzhVUHp0ME41a3N2dDM4NDFCclAy?=
 =?utf-8?B?U3dtZjlmWDhWTkd3Qm9tclRrdXZOSVQ5VkYxV2FwS2d0dm9BNllBeUVINXZx?=
 =?utf-8?B?UXNsSFVWTkwwQjRHQlVXc0RYcDR5cFJLMEVTNTluaThYMy9zekRhY2kvYS92?=
 =?utf-8?B?QjVTdXN4M2JwTVlBTmp5aGVZb3BIL3B3T0dIQW1xdy9Idlc4ek5MS3NRUEVy?=
 =?utf-8?B?MllhODVNSFNMSU5Va3FmTXpsakYwbW9yV1JUNVFQcGtibDg5SmpLbDdCT2g4?=
 =?utf-8?B?WUJ4aEY2ZHg0MFU5QzRuTzB0TnZzdkc0aDhvQzQrY25qRTF0RXh0TkMvV0lL?=
 =?utf-8?B?RTM2NzdCQ0MyZForWEEzME5YQkxlb2I3VFhoaVJrSEhKTTJqQnFuWGNTT3A1?=
 =?utf-8?B?UG9zV2FxeXBDbXkreHAzWHJHT3MvaEZSZkZ1TmZOc3JsbzFHdVFmV21JV25Z?=
 =?utf-8?B?STdzTzlETG0xam1hOVN6bVhXVVMzNEdhODI3WnYzNm9jeDF4ZlBWSExVblFo?=
 =?utf-8?B?NGl5b0VLVldYYmNZOUxFSm9YckV2dlRxVEJ5dndjZjZIK2lpZ0d2Z0FOQnJu?=
 =?utf-8?B?N0g5Yko0eGl1a2pudDFGNmRKRU90U2orUFhzSjRoUXhhaHpjcm5TS2Jqdytj?=
 =?utf-8?B?eFQ1cEhSYnVZcFU5Y3lJdHIxZDhScEN1QkthS09ORnI4em9INnVLN1hXQlJP?=
 =?utf-8?B?OWZ2NHJLMHBNY2JIV3pyWVFVWkp5TW52aXBCck1XUTd5bWlITWFMT2pFbDZV?=
 =?utf-8?B?U0VaVVJFUi9mMHdoUzVrd3dmQmVKU0dwR0hUaGVuNTAwRHJ2dVl1aFMvTi9v?=
 =?utf-8?B?VlB5VXJnUndUbVJBWUd0Vkl3NVVXRElpSlFxK2pZVTRsRjZjUnI3amp4ZmRF?=
 =?utf-8?B?L0Rvb1ZnY1Izb2h1eGJsWFZNbVZ3dWZOTFVQZHp2T3dZMVA4UWM3K1BYd1ZV?=
 =?utf-8?B?ZFRLWFRFRGZQWkhHWUtVdTVTSEl4Mm40ck5MUlRDbnlSbUNWN2R0MzFkWG9y?=
 =?utf-8?B?SEdoMjdlQ0dQRmVHY1VmNG4xQlRpUGlHbVNpdWxCL0xzT0U0TnkzRWc2NGtU?=
 =?utf-8?B?SW5XaEljWWJHR1FrWjFiTnd6cUEvVEU2Tkc4RnhWODFFZDM2M3FkQUVUcFlu?=
 =?utf-8?B?U1lNbFdFTDJxTnU0TEEwdnVVeklOZVlqMEN4cWJPMGFXSmdybllSdlZmRjVL?=
 =?utf-8?Q?wlfHVVUSgJkDHJJ/r/TNvl7HgwWnXes+Tx9MtpgVW82X?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88A77F618B21A0468CB15EB8363C7D4D@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cyberus-technology.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2149.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 990cac7d-0cad-4d78-1f9e-08dd528256ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 14:16:31.1461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f4e0f4e0-9d68-4bd6-a95b-0cba36dbac2e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0m4iJgkKWs0vAosBpVFL7J/3aZhL/cdscEV0+ubAFTdGI2h8VHt31lMeVqw0Jh1oLGzaH29Eisttr6EDTIqBcOJ3lT3aYkTx3LAXVCAFNLe421E6TgOUSTD7CO2SFrtU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB2909

T24gRnJpLCAyMDI1LTAyLTIxIGF0IDEzOjUyICswMDAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gSSBkb24ndCB0aGluayB3ZSBzaG91bGQgYWRkIGEgY29tbWFuZCBsaW5lIG9wdGlvbiAoaWUg
YmxhbWUgdGhlDQo+IHN5c2FkbWluDQo+IGZvciBnZXR0aW5nIGl0IHdyb25nKS7CoCBJbnN0ZWFk
LCB3ZSBzaG91bGQgZmlndXJlIG91dCB0aGUgcmlnaHQNCj4gbnVtYmVyLg0KPiBJcyBpdCBoYWxm
IHRoZSBudW1iZXIgb2YgdGhyZWFkcyBwZXIgc29ja2V0P8KgIEEgcXVhcnRlcj/CoCA5MCU/wqAg
SXQncw0KPiBib290dXAsIHRoZSB0aHJlYWRzIGFyZW4ndCByZWFsbHkgZG9pbmcgYW55dGhpbmcg
ZWxzZS7CoCBCdXQgd2UNCj4gc2hvdWxkIGZpZ3VyZSBpdCBvdXQsIG5vdCB0aGUgc3lzYWRtaW4u
DQoNCkkgZG9uJ3QgdGhpbmsgd2Ugd2lsbCBmaW5kIGEgbnVtYmVyIHRoYXQgZGVsaXZlcnMgdGhl
IGJlc3QgcGVyZm9ybWFuY2UNCm9uIGV2ZXJ5IHN5c3RlbSBvdXQgdGhlcmUuIFdpdGggdGhlIHR3
byBzeXN0ZW1zIHdlIHRlc3RlZCwgd2UgYWxyZWFkeQ0Kc2VlIHNvbWUgZGlmZmVyZW5jZXMuDQoN
ClRoZSBTa3lsYWtlIHNlcnZlcnMgaGF2ZSAzNiB0aHJlYWRzIHBlciBzb2NrZXQgYW5kIGRlbGl2
ZXIgdGhlIGJlc3QNCnBlcmZvcm1hbmNlIHdoZW4gd2UgdXNlIDggdGhyZWFkcyB3aGljaCBpcyAy
MiUuIFVzaW5nIG1vcmUgdGhyZWFkcw0KZGVjcmVhc2VzIHRoZSBwZXJmb3JtYW5jZS4NCg0KT24g
Q2FzY2FkZSBMYWtlIHdpdGggNDggdGhyZWFkcyBwZXIgc29ja2V0LCB3ZSBzZWUgdGhlIGJlc3Qg
cGVyZm9ybWFuY2UNCndoZW4gdXNpbmcgMzIgdGhyZWFkcyB3aGljaCBpcyA2NiUuIFVzaW5nIG1v
cmUgdGhyZWFkcyBhbHNvIGRlY3JlYXNlcw0KdGhlIHBlcmZvcm1hbmNlIGhlcmUgKG5vdCBpbmNs
dWRlZCBpbiB0aGUgdGFibGUgb2JvdmUpLiBUaGUgcGVyZm9ybWFuY2UNCmJlbmVmaXRzIG9mIHVz
aW5nIG1vcmUgdGhhbiA4IHRocmVhZHMgYXJlIHZlcnkgbWFyZ2luYWwgdGhvdWdoLg0KDQpJJ20g
Y29tcGxldGVseSBvcGVuIHRvIGNoYW5nZSB0aGUgZGVmYXVsdCBzbyBzb21ldGhpbmcgdGhhdCBt
YWtlcyBtb3JlDQpzZW5zZS4gRnJvbSB0aGUgZXhwZXJpbWVudHMgd2UgZGlkIHNvIGZhciwgMjUl
IG9mIHRoZSB0aHJlYWRzIHBlciBub2RlDQpkZWxpdmVyIGEgcmVhc29uYWJsZSBnb29kIHBlcmZv
cm1hbmNlLiBXZSBjb3VsZCBzdGlsbCBrZWVwIHRoZQ0KcGFyYW1ldGVyIGZvciBzeXNhZG1pbnMg
dGhhdCB3YW50IHRvIG1pY3JvLW9wdGltaXplIHRoZSBib290dXAgdGltZQ0KdGhvdWdoLg0K

