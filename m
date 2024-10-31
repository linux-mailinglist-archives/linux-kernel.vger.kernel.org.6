Return-Path: <linux-kernel+bounces-391358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B15DB9B858E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D44461C219F8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DBB1D094F;
	Thu, 31 Oct 2024 21:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aX8Ix0an";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aX8Ix0an"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13A11BC9ED
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 21:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.59
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730410977; cv=fail; b=W4ORe+T0ME9HB5NRjlLkSJxS3GH5rxozSasMj65qGqDq9EWtEY/LtcNQMOwfXR30j1c3zeTQ/2e64gJI/qCPUR+hOkkD09Q/Y7hAqnT+4xci4g4DqKU1jNJp/bisFG42kgmSVNWtjXCb24QVsLt139xCnRhiD6Pe9w4U4wA4JBw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730410977; c=relaxed/simple;
	bh=WZvWCMNOrbPpfr2gyLRsw86nRUaDWzpIEmtgD0yZZms=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yrbs8Fo2vkAzTmfzR6uBpL8sBOBc854phkKPnFcBClwI59VH86iu0HAFaVzWY/tOwscOvNPSD6dbsnSXHJmRTUo/kYtUhE0wm3GiLHwXBKCf5hCNrBi4aG+9OK0+dBYXYm5VLDjtGjBxdI7aSO6olSJZecTJz1Kzaga0H9N/eLc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aX8Ix0an; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aX8Ix0an; arc=fail smtp.client-ip=40.107.22.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=uF3UENwJXTJh5iYSt7AHuoIosGxQuaKACyD2JMTP5HQc18WNw4E/mTkJkW0CIWFticMqvSBk9A9/UC5/PU5R5WMEET7g0VDpuffI1D3v7OigyovboBaIHZe7hZhEvbuW+WOvq4cHPhoYlGslxBtfGdtdBgDflCU3+fqpJo1PnlPqCbVlgwv7KmQf7C0rEMHo7wR5+B9sWejISOaRO8ZUmqNIP4GSBX27C+qDWhV7CUk/ChsbwV0lovKE1vDHl9+GwGfp1dR/MnfrmammrG9rkxt1fvvyskgv/F+OUuLSliEPiz/9h1Y49pL/adNQRwxJHwUHbzsogSulEoxFgIocZA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCADoZ455RolCYiQWVnT0/TWSNe5edXG3KtHO/T9nFM=;
 b=e2yWHF6Bg/VXASQaSI7uudMSyTUHpYdBdEwt/e1GB6/EQLLAlh2rFPZth5YqUCegQ8pVdT2jo9zBeJU2Vu89lZpzYXras8oQZKHF47dT2ehPFGgofLWkwvn0BfN+eu47PRoribfIwFgahwHVkSfys5oEDDjB/cE97aroehJ5B9hX1mZocg6dvNtOcFDMOMtVTb6k9/cB022xlz2BSZYsNQYmC600tBL2DieHCJniup7oaO5ssL+baadINv8oUYGi/X6i/s3/c1Xjyb8NSdI0E4PA3a2N7Tp2Sc06XjgbXXz3TPPzjyQd2rwCQmMCD8/w5ArIzALEWW6v1+M5YqKdPg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCADoZ455RolCYiQWVnT0/TWSNe5edXG3KtHO/T9nFM=;
 b=aX8Ix0an3NB3RgjXSqUI8OWkAEa6Opo4VmO9GZA2OvtFedxTG3lbtXy/EBQqbGSxBeVB5WbL/WqK4JlfKM6AQ1z0NrwjmvB0ntgXCRf/AhNFZ4LxrhNio3qhzG8WgDqsBrQZWp4jict+QFi/TRf/EPH67fWUTdPdrdpKqCCdkd8=
