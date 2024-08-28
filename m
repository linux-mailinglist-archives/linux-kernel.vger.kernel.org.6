Return-Path: <linux-kernel+bounces-305441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 358DA962EA4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C9ADB21107
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A251A4F15;
	Wed, 28 Aug 2024 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OW5mUQyO";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OW5mUQyO"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8828F36130
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.67
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866679; cv=fail; b=L/YM+WUQpncxP2GcLbwuPdv45mzDXiuP9llVQIRH/MWoHaLHr/xbrlgEOz1GE8T8jtT3FbkQi2o0U5MJRONrCxQ35Pdh7O5jZtIRoTPwBMDfVzvzS4MvLORPGFPH3OOWub2YA1csNICmPMCAvMqnek1G6dlGQIf2U+N9smRnAZ4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866679; c=relaxed/simple;
	bh=vqZJZFqqq0Crm5yy6ysvqp3dVwJwr3aeBF9JmmqrUZY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hK4Q+1qYm+DDbugj/NUTnXgNgwIQJjgG9b44IX4ifWsQDNk27x0PsQbQIohXsInyJf8uVkaCN8Bkyw0LnY27Qb17ItPr6jQ9bNysoaiRVxN3lP5s5rb8wucT3+ffraPLwjDTz53vblltHs26Igb1pbLWkagD0E+q56/7lNtntJU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OW5mUQyO; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OW5mUQyO; arc=fail smtp.client-ip=40.107.20.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=nJA3XmwGqZRGiZDL9YppIYmk4/mHfNEBdv34CRDyToWBPiOUS0ERFpfA4EQa8TU3wXKgPZLkttHydNYDSaPJHtjHkKoKMV9NSfZ0rFpIucJraSOOmWtt9vQR2PKx7dMF5AYGBUQwXm4wOEKrgALDhuX0zAU7efpmKtx5p3B4OTlxKcNmMjS1dQzeTimSvYSiVUc64Fsb5iq/tH2JWktf4w1rbCi9oikGJwsjucDo0tZORqKID9OW/9Yv+9EA00WTm/1qy30usrDO3gFQiHD2OL/NMuSLIcl6Ge4YFxP6sE+XljgU3qhPdxSfXSNDpUO4LOHnXOGdseFBeDhC3lnbWA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FP25UcaMDvmXnLlz7Q9wsswVXlOxVbdRDeQn/Ui1khM=;
 b=WHFcRqycNzao/nkwmvZx/n6InUJ473TabNrh02g8uODer331Xo5V9KyyEtNIaRGX6jiVwUvuvuEkBqH1MDjYzwAf/x+mXi4iuDhUxjGHJpn+NaUyIEMYhUFleaU4QGjhEWxZs05KEsdDEKAFlmmVA1nnBTxt2eEeOseX4LRVc1cye22Og/6blhIbQnMAB66qbxtgrTEky3V0dOGMsVJTEoE+92E07l1GAofijDhJyutjjjAeMMCc995sQQkHGy9mXwxkHYn9/GQQvTOFCimSKeeXtL8g9wYqRUh/4So75HXuiqPkn2+PhfWPGa/5oqE/vMS97odHrkNLmYwJuPA/3g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FP25UcaMDvmXnLlz7Q9wsswVXlOxVbdRDeQn/Ui1khM=;
 b=OW5mUQyOOLo1F/+kxp2RuU7OBMU7JNOBsJtfMahRuUb8m3p3aXv2/l9Lgg1jlW+4978RH432K90aowNq6GOVLTzWXgn8LpPIRzS3WwCnnGPWj7/MVwAC3fh/5aefhc1NECIrUSP9QX8g4Sy3cL3NFVlcUUtPgBXFJuUcJT4wNmA=
