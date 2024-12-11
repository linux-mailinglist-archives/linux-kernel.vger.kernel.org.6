Return-Path: <linux-kernel+bounces-441470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 612C09ECEBF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E521882253
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90B2188583;
	Wed, 11 Dec 2024 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XCehHiNp"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F9C13C9C4;
	Wed, 11 Dec 2024 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927842; cv=fail; b=fvE2qKQt28CQTnFQ192RfyVK11dF9e2RcSBOfd11G51E453ncGKSU6KCfhoXQvRQjgt4GguA0BmEOqcpADnQmY/HxnCqCavr06vt+dYelRSM0A+G2e9G285phauDJNzAaUBI0aptT3eCuz5sg8lAEidG1tJJUXxzvpEgNE3l6A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927842; c=relaxed/simple;
	bh=EIDyxviDNpl8hA5XBH4Lv2+mkrvQTzz26kR0qspSy/I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZGoJliv2S4LsSjyGzQ/fNony0jPeRP4Bx5vcvWc5jnNVILn8eqYSFLzCkeJU/4uYRcYVDd6WhxDz6dNf+sxDBMeJ4YTeIJW0EzZg9WQmd10PUFghl6F8WHnIK+VYmC/HiowUwWdbWhyDGlLW2kztp//0k82hadWETz0BlElgXWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XCehHiNp; arc=fail smtp.client-ip=40.107.96.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBrcafeWGaX24jJiFb3P9akz4rnZBvkmPbI05tiWApH37qkvGfJmWGJIk3OCmbUP7hOjPwDaj4gomk0i1j7Kfu/g+GNNQR13DJmMfllY7nLZ8cpHzE9JspfESdPlUW8JbR7N9jcPN59dbr3BcRGJZOiVxzIYi4OIOyW6ZhKAREPA/ZHTg5yV2ieEaIFLiRu87S0ggvfuV9FOga/duJyPb+FIHB1DU0htBAyEEnZs32jV2V1Urk3h+f8jgxrz68CqIWPQO0i/YMZN1OBPBjJFzipMJjg40zUFrtfnqoHlH0I+N6lwhodYiNyEjgT0mAI3hUHqANjKGG1pXMb1y1OZLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0L56KoG/b/ANHQIYZhwsrxH0qqjYe8Dm9CAQpm6U3ek=;
 b=cBpN61lY8dx4sN2FWPyF4K7RcixwXewc5CEfZs4Ji+MQF+5FUkDP6qR5Z1H8tLGOxz9f+5EdpFcPhHmejiaQrJ/SnLFi/p7hoFNp3EkhGDReAdKbbQZVjceIj2zxcSc7en85qYkMp871ecO8ZJa3TQfa51g7GfYe6eFGc8DWMrby7IwegrksrJ6rf8GhoYcfW7n+RKplwFsTUGpah1W8iGBDFNysiEXKzeJU3KQDy/VxAVglc3aiYxM13PCuL6k1MBc6zN++Lauw7KzDJDS8H/bZxZSB39Lm5U9Wzs1+aaho3cd4egFnSablRaWoLd4cOPPKzTYLgbFcCO5516i+ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0L56KoG/b/ANHQIYZhwsrxH0qqjYe8Dm9CAQpm6U3ek=;
 b=XCehHiNpWHW76D7Ifq3tzUb0GWw7tYbt/yPU8OPOTIAkzemqJwarz9bv/j+cq5ZEb+pHHsy3wovRAYZd6oxNcHBLVXNR8Vpb3f9iZiGy9CpqH40mB9gLWhi1rqFj6jH78qNMcSHMKGyKGPh98RKzMtgxT+nloUFVqo0aYajMt/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 14:37:15 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 14:37:15 +0000