Received: from DB8PR06CA0055.eurprd06.prod.outlook.com (2603:10a6:10:120::29)
 by PA6PR08MB10525.eurprd08.prod.outlook.com (2603:10a6:102:3d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 21:42:45 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::f2) by DB8PR06CA0055.outlook.office365.com
 (2603:10a6:10:120::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Thu, 31 Oct 2024 21:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8114.16
 via Frontend Transport; Thu, 31 Oct 2024 21:42:45 +0000
Received: ("Tessian outbound 0fe1877cedb7:v490"); Thu, 31 Oct 2024 21:42:44 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a6aebf973e90ad25
X-TessianGatewayMetadata: 0L1o5m9Ht7KnrRi+C4Usfbdm53YL6i5afXyRZiTRHlqPy3aBfs28CaCAFE28SxTzH5EU7Kp3ZXR9D993iLx6+nap1jLUMBvDC4i8RXWAp1Z4mfPlSAfbZfBAnLJbg9Ng6Xna9t/L3SaNOkXMwEaBQ6Oa157h+Zf/+isVFKodWUw=
X-CR-MTA-TID: 64aa7808
Received: from La8c72a85860e.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7EA383CB-4653-4CA6-973A-6D7E38CC9303.1;
	Thu, 31 Oct 2024 21:42:33 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id La8c72a85860e.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 31 Oct 2024 21:42:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkmiPJBXppFPO/liKZR1taalovcGEM0rP3SR7QT+qobxl620otOxJddfPNbOtUKJ7GGc0GhwAA9m8a6k4o/Gv3urM24bd70HvU+hZQ/Ir+xCR0W+dviLlUDX7mE7hdbQ2QSGw25K4XZjiOeWV2RNiIM4/RZKWaU5+nZ3Ks/HTb4/FHKJERC+FISi40lgWPmd0RuwT+UPMVVkbTAOgi7uHprE6Arbe34rElvEg+MXJ2a7C3QTw0Bm9/vx0Q7JruPJ6V7BpD1u0mJKuZZVBnMi76oNWEozdZAB451sF6T//YP+bvGLa//ALpV0QZtTbELs51gDDvB/2eqjnrFmZSs/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCADoZ455RolCYiQWVnT0/TWSNe5edXG3KtHO/T9nFM=;
 b=a+M94EgLfmpYn/3OIS/s2NgVdGuvAk7RT2Z8lAcAUt+qmkKi6j5mY4IvPR65oekUoeou33O/wxne15XcrTc/b9ZmwgVart34noHK9MnxlF/oK54U+sDYvaR0dtshm9Ump6YME/CU867WPmcYSM0fsIMnV0elPQr5H9aaZI1wrVk/Pkq7p8SrU+8y9uzx1B/ymf2MVodPPTRZB4FMzqhhAff1FXoaeCrCTZRAwxBzIrqJfWGAkcEsW3wvt75gKuBrX7NiRLhfBwd8FinqrW5uC3yass4fCJjPi0Up/Yw9Cmj5PAmZ+AeDtjRD4EqtqLYV4Msdl931vkYixn8SjiTyMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCADoZ455RolCYiQWVnT0/TWSNe5edXG3KtHO/T9nFM=;
 b=aX8Ix0an3NB3RgjXSqUI8OWkAEa6Opo4VmO9GZA2OvtFedxTG3lbtXy/EBQqbGSxBeVB5WbL/WqK4JlfKM6AQ1z0NrwjmvB0ntgXCRf/AhNFZ4LxrhNio3qhzG8WgDqsBrQZWp4jict+QFi/TRf/EPH67fWUTdPdrdpKqCCdkd8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6982.eurprd08.prod.outlook.com (2603:10a6:20b:415::16)
 by DU0PR08MB7922.eurprd08.prod.outlook.com (2603:10a6:10:3c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 21:42:30 +0000
Received: from AM9PR08MB6982.eurprd08.prod.outlook.com
 ([fe80::5d5d:a4a7:198c:fbdd]) by AM9PR08MB6982.eurprd08.prod.outlook.com
 ([fe80::5d5d:a4a7:198c:fbdd%3]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 21:42:29 +0000
Message-ID: <40c9a0a3-81e4-4ecc-b9a0-d55523f5f594@arm.com>
Date: Thu, 31 Oct 2024 21:42:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/panthor: Prevent potential overwrite of buffer
 objects
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: liviu.dudau@arm.com, steven.price@arm.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mihail.atanassov@arm.com, ketil.johnsen@arm.com, florent.tomasin@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
References: <20241024145432.934086-1-akash.goel@arm.com>
 <20241024145432.934086-4-akash.goel@arm.com>
 <20241024173935.6430159e@collabora.com>
Content-Language: en-US
From: Akash Goel <akash.goel@arm.com>
In-Reply-To: <20241024173935.6430159e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0151.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::12) To AM9PR08MB6982.eurprd08.prod.outlook.com
 (2603:10a6:20b:415::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB6982:EE_|DU0PR08MB7922:EE_|DB1PEPF000509F9:EE_|PA6PR08MB10525:EE_
X-MS-Office365-Filtering-Correlation-Id: d245ae12-38e9-4270-f4a7-08dcf9f4f4b6
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?OFBFOHE2eHNzbmppWFZzRzNsaUhEeHRBZUJ5NTFibDRjamJZMlNTVGpseUpp?=
 =?utf-8?B?ZFVINnkwNjJ5QWpOVHhLb2tKcW80SjBhbjFsQ0JTV2VhRFZ5ajluZ1JBam1N?=
 =?utf-8?B?M0V4TE9mNmV6MGZwRklOQ3NwNHpGOXVyNUFlZGtRVlJRc2E1Q3pBd3hQbEhN?=
 =?utf-8?B?Z1ZQL3JaY2c5b1NRMWVpeGxCT21UeHk0cTBxYUZlTk81bGw2N004OEZVNHFa?=
 =?utf-8?B?WHU5Z3d5STZISktiUlZGZG9JeVkrODIrOTRYR094cWxSbG90S2czZk8yZkpH?=
 =?utf-8?B?RitmOUNoYzBoV1hyOGVpNzdJSTltMXFBblFJSERGRWIrcVRUdFU5MFZaRU55?=
 =?utf-8?B?OGFKSFZyemRlYkRsZjMzaGFONkxYSUhXWkpTV0dkaVJhUEFEeGhVNU1pR1Ra?=
 =?utf-8?B?emJGSDdGR0VWaEhtQTc1S2x2WXZ0V0tKNldrc0luZFJnOUc3T01hSGt0ZWxP?=
 =?utf-8?B?b0h1WnB1bWY1WWhMVmJXWHp0Mkdxd1A0clB6akdFcnBSYWxBamVzVTVCeXdw?=
 =?utf-8?B?dURqcGRoam92Vlh6UXcvRzFkd3FpbzhzNVJFZXIxa3dOV3g5bHdncXEySDZ4?=
 =?utf-8?B?VnFpbUVEODlmcWpBZmQ2TThSc0VZd1d6dVJMalBMQytOc2JHYjE4ZGM3M3pr?=
 =?utf-8?B?M3dIWENYd0M0bXJNSEo5VjBFR3dwYUF1bXdiWDBsclU4R0xCdEN0UXgrRnRm?=
 =?utf-8?B?d25CWSs2RkZrbGV4M2R1MUh3Q3VRU04rN1lxa0hIekdNeEZaSXBKRWN3Wkgy?=
 =?utf-8?B?bTJpRVNOVG83RDlYSGxQTTdQRFUvSXVXSTFYZUZrZTV6RERCdVh4d0FKVTlL?=
 =?utf-8?B?MDJHd0U4NG8wQk1OSDRiUzhMV1pOMGd2TlRkTWFNWjdkalNZUkRWQmcrU2Rx?=
 =?utf-8?B?a1lReUN0SFJGdWpwcS9Id0l1ZVpKaVRvdURtMTdNK3ZRRE8yNCtUOEpEdWZm?=
 =?utf-8?B?LzBRMFc2UFBFTzUvelBPRGV2dVFBUHVnVmN3QTk3N2UrQzRubjVlQU03ZmNM?=
 =?utf-8?B?SDdvYVZ2T3JpdlN0OUI2dDd5bEhzeGhIdmthc3pnbXZ1OVphaU9ueFFmYlcv?=
 =?utf-8?B?a2VpQzRzTDNLL29KejU2dUNPbWVOSnpQdzRqWlJEbWsxd0tQLytONXpDZUxw?=
 =?utf-8?B?b0NnS2xsdTNRZkRKM1BRelZjYmJmQkN5K1FrS0xRNmtQaW9yOEN3OXE3NG5H?=
 =?utf-8?B?L1VlbGh4S3BmL0pYVUorZHNQNVpuem13anppQUozK2ZDOEVTemY2Y1V3VVZT?=
 =?utf-8?B?UWdwUllUSUZ5YWQ2RytkZVhLMk5WNklkTm4venVESEJSZlJSOFFmZ3lUa3dN?=
 =?utf-8?B?S1gyNjRFOFNnSVBBdWgyRTNRbFNRMGhIQy9FajVHeE0wcjJPTWFUbHpDQ2FT?=
 =?utf-8?B?T1NVdmUyZkFpbWxtWG1VTDJ3SGF4bUZiKzIzYXRwbzc3UkY1SEs5QkR6bitC?=
 =?utf-8?B?WVJrSU9nM2NxVDFUeW00QXdFc3g5Zk5WaHlNTTNSZm9iV0hFZFJMK0s1SEQ1?=
 =?utf-8?B?UXdnd2dFMlF3M2pUdUdhbzdxaXVVa2cvWjluQnFTVnZMZnNyWVJiRzNad2t4?=
 =?utf-8?B?VExxekJxRkUyOThJZ21hdWpxRkdXaWJhZzJ2RkVDN2NnZHludThzbVZYeVZx?=
 =?utf-8?B?bVpueVdHNk5LbE9UYVVtanZxMmNTbWVjVU93V0NISG5ZZDA2ZVJ6U0I2TFZo?=
 =?utf-8?B?dHgzd21KY2w3U0w2TnVsUFA1c1hiL3BpRGxUeE9JUHBJVi9zQmZIYUFTRUFk?=
 =?utf-8?Q?SzgySdYHFmRO260OoAOX0kC0ErQoEL2UkEvGc7i?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6982.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7922
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:415::16];domain=AM9PR08MB6982.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9f9ed8a2-1361-4ece-8f2d-08dcf9f4eb6a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|35042699022|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXlhY1Nrc2tSbmpGbExMQ1g0QVlZd1FsYXNUcjh5U2JQaXhNN0c3YlNhUjJE?=
 =?utf-8?B?NlQzU1dJd0R6MUpqS3YvV0J2RTl2am1hT0FqK3hoeHdrODd0UGhiWHNrRHEr?=
 =?utf-8?B?U2tialBaZlV0Si93OWxiRjNDNFNkSkswZjR0Qk41RC9iVU5QSk1vL29kZU9N?=
 =?utf-8?B?enhzc1crbmFXVCt6bFBkOGMwTHI3djhUVEZCQW1UZUc5anZFa1p5K2p2QXlS?=
 =?utf-8?B?b0lMcG9jVkNmTFZMczF1MGFuY09VaS83WW96aWMrbzkzTVJXRzRlampFQ2F0?=
 =?utf-8?B?cjZqWFJEZWtFdnBydWhidU9YbnZITFNTLzcrWlNhRjdPdzVsckY5RjdLVWd1?=
 =?utf-8?B?eUJXRmw5em9aeGUzMjJpSHUrMnM3VFMyYWszNDZBdzE1ZXI5L3I0cFhiOEU4?=
 =?utf-8?B?bXgzVWV4OUFOOWU3TWd5R0NKZmFxMDhib3BNMG9QSG4rVUlPUWFWSHFWL0ti?=
 =?utf-8?B?MThtOEdhUTN3T0dBUU5xaUJlbHQvVUJRRjlTb29BTEZRR3l3RjlNY2ozQ3Uy?=
 =?utf-8?B?MzVJbk1Pa1p5UFIzS056SFZLMHg0WTFUQ2cyRVZ1STZlZlpNNWNXREt3MkhB?=
 =?utf-8?B?Rmd4TDJYS0h0amsyVTdCZU9DV3RuOXdpNUgvNFpBSlRIWU02U1NiSkJCY3da?=
 =?utf-8?B?WHEwSXVqWmJlU0NPRlgwcDJ5WWVMM25XMTR6WTRnVy9XNWY1SHZkempuWm9C?=
 =?utf-8?B?OE5RcU94V3dKcldaYmc3UTlHSUoyQkMzejJXTlhIU2R4RmljV2lQRWxNWjdn?=
 =?utf-8?B?RG9vTFVHNnpQbDFmQjJXNzZQOUV1elVPOU5LNnNtdFhoWXRweDExSk9uTlll?=
 =?utf-8?B?Yzh2bVFHb0pmTi9taWVLdVhFcjJSWDIyV0cvdkVYQ2pmd0VMaC9IT3hCSnBi?=
 =?utf-8?B?NHM4Yk1NOGk0Y2pqUld5eHp6dkRwdjVtdVNGaHRTNmRNQXQ5TUhDUzZyVEVR?=
 =?utf-8?B?TndjOHl6ZFhpeGRDbW01SzMxeHZsNWd5RFlSbzlIdEJsNStrLzM0Z0tSOE80?=
 =?utf-8?B?ZCs0RjBVSVpqWUh1djdpaDFPYjQybFVGUUw4SForV1dZcnU5Q3RLU2lsamla?=
 =?utf-8?B?QVRSTVZ3b1FzNWttanhaTDR2R3g0eUtGalVxRVc5ZVhpM2xpTUI5K1pOTkN6?=
 =?utf-8?B?czJFM1M5QUh6SExSUEJYRzlQYXRCWEpCb2tFRXgzT29ucjJyVmZzNEpVVWwr?=
 =?utf-8?B?TEVaa3R3NitZaVoyNzR5RGp5d3RUTks4VkFkUXp0VVlxUzkyelUvRmdYaFhX?=
 =?utf-8?B?UVEvekZrbHNYcnJMTjRjOFFnbERYem1UZXl5QkRhYlNzS2NucG05R1AxS3ZM?=
 =?utf-8?B?Q3hXckRwQWFGa3BmdjMreitpTm5waUJWVTdmWEoya0pQN1NMU3FhQlNtc01k?=
 =?utf-8?B?Umg0Q0hMUHQraW5VbXorcG41NGJxdmZxNjd6ZWJjVWdmOHZmZklBSll0Wkd5?=
 =?utf-8?B?NjY2clE1Uk94a2wzbWs4bnhhd29ENmFxcXc2SnkySDZzUzY1UGszMlNRcTFp?=
 =?utf-8?B?U0hscFh2ZU1Ic1hHN0dPS2xkYW5NVDhncFBpbmdNTHFKRk5QZnZ0aTJjOENs?=
 =?utf-8?B?MmNkZUpwRzhtbDd2MS96WHlDZzRWODRucUdKM0d6emZPYWttTitENGt4WjZV?=
 =?utf-8?B?a1JHUmEwZmhhZlZqT3V5bnVYb05QY0E0aUFrRjkxMFpWOUwvYXNQc2M5Sm9Z?=
 =?utf-8?B?SkZQK1BqckxxamhacEF4Q2tLUGVBOXB0NU5kWkR5WmZzRHNZazc2azF4R0ZD?=
 =?utf-8?B?NWY1L1Q2eE1yU0hEcEowTmRxMWs3dDVLcGJrSW50ODM4aVYzclFacDBUNGZo?=
 =?utf-8?B?UzlJL2NwWkR2UGF0SXJqeUw0bDRrVG9OU2FXTUQwU3RlS3pEK2cxeTlFYXJs?=
 =?utf-8?B?T1V3OEpNNmZLSUdmQVhqd2Z4WXJlcDZyK2wrWTZzZXdiR1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(35042699022)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 21:42:45.2735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d245ae12-38e9-4270-f4a7-08dcf9f4f4b6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10525



On 10/24/24 16:39, Boris Brezillon wrote:
> On Thu, 24 Oct 2024 15:54:32 +0100
> Akash Goel <akash.goel@arm.com> wrote:
> 
>> All CPU mappings are forced as uncached for Panthor buffer objects when
>> system(IO) coherency is disabled. Physical backing for Panthor BOs is
>> allocated by shmem, which clears the pages also after allocation. But
>> there is no explicit cache flush done after the clearing of pages.
>> So it could happen that there are dirty cachelines in the CPU cache
>> for the BOs, when they are accessed from the CPU side through uncached
>> CPU mapping, and the eviction of cachelines overwrites the data of BOs.
> 
> Hm, this looks like something that should be handled at the
> drm_gem_shmem level when drm_gem_shmem_object::map_wc=true, as I
> suspect other drivers can hit the same issue (I'm thinking of panfrost
> and lima, but there might be others).
> 


I am sorry for the late reply.
Many thanks for the quick feedback.

I assume you also reckon that there is a potential problem here for arm64.

Fully agree with your suggestion that the handling needs to be at the 
drm_gem_shmem level. I was not sure if we really need to do anything, as 
I didn't observe any overwrite issue during the testing. So thought 
better to limit the change to Panthor and get some feedback.

shmem calls 'flush_dcache_folio()' after clearing the pages but that 
just clears the 'PG_dcache_clean' bit and CPU cache is not cleaned 
immediately.

I realize that this patch is not foolproof, as Userspace can try to 
populate the BO from CPU side before mapping it on the GPU side.

Not sure if we also need to consider the case when shmem pages are 
swapped out. Don't know if there could be a similar situation of dirty 
cachelines after the swap in.

Also not sure if dma_sync_sgtable_for_device() can be called from 
drm_gem_shmem_get_pages() as the sg_table won't be available at that point.

Please let me know your thoughts.

Best regards
Akash



>>
>> This commit tries to avoid the potential overwrite scenario.
>>
>> Signed-off-by: Akash Goel <akash.goel@arm.com>
>> ---
>>   drivers/gpu/drm/panthor/panthor_gem.h | 10 ++++++++++
>>   drivers/gpu/drm/panthor/panthor_mmu.c |  5 +++++
>>   2 files changed, 15 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/panthor/panthor_gem.h
>> index e43021cf6d45..4b0f43f1edf1 100644
>> --- a/drivers/gpu/drm/panthor/panthor_gem.h
>> +++ b/drivers/gpu/drm/panthor/panthor_gem.h
>> @@ -46,6 +46,16 @@ struct panthor_gem_object {
>>   
>>   	/** @flags: Combination of drm_panthor_bo_flags flags. */
>>   	u32 flags;
>> +
>> +	/**
>> +	 * @cleaned: The buffer object pages have been cleaned.
>> +	 *
>> +	 * There could be dirty CPU cachelines for the pages of buffer object
>> +	 * after allocation, as shmem will zero out the pages. The cachelines
>> +	 * need to be cleaned if the pages are going to be accessed with an
>> +	 * uncached CPU mapping.
>> +	 */
>> +	bool cleaned;
>>   };
>>   
>>   /**
>> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
>> index f522a116c1b1..d8cc9e7d064e 100644
>> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
>> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
>> @@ -1249,6 +1249,11 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
>>   
>>   	op_ctx->map.sgt = sgt;
>>   
>> +	if (bo->base.map_wc && !bo->cleaned) {
>> +		dma_sync_sgtable_for_device(vm->ptdev->base.dev, sgt, DMA_TO_DEVICE);
>> +		bo->cleaned = true;
>> +	}
>> +
>>   	preallocated_vm_bo = drm_gpuvm_bo_create(&vm->base, &bo->base.base);
>>   	if (!preallocated_vm_bo) {
>>   		if (!bo->base.base.import_attach)
> 