Received: from AM0PR02CA0148.eurprd02.prod.outlook.com (2603:10a6:20b:28d::15)
 by DB9PR08MB7471.eurprd08.prod.outlook.com (2603:10a6:10:36d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Wed, 28 Aug
 2024 17:37:51 +0000
Received: from AM3PEPF00009B9B.eurprd04.prod.outlook.com
 (2603:10a6:20b:28d:cafe::fb) by AM0PR02CA0148.outlook.office365.com
 (2603:10a6:20b:28d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Wed, 28 Aug 2024 17:37:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF00009B9B.mail.protection.outlook.com (10.167.16.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Wed, 28 Aug 2024 17:37:50 +0000
Received: ("Tessian outbound de2677e4ad72:v403"); Wed, 28 Aug 2024 17:37:50 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 995ce8e2f973de11
X-CR-MTA-TID: 64aa7808
Received: from L3f941fdc1fa3.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 49AC219A-5B3C-4E6D-B6F5-D97FEE331624.1;
	Wed, 28 Aug 2024 17:37:43 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L3f941fdc1fa3.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 28 Aug 2024 17:37:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTFit6+6h5rJqUc3+vAGvMe333QR8nptmpNNHGE38EnYCK8PbMi/rYEgChgvTO06JUHg6oaeRw+NJFHKF/zvaza0/ypHgz7Uacs25QjRAr7GzXv74PT2VGsbDsolnJ85DsRyXSvU1It6CQXNXt8BF7DqJMv/Y1fme2mkAiLa9ZC17K6aJ5atLTaaPlV+H5UTheqhf2rW76TJE20BF0uzYBZtRw2zkDiNg56nw0noXaDVCzd9BpKWUcm+xZcGGbZYUzir7Dj8zDH0vbfo+A5ReFJLpicWczUfRdM+h5cpDoFAsFTb/BBKb71YJbtsaQI3HgerP18gSwrfUU0q1YN9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FP25UcaMDvmXnLlz7Q9wsswVXlOxVbdRDeQn/Ui1khM=;
 b=pJcvwsgA1P1ceqBSobadoKdbazKSUBs9sIdP2dmX2WfnJibEZ3GHKk+P7F0NaGSNUfivTbfR2Ezu0PuM9o9ePKxbp40ox/UiBr04B/8JY3d0PHWWcPOiDvpbIp2/wTW949SM7rP+kAnGO5Tt4m5XM/BKz45egw09CYTQUQWi2Jj9+bx2Ia8uOWaBlc22FU2rt6GqESFISBQjngDIG1i6pIEKQ4Xu3Ciox9XgeHt6X6623/XPu1tpipPIk+gqOoDXKlbM5MV+L9Luui96qoSekUXPq7nbOoprQRxkEme3LNK82gA3j6mqKO+x0/PPMp6T8knODE4IG7eOG5uzQuhruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FP25UcaMDvmXnLlz7Q9wsswVXlOxVbdRDeQn/Ui1khM=;
 b=OW5mUQyOOLo1F/+kxp2RuU7OBMU7JNOBsJtfMahRuUb8m3p3aXv2/l9Lgg1jlW+4978RH432K90aowNq6GOVLTzWXgn8LpPIRzS3WwCnnGPWj7/MVwAC3fh/5aefhc1NECIrUSP9QX8g4Sy3cL3NFVlcUUtPgBXFJuUcJT4wNmA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com (2603:10a6:20b:290::9)
 by AS4PR08MB7577.eurprd08.prod.outlook.com (2603:10a6:20b:4fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.18; Wed, 28 Aug
 2024 17:37:41 +0000
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c]) by AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c%7]) with mapi id 15.20.7918.012; Wed, 28 Aug 2024
 17:37:41 +0000
Message-ID: <da61aa7c-0cee-4d44-a0f3-4b7eed3a8b58@arm.com>
Date: Wed, 28 Aug 2024 18:37:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: Add DEV_QUERY_TIMESTAMP_INFO dev query
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Mary Guillemard <mary.guillemard@collabora.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com, Christopher Healy <healych@amazon.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, nd@arm.com
References: <20240807153553.142325-2-mary.guillemard@collabora.com>
 <327a3440-8d01-4787-83be-a00fbbe0b593@arm.com>
 <20240828140929.5c602436@collabora.com>
 <c38324e4-055f-44b5-beb4-6b3e6b860e69@arm.com>
 <20240828180703.4510a4e2@collabora.com>
 <010201919a07868c-a8b90e57-0e61-4a05-8271-f4f4f86ca4cf-000000@eu-west-1.amazonses.com>