Message-ID: <5051fb04-1bcc-4448-aa68-6ff300cc17d2@amd.com>
Date: Wed, 11 Dec 2024 15:37:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] ARM: zynq: Add ethernet phy reset information to
 DT(zc702)
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
References: <cover.1733920873.git.michal.simek@amd.com>
 <9e18d59ca339804320d2a5e3c7362aefa3bb7c99.1733920873.git.michal.simek@amd.com>
 <8395fb6b-d7a5-4e2c-9eb3-4984b8c775c4@lunn.ch>
 <344eb4b3-1073-4c65-a8ba-fee943776627@amd.com>
 <897ab5eb-a210-41d6-bfef-a60ab74f5943@lunn.ch>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <897ab5eb-a210-41d6-bfef-a60ab74f5943@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0042.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::14) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: c88bdf86-b16c-4145-38d4-08dd19f14e8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aE9MZkp2ejVXNkVLVXFKOHJlMWs2bWlNWVhJM2thclRhNnZ4T1l1c0hmbzll?=
 =?utf-8?B?Qy9NYzAxaFhnUU93eU1YbytIMHVEVU9YdW9DSDhDNnExMklYMmRaQTJ0ZXRi?=
 =?utf-8?B?Vk1KbXVxVHlkc1J6b2ZlVWNMZko0dnZoMGhUazVtejc1NXpsVExIbTJWbmRP?=
 =?utf-8?B?RmZHN05GREZXbXpYYndDMWxoOW44bmRWRFl0d1h6ZW1zbmxSTUE1K3ZMbVZS?=
 =?utf-8?B?REdiUHVZcWVScm0vbjJ1US85RWxsNHhpdHMvS28zNFY3Z2dhcVo0a0txenlx?=
 =?utf-8?B?MDdzdHp6RS85cEl0S1YrNFAwQ2Y4RGd6Tkl4NEJQNW5aU3RDQnZndHdQNnNP?=
 =?utf-8?B?KzlhNStBYlNvSDhQNDlJczBTTnpKYko4RktZWVliV1ptd0NiODRXK01rcEtS?=
 =?utf-8?B?SC9xV0RLcHQ0NGdWOUxLRHhPb1NXOVhMYWdHN09pY0dtNGM1OFRVZjFNdXQ4?=
 =?utf-8?B?S2RrY2FrUnR1VnZ3dVRqaW9vNEdma1BjMU45aTlSYktuM3ZjV3U3RVFEWWlV?=
 =?utf-8?B?TnByb0RDNENHZjd4L2JkSXZsZ2FmMmFNMkptQmFsUnhOUEhKNTh4emdzdFZB?=
 =?utf-8?B?akdyUzBaUU5IT01KTjI4WGFnVWVmM0NXMkxKd2x5bkduakRIV1lmbitaYVIz?=
 =?utf-8?B?QWpPTWVYK253TDNRalJQZDJYMVpyeTNTWUlteGJqb2hkaFdNbzJzN2RpdXYx?=
 =?utf-8?B?ZzlsYVRNd0tEdm5kUEFBMkhaUTVQcEYwekFkelVIZUh0ZG9XRWg5TmVpMlRJ?=
 =?utf-8?B?V0NrMkFRZjVyaFV1dzZQb1J1K2U5NytNaVJOTnRxOHM5MWJtN1Ezd0Uzd09k?=
 =?utf-8?B?Q1VFcHd2dlZHVWdsZlAzbjNwZFltRy9FTXdNUFhQQlFjdE9MUkRJenZoUk9U?=
 =?utf-8?B?TC9ZVE5vZUtJeUNCcTF3TTNiL0pObytrZktiSGNzcDdRK0VCektzOS9Bc1JQ?=
 =?utf-8?B?SGxxNTFMQlBxbUpMSmVIa21veFJTdEJaT29KRXJySUxVTE01UmVEZDdRM0dp?=
 =?utf-8?B?dUtqbTJxcHdUYU9kWEZxaTNYcUFvUFhRaHJYT1BOZDBPY1JUWS9hL3YyOTAz?=
 =?utf-8?B?KzF4NC9DS05YQ2VFek9PZWpKYlUxK0Y3Y2xsODgyTmUyRG12OE04RnR0YlV1?=
 =?utf-8?B?R0had05pREMzdGIxSDBoK0l0NVY4VXhLR0pPekt1MmZCckdWaGw2Tmt1a0Fs?=
 =?utf-8?B?YkU2Ry8rM0RwR3dlZUQ0T0lsTmdITHNISkhBMmNzU0o0MWJTNXRFNWlGdnB5?=
 =?utf-8?B?MzhMeXZ5ellkM1hnQk9vTVRGV2pQaVBMWGhyT2xOUUh0SllTZVp3WXU2WTYv?=
 =?utf-8?B?U2EwMXl4bk42TjZNUEtkV2x6UXgwRDBoYW92MmtUTmdTUERlT0ZwQ1hSRHhZ?=
 =?utf-8?B?OUFienZtRmZPZGc3d0dFL2QrZXN0eGdCTGQxMDhQa0xFenEydVZLZ1dsSE5k?=
 =?utf-8?B?T2xkZGsydEtxbUswQTNzS0VHY2hpeUQ0cjlFZkVOZDFOSHJzeGVjMElvRHd3?=
 =?utf-8?B?RFhmWEgxVm15NHpQNnEva0lUc0FZTXowOVREenBSeGZ5RXh1UzNEK2pTR2xk?=
 =?utf-8?B?WmJXTCtiN20xdmcybUNwb29GdkZnVGl0d2NzYzRrYzhuYTU0MnlRcXR5am1o?=
 =?utf-8?B?bmlFS2hXNm5wTVF5blJidjVzYnE5ZVBhbHJKYXBtWThqV1lsSXgrRFhQWFdF?=
 =?utf-8?B?VHJsSjUzblBIQ0R0ODdpdGpWbUZYVElabFNNVFFvMGpPUkt6ajZRTEozSzNx?=
 =?utf-8?B?MmwyaG1hWStPZXVEVEQ2L0xJNkoydFVHZjJscXl2dDB3NDZURmtoUkRxdWs5?=
 =?utf-8?B?bjVmVytmUTFOTDZXK2F0Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGpzTko3di84cnppQnM4YW5hcUF0MDAvOWZYNXVJTzBuSDVpMEhKRjNzcWlY?=
 =?utf-8?B?T3B0Q0RPNXdMc3FrNTdHdm9GRGZDMEliUzdOM1ZrQUZRSHI2WWpWY3RmUGlq?=
 =?utf-8?B?TEZGSDZPc1A5L2tQeDV1amJtSmV2QVlFOU9vRWp5N29Mb2oxYVh6MW83WWtS?=
 =?utf-8?B?TnlFa0xjVXN5VzQyRldSVWlLaVRtT3lGL3NwTk5uSDBIMGVMa05adURZRXhm?=
 =?utf-8?B?TFAyQXB1L2lYcW5pVzhKYmF0d2c1aWd6TmxsR1c4aGRNRnc5c2FFdnJQTjNB?=
 =?utf-8?B?RlR5MTl0M3lITUtocndMQzF6N0cxMGV3UzNQV1psZkQwNFIydDJFY01GR0Rp?=
 =?utf-8?B?U2NhanpzMXg4MGxzcWptMzNGMGRiWUl3RkpUcDZOVnRWT2hCWkpUK0Q4RnhR?=
 =?utf-8?B?ZE9yeXBtQkJJYkgyK01sKzArQnZCZWZrZWowbW1nZjJ5eUx1dUdyKzRhN0Fh?=
 =?utf-8?B?UE9tYWVGRjhrNnRYYXFmYW1RZGxWT2draisxcWlycWlwU0dFcThSQjdvUmly?=
 =?utf-8?B?MGU2N1FyZkJJalpsNExCT0duQlNKWGZZZnFSVGNvOERWeXpUNGhzNVlPcGJO?=
 =?utf-8?B?OTRSM01zcEZyb1M1cGJ4RkFJc0ZSMnc1YS9xNXlGZHdacHhBWk42OCtBVjRr?=
 =?utf-8?B?RURNN1lXV1laZlRUVVBySysyeVhHa1VYRFIzOVZDeityWGxNTkJGaHlrcE1t?=
 =?utf-8?B?YVVPNkFwbGIrRy8vZ0UxS1I3Q2I4NlByL0J3NGpmTklVZWxlRVJvcG95WVpV?=
 =?utf-8?B?YjRiUDRXUGVLRm9pZENqR0V4K3RuZU8rWXg1RHJTQzl0UGsrSjJubER0aGJu?=
 =?utf-8?B?TkJpMTk4RVNVcC9qZmY3Ukt2NTFXWmhMdTZueSt5WndsbUVFRnd6VjFGd0J2?=
 =?utf-8?B?WS9MbU5NcVU2TERBWEZreUp3b3FGa0trQm4vYWxmZkxuTk5GTDEwYXZxd1B3?=
 =?utf-8?B?ZnIreFNQcVh6cThyeWZZV01oUHhDNXNaWHBkTDViV2VKUTN0MElJR0ttS2xk?=
 =?utf-8?B?aWIzMTFrekNreWRmL0JhNWFFb2IrcFVyb3lrZUppL2lmcmFHL1ppeHdBVUJq?=
 =?utf-8?B?bnM3djhNeVVEcjhyc3hsYkN0SlJXa2hYOW1Ockt5M1hnblRaY3FuODNyR29X?=
 =?utf-8?B?R3RLSFNINjRtTVJNZ3BPdklNdmpOR1pRRUVpK3ZtOXUyM0J5R2pwNlFad1du?=
 =?utf-8?B?TWNzUlErbTNPV1JqVElLVWFyRUtCeVhtcHpwZnE1aVdDY2Fwd25IUXdIMkFh?=
 =?utf-8?B?TGl1aTJBZm95cjVLdkVTVkdwY1hlaFhHei9qVVZpUURZMHVkVkFvRVRlWDJO?=
 =?utf-8?B?WFA2a2pDT3k0ZTdBeWdIdWRXaDM2RmpoSHYzak1kaVczWU9PZy9NSHhBNjlM?=
 =?utf-8?B?eXhweXcvenNleDdMZ1pSdEFMdStWMTBuOWp6SHF2K096bmlVai9RS3FJVkpi?=
 =?utf-8?B?K0lVVkVDbmFTL001MG5udjlNbjFTNnNHaEx0bElBd1FQNlhUdUQ0WTNuVGE1?=
 =?utf-8?B?MmFURis3YVZ5RUpxZy8xSXRxSkkrQ09rSkR1c21sWkZaMy9mVUFsY1dNcnJh?=
 =?utf-8?B?V09IcnQxbFlqRE5DckxoZlMvK3pLdTYrSitEWGcvUDZCYnZzMmp5SExTTGNB?=
 =?utf-8?B?dUl5T3dlbVRWVFRjSXJmUmpRQjQzM3A4M25rdTd2RzF4R3U5bFEvRFY2aWUz?=
 =?utf-8?B?T21iV3dRUjVJandaTGxkZ2h1QXpUZ1VUSnFQaVRGWHJKRldTZU5mV24wUGVm?=
 =?utf-8?B?emJOVEFuWm11aUhCU2ltWFRCQmU3MEFXL0F6eEk3SG5rcWxRV2J6NENTRXM5?=
 =?utf-8?B?R1VJUU9DMkxQalN4SFZkWVVuTHRqR2hCS2dyb3F0UTFJdVNWZENmaGxXNmNG?=
 =?utf-8?B?WmZTKzVrZFB0d0FHUTRJOFJuOXNTendVVjRVcDRCV0c5YUhtck1qRWpiems1?=
 =?utf-8?B?MFNreG9mVlBmYm4reFBVSDhLNnNHVmtKMUNiR3Z6V21Qc0hYbmVQMWdwdUdF?=
 =?utf-8?B?TjhwSWNsMTdYZ1N1VlhxaW5JdnBXTzRzak82WU1RTGNkWVU3bkg4aWxGcEQ2?=
 =?utf-8?B?a2NENThOa3hCWEZHdEROVm0rbCtXR2pDWFVUVERmVzU4YXZZL3JudXVoUEsy?=
 =?utf-8?Q?RSKUv/w539tXY5iA0c9h5Si1u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c88bdf86-b16c-4145-38d4-08dd19f14e8e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 14:37:15.4631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkEoORHe0s2KtKx4qIJ/GxXebBLO2QiNq4XWc21j5SoSWbQ7RBEP68r6Dsb4MOWo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120