Content-Language: en-US
From: Mihail Atanassov <mihail.atanassov@arm.com>
In-Reply-To: <010201919a07868c-a8b90e57-0e61-4a05-8271-f4f4f86ca4cf-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0164.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::7) To AS8PR08MB6263.eurprd08.prod.outlook.com
 (2603:10a6:20b:290::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR08MB6263:EE_|AS4PR08MB7577:EE_|AM3PEPF00009B9B:EE_|DB9PR08MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: d666aabb-f816-44ca-1643-08dcc78823da
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?aU5JT1RubEx1dzZaQnozOXpaZnRFNzlpVC9SL2J3K2NuM0VqL1ltZ3BjMUYw?=
 =?utf-8?B?VlVSdUVuMnFOTlArNmJ3U2NqKy9wc3BsWmVPMERUaTNPTkxXL0RqelJYZkNp?=
 =?utf-8?B?R2xkaVk2WVRpaHdYbmFwQmZCaFpwVmxUeGlMZnhvQm81UTBPSmNZaGRGcHFU?=
 =?utf-8?B?QmNneWVoWEhJM21nR1Q1Z1FyUGpzYjhlZVhIYzJud0g0d2VmREJXTHpUakh5?=
 =?utf-8?B?Ny9WWmZ6ejJOb1dtTGt3Skw2ak1EcjlFM3dXMmlybXdLMnBkUEhvOThjQTJQ?=
 =?utf-8?B?dm1FdFZRcGh4UVhYak5rWkV3WXpva2NxM0NmWUc0MHA0eTVHNUNkY1YxaWVy?=
 =?utf-8?B?ZThXamRVcE1PQVpXdmxmQ0lCeUtCcE1ONmRnT0RWaWgzMldKS3lzZXo4bEtl?=
 =?utf-8?B?MUZZT3FxUjNFZE1hakxhNHR0L1F4cEJOMWY0Z2ljeGNVWTBIMzFRRWVob1lk?=
 =?utf-8?B?VFNIQmx5QTdHSVAxeHByZjZlR2ZlVisrWlpoZHRLUVFNRVllcGIrT3BBSytR?=
 =?utf-8?B?d21rTGR4YzI3MjBCSjdueFdJalptT1lCSXBubUZqeTFHcnU4WkF5RS9TTkM3?=
 =?utf-8?B?a28vNFJmSVpPN2JOSWxZdDB6eExxTEFlMm45dzhjUEYwWWd5bmdjSGJJbU5P?=
 =?utf-8?B?RlE3UUNuUWtnSnZEdnFVbXJMYzNCRjdETE52Z3lMMXJzR2FwNzJrVFNqWEZW?=
 =?utf-8?B?S24vSHd3bVV0MlVTVFlEMGozbDVqZ0RkOExvb2czZWhpd0FqUlcraFhLeFNQ?=
 =?utf-8?B?cmpMaEpCa2pza0hoUGFLNXROeHlOQW5OSldtWjdPb2NDd3UxOVBVZXF2Z1Ns?=
 =?utf-8?B?ajlCclB4NUFCdm5pWnJRN2pWRmdyYnBuUHhRNUlxMVNuMjdIaHBzV0doamt6?=
 =?utf-8?B?SkUyRlFzSW9MM29MVFVlelcyVjgxWEFuWXNzMllHb1NlbGxRTC9UeVY3VXc3?=
 =?utf-8?B?Z0FVZTdiMytDMVVNR3lNb1VGTWw2WDlrRUV2T1ZyTmg4YkEycE9uUGM2MkUw?=
 =?utf-8?B?a2dMLzdhQUp0bHh2cEMzeDlhNDh0b3piN0xiVmZnK2h1NTRzZFJZc28zTTVF?=
 =?utf-8?B?cmRHYTg3YTc3SWJZeDJtTXVCdWdWR1ZvMEUyYWJhNlFDUkc2K3ZZdHBEZnMy?=
 =?utf-8?B?d0hvdHdnbXJjMExCRnB0UnJnbVF2bktoTkgySll6RzBnb3NjaGNjUWVwWUFv?=
 =?utf-8?B?dGszeUZmbk5TQzk2UzZwclRWTVEzemhnYmF6M0tiMTh1MGdCTFdjV3lPMVFN?=
 =?utf-8?B?bzFpQ01tdnZVWjBvNGdKVkpOK2YrdW1mM3VBWnBWTDVhTXcwdEs0OEtHL3Z1?=
 =?utf-8?B?UFl0M1dIckN4aHQxYWV0T2pienpVTEN5ZjQ3eGwzVWYvRjZTL3dON3ZTTmJW?=
 =?utf-8?B?eUdJRHZvdFdxRHFjMzMrWjNtUEhncXdIK1A1SHNHbHlZYVdJRlMyLzV5SWhU?=
 =?utf-8?B?ZDhPQkV4dDRaV1BSTDNkUFhnOW9LTjltbDR4MlVHVCtZNXZRVmlaQ3R0b1Z0?=
 =?utf-8?B?OGNRcWk1WmtGT1hkU20vaWlUMlpvOXVwY3BmSDhOYkQ3ZEdZL1NxcjIwOG5F?=
 =?utf-8?B?VnJZelhBdnJMYmlzeEVpdEJvNHdjbUNuRFZRZUkvSmVzRXV2NTZZbUpVU1RF?=
 =?utf-8?B?ajU4eEJGSUpzaGZYSUg1eVVsNk1EMmJFTlc1QTBTK0JFeHJ6UnJjbHYyOFVt?=
 =?utf-8?B?NXlBVS9Bc0FLUGFqNVVIZGU0d1A5UUVRWGNwbnBpV04zMzZNLzBha09wMlRr?=
 =?utf-8?Q?FIBQ6CiuucPcFMD5T4=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6263.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7577
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:290::9];domain=AS8PR08MB6263.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9B.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9b36eff8-125c-4055-dcd9-08dcc7881e46
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVNzSmpnVGtIMW1GQXRXSFJPc1ZaQkNtb2F6VTZsVkZKMmdPTWlKSERYdTdJ?=
 =?utf-8?B?UWZ1cERIOUVseHNKbUIrQ2pwblNFK2ZsNGpWb0RFcUQzOFkxQWtrR0Z2cUxh?=
 =?utf-8?B?S0JDUUV6c251MjlQKzhkMUhyODBZYTI3VzU0MEQzUUVOV3BiY08xdUtxU1Q4?=
 =?utf-8?B?MkdjL1IwZ3FvdFJYVHBraGtwSldqRllCRk9PbDdhRmtPOCtJZWxaalU1UVpm?=
 =?utf-8?B?Qlo5dkVPbnhnOGFQQisvaDgrOHhhemt5MWVEc1RBYkx6cFV6VFlFbkt1RUpE?=
 =?utf-8?B?cVREQ0NWZ1JpNzJOeGQ5Slkxd2U2cVFoQmV0bWdmTEhTK1poRTluejM0VHhE?=
 =?utf-8?B?MVhiNVFrNlZHOG01Q05hbHcrSUtVaDVVWVAzazU5UXR6NzBkMkhNeE11YS94?=
 =?utf-8?B?SEZORDQzOHo5SzhaTzdJK2x3WFBOY1pIV2krVVlUU3NWNTNMcUhjMzF2aVZi?=
 =?utf-8?B?MEVhVi9UU0lkK2t4VFV2emVpcWx6NzdqMzBuVVZwSlZaQ2FnOCtmYVo5emRm?=
 =?utf-8?B?Mk9OaExLUEhWbklYZmlIbTJCWkcraDg1bTNBSXBQcHBDeW90RHhsOFZXeG81?=
 =?utf-8?B?RWo0ZmxSdDlKVE1USkFoZUlxNEhnU01rSGxaYzhXc1ZJb2pSM2VqUjVabUpE?=
 =?utf-8?B?ZEN5TlpuMG9pUk51cXJ6OXBlN2lDemFOMUJiSGZ1Q2lBTmtvbjAvUlo3QnMx?=
 =?utf-8?B?NDFkYVR3NTZCeWQ2Y0lkSkdVdm5UTVBEL3BsaWpCcFVhZjJLcE9FaWNmVk1Y?=
 =?utf-8?B?UXhCSFQrQTE5MTlIUjA1U21aZ3BiVGRpdnBpTktJaElnOVI0WGVyU0Uyc1NF?=
 =?utf-8?B?bVRtZFlZNTdZWU5Bd1ZrbWUvRjA1M1drVzFLcUkvcWdsS3BoRXEwbk4wWU10?=
 =?utf-8?B?SWRTd05meHByVk9ab0pCUTJJR2txRUtlZU9uMWQ1UVBXZFpmTEFKRGE2N3pi?=
 =?utf-8?B?d29qS2dzTUVTdlgyeVl1TFVCNE9hMVM3K3FtUWwzakRyUkpBeDV1UjNWc013?=
 =?utf-8?B?M3hhRFp3bXAzL3FLMXNhZitDR0JLT0JsNXpwTDlQY285ZThxM2NhVXZuQXpF?=
 =?utf-8?B?NG1USG5zRTN1bVQ2VlFwZnk5WWlLUmw1STM3QWU2djZ4ME9Eckw3SmtkTXpn?=
 =?utf-8?B?bEJCY000SFhGdVBhaFFZOFJncHFoVnEyQXNnV3FVNnMxN3pVQ1RwdjZHajc4?=
 =?utf-8?B?YTFhRnE5RHk0OG9rZS96eFNBSDFwOHlrMTliRnV6b1R0YmxaM1dwWUdOdHQ0?=
 =?utf-8?B?dFVtNUdLTE1QK2pnbEYvYVBhd09nZmp0WUhpazhmTGFmeGs4VWRYUG4vMEZv?=
 =?utf-8?B?MVVQbUs0M1pOM0lYS2wxU09vZ1FNampJODU5N2JLQkcxaDR6d0djUU1hNnVQ?=
 =?utf-8?B?S3ZkTGpsSE1pNGhTUVV6L3Iwd0xHd2lJOHZ1S2F2bHlTTy9zbWNEQUhTOTdM?=
 =?utf-8?B?YVh4R1QvT2dXUG84eENTNG5hU09XR3k3blQ5VDQrT0lKemxmdWl0bmFDcUYv?=
 =?utf-8?B?SFBVZ00wQmViTEpYeHBGc1lYZ3I4T1NQVXB5NHFqazNRVGZBaDdxSU8zSDgw?=
 =?utf-8?B?LytlVnVDQXVSVWwzaDdEanF3d0Q0aERWM3N2MXJyWTBvMjZ3Qjdoc3JVeW03?=
 =?utf-8?B?RndvaUpYOFhSZEkwVVFsak5HbXhHTS8xbDJFVXEweFJ6SHB0VFVrU2hyR0pH?=
 =?utf-8?B?YlNDVUdIdlJRUXd4UElJSm53OG9ybldDcC9jOHEyRCsrTG45aC9MdStrak15?=
 =?utf-8?B?dTN5RTN6TklIbzhJRit1ZStSQ1k3aEVRVVhHUkN1VnJDMHh3K2llSElDbU1W?=
 =?utf-8?B?UDRqT0d4S2ZKUVhYNSsvZm1PVlpjZXlXMUtBKzM1L2Z4SE9PYjQ5dkJDMmU1?=
 =?utf-8?B?N1NMNmRxbEtYcWt2V1lQaVd0VmI1MUs4dnVKcWMvRTlFT2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 17:37:50.9961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d666aabb-f816-44ca-1643-08dcc78823da
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7471



On 28/08/2024 18:27, Boris Brezillon wrote:
> On Wed, 28 Aug 2024 18:07:03 +0200
> Boris Brezillon <boris.brezillon@collabora.com> wrote:
> 
>> On Wed, 28 Aug 2024 14:22:51 +0100
>> Mihail Atanassov <mihail.atanassov@arm.com> wrote:
>>
>>> Hi Boris,
>>>
>>> On 28/08/2024 13:09, Boris Brezillon wrote:
>>>> Hi Mihail,
>>>>
>>>> On Thu, 8 Aug 2024 12:41:05 +0300
>>>> Mihail Atanassov <mihail.atanassov@arm.com> wrote:
>>>>      
>>>>>>
>>>>>> +/** + * struct drm_panthor_timestamp_info - Timestamp information +
>>>>>> * + * Structure grouping all queryable information relating to the
>>>>>> GPU timestamp. + */ +struct drm_panthor_timestamp_info { +	/**
>>>>>> @timestamp_frequency: The frequency of the timestamp timer. */ +
>>>>>> __u64 timestamp_frequency; + +	/** @current_timestamp: The current
>>>>>> timestamp. */ +	__u64 current_timestamp;
>>>>>
>>>>> As it stands, this query has nothing to do with the actual GPU so
>>>>> doesn't really belong here.
>>>>>
>>>>> It'd be more valuable, and can maybe give better calibration results
>>>>> than querying the system timestamp separately in userspace, if you
>>>>> reported all of:
>>>>>     * the system timer value
>>>>>     * the system timer frequency
>>>>>     * the GPU timer value
>>>>>     * the GPU timer frequency (because it _could_ be different in some
>>>>> systems)
>>>>
>>>> Duh, I wish this wasn't the case and all SoC vendors went for the
>>>> arch-timer which guarantees the consistency of the timestamp on the GPU
>>>> and CPU. But let's say this is a case we need to support, wouldn't it
>>>> be more useful to do the CPU/GPU calibration kernel side (basically at
>>>> init/resume time) and then expose the formula describing the
>>>> relationship between those 2 things:
>>>>
>>>> CPU_time = GPU_time * GPU_to_CPU_mul / GPU_to_CPU_div +
>>>> 	   GPU_to_CPU_offset;
>>>>      
>>>
>>> TIMESTAMP_OFFSET should indeed be set by the kernel (on resume). But I
>>> don't think we need to post M/D+offset to userspace. The 2 Frequencies +
>>> the scalar offset are the raw sources, and userspace can work back from
>>> there.
>>
>> Sure. No matter how you express the relationship, my point was, if the
>> calibration is supposed to happen in the kernel at resume time,
>> returning both the CPU/GPU time in DEV_QUERY_TIMESTAMP to make sure the
>> sampling is close enough that they actually represent the same
>> timestamp might not be needed, because you can easily convert from one
>> domain to the other.
> 
> I think it makes more sense after reading [1] :-). This being said, the
> maxDeviation is here to account for any latency that might exists
> between each domain sampling, so I'd be tempted to read the CPU
> monotonic time through the regular syscalls rather than add it to the
> DEV_QUERY_TIMESTAMP ioctl.
> 

Wouldn't that defeat the point of getting low-latency consecutive reads 
of both time domains? If you leave it to a separate syscall, you're at 
the mercy of a lot of things, so it's not just a scalar time delta, 
you'll get much higher measurement variance. Doing it in-kernel with no 
sleeps in the middle gets you better confidence in your samples being 
consistently correlated in time. If you have that in-kernel low latency 
correlation pairwise for all time domains you're interested in (in this 
case CPU & GPU timestamps, but you could get CPU & display IP 
timestamps, etc), you can then correlate all of the clocks in userspace.

Fundamentally, though, if you don't report CPU timestamps in v1 of the 
ioctl, you can extend later if it becomes clear that the maxDeviation is 
not low enough with the samples being across a syscall.

> [1]https://docs.vulkan.org/features/latest/features/proposals/VK_EXT_calibrated_timestamps.html

-- 
Mihail Atanassov <mihail.atanassov@arm.com>