On 12/11/24 15:21, Andrew Lunn wrote:
> On Wed, Dec 11, 2024 at 03:04:28PM +0100, Michal Simek wrote:
>> Hi Andrew,
>>
>> On 12/11/24 14:45, Andrew Lunn wrote:
>>> On Wed, Dec 11, 2024 at 01:41:26PM +0100, Michal Simek wrote:
>>>> Added phy reset gpio information for gem0.
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>> ---
>>>>
>>>>    arch/arm/boot/dts/xilinx/zynq-zc702.dts | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/xilinx/zynq-zc702.dts b/arch/arm/boot/dts/xilinx/zynq-zc702.dts
>>>> index 424e78f6c148..975385f4ac01 100644
>>>> --- a/arch/arm/boot/dts/xilinx/zynq-zc702.dts
>>>> +++ b/arch/arm/boot/dts/xilinx/zynq-zc702.dts
>>>> @@ -79,6 +79,8 @@ &gem0 {
>>>>    	phy-handle = <&ethernet_phy>;
>>>>    	pinctrl-names = "default";
>>>>    	pinctrl-0 = <&pinctrl_gem0_default>;
>>>> +	phy-reset-gpio = <&gpio0 11 0>;
>>>> +	phy-reset-active-low;
>>>
>>> Hi Michal
>>>
>>> Could you point me at code which actually implements these two
>>> properties.
>>
>> I have tracked it down and it was only used from 2016 to 2018 in Xilinx
>> downstream Linux repository. After that it was removed.
> 
> O.K. So when you ran the DT lint tools to validate these DT changes,
> why did it not give errors pointing this out?
> 
> I wounder how many other such errors there are in this patchset?

That's definitely valid concern.
I was running it but for all files there are a lot of other issues generated 
that I missed this one.

../linux/arch/arm/boot/dts/xilinx/zynq-zc702.dtb: ethernet@e000b000: Unevaluated 
properties are not allowed ('phy-reset-active-low', 'phy-reset-gpio' were 
unexpected)

Thanks,
Michal



